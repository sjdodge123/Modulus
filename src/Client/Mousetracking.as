package Client
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	import Events.ScreenEvent;

	public class MouseTracking extends Sprite
	{
		private var cursor:Sprite = new Sprite();
		public function MouseTracking(stage:Stage)
		{
			cursor.graphics.beginFill(0x000000); 
			cursor.graphics.drawCircle(0,0,5); 
			cursor.graphics.endFill(); 
			addChild(cursor);
			stage.addEventListener(MouseEvent.MOUSE_MOVE,redrawCursor);
			Mouse.hide();
		}
		
		protected function redrawCursor(event:MouseEvent):void
		{
			dispatchEvent(new ScreenEvent(ScreenEvent.INDEX_ORDER,this));
			cursor.x = event.stageX; 
			cursor.y = event.stageY;
		}
	}
}