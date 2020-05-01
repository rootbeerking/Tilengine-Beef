using System;
using Tilengine.Enums;
using Tilengine.Types;
namespace Tilengine
{
	public class TLN
	{
		// Used by
		// DllImport to load the native library.
		public const char8* nativeLibName = "Tilengine";

		/* version */
		public const int TILENGINE_VER_MAJ = 2;
		public const int TILENGINE_VER_MIN = 7;
  		public const int TILENGINE_VER_REV = 6;
		public const int TILENGINE_HEADER_VERSION = ((TILENGINE_VER_MAJ << 16) | (TILENGINE_VER_MIN << 8) | TILENGINE_VER_REV);
		
		/* fixed point helper */
		//typedef int fix_t;
		public const int FIXED_BITS = 16;
		//#define float2fix(f)	(fix_t)(f*(1 << FIXED_BITS))
		//#define int2fix(i)		((int)(i) << FIXED_BITS)
		//#define fix2int(f)		((int)(f) >> FIXED_BITS)
		//#define fix2float(f)	(float)(f)/(1 << FIXED_BITS)

		/* callbacks */
		/*typedef union SDL_Event SDL_Event;
		typedef void(*TLN_VideoCallback)(int scanline);
		typedef uint8_t(*TLN_BlendFunction)(uint8_t src, uint8_t dst);
		typedef void(*TLN_SDLCallback)(SDL_Event*);*/

		// ------------------------------------------------------------------------------------
		// - Setup
		// -	Basic setup and management
		// ------------------------------------------------------------------------------------

		// // Initializes the graphic engine in 32 bpp pixel format.
		// // Creates the Viewport with the specified dimensions and allocates the number of Layers, Sprites and Animation slots.
		[CLink]
		public static extern TLN_Engine TLN_Init(int hres, int vres, int numlayers, int numsprites, int numanimations);
		// // Deinitializes current engine context and frees used resources.
		[CLink]
		public static extern void TLN_Deinit();
		// // Deletes explicit context.
		[CLink]
		public static extern bool TLN_DeleteContext (TLN_Engine context);
		// // Sets current engine context.
		[CLink]
		public static extern bool TLN_SetContext(TLN_Engine context);
		// // Returns the current engine context.
		[CLink]
		public static extern TLN_Engine TLN_GetContext();
		// // Returns the Width in pixels of the framebuffer.
		[CLink]
		public static extern int TLN_GetWidth();
		// // Returns the Height in pixels of the framebuffer.
		[CLink]
		public static extern int TLN_GetHeight();
		// // Returns the pixel format of the framebuffer.
		[CLink]
		public static extern int TLN_GetBPP();
		// // Returns the number of Objects(The total amount of Tilesets, Tilemaps, Spritesets, Palettes or Sequences combined) used by the engine so far.
		[CLink]
		public static extern uint32 TLN_GetNumObjects();
		// // Returns the total amount of memory used by the Objects.
		[CLink]
		public static extern uint32 TLN_GetUsedMemory();
		// // Retrieves Tilengine DLL version.
		[CLink]
		public static extern uint32 TLN_GetVersion();
		// // Returns the number of layers specified during initialization.
		[CLink]
		public static extern int TLN_GetNumLayers();
		// // Returns the number of sprites specified during initialization.
		[CLink]
		public static extern int TLN_GetNumSprites();
		// // Sets the background color; the color of the pixel when there isn't any layer or sprite at that position.
		// // This function can be called during a raster callback to create gradient backgrounds
		[CLink]
		public static extern void TLN_SetBGColor(uint8 r, uint8 g, uint8 b);
		// // Sets the background color from a Tilemap defined color.
		[CLink]
		public static extern bool TLN_SetBGColorFromTilemap(TLN_Tilemap tilemap);
		// // Disables background color rendering.
		// // If you know that the last background layer will always cover the entire screen, you can disable it to gain some performance.
		[CLink]
		public static extern void TLN_DisableBGColor();
		// // Sets a static Bitmap as background.
		// // Sets an optional Bitmap instead of a solid color where there is no Layer or Sprite. Unlike Tilemaps or Sprites, this Bitmap cannot be moved and has no transparency
		[CLink]
		public static extern bool TLN_SetBGBitmap(TLN_Bitmap bitmap);
		// // Changes the Palette for the background Bitmap.
		[CLink]
		public static extern bool TLN_SetBGPalette(TLN_Palette palette);
		// // Set RasterCallback for Raster Effects
		[CLink]
		public static extern void TLN_SetRasterCallback(TLN_VideoCallback);
		// // Set Frame Callback
		[CLink]
		public static extern void TLN_SetFrameCallback(TLN_VideoCallback);
		// // Sets the output surface for rendering. The render target pixel format must be 32 bits RGBA
		[CLink]
		public static extern void TLN_SetRenderTarget(uint8* data, int pitch);
		// // Draws the frame to the previously specified render target.
		// // The time value is application defined, but its units must match the same used in the sequences xml file. It usually is the frame number or millisecond count
		[CLink]
		public static extern void TLN_UpdateFrame(int time);
		// // Starts active rendering of the current frame.
		[CLink]
		public static extern void TLN_BeginFrame(int time);
		// // Draws the next scanline of the frame started with TLN_BeginFrame() or TLN_BeginWindowFrame()
		// // Use this function in conjunction with TLN_BeginFrame() (custom render target) or TLN_BeginWindoFrame() and TLN_EndWindowFrame() (built-in window) for active rendering without callbacks.
		[CLink]
		public static extern bool TLN_DrawNextScanline();
		// // Sets base path for TLN_LoadXXX functions.
		[CLink]
		public static extern void TLN_SetLoadPath(char8* path);
		// // Sets custom blend function to use when Blend.Custom mode is selected.
		[CLink]
		public static extern void TLN_SetCustomBlendFunction(TLN_BlendFunction);
		// // Sets logging level for current instance.
		[CLink]
		public static extern void TLN_SetLogLevel(LogLevel log_level);
		// // Open the resource package with optional aes-128 key and binds it.
		[CLink]
		public static extern bool TLN_OpenResourcePack(char8* filename, char8* key);
		// // Closes current resource package and unbinds it.
		[CLink]
		public static extern void TLN_CloseResourcePack();

