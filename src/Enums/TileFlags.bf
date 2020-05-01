namespace Tilengine.Enums
{
	public enum TileFlags 		  // List of flags for tiles and sprites	
	{							  // Can be none or a combination of the following:
		None        = (0),
		FlipX       = (1 << 15),
		FlipY       = (1 << 14),
		Rotate      = (1 << 13),
		Priority    = (1 << 12)
	}
}
