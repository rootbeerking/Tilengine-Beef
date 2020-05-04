namespace TLN.Enums
{
	public enum Error : int	// List of possible exception Error codes
	{
		Ok,			  	// No Error
		OutOfMemory,  	// Not enough memory
		IdxLayer,	  	// Layer index out of range
		IdxSprite,	  	// Sprite index out of range
		IdxAnimation,	// Animation index out of range
		IdxPicture,		// Picture or tile index out of range
		RefTileset,		// Invalid Tileset reference
		RefTilemap,		// Invalid Tilemap reference
		RefSpriteset,	// Invalid Spriteset reference
		RefPalette,		// Invalid Palette reference
		RefSequence,	// Invalid Sequence reference
		RefSequencePack,// Invalid SequencePack reference
		RefBitmap,		// Invalid Bitmap reference
		NullPointer,	// Null pointer as argument
		FileNotFound,	// Resource file not found
		WrongFormat,	// Resource file has invalid format
		WrongSize,		// A Width or Height parameter is invalid
		Unsupported,	// Unsupported function
		RefList,		// Invalid ObjectList reference
		MaxError		// ???
	}
}
