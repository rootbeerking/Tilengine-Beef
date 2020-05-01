using Tilengine.Enums;
using System;
namespace Tilengine.Types
{
	[CRepr]
	public struct TileAttributes	// Tileset attributes for constructor
	{
		public uint8 type;			// Tile type
		public bool	priority;		// Priority flag set
	}
}