		// ------------------------------------------------------------------------------------
		// - Errors
		// -	Basic setup and management
		// ------------------------------------------------------------------------------------
		// // Sets the global error code of Tilengine. Useful for custom loaders that need to set the error state.
		[CLink]
		public static extern void TLN_SetLastError(Error error);
		// // Returns the last error after an invalid operation.
		[CLink]
		public static extern Error TLN_GetLastError();
		// // Returns the string description of the specified error code.
		[CLink]
		public static extern char8* TLN_GetErrorString(Error error);

		// ------------------------------------------------------------------------------------
		// - Windowing
		// -	Built-in window and input management.
		// ------------------------------------------------------------------------------------
		// // Creates a window for rendering.
		// // Using this feature is optional, Tilengine is designed to output its rendering to a user-provided surface so it can be used as a backend renderer of an already existing framework.
		// // But it is provided for convenience, so it isn't needed to provide external components to run the examples or do engine tests.
		[CLink]
		public static extern bool TLN_CreateWindow(char8* overlay, int flags);
		// // Creates a Multithreaded Window for rendering.
		// // Unlike TLN_CreateWindow, This Window runs in its own thread.
		[CLink]
		public static extern bool TLN_CreateWindowThread(char8* overlay, int flags);
		// // Sets Window Title.
		[CLink]
		public static extern void TLN_SetWindowTitle(char8* title);
		// // Does basic Window housekeeping in single-threaded Window.
		[CLink]
		public static extern bool TLN_ProcessWindow();
		// // Checks Window state.
		[CLink]
		public static extern bool TLN_IsWindowActive();
		// // Returns the state of a given player controlled Input.
		[CLink]
		public static extern bool TLN_GetInput(Input id);
		// // Enables or disables Input for specified Player.
		[CLink]
		public static extern void TLN_EnableInput(Player player, bool enable);
		// // Assigns a Joystick index to the specified Player.
		[CLink]
		public static extern void TLN_AssignInputJoystick(Player player, int index);
		// // Assigns a Keyboard Input to a Player.
		[CLink]
		public static extern void TLN_DefineInputKey(Player player, Input input, uint32 keycode);
		// // Assigns a button Joystick Input to a Player.
		[CLink]
		public static extern void TLN_DefineInputButton(Player player, Input input, uint8 joybutton);
		// // Draws a frame to the Window.
		[CLink]
		public static extern void TLN_DrawFrame(int time);
		// // Thread synchronization for multi-threaded Window. Waits until the current frame has ended rendering.
		[CLink]
		public static extern void TLN_WaitRedraw();
		// // Deletes the Window previously created with TLN_CreateWindow() or TLN_CreateWindowThread()
		[CLink]
		public static extern void TLN_DeleteWindow();
		// // Removed in release 1.12, use TLN_EnableCRTEffect() instead.
		[CLink]
		public static extern void TLN_EnableBlur(bool mode);
		// // Enables CRT simulation post-processing effect to give true retro appearance.
		[CLink]
		public static extern void TLN_EnableCRTEffect (Overlay overlay, uint8 overlay_factor, uint8 threshold, uint8 v0, uint8 v1, uint8 v2, uint8 v3, bool blur, uint8 glow_factor);
		// // Disables the CRT post-processing effect.
		[CLink]
		public static extern void TLN_DisableCRTEffect();
		// // Registers a user-defined callback to capture internal SDL2 events.
		[CLink]
		public static extern void TLN_SetSDLCallback(TLN_SDLCallback);
		// // Suspends execution for a fixed time.
		[CLink]
		public static extern void TLN_Delay(uint32 msecs);
		// // Returns the number of milliseconds since application start.
		[CLink]
		public static extern uint32 TLN_GetTicks();
		// // Begins active rendering frame in built-in Window.
		[CLink]
		public static extern void TLN_BeginWindowFrame(int time);
		// // Finishes rendering the current frame and updates the built-in Window.
		[CLink]
		public static extern void TLN_EndWindowFrame();
		// // Returns Horizontal dimension of Window after scaling.
		[CLink]
		public static extern int TLN_GetWindowWidth();
		// // Returns Vertical dimension of Window after scaling.
		[CLink]
		public static extern int TLN_GetWindowHeight();

