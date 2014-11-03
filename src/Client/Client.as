package Client
{
	import flash.display.Stage;
	import flash.events.Event;
	
	import Events.ActionEvent;
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
			IO.addEventListener(MovementEvent.FORWARD_RIGHT,handleKeys);
			IO.addEventListener(MovementEvent.FORWARD_LEFT,handleKeys);
			IO.addEventListener(MovementEvent.REVERSE_RIGHT,handleKeys);
			IO.addEventListener(MovementEvent.REVERSE_LEFT,handleKeys);
			IO.addEventListener(ActionEvent.ACTION_PRESSED,performAction);
			
			coms.addEventListener(ScreenEvent.SPAWN_SHIP,spawnShip);
			coms.addEventListener(MessageEvent.UPDATE_LISTINGS,updateListings);
			coms.addEventListener(MessageEvent.UPDATE_POSITION,movePlayers);
			coms.joinServer("192.168.1.136",8087);
		}
		
		protected function performAction(event:ActionEvent):void
		{
			
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
			var moveAmount:int = 5;
			var moveChangeData:Array = new Array();
			if(event.type == MovementEvent.FORWARD)
			{
				moveChangeY -=moveAmount;
			}
			if(event.type == MovementEvent.REVERSE)
			{
				moveChangeY +=moveAmount;
			}
			if(event.type == MovementEvent.LEFT)
			{
				moveChangeX -=moveAmount;
			}
			if(event.type == MovementEvent.RIGHT)
			{
				moveChangeX +=moveAmount;
			}
			if(event.type == MovementEvent.FORWARD_RIGHT)
			{
				moveChangeX +=moveAmount/Math.SQRT2;
				moveChangeY -=moveAmount/Math.SQRT2;
			}
			if(event.type == MovementEvent.FORWARD_LEFT)
			{
				moveChangeX -=moveAmount/Math.SQRT2;
				moveChangeY -=moveAmount/Math.SQRT2;
			}
			if(event.type == MovementEvent.REVERSE_LEFT)
			{
				moveChangeX -=moveAmount/Math.SQRT2;
				moveChangeY +=moveAmount/Math.SQRT2;
			}
			if(event.type == MovementEvent.REVERSE_RIGHT)
			{
				moveChangeX +=moveAmount/Math.SQRT2;
				moveChangeY +=moveAmount/Math.SQRT2;
			}
			
			moveChangeData.push(moveChangeX);
			moveChangeData.push(moveChangeY);
			coms.sendFile(0,6000,moveChangeData);
		}
		protected function spawnShip(event:ScreenEvent):void
		{
			if (myShip == null)
			{
				var shipData:Array = event.params as Array;
				var xLoc:int = shipData[0];
				var yLoc:int = shipData[1];
				var widthData:int = shipData[2];
				var heightData:int = shipData[3];
				var seatArray:Array = shipData[4];
				myShip = new ShipFrame(xLoc,yLoc,widthData,heightData,seatArray);
				screen.addChild(myShip);
			}
		}		
		
		public function getScreen():ClientScreen
		{
			return screen;
		}
	}
}