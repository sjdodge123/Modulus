package Server
{
	import flash.geom.Point;
	

	public class ShipFrameShell
	{
		private var friendlyPlayers:Vector.<PlayerUnit>;
		private var enemyPlayers:Vector.<PlayerUnit>;
		private var playerSpawnLoc:Point;
		private var shipSpawnLoc:Point;
		private var x:int = 100;
		private var y:int = 50;
		public function ShipFrameShell() 
		{
			
			friendlyPlayers = new Vector.<PlayerUnit>;
			enemyPlayers = new Vector.<PlayerUnit>;
			shipSpawnLoc = new Point(x,y);
			playerSpawnLoc = new Point(x +5,y+5);
		}
		
		public function addFriendly(friendly:PlayerUnit):void
		{
			friendlyPlayers.push(friendly);
			friendly.spawnPlayer(playerSpawnLoc);
		}
		
		public function addEnemy(enemy:PlayerUnit,loc:Point):void
		{
			
		}
		
		public function getShipSpawnLoc():Point
		{
			return shipSpawnLoc;
		}
		
		public function getPlayerSpawnLoc():Point
		{
			return playerSpawnLoc;
		}
	}
}