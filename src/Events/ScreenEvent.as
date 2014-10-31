package Events
{
	import flash.events.Event;
	
	public class ScreenEvent extends Event
	{
		public static const UPDATE_SCREEN:String = "update";
		public static const SPAWN_PLAYER:String = "spawnPlayer";
		public static const SPAWN_SHIP:String = "spawnShip";
		public var params:Object;
		public function ScreenEvent(type:String,params:Object,bubbles:Boolean = false,cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
			this.params = params;
		}
		public override function clone():Event
		{
			return new ScreenEvent(type, this.params, bubbles, cancelable);
		}
		public override function toString():String
		{
			return formatToString("CustomEvent", "params", "type", "bubbles", "cancelable");
		}
		
	}
}