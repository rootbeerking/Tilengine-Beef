using TLN.Enums;
using TLN.Types;
using System;
namespace TLN.Data
{
	[CRepr]
	public struct SequenceFrame	  // Data used to define each frame of an animation for Sequence objects
	{
		public int index;		  // Tile/Sprite index
		public int delay;		  // Time delay for next frame
	}
}
