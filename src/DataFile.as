package
{
	public class DataFile
	{
		public var type:int;
		public var route:int;
		public var content:Object;
		public function DataFile(type:int=0,route:int=0,content:Object=null)
		{
			this.type = type;
			this.route = route;
			this.content = content;
		}
	}
}