		// ------------------------------------------------------------------------------------
		// - Spriteset
		// -	Resources management for sprites.
		// ------------------------------------------------------------------------------------
		// // Creates a new Spriteset.
		[CLink]
		public static extern TLN_Spriteset TLN_CreateSpriteset(TLN_Bitmap bitmap, SpriteData* data, int num_entries);
		// // Loads a Spriteset from an image png and its associated atlas descriptor.
		// // The Spriteset comes in a pair of files: an image file (bmp or png) and a standardized atlas descriptor (json, csv or txt) The supported json format is the array.
		[CLink]
		public static extern TLN_Spriteset TLN_LoadSpriteset(char8* name);
		// // Creates a duplicate of the specified Spriteset and its associated Palette.
		[CLink]
		public static extern TLN_Spriteset TLN_CloneSpriteset(TLN_Spriteset src);
		// // Query the details about the specified Sprite inside a Spriteset.
		[CLink]
		public static extern bool TLN_GetSpriteInfo (TLN_Spriteset spriteset, int entry, SpriteInfo* info);
		// // Returns a reference to the Palette associated to the specified Spriteset.
		[CLink]
		public static extern TLN_Palette TLN_GetSpritesetPalette(TLN_Spriteset spriteset);
		// // Returns a reference to the Palette associated to the specified Spriteset.
		[CLink]
		public static extern int TLN_FindSpritesetSprite(TLN_Spriteset spriteset, char8* name);
		// // Sets attributes and pixels of a given Sprite inside a Spriteset.
		[CLink]
		public static extern bool TLN_SetSpritesetData(TLN_Spriteset spriteset, int entry, SpriteData* data, void* pixels, int pitch);
		// // Deletes the specified Spriteset and frees memory.
		[CLink]
		public static extern bool TLN_DeleteSpriteset(TLN_Spriteset Spriteset);

		// ------------------------------------------------------------------------------------
		// - Tileset
		// -	Resources management for background layers.
		// ------------------------------------------------------------------------------------
		// // Creates a tile-based Tileset.
		[CLink]
		public static extern TLN_Tileset TLN_CreateTileset(int numtiles, int width, int height, TLN_Palette palette, TLN_SequencePack sp, TileAttributes* attributes);
		// // Creates a multiple image-based Tileset.
		[CLink]
		public static extern TLN_Tileset TLN_CreateImageTileset(int numtiles, TileImage* images);
		// // Loads a tileset from a Tiled .tsx file.
		[CLink]
		public static extern TLN_Tileset TLN_LoadTileset(char8* filename);
		// // Creates a duplicate of the specified Tileset and its associated palette.
		[CLink]
		public static extern TLN_Tileset TLN_CloneTileset(TLN_Tileset src);
		// // Sets pixel data for a tile in a Tileset.
		[CLink]
		public static extern bool TLN_SetTilesetPixels(TLN_Tileset tileset, int entry, uint8* srcdata, int srcpitch);
		// // Copies tile graphic data inside a Tileset specified tileset.
		[CLink]
		public static extern bool TLN_CopyTile(TLN_Tileset tileset, int src, int dst);
		// // Returns the width in pixels of each individual Tile in the tileset.
		[CLink]
		public static extern int TLN_GetTileWidth(TLN_Tileset tileset);
		// // Returns the height in pixels of each individual tile in the tileset.
		[CLink]
		public static extern int TLN_GetTileHeight(TLN_Tileset tileset);
		// // Returns the number of different tiles in tileset.
		[CLink]
		public static extern int TLN_GetTilesetNumTiles(TLN_Tileset tileset);
		// // Returns a reference to the Palette associated to the specified tileset.
		[CLink]
		public static extern TLN_Palette TLN_GetTilesetPalette(TLN_Tileset tileset);
		// // Returns a reference to the optional sequence pack associated to the specified tileset.
		[CLink]
		public static extern TLN_SequencePack TLN_GetTilesetSequencePack(TLN_Tileset tileset);
		// // Deletes the specified tileset and frees memory.
		[CLink]
		public static extern bool TLN_DeleteTileset(TLN_Tileset tileset);

