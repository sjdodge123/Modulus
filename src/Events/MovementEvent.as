package Events
{
	import flash.events.Event;
	
	public class MovementEvent extends Event
	{
		public static const FORWARD:String = "forward";
		public static const REVERSE:String = "reverse";
		public static const LEFT:String = "left";
		public static const RIGHT:String = "right";
		public static const FORWARD_RIGHT:String = "forward_right";
		public static const FORWARD_LEFT:String = "forward_left";
		public static const REVERSE_RIGHT:String = "reverse_right";
		public static const REVERSE_LEFT:String = "reverse_left";
		public static const UPDATE:String = "update";
		public var params:Object;
		public function MovementEvent(type:String,params:Object,bubbles:Boolean = false,cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
			this.params = params;
		}
		public override function clone():Event
		{
			return new MovementEvent(type, this.params, bubbles, cancelable);
		}
		public override function toString():String
		{
			return formatToString("CustomEvent", "params", "type", "bubbles", "cancelable");
		}
		
	}
}