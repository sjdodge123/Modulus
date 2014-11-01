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
			var server:Server = new Server(stage);
			var myClient:Client = new Client(stage);
//			var myClient2:Client = new Client(stage);

			addChild(myClient.getScreen());
			
		}
	}
}