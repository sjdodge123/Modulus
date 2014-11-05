package Server
{
	public class ProjectileShell
	{
		private var x:Number;
		private var y:Number;
		private var dirX:Number;
		private var dirY:Number;
		private var velocity:Number = 10;
		private var velX:Number;
		private var velY:Number;
		private var bulletStuff:Array;
		
		public function ProjectileShell(spawnX:int,spawnY:int,dirX:Number,dirY:Number)
		{
			this.x = spawnX + 30*dirX;
			this.y = spawnY + 30*dirY;
			this.dirX = dirX;
			this.dirY = dirY;
			velX = velocity*dirX;
			velY = velocity*dirY;
		}
		
		public function update(dt:Number):Array
		{
			this.x += velX * dt;
			this.y += velY * dt;
			bulletStuff = new Array();
			bulletStuff.push(this.x);
			bulletStuff.push(this.y);
			return bulletStuff;
		}
		
		public function getVelX():Number
		{
			return velX;
		}
		
		public function getVelY():Number
		{
			return velY;
		}
		public function getVelocity():Number
		{
			return velocity;
		}
		
		public function getX():Number
		{
			return x;
		}
		public function getY():Number
		{
			return y;
		}
	}
}