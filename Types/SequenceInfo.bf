using TLN.Enums;
using TLN.Types;
using System;
namespace TLN.Data
{
	[CRepr]
	public struct SequenceInfo	// Sequence info returned by Sequence.GetInfo
	{
		public char32 Name;		// Sequence Name
		public int NumFrames;	// Number of Frames
	}
}
