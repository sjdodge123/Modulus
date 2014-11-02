package Server
{
	import flash.geom.Point;
	

	public class ShipFrameShell
	{
		private var friendlyPlayers:Vector.<PlayerUnitShell>;
		private var enemyPlayers:Vector.<PlayerUnitShell>;
		private var playerSpawnLoc:Point;
		private var shipSpawnLoc:Point;
		private var x:int = 50;
		private var y:int = 50;
		private var width:int = 700;
		private var height:int = 400;
		private var padding:int = 20;
		public function ShipFrameShell() 
		{
			friendlyPlayers = new Vector.<PlayerUnitShell>;
			enemyPlayers = new Vector.<PlayerUnitShell>;
			shipSpawnLoc = new Point(x,y);
			playerSpawnLoc = new Point(x+padding,y+padding);
		}
		
		public function addFriendly(friendly:PlayerUnitShell):void
		{
			friendlyPlayers.push(friendly);
		}
		
		public function addEnemy(enemy:PlayerUnitShell):void
		{
			
		}
		
		public function checkBounds(xValue:int,yValue:int):Boolean
		{
			if((width+x-padding*2 > xValue ) && (xValue > x) && (yValue < height + y-padding*2) && (yValue > y ))
			{
				return true;
			}
			return false;
		}
		
		public function getWidth():int
		{
			return width;
		}
		public function getHeight():int
		{
			return height;
		}
		
		public function getShipSpawnLoc():Point
		{
			return shipSpawnLoc;
		}
		
		public function getPlayerSpawnLoc():Point
		{
			return playerSpawnLoc;
		}
	}
}