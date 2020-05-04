using System;
namespace TLN.Enums
{
	[AllowDuplicates]
	public enum Blend : int // Layer blend modes for Layers and Sprites.
	{				  // Must set one of these; choice is mutually exclusive:
	    None,		  // Disable Blending
		Mix25,		  // Color averaging 1
		Mix50,	      // Color averaging 2
		Mix75,	 	  // Color averaging 3
		Add,		  // Color is always brighter (Simulate Light Effects)
		Sub,		  // Color is always darker (Simulate Shadow Effects) 
		Mod,		  // Color is always darker (Simulate Shadow Effects) 
		Custom,		  // User provided blend function with SetCustomBlendFunction()
		Max_Blend,	  // ???
		Mix = Mix50	  // ???
	}
}
