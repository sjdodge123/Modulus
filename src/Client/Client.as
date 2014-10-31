package Client
{
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.geom.Point;
	import flash.net.Socket;
	

	public class Client
	{
		private var socket:Socket;
		private var screen:ClientScreen;
		public function Client()
		{
			screen = new ClientScreen();
		}
		
		public function joinServer(server:String, port:int):void
		{
			socket = new Socket(server,port);
			socket.addEventListener(Event.CONNECT,connectHandler);
		}
		
		
		
		
		protected function connectHandler(event:Event):void
		{
			socket.addEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);
			socket.writeUTFBytes("");
			socket.flush();
		}	
		protected function socketDataHandler(event:ProgressEvent):void
		{
			var socket:Socket = event.target as Socket;
			var packet:Array = socket.readObject();
			
			var type:int = packet[0];
			var route:int = packet[1];
			var content:Object = packet[2];
			if(type == 0) //String
			{
				
			}
			if(type == 1) //int
			{
				
			}
			if(type == 2) //point
			{
				
			}
			if(route == 1000) // Connection INFO
			{
				trace(content.toString());
			}
			if(route == 5000) // Ship Spawn INFO
			{
				var myShip:ShipFrame = new ShipFrame(content.x,content.y);
				screen.addChild(myShip);
			}
			if(route == 5100) // Player Spawn INFO
			{
				
				
			}	
		}
		
		public function getScreen():ClientScreen
		{
			return screen;
		}
	}
}