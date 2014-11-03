package Client
{
	import flash.display.Sprite;

	public class Projectile extends Sprite
	{
		public function Projectile(xSpawn:Number,ySpawn:Number)
		{
			graphics.beginFill(0x000000); 
			graphics.drawCircle(xSpawn,ySpawn,10); 
			graphics.endFill();
			
		}
	}
}