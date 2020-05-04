using TLN.Enums;
using TLN.Types;
using System;
namespace TLN.Data
{
	[CRepr]
	public struct ObjectInfo	// Object item info returned by TLN_GetObjectInfo()
	{
		public uint16 ID;		// Unique ID
		public uint16 gID;		// Graphic ID (tile index)
		public uint16 Flags;	// Attributes (FlipX, FlipY, Priority)
		public int X;			// Horizontal position
		public int Y;			// Vertical position
		public int Width;		// Horizontal size
		public int Height;		// Vertical size
	}
}
