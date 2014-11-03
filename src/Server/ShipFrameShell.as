package Server
{
	import flash.geom.Point;
	

	public class ShipFrameShell
	{
		private var friendlyPlayers:Vector.<PlayerUnitShell>;
		private var enemyPlayers:Vector.<PlayerUnitShell>;
		private var projectiles:Vector.<ProjectileShell>;
		private var seats:Vector.<SeatShell>;
		private var playerSpawnLoc:Point;
		private var shipSpawnLoc:Point;
		private var x:int = 50;
		private var y:int = 50;
		private var width:int = 450;
		private var height:int = 400;
		private var radius:int = 20;
		public function ShipFrameShell(... seats) 
		{
			friendlyPlayers = new Vector.<PlayerUnitShell>;
			enemyPlayers = new Vector.<PlayerUnitShell>;
			projectiles = new Vector.<ProjectileShell>;
			this.seats = new Vector.<SeatShell>;
			shipSpawnLoc = new Point(x,y);
			playerSpawnLoc = new Point(x+radius+10,y+radius+10);
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
		
		public function addProjectile(spawnX:int,spawnY:int,mouseX:int,mouseY:int):Array
		{
			var dx:Number = mouseX - spawnX;
			var dy:Number = mouseY - spawnY;
			var mag:Number = Math.sqrt(dx*dx+dy*dy);
			var dirX:Number = dx/mag;
			var dirY:Number = dy/mag;
			projectiles.push(new ProjectileShell(spawnX,spawnY,dirX,dirY));
			var bulletData:Array = new Array();
			bulletData.push(projectiles[projectiles.length-1].getX());
			bulletData.push(projectiles[projectiles.length-1].getY());
			return bulletData;
		}
		
		public function checkBounds(xValue:int,yValue:int):Boolean
		{
			if((width+x -radius > xValue ) && (xValue > x +radius) && (yValue < height + y -radius) && (yValue > y +radius ))
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