using Tilengine.Enums;
using System;
namespace Tilengine.Types
{
	[CRepr]
	public struct SpriteInfo // Data returned by Spriteset.GetSpriteInfo with dimensions of the requested sprite
	{
	    public int W;		 // Width of Sprite
	    public int H;		 // Height of Sprite
	}
}
