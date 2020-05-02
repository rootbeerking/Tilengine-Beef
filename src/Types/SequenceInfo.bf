using TLN.Enums;
using System;
namespace TLN.Types
{
	[CRepr]
	public struct SequenceInfo	// Sequence info returned by Sequence.GetInfo
	{
		public char32 Name;		// Sequence Name
		public int NumFrames;	// Number of Frames
	}
}
