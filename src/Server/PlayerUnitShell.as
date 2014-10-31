package Server
{
	public class PlayerUnitShell
	{
		private var x:int;
		private var y:int;
		private var id:int
		public function PlayerUnitShell(id:int,x:int,y:int)
		{
			this.id = id;
			this.x = x;
			this.y = y;
		}
		
		public function getId():int
		{
			return id;
		}
		
		public function setX(x:int):void
		{
			this.x = x;
		}
		public function setY(y:int):void
		{
			this.y = y;
		}
		
		public function getX():int
		{
			return x;
		}
		public function getY():int
		{
			return y;
		}
	}
}