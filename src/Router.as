package
{
	import Events.MessageEvent;
	import Events.ScreenEvent;
	import Events.ServerComsEvent;

	public class Router
	{
		private var packet:Array = new Array();
		private var currentId:int = 0;
		public function Router()
		{
		}
		
		
		public function pack(file:Array):void
		{
			if(packet == null)
			{
				packet = new Array();
			}
			packet.push(file);
		}
		
		public function packBulk(... file):Array
		{
			var bulkPacket:Array = new Array();
			for(var i:int =0;i<file.length;i++)
			{
				bulkPacket.push(file[i]);
			}
			return bulkPacket;
		}
		
		public function unpack(packet:Array):Array
		{
			var eventArray:Array = new Array();
			eventArray.push(new MessageEvent(MessageEvent.CLIENT_ID,currentId));
			for(var i:int=0;i<packet.length;i++)
			{
				var file:Array = packet[i];
				var type:int = file[0];
				var route:int = file[1];
				var content:Object = file[2];
			
				
				if(route == 1000) // Connection INFO
				{
					eventArray.push(new ServerComsEvent(ServerComsEvent.PLAYER_JOINED,content));
				}
				if(route == 5000) // Ship Spawn INFO
				{
					eventArray.push(new ScreenEvent(ScreenEvent.SPAWN_SHIP,content));			
				}
				if(route == 5001) // Ship Spawn INFO
				{
					eventArray.push(new MessageEvent(MessageEvent.UPDATE_LISTINGS,content));			
				}
				if(route == 5100) // Player Spawn INFO
				{
					eventArray.push(new ScreenEvent(ScreenEvent.SPAWN_PLAYER,content));			
				}
				if(route == 6000) // Player Movement
				{
					eventArray.push(new MessageEvent(MessageEvent.UPDATE_POSITION,content));			
				}
			}
			return eventArray;
		}
		
		public function tagId(index:int):void
		{
			currentId = index;
		}
		
		public function getPacket():Array
		{
			return packet;
		}
		public function clearPacket():void
		{
			packet = null;
		}
	}
}