		// ------------------------------------------------------------------------------------
		// - Tilemap
		// -	Resources management for Tilemap background layers.
		// ------------------------------------------------------------------------------------
		// // Creates a new tilemap. Make sure that the tiles[] array is has at least rows*cols items or application may crash
		[CLink]
		public static extern TLN_Tilemap TLN_CreateTilemap(int rows, int cols, TLN_Tile tiles, uint32 bgcolor, TLN_Tileset tileset);
		// // Loads a tilemap layer from a Tiled .tmx file.
		[CLink]
		public static extern TLN_Tilemap TLN_LoadTilemap(char8* filename, char8* layername);
		// // Creates a duplicate of the specified tilemap.
		[CLink]
		public static extern TLN_Tilemap TLN_CloneTilemap(TLN_Tilemap src);
		// // Returns the number of vertical tiles in the tilemap.
		[CLink]
		public static extern int TLN_GetTilemapRows(TLN_Tilemap tilemap);
		// // Returns the number of horizontal tiles in the tilemap.
		[CLink]
		public static extern int TLN_GetTilemapCols(TLN_Tilemap tilemap);
		// // Returns the optional associated tileset to the specified tilemap.
		[CLink]
		public static extern TLN_Tileset TLN_GetTilemapTileset(TLN_Tilemap tilemap);
		// // Gets data of a single tile inside a tilemap.
		[CLink]
		public static extern bool TLN_GetTilemapTile(TLN_Tilemap tilemap, int row, int col, TLN_Tile tile);
		// // Sets a tile of a tilemap.
		[CLink]
		public static extern bool TLN_SetTilemapTile(TLN_Tilemap tilemap, int row, int col, TLN_Tile tile);
		// // Copies blocks of tiles between two tilemaps.
		[CLink]
		public static extern bool TLN_CopyTiles(TLN_Tilemap src, int srcrow, int srccol, int rows, int cols, TLN_Tilemap dst, int dstrow, int dstcol);
		// // Deletes the specified tilemap and frees memory.
		[CLink]
		public static extern bool TLN_DeleteTilemap(TLN_Tilemap tilemap);

		// ------------------------------------------------------------------------------------
		// - Palette
		// -	Color palette resources management for sprites and background layers.
		// ------------------------------------------------------------------------------------
		// // Creates a new color table.
		[CLink]
		public static extern TLN_Palette TLN_CreatePalette(int entries);
		// // Loads a palette from a standard .act file.
		[CLink]
		public static extern TLN_Palette TLN_LoadPalette(char8* filename);
		// // Creates a duplicate of the specified palette.
		[CLink]
		public static extern TLN_Palette TLN_ClonePalette(TLN_Palette src);
		// // Sets the RGB color value of a palette entry.
		[CLink]
		public static extern bool TLN_SetPaletteColor(TLN_Palette palette, int color, uint8 r, uint8 g, uint8 b);
		// // Mixes two palettes to create a third one.
		[CLink]
		public static extern bool TLN_MixPalettes(TLN_Palette src1, TLN_Palette src2, TLN_Palette dst, uint8 factor);
		// // Modifies a range of colors by adding the provided color value to the selected range. The result is always a brighter color.
		[CLink]
		public static extern bool TLN_AddPaletteColor(TLN_Palette palette, uint8 r, uint8 g, uint8 b, uint8 start, uint8 num);
		// Modifies a range of colors by subtracting the provided color value to the selected range. The result is always a darker color.
		[CLink]
		public static extern bool TLN_SubPaletteColor(TLN_Palette palette, uint8 r, uint8 g, uint8 b, uint8 start, uint8 num);
		// // Modifies a range of colors by modulating (normalized product) the provided color value to the selected range. The result is always a darker color.
		[CLink]
		public static extern bool TLN_ModPaletteColor(TLN_Palette palette, uint8 r, uint8 g, uint8 b, uint8 start, uint8 num);
		// // Returns the color value of a palette entry.
		[CLink]
		public static extern uint8* TLN_GetPaletteData(TLN_Palette palette, int index);
		// // Deletes the specified palette and frees memory.
		[CLink]
		public static extern bool TLN_DeletePalette(TLN_Palette palette);

