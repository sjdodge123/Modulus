package Events
{
	import flash.events.Event;
	
	public class ActionEvent extends Event
	{
		public static const ACTION_PRESSED:String = "action";
		public static const BOARD_SEAT:String = "sit";
		public static const FIRE:String = "fire";
		
		public var params:Object;
		public function ActionEvent(type:String,params:Object,bubbles:Boolean = false,cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
			this.params = params;
		}
		public override function clone():Event
		{
			return new ActionEvent(type, this.params, bubbles, cancelable);
		}
		public override function toString():String
		{
			return formatToString("CustomEvent", "params", "type", "bubbles", "cancelable");
		}
		
	}
}