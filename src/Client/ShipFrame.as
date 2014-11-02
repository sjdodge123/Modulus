package Client
{
	import flash.display.Sprite;
	

	public class ShipFrame extends Sprite
	{
		private var extWalls:Sprite;
		public function ShipFrame(spawnPointX:int,spawnPointY:int,shipWidth:int,shipHeight:int) 
		{
			buildExteriorWalls(spawnPointX,spawnPointY,shipWidth,shipHeight);
		}
		
		private function buildExteriorWalls(xSpawn:int,ySpawn:int,shipWidth:int,shipHeight:int):void
		{
			extWalls = new Sprite();
			extWalls.graphics.clear();
			extWalls.graphics.beginFill(0xf2f2f2);
			extWalls.graphics.lineStyle(2, 0xC0C0C0, 100);
			extWalls.graphics.drawRect(xSpawn, ySpawn,shipWidth, shipHeight);
			extWalls.useHandCursor = false;
			addChild(extWalls);
		}
	}
}