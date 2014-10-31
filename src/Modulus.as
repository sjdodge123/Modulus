package
{
	import flash.display.Sprite;
	
	import Client.Client;
	import Server.Server;
	
	[SWF(backgroundColor= "0xFFFFFF", width="800", height ="600", frameRate='30')]
	public class Modulus extends Sprite
	{
		public function Modulus()
		{
			var server:Server = new Server();
			var client1:Client = new Client();
			client1.joinServer("127.0.0.1",8087);
			addChild(client1.getScreen());
			
		}
	}
}