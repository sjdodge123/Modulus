package Events
{
	import flash.events.Event;
	
	public class ServerComsEvent extends Event
	{
		public static const PLAYER_JOINED:String = "playerJoined";
		public static const SEND_MESSAGE:String = "sendMessage";
		public var params:Object;
		public function ServerComsEvent(type:String,params:Object,bubbles:Boolean = false,cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
			this.params = params;
		}
		public override function clone():Event
		{
			return new ServerComsEvent(type, this.params, bubbles, cancelable);
		}
		public override function toString():String
		{
			return formatToString("CustomEvent", "params", "type", "bubbles", "cancelable");
		}
		
	}
}