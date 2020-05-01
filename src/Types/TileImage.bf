using Tilengine.Enums;
using System;
namespace Tilengine.Types
{
	[CRepr]
	public struct TileImage			// Image Tile items for TLN_CreateImageTileset()
	{
	    public TLN_Bitmap bitmap;
		public uint16 id;
		public uint8	type;
	}
}
