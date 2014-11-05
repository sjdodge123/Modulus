package Server
{	
	import flash.display.Stage;
	import flash.events.Event;
	
	import Events.ServerComsEvent;

	public class Server
	{
		private var coms:ServerComs;
		private var players:Vector.<PlayerShell> = new Vector.<PlayerShell>;
		private var ships:Vector.<ShipFrameShell> = new Vector.<ShipFrameShell>;
		private static var shipId:int = 0;
		private var dt:Number = .5;
		public function Server(stage:Stage,serverIP:String,serverPort:int)
		{
			stage.addEventListener(Event.ENTER_FRAME,updateShell);	
			coms = new ServerComs();
			coms.startServer(serverIP,serverPort);
			coms.addEventListener(ServerComsEvent.PLAYER_JOINED,addPlayer);
			ships.push(new ShipFrameShell(coms,new SeatShell(225,75,1),new SeatShell(125,75,0)));
		}
		
		protected function addPlayer(event:ServerComsEvent):void
		{
			event.stopPropagation();
			var newPlayer:PlayerShell = new PlayerShell(event.params as int,shipId);
			ships[newPlayer.getHomeShipId()].addFriendly(newPlayer);
		}
		
		public function updateShell(e:Event):void
		{
			for(var i:int=0;i<ships.length;i++)
			{
				ships[i].update(dt);
			}
			coms.sendBuffer();
		}	
	}
}