		// ------------------------------------------------------------------------------------
		// - Bitmap
		// -	Bitmap management.
		// ------------------------------------------------------------------------------------
		// // Creates a memory Bitmap.
		[CLink]
		public static extern TLN_Bitmap TLN_CreateBitmap(int width, int height, int bpp);
		// // Load image file (8-bit BMP or PNG)
		[CLink]
		public static extern TLN_Bitmap TLN_LoadBitmap(char8* filename);
		// // Creates a copy of a Bitmap.
		[CLink]
		public static extern TLN_Bitmap TLN_CloneBitmap(TLN_Bitmap src);
		// // Gets memory access for direct pixel manipulation.
		[CLink]
		public static extern uint8* TLN_GetBitmapPtr(TLN_Bitmap bitmap, int x, int y);
		// // Returns the Width in pixels.
		[CLink]
		public static extern int TLN_GetBitmapWidth(TLN_Bitmap bitmap);
		// // Returns the Height in pixels.
		[CLink]
		public static extern int TLN_GetBitmapHeight(TLN_Bitmap bitmap);
		// // Returns the bits per pixel.
		[CLink]
		public static extern int TLN_GetBitmapDepth(TLN_Bitmap bitmap);
		// // Returns the number of bytes per scanline (also known a stride)
		[CLink]
		public static extern int TLN_GetBitmapPitch(TLN_Bitmap bitmap);
		// // Gets the associated Palette of a bitmap.
		[CLink]
		public static extern TLN_Palette TLN_GetBitmapPalette(TLN_Bitmap bitmap);
		// // Assigns a new Palette to the bitmap.
		[CLink]
		public static extern bool TLN_SetBitmapPalette(TLN_Bitmap bitmap, TLN_Palette palette);
		// // Deletes bitmap and frees resources.
		[CLink]
		public static extern bool TLN_DeleteBitmap(TLN_Bitmap bitmap);

		// ------------------------------------------------------------------------------------
		// - Objects
		// -	ObjectList resources management.
		// ------------------------------------------------------------------------------------
		// // Creates a TLN_ObjectList The list is created empty, it must be populated with TLN_AddSpriteToList() and assigned to a layer with TLN_SetLayerObjects()
		[CLink]
		public static extern TLN_ObjectList TLN_CreateObjectList();
		// // Adds an image-based Tileset item to given TLN_ObjectList.
		[CLink]
		public static extern bool TLN_AddTileObjectToList(TLN_ObjectList list, uint16 id, uint16 gid, uint16 flags, int x, int y);
		// // Loads an Object List from a Tiled Object Layer.
		[CLink]
		public static extern TLN_ObjectList TLN_LoadObjectList(char8* filename, char8* layername);
		// // Creates a duplicate of a given TLN_ObjectList Object.
		[CLink]
		public static extern TLN_ObjectList TLN_CloneObjectList(TLN_ObjectList src);
		// // Returns number of items in TLN_ObjectList.
		[CLink]
		public static extern int TLN_GetListNumObjects(TLN_ObjectList list);
		// // Iterates over elements in a TLN_ObjectList.
		[CLink]
		public static extern bool TLN_GetListObject(TLN_ObjectList list, TLN_ObjectInfo* info);
		// // Deletes Object List.
		[CLink]
		public static extern bool TLN_DeleteObjectList(TLN_ObjectList list);

