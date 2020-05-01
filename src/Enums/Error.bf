namespace Tilengine.Enums
{
	public enum Error 	// List of possible exception Error codes
	{
		Ok,			  	// No Error
		OutOfMemory,  	// Not enough memory
		IdxLayer,	  	// Layer index out of range
		IdxSprite,	  	// Sprite index out of range
		IdxAnimation,	// Animation index out of range
		IdxPicture,		// Picture or tile index out of range
		RefTileset,		// Invalid Tileset reference
		RefTilemap,		// Invalid TLN_Tilemap reference
		RefSpriteset,	// Invalid TLN_Spriteset reference
		RefPalette,		// Invalid TLN_Palette reference
		RefSequence,	// Invalid TLN_Sequence reference
		RefSequencePack,// Invalid TLN_SequencePack reference
		RefBitmap,		// Invalid TLN_Bitmap reference
		NullPointer,	// Null pointer as argument
		FileNotFound,	// Resource file not found
		WrongFormat,	// Resource file has invalid format
		WrongSize,		// A Width or Height parameter is invalid
		Unsupported,	// Unsupported function
		RefList,		// Invalid TLN_ObjectList reference
		MaxError		// ???
	}
}
