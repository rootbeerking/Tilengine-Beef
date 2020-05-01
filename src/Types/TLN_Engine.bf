using Tilengine.Enums;
using System;
namespace Tilengine.Types
{
	[CRepr]
	public struct TLN_Engine	// Engine context
	{							// data refers to a void *
		public void* Engine;	// I have no idea what I'm doing here...
	}
}
