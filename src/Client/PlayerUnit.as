package Client
{
	import flash.display.Sprite;

	public class PlayerUnit extends Sprite
	{
		private var circle:Sprite;
		private var radius:int = 20;
		public function PlayerUnit(playerPointX:int,playerPointY:int)
		{
			x = playerPointX;
			y = playerPointY;
			circle = new Sprite();
			circle.graphics.clear();
			circle.graphics.beginFill(0xBDFCC9);
			circle.graphics.lineStyle(2, 0xC0C0C0, 100);
			circle.graphics.drawCircle(radius,radius, radius);
			circle.useHandCursor = false;
			addChild(circle);
		}
	}
}