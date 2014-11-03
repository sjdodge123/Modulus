package Client
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import Events.ScreenEvent;

	public class ClientScreen extends Sprite
	{
		private var mouse:MouseTracking;
		public function ClientScreen(stage:Stage)
		{
			mouse = new MouseTracking(stage);
			addChild(mouse);
			mouse.addEventListener(ScreenEvent.INDEX_ORDER,moveToFront);
		}
		
		
		public function moveToFront(event:ScreenEvent):void
		{
			setChildIndex(event.params as Sprite,numChildren-1);
		}
		
		public function updateScreen(updateInfo:Array):void
		{
		
		}
		
		
		
		
		
	}
}