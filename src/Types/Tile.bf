using Tilengine.Enums;
using System;
namespace Tilengine.Types
{
	[CRepr, Union]
	public struct Tile			// Tile item for Tilemap access methods
	{
	    public uint16 index;	// Tile index
		public uint16 flags;	// Attributes (FLAG_FLIPX, FLAG_FLIPY, FLAG_PRIORITY)
	}
}
