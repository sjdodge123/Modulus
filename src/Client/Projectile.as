package Client
{
	import flash.display.Sprite;

	public class Projectile extends Sprite
	{
		private var bullet:Sprite = new Sprite();
		public function Projectile(xSpawn:Number,ySpawn:Number)
		{
			bullet.graphics.beginFill(0xff1919); 
			bullet.graphics.drawRect(xSpawn,ySpawn,10,1);
//			graphics.drawCircle(xSpawn,ySpawn,10); 
			bullet.graphics.endFill();
			bullet.rotationZ = 20;
			addChild(bullet);
			
		}
	}
}