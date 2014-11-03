package Server
{	
	import flash.display.Stage;
	import flash.events.Event;

	public class Server
	{
		private var coms:ServerComs;
		
		private var ships:Vector.<ShipFrameShell> = new Vector.<ShipFrameShell>;
		public function Server(stage:Stage,serverIP:String,serverPort:int)
		{
			stage.addEventListener(Event.ENTER_FRAME,updateClients);	
			coms = new ServerComs();
			coms.startServer(serverIP,serverPort);
			ships.push(new ShipFrameShell(coms,new SeatShell(225,75,1),new SeatShell(125,75,0)));
		}
		public function updateClients(e:Event):void
		{
			coms.sendBuffer();
		}	
	}
}