package Client
{
	import flash.display.Sprite;
	

	public class ShipFrame extends Sprite
	{
		private var extWalls:Sprite;
		private var seats:Vector.<Seat>;
		private var projectiles:Vector.<Projectile>;
		public function ShipFrame(spawnPointX:int,spawnPointY:int,shipWidth:int,shipHeight:int,seats:Array) 
		{
			this.seats = new Vector.<Seat>;
			projectiles = new Vector.<Projectile>;
			buildExteriorWalls(spawnPointX,spawnPointY,shipWidth,shipHeight);
			addSeats(seats);
		}
		
		public function spawnBullet(spawnX:Number,spawnY:Number):void
		{
			projectiles.push(new Projectile(spawnX,spawnY));
			addChild(projectiles[projectiles.length-1]);
		}
		
		private function addSeats(seats:Array):void
		{
			for(var i:int=0;i<seats.length;i++)
			{
				this.seats.push(new Seat(seats[i].x,seats[i].y,seats[i].width,seats[i].height,seats[i].type));
				addChild(this.seats[i]);
			}
		}
		
		private function buildExteriorWalls(xSpawn:int,ySpawn:int,shipWidth:int,shipHeight:int):void
		{
			extWalls = new Sprite();
			extWalls.graphics.clear();
			extWalls.graphics.beginFill(0xf2f2f2);
			extWalls.graphics.lineStyle(2, 0xC0C0C0, 100);
			extWalls.graphics.drawRect(xSpawn, ySpawn,shipWidth, shipHeight);
			extWalls.useHandCursor = false;
			addChild(extWalls);
		}
	}
}