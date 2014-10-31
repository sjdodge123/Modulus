package Client
{
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import Events.MovementEvent;
	import flash.display.Stage;

	public class IOMonitor extends EventDispatcher
	{
		public function IOMonitor(gameStage:Stage)
		{
			gameStage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
		}
		
		private function keyPressed(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case Keyboard.W:
				{
					dispatchEvent(new MovementEvent(MovementEvent.FORWARD,null));
					break;
				}
				case Keyboard.A:
				{
					dispatchEvent(new MovementEvent(MovementEvent.LEFT,null));
					break;
				}
				case Keyboard.S:
				{
					dispatchEvent(new MovementEvent(MovementEvent.REVERSE,null));
					break;
				}
				case Keyboard.D:
				{
					dispatchEvent(new MovementEvent(MovementEvent.RIGHT,null));
					break;
				}
			}
			
		}
	}
}