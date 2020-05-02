using TLN.Enums;
using System;
namespace TLN.Types
{
	[CRepr]
	public struct TileImage			// Image Tile items for TLN_CreateImageTileset()
	{
	    public Bitmap bitmap;
		public uint16 id;
		public uint8	type;
	}
}
