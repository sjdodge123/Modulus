package Server
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.ServerSocketConnectEvent;
	import flash.net.ServerSocket;
	import flash.net.Socket;

	public class Server
	{
		private var serverSocket:ServerSocket;
		public var ships:Vector.<ShipFrameShell> = new Vector.<ShipFrameShell>;
		private var clientSockets:Vector.<Socket> = new Vector.<Socket>;
		public function Server()
		{
			serverSocket = new ServerSocket();
			serverSocket.addEventListener( Event.CONNECT, connectHandler ); 
			serverSocket.addEventListener( Event.CLOSE, onClose ); 
			serverSocket.bind(8087,"192.168.1.136");
			serverSocket.listen(); 
			
			ships.push(new ShipFrameShell());
		}	
		protected function connectHandler(event:ServerSocketConnectEvent):void
		{
			var socket:Socket = event.socket as Socket; 
			clientSockets.push(socket);
			
			socket.addEventListener( ProgressEvent.SOCKET_DATA, socketDataHandler); 
			socket.addEventListener( Event.CLOSE, onClientClose ); 
			socket.addEventListener( IOErrorEvent.IO_ERROR, onIOError );
			trace("Player joined");
			
			var packet:Array = new Array();
			packet.push(2);
			packet.push(5000);
			packet.push(ships[0].getShipSpawnLoc());
			socket.writeObject(packet);
			socket.flush();
		}
		
		protected function onIOError(event:IOErrorEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function socketDataHandler(event:ProgressEvent):void
		{
			var clientID:int = clientSockets.indexOf(event.target as Socket);
			var socket:Socket = event.target as Socket;
			var message:String = socket.readUTFBytes(socket.bytesAvailable); 
//			if(message == "Test")
//			{
//				var packet:Array = new Array();
//				packet.push(0);
//				packet.push(1000);
//				packet.push("Connection confirmed");
//				socket.writeObject(packet);
//				socket.flush();
//			}
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