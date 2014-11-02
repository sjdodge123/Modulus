package Server
{
	public class SeatShell
	{
		public var x:int;
		public var y:int;
		public var width:int = 50;
		public var height:int = 50;
		public var type:int;
		public function SeatShell(x:int,y:int,type:int)
		{
			this.x = x;
			this.y = y;
			this.type = type;
		}
		
		public function getType():int
		{
			return type;
		}
		public function getX():int
		{
			return x;
		}
		public function getY():int
		{
			return y;
		}
		public function getWidth():int
		{
			return width;
		}
		public function getHeight():int
		{
			return height;
		}
	}
}