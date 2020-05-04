using TLN.Enums;
using TLN.Types;
using System;
namespace TLN.Data
{
	[CRepr]
	public struct ColorStrip	// Data used to define each frame of a color cycle for Sequence objects
	{
		public int Delay;		// Time delay between frames
		public uint8 First;		// Index of first color to cycle
		public uint8 Count;		// Number of colors in the cycle
		public uint8 Dir;		// Direction: 0 = Descending, 1 = Ascending
	}
}
