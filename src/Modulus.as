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
			var myClient:Client = new Client();
			myClient.joinServer("192.168.1.136",8087);
			addChild(myClient.getScreen());
			
		}
	}
}