using TLN.Enums;
using System;
namespace TLN.Types
{
	[CRepr]
	public struct SpriteData // Data used to create Spriteset objects
	{
		public char32 Name;  // Entry name
		public int X;		 // Horizontal Position
		public int Y;		 // Vertical Position
		public int W;		 // Width
		public int H;		 // Height
	}
}
