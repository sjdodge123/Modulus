package Events
{
	import flash.events.Event;

	public class MessageEvent extends Event
	{
		public static const SEND_MESSAGE:String = "sendMessage";
		public static const RECEIVE_MESSAGE:String = "receiveMessage";
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