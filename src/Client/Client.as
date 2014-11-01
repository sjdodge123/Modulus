package Client
{
	import flash.display.Stage;
	import flash.geom.Point;
	
	import Events.MessageEvent;
	import Events.MovementEvent;
	import Events.ScreenEvent;
	

	public class Client
	{
		private var screen:ClientScreen;
		private var IO:IOMonitor;
		private var coms:ClientComs;
		private var playerList:Vector.<PlayerUnit>; 
		private var myShip:ShipFrame;
		public function Client(stage:Stage)
		{
			screen = new ClientScreen(stage);
			coms = new ClientComs();
			IO = new IOMonitor(stage);
			IO.addEventListener(MovementEvent.FORWARD,handleKeys);
			IO.addEventListener(MovementEvent.REVERSE,handleKeys);
			IO.addEventListener(MovementEvent.LEFT,handleKeys);
			IO.addEventListener(MovementEvent.RIGHT,handleKeys);
			
			coms.addEventListener(ScreenEvent.SPAWN_SHIP,spawnShip);
			coms.addEventListener(MessageEvent.UPDATE_LISTINGS,updateListings);
			coms.addEventListener(MessageEvent.UPDATE_POSITION,movePlayers);
			coms.joinServer("192.168.1.136",8087);
		}
		
		protected function updateListings(event:MessageEvent):void
		{
			if(playerList == null)
			{
				playerList = new Vector.<PlayerUnit>;
				var shellData:Array = event.params as Array;
				for(var i:int=0;i<shellData.length;i++)
				{
					var playerLoc:Array = shellData[i];
					var newPlayer:PlayerUnit = new PlayerUnit(playerLoc[0],playerLoc[1])
					playerList.push(newPlayer);
					screen.addChild(newPlayer);
				}
			}
			else
			{
				shellData = event.params as Array;
				playerLoc = shellData[shellData.length-1]
				newPlayer = new PlayerUnit(playerLoc[0],playerLoc[1])
				playerList.push(newPlayer);
				screen.addChild(newPlayer);
			}
		}
		protected function movePlayers(event:MessageEvent):void
		{
			var shellData:Array = event.params as Array;
			for(var i:int=0;i<shellData.length;i++)
			{
				var playerLoc:Array = shellData[i];
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
			
			if (myShip == null)
			{
				var shipPoint:Point = new Point(event.params.x,event.params.y);
				myShip= new ShipFrame(shipPoint.x,shipPoint.y);
				screen.addChild(myShip);
			}
			
			
		}		
		
		public function getScreen():ClientScreen
		{
			return screen;
		}
	}
}