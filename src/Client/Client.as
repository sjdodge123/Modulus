package Client
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Point;
	
	import Events.MessageEvent;
	import Events.MovementEvent;
	import Events.ScreenEvent;
	import Events.ServerComsEvent;

	public class Client
	{
		private var screen:ClientScreen;
		private var IO:IOMonitor;
		private var coms:ClientComs;
		private var playerList:Vector.<PlayerUnit> = new Vector.<PlayerUnit>; 
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
			coms.addEventListener(MessageEvent.UPDATE_LISTINGS,updateListings);
			coms.addEventListener(MessageEvent.UPDATE_POSITION,movePlayers);
			coms.joinServer("192.168.1.136",8087);
		}
		
		protected function updateListings(event:MessageEvent):void
		{
			var playerListings:Array = event.params as Array;
			for(var i:int=0;i<playerListings.length;i++)
			{
				var playerLoc:Array = playerListings[i];
				playerList = null;
				playerList = new Vector.<PlayerUnit>; 
				playerList.push(new PlayerUnit(playerLoc[0],playerLoc[1]));
			}

		}
		
		protected function movePlayers(event:MessageEvent):void
		{
			var playerListings:Array = event.params as Array;
			for(var i:int=0;i<playerList.length;i++)
			{
				var playerLoc:Array = playerListings[i];
				playerList[i].x = playerLoc[0];
				playerList[i].y = playerLoc[1];
			}
			
		}
		
		protected function handleKeys(event:MovementEvent):void
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
		protected function spawnShip(event:ScreenEvent):void
		{
			var shipPoint:Point = new Point(event.params.x,event.params.y);
			var myShip:ShipFrame = new ShipFrame(shipPoint.x,shipPoint.y);
			screen.addChild(myShip);
		}		
		protected function spawnPlayer(event:ScreenEvent):void
		{
			var playerPoint:Point = new Point(event.params.x,event.params.y);
			playerList.push(new PlayerUnit(playerPoint.x,playerPoint.y));
			screen.addChild(playerList[playerList.length-1]);
		}
		
		public function getScreen():ClientScreen
		{
			return screen;
		}
	}
}