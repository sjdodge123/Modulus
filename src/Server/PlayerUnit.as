package Server
{
	import flash.display.Sprite;
	import flash.geom.Point;

	public class PlayerUnit extends Sprite
	{
		private var circle:Sprite;
		private var radius:int = 20;
		public function PlayerUnit()
		{
			
		}
		
		public function spawnPlayer(loc:Point):void
		{
			circle = new Sprite();
			circle.graphics.clear();
			circle.graphics.beginFill(0xBDFCC9);
			circle.graphics.lineStyle(2, 0xC0C0C0, 100);
			circle.graphics.drawCircle(loc.x+radius+5,loc.y+radius+5, radius);
			circle.useHandCursor = false;
			addChild(circle);
		}
	}
}