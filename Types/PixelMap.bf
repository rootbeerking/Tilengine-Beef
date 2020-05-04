using TLN.Enums;
using TLN.Types;
using System;
namespace TLN.Data
{
	[CRepr]
	public struct PixelMap	// Pixel mapping for Layer.SetPixelMapping
	{
		public int16 dX;	// Horizontal Pixel Displacement
		public int16 dY;	// Vertical Pixel Displacement
	}
}
