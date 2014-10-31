package Server
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.ServerSocketConnectEvent;
	import flash.events.TimerEvent;
	import flash.net.ServerSocket;
	import flash.net.Socket;
	import flash.utils.Timer;
	
	import Events.ServerComsEvent;

	public class ServerComs extends EventDispatcher
	{
		private var serverSocket:ServerSocket;
		private var clientSockets:Vector.<Socket> = new Vector.<Socket>;
		private var router:Router;
		private var timer:Timer;
		public function ServerComs()
		{
			serverSocket = new ServerSocket();
			router = new Router();
			timer = new Timer(5,1);
			timer.addEventListener(TimerEvent.TIMER,sendBuffer);
			timer.start();
			serverSocket.addEventListener( Event.CONNECT, connectHandler ); 
			serverSocket.addEventListener( Event.CLOSE, onClose ); 
			serverSocket.bind(8087,"192.168.1.136");
			serverSocket.listen(); 
		}	
		
		
		protected function connectHandler(event:ServerSocketConnectEvent):void
		{
			var socket:Socket = event.socket as Socket; 
			clientSockets.push(socket);
			var index:int = clientSockets.indexOf(socket);
			socket.addEventListener( ProgressEvent.SOCKET_DATA, socketDataHandler); 
			socket.addEventListener( Event.CLOSE, onClientClose ); 
			socket.addEventListener( IOErrorEvent.IO_ERROR, onIOError );
			trace("Player joined");
			dispatchEvent(new ServerComsEvent(ServerComsEvent.PLAYER_JOINED,index));
		}
		
		public function sendData(... file):void
		{
			for(var i:int=0;i<file.length;i++)
			{
				router.pack(file[i]);
			}
			
		}
		
		protected function onIOError(event:IOErrorEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function socketDataHandler(event:ProgressEvent):void
		{
			var socket:Socket = event.target as Socket;
			var index:int = clientSockets.indexOf(socket);
			router.tagId(index);
			var packet:Array = socket.readObject();
			var packetEventArray:Array = router.unpack(packet);
			for(var i:int =0;i<packetEventArray.length;i++)
			{
				dispatchEvent(packetEventArray[i]);
			}
		}
		
		protected function sendBuffer(event:TimerEvent):void
		{
			timer.reset();
			for(var i:int=0; i<clientSockets.length;i++)
			{
				if(router.getPacket() != null)
				{
					clientSockets[i].writeObject(router.getPacket());
					clientSockets[i].flush();
					router.clearPacket();
				}
			}
			timer.start();
		}
		

		
		protected function onClientClose(event:Event):void
		{
			trace( "Connection to client closed." ); 
		}
		protected function onClose(event:Event):void
		{
			trace( "Server socket closed by OS." ); 
		}
	}
}