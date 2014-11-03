package Server
{
	public class ProjectileShell
	{
		private var x:Number;
		private var y:Number;
		private var dirX:Number;
		private var dirY:Number;
		
		public function ProjectileShell(spawnX:int,spawnY:int,dirX:Number,dirY:Number)
		{
			
			this.x = spawnX + 100*dirX;
			this.y = spawnY + 100*dirX;
			this.dirX = dirX;
			this.dirY = dirY;
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