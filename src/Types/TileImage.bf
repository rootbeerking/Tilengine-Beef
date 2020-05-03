using TLN.Enums;
using TLN.Types;
using System;
namespace TLN.Data
{
	[CRepr]
	public struct TileImage			// Image Tile items for TLN_CreateImageTileset()
	{
	    public Bitmap bitmap;
		public uint16 id;
		public uint8	type;
	}
}
