package Client
{
	import flash.display.Sprite;

	public class Seat extends Sprite
	{
		private var type:int;
		private var seatColor:uint = 0x000000;
		public function Seat(xSpawn:int, ySpawn:int,seatWidth:int, seatHeight:int,type:int)
		{
			this.type = type;
			
			if(type == 0)
			{
				seatColor = 0xff7676;
			}
			if(type == 1)
			{
				seatColor = 0x37FDFC;
			}
			graphics.clear();
			graphics.beginFill(seatColor);
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