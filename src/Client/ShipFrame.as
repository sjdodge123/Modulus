package Client
{
	import flash.display.Sprite;
	

	public class ShipFrame extends Sprite
	{
		private var extWalls:Sprite;
		public function ShipFrame(spawnPointX:int,spawnPointY:int) 
		{
			buildExteriorWalls(spawnPointX,spawnPointY);
		}
		
		private function buildExteriorWalls(xSpawn,ySpawn):void
		{
			extWalls = new Sprite();
			extWalls.graphics.clear();
			extWalls.graphics.beginFill(0xf2f2f2);
			extWalls.graphics.lineStyle(2, 0xC0C0C0, 100);
			extWalls.graphics.drawRect(xSpawn, ySpawn, 400, 400);
			extWalls.useHandCursor = false;
			addChild(extWalls);
		}
	}
}