		// ------------------------------------------------------------------------------------
		// - Layers
		// -	Background layers management.
		// ------------------------------------------------------------------------------------
		// // Configures a background layer with the specified tileset and tilemap.
		// // This function doesn't modify the current position nor the blend mode, but assigns the palette of the specified tileset.
		[CLink]
		public static extern bool TLN_SetLayer(int nlayer, TLN_Tileset tileset, TLN_Tilemap tilemap);
		// // Configures a background layer with the specified full bitmap.
		// // This function doesn't modify the current position nor the blend mode, but assigns the palette of the specified bitmap.
		[CLink]
		public static extern bool TLN_SetLayerBitmap(int nlayer, TLN_Bitmap bitmap);
		// // Sets the color palette to the layer.
		// // When a layer is assigned with a tileset with the function TLN_SetLayer(), it automatically sets the palette of the assigned tileset to the layer.
		// // Use this function to override it and set another palette
		// // Call this function inside a raster callback to change the palette in the middle of the frame to get raster effect colors, like and "underwater" palette below the water line in a partially submerged background, or a gradient palette in an area at the top of the screen to simulate a "depth fog effect" in a pseudo 3d background
		[CLink]
		public static extern bool TLN_SetLayerPalette(int nlayer, TLN_Palette palette);
		// // Sets the position of the tileset that corresponds to the upper left corner.
		// // The tileset usually spans an area much bigger than the viewport. Use this function to move the viewport insde the tileset. Change this value progressively for each frame to get a scrolling effect.
		// // Call this function inside a raster callback to get a raster scrolling effect. Use this to create horizontal strips of the same layer that move at different speeds to simulate depth. The extreme case of this effect, where the position is changed in each scanline, is called "line scroll" and was the technique used by games such as Street Fighter II to simualte a pseudo 3d floor, or many racing games to simulate a 3D road.
		[CLink]
		public static extern bool TLN_SetLayerPosition(int nlayer, int hstart, int vstart);
		// // Sets simple scaling.
		// // By default the scaling factor of a given layer is 1.0f, 1.0f, which means no scaling. Use values below 1.0 to downscale (shrink) and above 1.0 to upscale (enlarge). Call TLN_ResetLayerMode() to disable scaling.
		[CLink]
		public static extern bool TLN_SetLayerScaling(int nlayer, float xfactor, float yfactor);
		// // Sets affine transform matrix to enable rotating and scaling of this layer.
		// // Enable the transformation matrix to give the layer the capabilities of the famous Super Nintendo / Famicom Mode 7. Beware that the rendering of a transformed layer uses more CPU than a regular layer. Unlike the original Mode 7, that could only transform the single layer available, Tilengine can transform all the layers at the same time. The only limitation is the available CPU power.
		// // Call this function inside a raster callback to set the transformation matrix in the middle of the frame. Setting it for each scanline is the trick used by many Super Nintendo games to fake a 3D perspective projection.
		[CLink]
		public static extern bool TLN_SetLayerAffineTransform(int nlayer, Affine *affine);
		// // Sets affine transform matrix to enable rotating and scaling of this layer.
		// // This function is a simple wrapper to TLN_SetLayerAffineTransform() without using the TLN_Affine struct
		[CLink]
		public static extern bool TLN_SetLayerTransform(int layer, float angle, float dx, float dy, float sx, float sy);
		// Sets the table for pixel mapping render mode.
		[CLink]
		public static extern bool TLN_SetLayerPixelMapping(int nlayer, PixelMap* table);
		// // Sets the blending mode (transparency effect).
		[CLink]
		public static extern bool TLN_SetLayerBlendMode(int nlayer, Blend mode, uint8 factor);
		// // Enables column offset mode for this layer.
		// // Column offset is a value that is added or substracted (depeinding on the sign) to the vertical position for that layer (see TLN_SetLayerPosition) for each column in the tilemap assigned to that layer.
		// // This feature is tipically used to simulate vertical strips moving at different speeds, or combined with a line scroll effect, to fake rotations where the angle is small. The Sega Genesis games Puggsy and Chuck Rock II used this trick to simulate partially rotating backgrounds
		[CLink]
		public static extern bool TLN_SetLayerColumnOffset(int nlayer, int* offset);
		// // Enables clipping rectangle on selected layer.
		[CLink]
		public static extern bool TLN_SetLayerClip(int nlayer, int x1, int y1, int x2, int y2);
		// // Disables clipping rectangle on selected layer.
		[CLink]
		public static extern bool TLN_DisableLayerClip(int nlayer);
		// // Enables mosaic effect (pixelation) for selected layer.
		[CLink]
		public static extern bool TLN_SetLayerMosaic(int nlayer, int width, int height);
		// // Disables mosaic effect for selected layer.
		[CLink]
		public static extern bool TLN_DisableLayerMosaic(int nlayer);
		// // Disables scaling or affine transform for the layer.
		[CLink]
		public static extern bool TLN_ResetLayerMode(int nlayer);
		// // Configures a background layer with a object list and an image-based tileset.
		[CLink]
		public static extern bool TLN_SetLayerObjects(int nlayer, TLN_ObjectList objects, TLN_Tileset tileset);
		// // Sets full Layer priority, appearing in front of Sprites.
		[CLink]
		public static extern bool TLN_SetLayerPriority(int nlayer, bool enable);
		// // Sets parent Layer index to scroll in sync.
		// // A layer with a parent gets scroll position from its parent, so they scroll together
		[CLink]
		public static extern bool TLN_SetLayerParent(int nlayer, int parent);
		// // Disables Layer parent.
		[CLink]
		public static extern bool TLN_DisableLayerParent(int nlayer);
		// // Disables the specified Layer so it is not drawn.
		[CLink]
		public static extern bool TLN_DisableLayer(int nlayer);
		// // Gets the attached Palette of a Layer.
		[CLink]
		public static extern TLN_Palette TLN_GetLayerPalette(int nlayer);
		// // Gets info about the tile located in Tilemap space.
		// // Use this function to implement collision detection between sprites and the main background layer.
		[CLink]
		public static extern bool TLN_GetLayerTile(int nlayer, int x, int y, TileInfo* info);
		// Returns the Layer Width in pixels.
		[CLink]
		public static extern int  TLN_GetLayerWidth(int nlayer);
		// // Returns the Layer Height in pixels.
		[CLink]
		public static extern int  TLN_GetLayerHeight(int nlayer);

