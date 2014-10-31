package Client
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Point;
	
	import Events.MessageEvent;
	import Events.MovementEvent;
	import Events.ScreenEvent;

	public class Client
	{
		private var screen:ClientScreen;
		private var IO:IOMonitor;
		private var coms:ClientComs;
		private var player:PlayerUnit; 
		public function Client(stage:Stage)
		{
			screen = new ClientScreen();
			coms = new ClientComs();
			IO = new IOMonitor(stage);
			IO.addEventListener(MovementEvent.FORWARD,handleKeys);
			IO.addEventListener(MovementEvent.REVERSE,handleKeys);
			IO.addEventListener(MovementEvent.LEFT,handleKeys);
			IO.addEventListener(MovementEvent.RIGHT,handleKeys);
			
			coms.addEventListener(ScreenEvent.SPAWN_SHIP,spawnShip);
			coms.addEventListener(ScreenEvent.SPAWN_PLAYER,spawnPlayer);
			coms.addEventListener(MessageEvent.UPDATE_POSITION,movePlayer);
			coms.joinServer("192.168.1.136",8087);
		}
		
		protected function movePlayer(event:MessageEvent):void
		{
			player.x = event.params[0];
			player.y = event.params[1];
			trace(player.x);
		}
		
		protected function handleKeys(event:MovementEvent):void
		{
			if(player != null)
			{
				var moveChangeX:int= 0;
				var moveChangeY:int= 0;
				var moveChangeData:Array = new Array();
				if(event.type == MovementEvent.FORWARD)
				{
					moveChangeY -=5;
				}
				if(event.type == MovementEvent.REVERSE)
				{
					moveChangeY +=5
				}
				if(event.type == MovementEvent.LEFT)
				{
					moveChangeX -=5
				}
				if(event.type == MovementEvent.RIGHT)
				{
					moveChangeX +=5
				}
				moveChangeData.push(moveChangeX);
				moveChangeData.push(moveChangeY);
				var file:Array = new Array();
				file.push(0);
				file.push(6000);
				file.push(moveChangeData);
				coms.sendData(file);
			}
		}
		protected function spawnShip(event:ScreenEvent):void
		{
			var shipPoint:Point = new Point(event.params.x,event.params.y);
			var myShip:ShipFrame = new ShipFrame(shipPoint.x,shipPoint.y);
			screen.addChild(myShip);
		}		
		protected function spawnPlayer(event:ScreenEvent):void
		{
			var playerPoint:Point = new Point(event.params.x,event.params.y);
			player = new PlayerUnit(playerPoint.x,playerPoint.y);
			trace(player.x)
			screen.addChild(player);
		}
		
		public function getScreen():ClientScreen
		{
			return screen;
		}
	}
}