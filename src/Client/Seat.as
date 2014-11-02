package Client
{
	import flash.display.Sprite;

	public class Seat extends Sprite
	{
		private var type:int;
		public function Seat(xSpawn:int, ySpawn:int,seatWidth:int, seatHeight:int,type:int)
		{
			this.type = type;
			graphics.clear();
			graphics.beginFill(0xff7676);
			graphics.lineStyle(2, 0xC0C0C0, 100);
			graphics.drawRect(xSpawn, ySpawn,seatWidth, seatHeight);
			useHandCursor = false;
		}
		public function getType():int
		{
			return type;
		}
	}
}