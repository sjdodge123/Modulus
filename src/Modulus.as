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
			var server:Server = new Server(stage,"192.168.1.136",8087);
			var myClient:Client = new Client(stage,"50.167.6.43",8087);
//			var myClient:Client = new Client(stage,"192.168.1.136",8087);
			addChild(myClient.getScreen());
			
		}
	}
}