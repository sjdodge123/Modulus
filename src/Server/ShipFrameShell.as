package Server
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	import Events.ActionEvent;
	import Events.MessageEvent;
	import Events.ServerComsEvent;
	

	public class ShipFrameShell extends EventDispatcher
	{
		private var coms:ServerComs;
		private var playerShells:Vector.<PlayerUnitShell> = new Vector.<PlayerUnitShell>;
		private var friendlyPlayers:Vector.<PlayerUnitShell>;
		private var enemyPlayers:Vector.<PlayerUnitShell>;
		private var projectiles:Vector.<ProjectileShell>;
		private var seats:Vector.<SeatShell>;
		private var playerSpawnLoc:Point;
		private var shipSpawnLoc:Point;
		private var x:int = 50;
		private var y:int = 50;
		private var width:int = 450;
		private var height:int = 400;
		private var radius:int = 20;
		private var currentPlayer:int;
		public function ShipFrameShell(coms:ServerComs, ... seats) 
		{
			friendlyPlayers = new Vector.<PlayerUnitShell>;
			enemyPlayers = new Vector.<PlayerUnitShell>;
			projectiles = new Vector.<ProjectileShell>;
			this.seats = new Vector.<SeatShell>;
			this.coms = coms;
			coms.addEventListener(ActionEvent.FIRE,mouseClicked);
			coms.addEventListener(MessageEvent.CLIENT_ID,changeIndex);
			coms.addEventListener(ServerComsEvent.PLAYER_JOINED,addPlayer);
			coms.addEventListener(MessageEvent.UPDATE_POSITION,updatePlayer);
			coms.addEventListener(ActionEvent.BOARD_SEAT,sitDown);
			shipSpawnLoc = new Point(x,y);
			playerSpawnLoc = new Point(x+radius+10,y+radius+10);
			for(var i:int;i<seats.length;i++)
			{
				this.seats.push(seats[i]);
			}
		}
		
		protected function changeIndex(event:MessageEvent):void
		{
			currentPlayer = event.params as int;
		}
		protected function sitDown(event:Event):void
		{
			
		}	
		
		protected function updatePlayer(event:MessageEvent):void
		{
			var currentX:int = playerShells[currentPlayer].getX();
			var currentY:int = playerShells[currentPlayer].getY();
			if(checkBounds(currentX + event.params[0],currentY + event.params[1]))
			{
				playerShells[currentPlayer].setX(currentX + event.params[0]);
				playerShells[currentPlayer].setY(currentY + event.params[1]);
				var shellData:Array = new Array();
				for(var i:int;i<playerShells.length;i++)
				{
					var playerLoc:Array = new Array();
					playerLoc.push(playerShells[i].getX());
					playerLoc.push(playerShells[i].getY());
					shellData.push(playerLoc);
				}
				coms.sendFile(0,6000,shellData);
			}
		}
		
		protected function addPlayer(event:ServerComsEvent):void
		{
			var index:int = event.params as int;
			var shipData:Array = new Array();
			shipData.push(getShipSpawnLoc().x);
			shipData.push(getShipSpawnLoc().y);
			shipData.push(getWidth());
			shipData.push(getHeight());
			shipData.push(getSeats());
			var player:PlayerUnitShell= new PlayerUnitShell(index,getPlayerSpawnLoc().x,getPlayerSpawnLoc().y)
			playerShells.push(player);
			addFriendly(player);
			var shellData:Array = new Array();
			for(var i:int;i<playerShells.length;i++)
			{
				var playerLoc:Array = new Array();
				playerLoc.push(playerShells[i].getX());
				playerLoc.push(playerShells[i].getY());
				shellData.push(playerLoc);
			}
			coms.sendFile(0,5000,shipData);
			coms.sendFile(0,5001,shellData);
		}
		
		
		
		protected function mouseClicked(event:ActionEvent):void
		{
			var bulletData:Array = addProjectile(playerShells[currentPlayer].getX(),playerShells[currentPlayer].getY(),event.params[0],event.params[1]);
			coms.sendFile(0,5002,bulletData);
		}
		
		public function addFriendly(friendly:PlayerUnitShell):void
		{
			friendlyPlayers.push(friendly);
		}
		
		public function addEnemy(enemy:PlayerUnitShell):void
		{
			
		}
		
		public function addProjectile(spawnX:int,spawnY:int,mouseX:int,mouseY:int):Array
		{
			var dx:Number = mouseX - spawnX;
			var dy:Number = mouseY - spawnY;
			var mag:Number = Math.sqrt(dx*dx+dy*dy);
			var dirX:Number = dx/mag;
			var dirY:Number = dy/mag;
			projectiles.push(new ProjectileShell(spawnX,spawnY,dirX,dirY));
			var bulletData:Array = new Array();
			bulletData.push(projectiles[projectiles.length-1].getX());
			bulletData.push(projectiles[projectiles.length-1].getY());
			return bulletData;
		}
		
		public function checkBounds(xValue:int,yValue:int):Boolean
		{
			if((width+x -radius > xValue ) && (xValue > x +radius) && (yValue < height + y -radius) && (yValue > y +radius ))
			{
				return true;
			}
			return false;
		}
		
		public function getSeats():Array
		{
			var seatArray:Array = new Array();
			for(var i:int=0;i<this.seats.length;i++)
			{
				seatArray.push(this.seats[i])
			}
			return seatArray;
		}
		
		public function getWidth():int
		{
			return width;
		}
		public function getHeight():int
		{
			return height;
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