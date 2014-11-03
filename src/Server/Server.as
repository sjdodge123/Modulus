package Server
{	
	import flash.display.Stage;
	import flash.events.Event;
	import Events.ActionEvent;
	import Events.MessageEvent;
	import Events.ServerComsEvent;

	public class Server
	{
		private var coms:ServerComs;
		private var playerShells:Vector.<PlayerUnitShell> = new Vector.<PlayerUnitShell>;
		private var ships:Vector.<ShipFrameShell> = new Vector.<ShipFrameShell>;
		private var currentPlayer:int = 63;
		public function Server(stage:Stage)
		{
			stage.addEventListener(Event.ENTER_FRAME,updateClients);	
			coms = new ServerComs();
			coms.addEventListener(ServerComsEvent.PLAYER_JOINED,addPlayer);
			coms.addEventListener(MessageEvent.CLIENT_ID,changeIndex);
			coms.addEventListener(MessageEvent.UPDATE_POSITION,updatePlayer);
			coms.addEventListener(ActionEvent.FIRE,mouseClicked);
			coms.addEventListener(ActionEvent.BOARD_SEAT,sitDown);
			ships.push(new ShipFrameShell(new SeatShell(225,75,1),new SeatShell(125,75,0)));
		}		
		
		protected function mouseClicked(event:ActionEvent):void
		{
			var bulletData:Array = ships[0].addProjectile(playerShells[currentPlayer].getX(),playerShells[currentPlayer].getY(),event.params[0],event.params[1]);
			coms.sendFile(0,5002,bulletData);
		}
		
		protected function sitDown(event:Event):void
		{
						
		}		
		
		public function updateClients(e:Event):void
		{
			coms.sendBuffer();
		}
		protected function changeIndex(event:MessageEvent):void
		{
			currentPlayer = event.params as int;
		}
		
		protected function updatePlayer(event:MessageEvent):void
		{
			var currentX:int = playerShells[currentPlayer].getX();
			var currentY:int = playerShells[currentPlayer].getY();
			
			if(ships[0].checkBounds(currentX + event.params[0],currentY + event.params[1]))
			{
				playerShells[currentPlayer].setX(currentX + event.params[0]);
				playerShells[currentPlayer].setY(currentY + event.params[1]);
				var shellData:Array = new Array();
				for(var i:int;i<playerShells.length;i++)
				{
					var playerLoc:Array = new Array();
					playerLoc.push(playerShells[i].getX());
					playerLoc.push(playerShells[i].getY());
					shellData.push(playerLoc);
				}
				coms.sendFile(0,6000,shellData);
			}
		}
		protected function addPlayer(event:ServerComsEvent):void
		{
			var index:int = event.params as int;
			var shipData:Array = new Array();
			shipData.push(ships[0].getShipSpawnLoc().x);
			shipData.push(ships[0].getShipSpawnLoc().y);
			shipData.push(ships[0].getWidth());
			shipData.push(ships[0].getHeight());
			shipData.push(ships[0].getSeats());
			var player:PlayerUnitShell= new PlayerUnitShell(index,ships[0].getPlayerSpawnLoc().x,ships[0].getPlayerSpawnLoc().y)
			playerShells.push(player);
			ships[0].addFriendly(player);
			var shellData:Array = new Array();
			for(var i:int;i<playerShells.length;i++)
			{
				var playerLoc:Array = new Array();
				playerLoc.push(playerShells[i].getX());
				playerLoc.push(playerShells[i].getY());
				shellData.push(playerLoc);
			}
			coms.sendFile(0,5000,shipData);
			coms.sendFile(0,5001,shellData);
		}
		
	}
}