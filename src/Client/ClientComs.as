package Client
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	
	public class ClientComs extends EventDispatcher
	{
		private var socket:Socket;
		private var router:Router;
	
		public function ClientComs()
		{
			router = new Router();
		}
		
		public function joinServer(server:String, port:int):void
		{
			socket = new Socket(server,port);
			socket.addEventListener(Event.CONNECT,connectHandler);
		}
		
		protected function connectHandler(event:Event):void
		{
			socket.addEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);
		}	
		protected function socketDataHandler(event:ProgressEvent):void
		{
			var socket:Socket = event.target as Socket;
			while(socket.bytesAvailable)
			{
				var packet:Array = socket.readObject();
				var packetEventArray:Array = router.unpack(packet);
			}
			for(var i:int =0;i<packetEventArray.length;i++)
			{
				dispatchEvent(packetEventArray[i]);
			}
			
		}
		public function sendData(file:Array):void
		{
			router.pack(file);
			socket.writeObject(router.getPacket());
			socket.flush();
			router.clearPacket();
		}
	}
}