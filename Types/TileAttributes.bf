using TLN.Enums;
using TLN.Types;
using System;
namespace TLN.Data
{
	[CRepr]
	public struct TileAttributes	// Tileset attributes for constructor
	{
		public uint8 type;			// Tile type
		public bool	priority;		// Priority flag set
	}
}