		// ------------------------------------------------------------------------------------
		// - Sprites
		// -	Sprites management.
		// ------------------------------------------------------------------------------------
		// // Configures a Sprite, setting Spriteset and flags at once
		[CLink]
		public static extern bool TLN_ConfigSprite(int nsprite, TLN_Spriteset spriteset, TileFlags flags);
		// // Assigns the spriteset and its palette to a given sprite.
		[CLink]
		public static extern bool TLN_SetSpriteSet(int nsprite, TLN_Spriteset spriteset);
		// // Sets flags for a given sprite.
		[CLink]
		public static extern bool TLN_SetSpriteFlags(int nsprite, TileFlags flags);
		// // Sets the sprite position inside the viewport.
		// // Call this function inside a raster callback to so some vertical distortion effects (fake scaling) or sprite multiplexing (reusing a single sprite at different screen heights). This technique was used by some 8 bit games, with very few hardware sprites, to draw much more sprites in the screen, as long as they don't overlap vertically.
		[CLink]
		public static extern bool TLN_SetSpritePosition(int nsprite, int x, int y);
		// // Sets the actual graphic to the sprite.
		[CLink]
		public static extern bool TLN_SetSpritePicture(int nsprite, int entry);
		// // Assigns a palette to a sprite.
		[CLink]
		public static extern bool TLN_SetSpritePalette(int nsprite, TLN_Palette palette);
		// // Sets the blending mode (transparency effect).
		[CLink]
		public static extern bool TLN_SetSpriteBlendMode(int nsprite, Blend mode, uint8 factor);
		// // Sets the scaling factor of the sprite.
		[CLink]
		public static extern bool TLN_SetSpriteScaling(int nsprite, float sx, float sy);
		// // Disables scaling for a given sprite.
		[CLink]
		public static extern bool TLN_ResetSpriteScaling(int nsprite);
		/*// // Rotate Sprite
		[CLink]
		public static extern bool TLN_SetSpriteRotation (int nsprite, float angle);
		// // Reset	Sprite Rotation
		[CLink]
		public static extern bool TLN_ResetSpriteRotation (int nsprite);*/
		// // Returns the index of the assigned picture from the Spriteset.
		[CLink]
		public static extern int  TLN_GetSpritePicture(int nsprite);
		// // Finds an available (unused) Sprite.
		[CLink]
		public static extern int  TLN_GetAvailableSprite();
		// // Enable sprite collision checking at pixel level.
		// // Only sprites that have collision enabled are checked between them, so to detect a collision between two sprites, both of them must have collision detection enabled. Processing collision detection sprites take more a bit more CPU time compared to non-colliding sprites, so by default it is disabled on all sprites.
		[CLink]
		public static extern bool TLN_EnableSpriteCollision (int nsprite, bool enable);
		// // Gets the collision status of a given sprite. Collision detection must be enabled for the sprite to get checked
		[CLink]
		public static extern bool TLN_GetSpriteCollision (int nsprite);
		// // Returns runtime info about a given sprite.
		// // Info may not be accurate if SpriteState.enabled member is returned as false
		[CLink]
		public static extern bool TLN_GetSpriteState(int nsprite, SpriteState* state);
		// // Sets the first sprite drawn (beginning of list)
		[CLink]
		public static extern bool TLN_SetFirstSprite(int nsprite);
		// // Sets the next sprite to draw for a given sprite, builds list.
		[CLink]
		public static extern bool TLN_SetNextSprite(int nsprite, int next);
		// // Enables or disables masking for this sprite, if enabled it won't be drawn inside the region set up with TLN_SetSpritesMaskRegion()
		[CLink]
		public static extern bool TLN_EnableSpriteMasking(int nsprite, bool enable);
		// // Defines a sprite masking region between the two scanlines. Sprites masked with TLN_EnableSpriteMasking() won't be drawn inside this region.
		[CLink]
		public static extern void TLN_SetSpritesMaskRegion(int top_line, int bottom_line);
		// // Disables the sprite so it is not drawn.
		// // A sprite is also automatically disabled when assigned with an invalid spriteste or palette. Disabled sprites are returned by the function TLN_GetAvailableSprite as available
		[CLink]
		public static extern bool TLN_DisableSprite(int nsprite);
		// // Gets the palette assigned to a given Sprite.
		[CLink]
		public static extern TLN_Palette TLN_GetSpritePalette(int nsprite);

