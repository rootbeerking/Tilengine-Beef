namespace TLN.Enums
{
	public enum WindowFlags :int	  	// List of flag values for window creation
	{						  	// Can be none or a combination of the following:
	    Fullscreen = (1 << 0),	// Create a Fullscreen Window
		Vsync = (1 << 1),	  	// Sync frame updates with vertical retrace
		S1 = (1 << 2),		  	// Create a Window the same size as the framebuffer
		S2 = (2 << 2),		  	// Create a Window 2x the size the framebuffer
		S3 = (3 << 2),		  	// Create a Window 3x the size the framebuffer
		S4 = (4 << 2),		  	// Create a Window 4x the size the framebuffer
		S5 = (5 << 2),		  	// Create a Window 5x the size the framebuffer
		Nearest	= (1 << 6) 		// unfiltered up-scaling
	}
}
