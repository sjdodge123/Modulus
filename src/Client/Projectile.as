package Client
{
	import flash.display.Sprite;

	public class Projectile extends Sprite
	{
		private var bullet:Sprite = new Sprite();
		private var bulletWidth:Number = 10;
		private var bulletHeight:Number = 1;
		private var velX:Number;
		private var velY:Number;
		
		public function Projectile(xSpawn:Number,ySpawn:Number,velX:Number,velY:Number)
		{
			this.x = xSpawn;
			this.y = ySpawn;
			this.velX = velX;
			this.velY = velY;
			bullet.graphics.beginFill(0xff1919); 
			bullet.graphics.drawRect(-bulletWidth/2,-bulletHeight/2,bulletWidth,bulletHeight);
			bullet.graphics.endFill();
			bullet.rotationZ = 180*Math.atan(velY/velX)/Math.PI;
			addChild(bullet);
			
		}
		public function update(dt:Number):void
		{
			this.x += velX * dt;
			this.y += velY * dt;
		}
	}
}