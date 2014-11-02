package Server
{
	import flash.geom.Point;
	

	public class ShipFrameShell
	{
		private var friendlyPlayers:Vector.<PlayerUnitShell>;
		private var enemyPlayers:Vector.<PlayerUnitShell>;
		private var seats:Vector.<SeatShell>;
		private var playerSpawnLoc:Point;
		private var shipSpawnLoc:Point;
		private var x:int = 50;
		private var y:int = 50;
		private var width:int = 600;
		private var height:int = 600;
		private var padding:int = 20;
		public function ShipFrameShell(... seats) 
		{
			friendlyPlayers = new Vector.<PlayerUnitShell>;
			enemyPlayers = new Vector.<PlayerUnitShell>;
			this.seats = new Vector.<SeatShell>;
			shipSpawnLoc = new Point(x,y);
			playerSpawnLoc = new Point(x+padding,y+padding);
			for(var i:int;i<seats.length;i++)
			{
				this.seats.push(seats[i]);
			}
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
		
		public function getSeats():Array
		{
			var seatArray:Array = new Array();
			for(var i:int=0;i<this.seats.length;i++)
			{
				seatArray.push(this.seats[i])
			}
			return seatArray;
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