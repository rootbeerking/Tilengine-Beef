namespace TLN.Enums
{
	public enum Overlay : int	// Overlays for CRT effect
	{
		None,
		ShadowMask,
		Aperture,
		Scanlines,
		Custom			// User-provided when calling TLN_CreateWindow()
	}
}
