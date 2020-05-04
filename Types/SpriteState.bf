using TLN.Enums;
using TLN.Types;
using System;
namespace TLN.Data
{
	[CRepr]
	public struct SpriteState 			// State of Sprite
	{
		public int X;					// Screen Position X
		public int Y;					// Screen Position Y
		public int W;					// Actual width in screen (after scaling)
		public int H;					// Actual height in screen (after scaling)
		public TileFlags Flags;			// Flags
		public Palette Palette;		// Assigned Palette	 
		public Spriteset Spriteset;	// Assigned Spriteset	
		public int Index;				// Graphic index inside Spriteset 
		public bool Enabled;			// Enabled or not 
		public bool Collision;			// Per-Pixel Collision detection enabled or not
	}
}
