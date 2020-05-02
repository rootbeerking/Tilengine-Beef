![](img/Tilengine-logo.png)
# Tilengine-Beef
**Tilengine-Beef** is a work in progress Beef wrapper library for **Tilengine 2.7.0** 2D graphics engine. It seems to be up and working for the most part, but there are bugs and not everything is working exactly as it should such as the input, and a few things like calling null to some functions. There are a few things I can't figure out how to get working right, so if anyone could take a look and help me out that would be much appreciated.

## Things that are broken and I have no idea how to fix:
- Fixed point helper in src\Tilengine.bf (Line 18-24)
- Callbacks in src\Tilengine.bf (Line 27-31, I'm not sure I implemented these correctly, they could be working, they could be broken, I'm not 100% sure at the moment)
- src\Enums\Input.bf (Line 20-32)

## TODO:
- Figure out how to finish this wrapper.
- Rewrite examples to Beef


# Quick Start *(using Beef IDE)*
1. **Download** Tilengine-beef and copy it here: **C:\Program Files\BeefLang\BeefLibs**
2. Right-click on your workspace and select **Add from Installed** and choose Tilengine
3. **Make** Tilengine **as a dependency** of your project 
4. Write some code

# Example Code
![](img/Tilengine-beef.gif)
```
using Tilengine;
using System;

namespace TilengineTest
{
	public static class Program : TLN
	{
		public static void Main()
		{
			Tilengine.Types.TLN_Tilemap foreground;
			Tilengine.Types.TLN_Tileset tileset;
			int frame = 0;

			Init(400,240,1,0,20);
			SetLoadPath("assets/sonic");
			foreground = LoadTilemap ("Sonic_md_fg1.tmx", null);
			tileset = LoadTileset("Sonic_md_fg1.tsx");
			SetLayer (0, tileset, foreground);

			CreateWindow(null, 0);

			while (ProcessWindow())
			{
				DrawFrame (frame);
				frame += 1;
			}
			Deinit();
			
		}
	}
}
```

# More Info
- More info about **Tilengine** (https://github.com/megamarc/Tilengine/)
- More info about **BeefLang** (https://www.beeflang.org)

# Contribution

If you can make this work right please do! 
