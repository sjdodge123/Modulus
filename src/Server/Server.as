package Server
{	
	import flash.events.Event;
	
	import Events.MessageEvent;
	import Events.ServerComsEvent;

	public class Server
	{
		private var coms:ServerComs;
		private var playerShells:Vector.<PlayerUnitShell> = new Vector.<PlayerUnitShell>;
		private var ships:Vector.<ShipFrameShell> = new Vector.<ShipFrameShell>;
		private var currentPlayer:int = 63;
		public function Server()
		{
			coms = new ServerComs();
			coms.addEventListener(ServerComsEvent.PLAYER_JOINED,addPlayer);
			coms.addEventListener(MessageEvent.CLIENT_ID,changeIndex);
			coms.addEventListener(MessageEvent.UPDATE_POSITION,updatePlayer);
			ships.push(new ShipFrameShell());
		}
		
		protected function changeIndex(event:MessageEvent):void
		{
			currentPlayer = event.params as int;
		}
		
		protected function updatePlayer(event:MessageEvent):void
		{
			var moveInfo:Array = event.params as Array; 
			playerShells[currentPlayer].setX(playerShells[currentPlayer].getX() + moveInfo[0]);
			playerShells[currentPlayer].setY(playerShells[currentPlayer].getY() + moveInfo[1]);
			var playerLoc:Array = new Array();
			playerLoc.push(playerShells[currentPlayer].getX());
			playerLoc.push(playerShells[currentPlayer].getY());
			var file:Array = new Array();
			file.push(0);
			file.push(6000);
			file.push(playerLoc);
			coms.sendData(file);
			trace(playerShells[0].getX());
//			trace(playerShells[1].getX());
		}
		protected function addPlayer(event:ServerComsEvent):void
		{
			var index:int = event.params as int;
			var file1:Array = new Array();
			file1.push(0);
			file1.push(5000);
			file1.push(ships[0].getShipSpawnLoc());
			
//			trace(ships[0].getPlayerSpawnLoc().x);
			playerShells.push(new PlayerUnitShell(index,ships[0].getPlayerSpawnLoc().x,ships[0].getPlayerSpawnLoc().y));
			var file:Array = new Array();
			file.push(0);
			file.push(5100);
			file.push(ships[0].getPlayerSpawnLoc());
			trace(playerShells[0].getX());
			coms.sendData(file1,file);
		}
		
	}
}