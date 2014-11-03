package Server
{
	public class PlayerShell
	{
		private var homeShipId:int;
		private var playerId:int;
		public function PlayerShell(playerId:int,homeShipId:int)
		{
			this.homeShipId = homeShipId;
			this.playerId = playerId;
		}
		public function getHomeShipId():int
		{
			return homeShipId;
		}
		public function getPlayerId():int
		{
			return playerId;
		}
	}
}