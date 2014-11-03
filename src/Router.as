package
{
	import Events.ActionEvent;
	import Events.MessageEvent;
	import Events.ScreenEvent;
	import Events.ServerComsEvent;
	import Events.SpawnEvent;

	public class Router
	{
		private var packet:Array = new Array();
		private var currentId:int = 0;
		public function Router()
		{
		}
		
		
		public function pack(file:DataFile):void
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
				var file:DataFile = new DataFile(packet[i].type,packet[i].route,packet[i].content);
				
				if(file.route == 1000) // Connection INFO
				{
					eventArray.push(new ServerComsEvent(ServerComsEvent.PLAYER_JOINED,file.content));
				}
				if(file.route  == 5000) // Ship Spawn INFO
				{
					eventArray.push(new ScreenEvent(ScreenEvent.SPAWN_SHIP,file.content));			
				}
				if(file.route  == 5001) // Update Listings
				{
					eventArray.push(new MessageEvent(MessageEvent.UPDATE_LISTINGS,file.content));			
				}
				if(file.route  == 5002) // Spawn Bullet
				{
					eventArray.push(new SpawnEvent(SpawnEvent.BULLET,file.content));			
				}
				if(file.route  == 6000) // Player Movement
				{
					eventArray.push(new MessageEvent(MessageEvent.UPDATE_POSITION,file.content));			
				}
				if(file.route  == 6001) // Action Performed
				{
					eventArray.push(new ActionEvent(ActionEvent.BOARD_SEAT,file.content));			
				}
				if(file.route  == 6002) // Mouse Clicked
				{
					eventArray.push(new ActionEvent(ActionEvent.FIRE,file.content));			
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