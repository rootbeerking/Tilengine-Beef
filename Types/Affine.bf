using TLN.Enums;
using TLN.Types;
using System;
namespace TLN.Data
{
	[CRepr]
	public struct Affine		    // Affine transformation parameters
	{
	    public float Angle;         // Rotation in degrees
	    public float dX;    		// Horizontal translation
	    public float dY;      		// Vertical translation
		public float sX;			// Horizontal scaling 
		public float sY;		  	// Vertical scaling
	}
}
