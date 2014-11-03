package Client
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import Events.MovementEvent;

	public class IOMonitor extends EventDispatcher
	{
		private var forward:Boolean;
		private var reverse:Boolean;
		private var right:Boolean;
		private var left:Boolean;
		
		public function IOMonitor(gameStage:Stage)
		{
			gameStage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
			gameStage.addEventListener(KeyboardEvent.KEY_UP, keyReleased);
			gameStage.addEventListener(Event.ENTER_FRAME, updateKeys);
		}
		
		protected function updateKeys(event:Event):void
		{
			if(forward && right)
			{
				dispatchEvent(new MovementEvent(MovementEvent.FORWARD_RIGHT,null));
			}
			else if(forward && left)
			{
				dispatchEvent(new MovementEvent(MovementEvent.FORWARD_LEFT,null));
			}
			else if(reverse && right)
			{
				dispatchEvent(new MovementEvent(MovementEvent.REVERSE_RIGHT,null));
			}
			else if(reverse && left)
			{
				dispatchEvent(new MovementEvent(MovementEvent.REVERSE_LEFT,null));
			}
			else if(forward)
			{
				dispatchEvent(new MovementEvent(MovementEvent.FORWARD,null));
			}
			else if(reverse)
			{
				dispatchEvent(new MovementEvent(MovementEvent.REVERSE,null));
			}
			else if(left)
			{
				dispatchEvent(new MovementEvent(MovementEvent.LEFT,null));
			}
			else if(right)
			{
				dispatchEvent(new MovementEvent(MovementEvent.RIGHT,null));
			}
			
		}
		
		private function keyPressed(event:KeyboardEvent):void
		{
			switch(event.keyCode)	
			{	
				case Keyboard.W:
				{
					forward = true;
					break;
				}
				case Keyboard.S:
				{
					reverse = true;
					break;
				}
				case Keyboard.A:
				{
					left = true;
					break;
				}
				case Keyboard.D:
				{
					right = true;
					break;
				}
			}
		}
		private function keyReleased(event:KeyboardEvent):void
		{
			switch(event.keyCode)	
			{	
				case Keyboard.W:
				{
					forward = false;
					break;
				}
				case Keyboard.S:
				{
					reverse = false;
					break;
				}
				case Keyboard.A:
				{
					left = false;
					break;
				}
				case Keyboard.D:
				{
					right = false;
					break;
				}
			}
		}
	}
}
