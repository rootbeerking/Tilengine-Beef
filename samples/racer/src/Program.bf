using System;
using Tilengine;
using TLN.Types;

namespace racer
{
	static {
		public const int SPRITESET_TREES = 0;
		public const int MAX_SPRITESET   = 1;

		/* layers */
		public const int LAYER_PLAYFIELD = 0;
		public const int MAX_LAYER       = 1;
		
		public const int WIDTH  = 400;
		public const int HEIGHT = 240;

		public const int MAX_ACTOR = 40;
		public const int Z_NEAR    = 50;
		public const int Z_FAR     = 1000;

		public const int MAX_SPEED = 6;
		public const int MAX_STEER = 58;
	}

	public class Program : TLN
	{
		/* linear interploation */
		public static int Lerp(int x0, int x1, int x2, int x3, int x4) => x3 + (x4 - x3) * (x0 - x1) / (x2 - x1);

		public struct RGB
		{
			public uint8 r, g, b;

			public this()
			{
				r = 0;
				g = 0;
				b = 0;
			}

			public this(uint8 r, uint8 g, uint8 b)
			{
				this.r = r;
				this.g = g;
				this.b = b;
			}
		}

		public static RGB[?] sky = .(
			.(0x66, 0x22, 0xEE),
			.(0xCC, 0xCC, 0xEE)
		);

		public static Spriteset[MAX_SPRITESET] spritesets;
		public static Palette[2] palettes;
		public static int pos;
		public static int speed;
		public static int last_tree;
		public static uint frame;
		public static uint time;
		public static int pan;

		public static int Main()
		{
			Tilemap tilemap;
			Tileset tileset;
			Init(WIDTH, HEIGHT, MAX_LAYER, MAX_ACTOR, 0);
			SetRasterCallback(=> myRasterCb);

			/* load resources*/
			SetLoadPath("assets/racer");
			tilemap = LoadTilemap("racer.tmx", null);
			tileset = LoadTileset("racer.tsx");

			SetLayer(LAYER_PLAYFIELD, tileset, tilemap);
			palettes[0] = GetLayerPalette(LAYER_PLAYFIELD);
			palettes[1] = LoadPalette("racer.act");
			spritesets[SPRITESET_TREES] = LoadSpriteset("trees");

			/* startup display */
			CreateWindow(null, 0);

			Actor.CreateActors(MAX_ACTOR);

			/* main loop */
			while (ProcessWindow())
			{
				/* timekeeper */
				time = frame;

				SetLayerPosition(LAYER_PLAYFIELD, 56, 72);
				if (pos - last_tree >= 100) {
					Tree.CreateTree(240, 184, 0);
					Tree.CreateTree(240, 184, 1);
					last_tree = pos;
				}

				/* input */
				if ((time & 0x07) == 0) {
					if (GetInput(.Up) && speed < MAX_SPEED)
						speed++;
				} else if (!GetInput(.Up) && speed > 0)
					speed--;

				if (GetInput(.Left) && pan > -MAX_STEER)
					pan -= 2;
				else if (GetInput(.Right) && pan < MAX_STEER)
					pan += 2;

				/* actores */
				pos += speed;
				Actor.TasksActors(time);

				/* render to window */
				DrawFrame((int)time);

				frame++;
			}

			DeleteTilemap(tilemap);
			DeleteSpriteset(spritesets[SPRITESET_TREES]);
			Deinit();
			return 0;
		}

		public static void myRasterCb(int line)
		{
			/* sky gradient */
			if (line < 56) {
				RGB color = .();
				InterpolateColor(line, 0,56, &sky[0], &sky[1], &color);
				SetBGColor(color.r, color.g, color.b);
			}

			/* road */
			if (line >= 56) {
				int depth = Lerp(line, 56, 240, Z_NEAR, Z_FAR);
				int value = pos + 32768 / depth;
				int phase = (value>>5) & 1;
				int dx = Lerp(line, 56, 240, 0, pan);
				int c = 240 - line - 1;
				int s = ((c * (c + 1)) / 2) / 128;
				SetLayerPalette(LAYER_PLAYFIELD, palettes[phase]);
				SetLayerPosition(LAYER_PLAYFIELD, 56 + dx /*+ s*/, 72);
			}
		}

		public static void InterpolateColor(int v, int v1, int v2, RGB* color1, RGB* color2, RGB* result)
		{
			result.r = (uint8)Lerp(v, v1, v2, color1.r, color2.r);
			result.g = (uint8)Lerp(v, v1, v2, color1.g, color2.g);
			result.b = (uint8)Lerp(v, v1, v2, color1.b, color2.b);
		}
	}
}
