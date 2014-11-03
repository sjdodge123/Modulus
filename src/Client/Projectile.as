package Client
{
	import flash.display.Sprite;

	public class Projectile extends Sprite
	{
		public function Projectile(x:Number,y:Number)
		{
			this.x = x;
			this.y = y;
			graphics.beginFill(0x000000); 
			graphics.drawCircle(x,y,10); 
			graphics.endFill();
			
		}
	}
}