		// ------------------------------------------------------------------------------------
		// - Sequences
		// -	Resources management for Layer, Sprite and Palette animations.
		// ------------------------------------------------------------------------------------
		// // Creates a new Sequence for the animation engine.
		// // Use this function to create Tileset or Sprite animations
		[CLink]
		public static extern TLN_Sequence TLN_CreateSequence(char8* name, int target, int num_frames, SequenceFrame* frames);
		// // Creates a Color Cycle Sequence for Palette animation.
		// // Use this function to create advanced Palette animation effects.
		[CLink]
		public static extern TLN_Sequence TLN_CreateCycle(char8* name, int num_strips, ColorStrip* strips);
		// // Creates a name based Sprite Sequence.
		[CLink]
		public static extern TLN_Sequence TLN_CreateSpriteSequence(char8* name, TLN_Spriteset spriteset, char8* basename, int delay);
		// // Creates a duplicate of the specified Sequence.
		[CLink]
		public static extern TLN_Sequence TLN_CloneSequence(TLN_Sequence src);
		// // Returns runtime info about a given Sequence.
		[CLink]
		public static extern bool TLN_GetSequenceInfo(TLN_Sequence sequence, SequenceInfo* info);
		// // Deletes the sequence and frees resources.
		[CLink]
		public static extern bool TLN_DeleteSequence(TLN_Sequence sequence);

		// ------------------------------------------------------------------------------------
		// - SequencePacks
		// -	Sequence pack manager for grouping and finding sequences.
		// ------------------------------------------------------------------------------------
		// // Creates a new collection of Sequences.
		[CLink]
		public static extern TLN_SequencePack TLN_CreateSequencePack();
		// // Loads a .sqx file containing one or more Sequences.
		// // A SQX file can contain many sequences. This function loads all of them inside a single TLN_SequencePack(). Individual Sequences can be later queried with TLN_FindSequence()
		[CLink]
		public static extern TLN_SequencePack TLN_LoadSequencePack(char8* filename);
		// // Returns the nth Sequence inside a Sequence Pack.
		[CLink]
		public static extern TLN_Sequence TLN_GetSequence(TLN_SequencePack sp, int index);
		// // Finds a Sequence inside a Sequence Pack.
		[CLink]
		public static extern TLN_Sequence TLN_FindSequence(TLN_SequencePack sp, char8* name);
		// // Returns the number of Sequences inside a Sequence Pack.
		[CLink]
		public static extern int TLN_GetSequencePackCount(TLN_SequencePack sp);
		// // Adds a Sequence to a Sequence Pack.
		[CLink]
		public static extern bool TLN_AddSequenceToPack(TLN_SequencePack sp, TLN_Sequence sequence);
		// // Deletes the specified Sequence Pack and frees memory.
		[CLink]
		public static extern bool TLN_DeleteSequencePack(TLN_SequencePack sp);

		// ------------------------------------------------------------------------------------
		// - Animations
		// -	Animation engine manager.
		// ------------------------------------------------------------------------------------
		// // Starts a Palette animation.
		[CLink]
		public static extern bool TLN_SetPaletteAnimation(int index, TLN_Palette palette, TLN_Sequence sequence, bool blend);
		// // Sets the source Palette of a Color Cycle animation.
		// // Use this function to change the palette assigned to a color cycle animation running. This is useful to combine color cycling and palette interpolation at the same time.
		[CLink]
		public static extern bool TLN_SetPaletteAnimationSource(int index, TLN_Palette);
		// // Starts a Tileset animation.
		[CLink]
		public static extern bool TLN_SetTilesetAnimation(int index, int nlayer, TLN_Sequence);
		// // Starts a Tilemap animation.
		[CLink]
		public static extern bool TLN_SetTilemapAnimation(int index, int nlayer, TLN_Sequence);
		// // Starts a Sprite animation.
		[CLink]
		public static extern bool TLN_SetSpriteAnimation(int index, int nsprite, TLN_Sequence sequence, int loop);
		// // Checks the state of the specified animation.
		[CLink]
		public static extern bool TLN_GetAnimationState(int index);
		// // Deprecated, each frame has its own delay.
		[CLink]
		public static extern bool TLN_SetAnimationDelay(int index, int delay);
		// // Finds an available (unused) animation.
		[CLink]
		public static extern int  TLN_GetAvailableAnimation();
		// // Disables the animation so it stops playing and returns it to the list of available animations.
		[CLink]
		public static extern bool TLN_DisableAnimation(int index);
	}
}
