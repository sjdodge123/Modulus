package Events
{
	import flash.events.Event;

	public class MessageEvent extends Event
	{
		public static const CLIENT_ID:String = "clientId";
		public static const UPDATE_POSITION:String = "update_Position";
		public static const UPDATE_LISTINGS:String = "update_Listings";
		public var params:Object;
		public function MessageEvent(type:String,params:Object,bubbles:Boolean = false,cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
			this.params = params;
		}
		public override function clone():Event
		{
			return new MessageEvent(type, this.params, bubbles, cancelable);
		}
		public override function toString():String
		{
			return formatToString("CustomEvent", "params", "type", "bubbles", "cancelable");
		}
		
	}
}