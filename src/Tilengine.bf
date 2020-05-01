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
		//#define float2fix(f)	(fix)(f*(1 << FIXED_BITS))
		//#define int2fix(i)	((int)(i) << FIXED_BITS)
		//#define fix2int(f)	((int)(f) >> FIXED_BITS)
		//#define fix2float(f)	(float)(f)/(1 << FIXED_BITS)

		/* callbacks */
		public delegate void VideoCallback(int scanline);
		public delegate uint8 BlendFunction(uint8 src, uint8 dst);
		[Union]
		public struct SDL_Event;
		public delegate void SDLCallback(SDL_Event callback);

		// ------------------------------------------------------------------------------------
		// - Setup
		// -	Basic setup and management
		// ------------------------------------------------------------------------------------

		// // Initializes the graphic engine in 32 bpp pixel format.
		// // Creates the Viewport with the specified dimensions and allocates the number of Layers, Sprites and Animation slots.
		[LinkName("TLN_Init")]
		public static extern TLN_Engine Init(int hres, int vres, int numlayers, int numsprites, int numanimations);
		// // Deinitializes current engine context and frees used resources.
		[LinkName("TLN_Deinit")]
		public static extern void Deinit();
		// // Deletes explicit context.
		[LinkName("TLN_DeleteContext")]
		public static extern bool DeleteContext (TLN_Engine context);
		// // Sets current engine context.
		[LinkName("TLN_SetContext")]
		public static extern bool SetContext(TLN_Engine context);
		// // Returns the current engine context.
		[LinkName("TLN_GetContext")]
		public static extern TLN_Engine GetContext();
		// // Returns the Width in pixels of the framebuffer.
		[LinkName("TLN_GetWidth")]
		public static extern int GetWidth();
		// // Returns the Height in pixels of the framebuffer.
		[LinkName("TLN_GetHeight")]
		public static extern int GetHeight();
		// // Returns the pixel format of the framebuffer.
		[LinkName("TLN_GetBPP")]
		public static extern int GetBPP();
		// // Returns the number of Objects(The total amount of Tilesets, Tilemaps, Spritesets, Palettes or Sequences combined) used by the engine so far.
		[LinkName("TLN_GetNumObjects")]
		public static extern uint32 GetNumObjects();
		// // Returns the total amount of memory used by the Objects.
		[LinkName("TLN_GetUsedMemory")]
		public static extern uint32 GetUsedMemory();
		// // Retrieves Tilengine DLL version.
		[LinkName("TLN_GetVersion")]
		public static extern uint32 GetVersion();
		// // Returns the number of layers specified during initialization.
		[LinkName("TLN_GetNumLayers")]
		public static extern int GetNumLayers();
		// // Returns the number of sprites specified during initialization.
		[LinkName("TLN_GetNumSprites")]
		public static extern int GetNumSprites();
		// // Sets the background color; the color of the pixel when there isn't any layer or sprite at that position.
		// // This function can be called during a raster callback to create gradient backgrounds
		[LinkName("TLN_SetBGColor")]
		public static extern void SetBGColor(uint8 r, uint8 g, uint8 b);
		// // Sets the background color from a Tilemap defined color.
		[LinkName("TLN_SetBGColorFromTilemap")]
		public static extern bool SetBGColorFromTilemap(TLN_Tilemap tilemap);
		// // Disables background color rendering.
		// // If you know that the last background layer will always cover the entire screen, you can disable it to gain some performance.
		[LinkName("TLN_DisableBGColor")]
		public static extern void DisableBGColor();
		// // Sets a static Bitmap as background.
		// // Sets an optional Bitmap instead of a solid color where there is no Layer or Sprite. Unlike Tilemaps or Sprites, this Bitmap cannot be moved and has no transparency
		[LinkName("TLN_SetBGBitmap")]
		public static extern bool SetBGBitmap(TLN_Bitmap bitmap);
		// // Changes the Palette for the background Bitmap.
		[LinkName("TLN_SetBGPalette")]
		public static extern bool SetBGPalette(TLN_Palette palette);
		// // Set RasterCallback for Raster Effects
		[LinkName("TLN_SetRasterCallback")]
		public static extern void SetRasterCallback(VideoCallback callback);
		// // Set Frame Callback
		[LinkName("TLN_SetFrameCallback")]
		public static extern void SetFrameCallback(VideoCallback callback);
		// // Sets the output surface for rendering. The render target pixel format must be 32 bits RGBA
		[LinkName("TLN_SetRenderTarget")]
		public static extern void SetRenderTarget(uint8* data, int pitch);
		// // Draws the frame to the previously specified render target.
		// // The time value is application defined, but its units must match the same used in the sequences xml file. It usually is the frame number or millisecond count
		[LinkName("TLN_UpdateFrame")]
		public static extern void UpdateFrame(int time);
		// // Starts active rendering of the current frame.
		[LinkName("TLN_BeginFrame")]
		public static extern void BeginFrame(int time);
		// // Draws the next scanline of the frame started with TLN_BeginFrame() or TLN_BeginWindowFrame()
		// // Use this function in conjunction with TLN_BeginFrame() (custom render target) or TLN_BeginWindoFrame() and TLN_EndWindowFrame() (built-in window) for active rendering without callbacks.
		[LinkName("TLN_DrawNextScanline")]
		public static extern bool DrawNextScanline();
		// // Sets base path for TLN_LoadXXX functions.
		[LinkName("TLN_SetLoadPath")]
		public static extern void SetLoadPath(char8* path);
		// // Sets custom blend function to use when Blend.Custom mode is selected.
		[LinkName("TLN_SetCustomBlendFunction")]
		public static extern void SetCustomBlendFunction(BlendFunction callback);
		// // Sets logging level for current instance.
		[LinkName("TLN_SetLogLevel")]
		public static extern void SetLogLevel(LogLevel log_level);
		// // Open the resource package with optional aes-128 key and binds it.
		[LinkName("TLN_OpenResourcePack")]
		public static extern bool OpenResourcePack(char8* filename, char8* key);
		// // Closes current resource package and unbinds it.
		[LinkName("TLN_CloseResourcePack")]
		public static extern void CloseResourcePack();

		// ------------------------------------------------------------------------------------
		// - Errors
		// -	Basic setup and management
		// ------------------------------------------------------------------------------------
		// // Sets the global error code of Tilengine. Useful for custom loaders that need to set the error state.
		[LinkName("TLN_SetLastError")]
		public static extern void SetLastError(Error error);
		// // Returns the last error after an invalid operation.
		[LinkName("TLN_GetLastError")]
		public static extern Error GetLastError();
		// // Returns the string description of the specified error code.
		[LinkName("TLN_GetErrorString")]
		public static extern char8* GetErrorString(Error error);

		// ------------------------------------------------------------------------------------
		// - Windowing
		// -	Built-in window and input management.
		// ------------------------------------------------------------------------------------
		// // Creates a window for rendering.
		// // Using this feature is optional, Tilengine is designed to output its rendering to a user-provided surface so it can be used as a backend renderer of an already existing framework.
		// // But it is provided for convenience, so it isn't needed to provide external components to run the examples or do engine tests.
		[LinkName("TLN_CreateWindow")]
		public static extern bool CreateWindow(char8* overlay, int flags);
		// // Creates a Multithreaded Window for rendering.
		// // Unlike TLN_CreateWindow, This Window runs in its own thread.
		[LinkName("TLN_CreateWindowThread")]
		public static extern bool CreateWindowThread(char8* overlay, int flags);
		// // Sets Window Title.
		[LinkName("TLN_SetWindowTitle")]
		public static extern void SetWindowTitle(char8* title);
		// // Does basic Window housekeeping in single-threaded Window.
		[LinkName("TLN_ProcessWindow")]
		public static extern bool ProcessWindow();
		// // Checks Window state.
		[LinkName("TLN_IsWindowActive")]
		public static extern bool IsWindowActive();
		// // Returns the state of a given player controlled Input.
		[LinkName("TLN_GetInput")]
		public static extern bool GetInput(Input id);
		// // Enables or disables Input for specified Player.
		[LinkName("TLN_EnableInput")]
		public static extern void EnableInput(Player player, bool enable);
		// // Assigns a Joystick index to the specified Player.
		[LinkName("TLN_AssignInputJoystick")]
		public static extern void AssignInputJoystick(Player player, int index);
		// // Assigns a Keyboard Input to a Player.
		[LinkName("LN_DefineInputKey")]
		public static extern void DefineInputKey(Player player, Input input, uint32 keycode);
		// // Assigns a button Joystick Input to a Player.
		[LinkName("TLN_DefineInputButton")]
		public static extern void DefineInputButton(Player player, Input input, uint8 joybutton);
		// // Draws a frame to the Window.
		[LinkName("TLN_DrawFrame")]
		public static extern void DrawFrame(int time);
		// // Thread synchronization for multi-threaded Window. Waits until the current frame has ended rendering.
		[LinkName("TLN_WaitRedraw")]
		public static extern void WaitRedraw();
		// // Deletes the Window previously created with TLN_CreateWindow() or TLN_CreateWindowThread()
		[LinkName("TLN_DeleteWindow")]
		public static extern void DeleteWindow();
		// // Removed in release 1.12, use TLN_EnableCRTEffect() instead.
		[LinkName("TLN_EnableBlur")]
		public static extern void EnableBlur(bool mode);
		// // Enables CRT simulation post-processing effect to give true retro appearance.
		[LinkName("TLN_EnableCRTEffect")]
		public static extern void EnableCRTEffect (Overlay overlay, uint8 overlay_factor, uint8 threshold, uint8 v0, uint8 v1, uint8 v2, uint8 v3, bool blur, uint8 glow_factor);
		// // Disables the CRT post-processing effect.
		[LinkName("TLN_DisableCRTEffect")]
		public static extern void DisableCRTEffect();
		// // Registers a user-defined callback to capture internal SDL2 events.
		[LinkName("TLN_SetSDLCallback")]
		public static extern void SetSDLCallback(SDLCallback callback);	// This might not work... We shall see hopefully.
		// // Suspends execution for a fixed time.
		[LinkName("TLN_Delay")]
		public static extern void Delay(uint32 msecs);
		// // Returns the number of milliseconds since application start.
		[LinkName("TLN_GetTicks")]
		public static extern uint32 GetTicks();
		// // Begins active rendering frame in built-in Window.
		[LinkName("TLN_BeginWindowFrame")]
		public static extern void BeginWindowFrame(int time);
		// // Finishes rendering the current frame and updates the built-in Window.
		[LinkName("TLN_EndWindowFrame")]
		public static extern void EndWindowFrame();
		// // Returns Horizontal dimension of Window after scaling.
		[LinkName("TLN_GetWindowWidth")]
		public static extern int GetWindowWidth();
		// // Returns Vertical dimension of Window after scaling.
		[LinkName("TLN_GetWindowHeight")]
		public static extern int GetWindowHeight();

		// ------------------------------------------------------------------------------------
		// - Spriteset
		// -	Resources management for sprites.
		// ------------------------------------------------------------------------------------
		// // Creates a new Spriteset.
		[LinkName("TLN_CreateSpriteset")]
		public static extern TLN_Spriteset CreateSpriteset(TLN_Bitmap bitmap, SpriteData* data, int num_entries);
		// // Loads a Spriteset from an image png and its associated atlas descriptor.
		// // The Spriteset comes in a pair of files: an image file (bmp or png) and a standardized atlas descriptor (json, csv or txt) The supported json format is the array.
		[LinkName("TLN_LoadSpriteset")]
		public static extern TLN_Spriteset LoadSpriteset(char8* name);
		// // Creates a duplicate of the specified Spriteset and its associated Palette.
		[LinkName("TLN_CloneSpriteset")]
		public static extern TLN_Spriteset CloneSpriteset(TLN_Spriteset src);
		// // Query the details about the specified Sprite inside a Spriteset.
		[LinkName("TLN_GetSpriteInfo")]
		public static extern bool GetSpriteInfo (TLN_Spriteset spriteset, int entry, SpriteInfo* info);
		// // Returns a reference to the Palette associated to the specified Spriteset.
		[LinkName("TLN_GetSpritesetPalette")]
		public static extern TLN_Palette GetSpritesetPalette(TLN_Spriteset spriteset);
		// // Returns a reference to the Palette associated to the specified Spriteset.
		[LinkName("TLN_FindSpritesetSprite")]
		public static extern int FindSpritesetSprite(TLN_Spriteset spriteset, char8* name);
		// // Sets attributes and pixels of a given Sprite inside a Spriteset.
		[LinkName("TLN_SetSpritesetData")]
		public static extern bool SetSpritesetData(TLN_Spriteset spriteset, int entry, SpriteData* data, void* pixels, int pitch);
		// // Deletes the specified Spriteset and frees memory.
		[LinkName("TLN_DeleteSpriteset")]
		public static extern bool DeleteSpriteset(TLN_Spriteset Spriteset);

		// ------------------------------------------------------------------------------------
		// - Tileset
		// -	Resources management for background layers.
		// ------------------------------------------------------------------------------------
		// // Creates a tile-based Tileset.
		[LinkName("TLN_CreateTileset")]
		public static extern TLN_Tileset CreateTileset(int numtiles, int width, int height, TLN_Palette palette, TLN_SequencePack sp, TileAttributes* attributes);
		// // Creates a multiple image-based Tileset.
		[LinkName("TLN_CreateImageTileset")]
		public static extern TLN_Tileset CreateImageTileset(int numtiles, TileImage* images);
		// // Loads a tileset from a Tiled .tsx file.
		[LinkName("TLN_LoadTileset")]
		public static extern TLN_Tileset LoadTileset(char8* filename);
		// // Creates a duplicate of the specified Tileset and its associated palette.
		[LinkName("TLN_CloneTileset")]
		public static extern TLN_Tileset CloneTileset(TLN_Tileset src);
		// // Sets pixel data for a tile in a Tileset.
		[LinkName("TLN_SetTilesetPixels")]
		public static extern bool SetTilesetPixels(TLN_Tileset tileset, int entry, uint8* srcdata, int srcpitch);
		// // Copies tile graphic data inside a Tileset specified tileset.
		[LinkName("TLN_CopyTile")]
		public static extern bool CopyTile(TLN_Tileset tileset, int src, int dst);
		// // Returns the width in pixels of each individual Tile in the tileset.
		[LinkName("TLN_GetTileWidth")]
		public static extern int GetTileWidth(TLN_Tileset tileset);
		// // Returns the height in pixels of each individual tile in the tileset.
		[LinkName("TLN_GetTileHeight")]
		public static extern int GetTileHeight(TLN_Tileset tileset);
		// // Returns the number of different tiles in tileset.
		[LinkName("TLN_GetTilesetNumTiles")]
		public static extern int GetTilesetNumTiles(TLN_Tileset tileset);
		// // Returns a reference to the Palette associated to the specified tileset.
		[LinkName("TLN_GetTilesetPalette")]
		public static extern TLN_Palette GetTilesetPalette(TLN_Tileset tileset);
		// // Returns a reference to the optional sequence pack associated to the specified tileset.
		[LinkName("TLN_GetTilesetSequencePack")]
		public static extern TLN_SequencePack GetTilesetSequencePack(TLN_Tileset tileset);
		// // Deletes the specified tileset and frees memory.
		[LinkName("TLN_DeleteTileset")]
		public static extern bool DeleteTileset(TLN_Tileset tileset);

		// ------------------------------------------------------------------------------------
		// - Tilemap
		// -	Resources management for Tilemap background layers.
		// ------------------------------------------------------------------------------------
		// // Creates a new tilemap. Make sure that the tiles[] array is has at least rows*cols items or application may crash
		[LinkName("TLN_CreateTilemap")]
		public static extern TLN_Tilemap CreateTilemap(int rows, int cols, TLN_Tile tiles, uint32 bgcolor, TLN_Tileset tileset);
		// // Loads a tilemap layer from a Tiled .tmx file.
		[LinkName("TLN_LoadTilemap")]
		public static extern TLN_Tilemap LoadTilemap(char8* filename, char8* layername);
		// // Creates a duplicate of the specified tilemap.
		[LinkName("TLN_CloneTilemap")]
		public static extern TLN_Tilemap CloneTilemap(TLN_Tilemap src);
		// // Returns the number of vertical tiles in the tilemap.
		[LinkName("TLN_GetTilemapRows")]
		public static extern int GetTilemapRows(TLN_Tilemap tilemap);
		// // Returns the number of horizontal tiles in the tilemap.
		[LinkName("TLN_GetTilemapCols")]
		public static extern int GetTilemapCols(TLN_Tilemap tilemap);
		// // Returns the optional associated tileset to the specified tilemap.
		[LinkName("TLN_GetTilemapTileset")]
		public static extern TLN_Tileset GetTilemapTileset(TLN_Tilemap tilemap);
		// // Gets data of a single tile inside a tilemap.
		[LinkName("TLN_GetTilemapTile")]
		public static extern bool GetTilemapTile(TLN_Tilemap tilemap, int row, int col, TLN_Tile tile);
		// // Sets a tile of a tilemap.
		[LinkName("TLN_SetTilemapTile")]
		public static extern bool SetTilemapTile(TLN_Tilemap tilemap, int row, int col, TLN_Tile tile);
		// // Copies blocks of tiles between two tilemaps.
		[LinkName("TLN_CopyTiles")]
		public static extern bool CopyTiles(TLN_Tilemap src, int srcrow, int srccol, int rows, int cols, TLN_Tilemap dst, int dstrow, int dstcol);
		// // Deletes the specified tilemap and frees memory.
		[LinkName("TLN_DeleteTilemap")]
		public static extern bool DeleteTilemap(TLN_Tilemap tilemap);

		// ------------------------------------------------------------------------------------
		// - Palette
		// -	Color palette resources management for sprites and background layers.
		// ------------------------------------------------------------------------------------
		// // Creates a new color table.
		[LinkName("TLN_CreatePalette")]
		public static extern TLN_Palette CreatePalette(int entries);
		// // Loads a palette from a standard .act file.
		[LinkName("TLN_LoadPalette")]
		public static extern TLN_Palette LoadPalette(char8* filename);
		// // Creates a duplicate of the specified palette.
		[LinkName("TLN_ClonePalette")]
		public static extern TLN_Palette ClonePalette(TLN_Palette src);
		// // Sets the RGB color value of a palette entry.
		[LinkName("TLN_SetPaletteColor")]
		public static extern bool SetPaletteColor(TLN_Palette palette, int color, uint8 r, uint8 g, uint8 b);
		// // Mixes two palettes to create a third one.
		[LinkName("TLN_MixPalettes")]
		public static extern bool MixPalettes(TLN_Palette src1, TLN_Palette src2, TLN_Palette dst, uint8 factor);
		// // Modifies a range of colors by adding the provided color value to the selected range. The result is always a brighter color.
		[LinkName("TLN_AddPaletteColor")]
		public static extern bool AddPaletteColor(TLN_Palette palette, uint8 r, uint8 g, uint8 b, uint8 start, uint8 num);
		// Modifies a range of colors by subtracting the provided color value to the selected range. The result is always a darker color.
		[LinkName("TLN_SubPaletteColor")]
		public static extern bool SubPaletteColor(TLN_Palette palette, uint8 r, uint8 g, uint8 b, uint8 start, uint8 num);
		// // Modifies a range of colors by modulating (normalized product) the provided color value to the selected range. The result is always a darker color.
		[LinkName("TLN_ModPaletteColor")]
		public static extern bool ModPaletteColor(TLN_Palette palette, uint8 r, uint8 g, uint8 b, uint8 start, uint8 num);
		// // Returns the color value of a palette entry.
		[LinkName("TLN_GetPaletteData")]
		public static extern uint8* GetPaletteData(TLN_Palette palette, int index);
		// // Deletes the specified palette and frees memory.
		[LinkName("TLN_DeletePalette")]
		public static extern bool DeletePalette(TLN_Palette palette);

		// ------------------------------------------------------------------------------------
		// - Bitmap
		// -	Bitmap management.
		// ------------------------------------------------------------------------------------
		// // Creates a memory Bitmap.
		[LinkName("TLN_CreateBitmap")]
		public static extern TLN_Bitmap CreateBitmap(int width, int height, int bpp);
		// // Load image file (8-bit BMP or PNG)
		[LinkName("TLN_LoadBitmap")]
		public static extern TLN_Bitmap LoadBitmap(char8* filename);
		// // Creates a copy of a Bitmap.
		[LinkName("TLN_CloneBitmap")]
		public static extern TLN_Bitmap CloneBitmap(TLN_Bitmap src);
		// // Gets memory access for direct pixel manipulation.
		[LinkName("TLN_GetBitmapPtr")]
		public static extern uint8* GetBitmapPtr(TLN_Bitmap bitmap, int x, int y);
		// // Returns the Width in pixels.
		[LinkName("TLN_GetBitmapWidth")]
		public static extern int GetBitmapWidth(TLN_Bitmap bitmap);
		// // Returns the Height in pixels.
		[LinkName("TLN_GetBitmapHeight")]
		public static extern int GetBitmapHeight(TLN_Bitmap bitmap);
		// // Returns the bits per pixel.
		[LinkName("TLN_GetBitmapDepth")]
		public static extern int GetBitmapDepth(TLN_Bitmap bitmap);
		// // Returns the number of bytes per scanline (also known a stride)
		[LinkName("TLN_GetBitmapPitch")]
		public static extern int GetBitmapPitch(TLN_Bitmap bitmap);
		// // Gets the associated Palette of a bitmap.
		[LinkName("TLN_GetBitmapPalette")]
		public static extern TLN_Palette GetBitmapPalette(TLN_Bitmap bitmap);
		// // Assigns a new Palette to the bitmap.
		[LinkName("TLN_SetBitmapPalette")]
		public static extern bool SetBitmapPalette(TLN_Bitmap bitmap, TLN_Palette palette);
		// // Deletes bitmap and frees resources.
		[LinkName("TLN_DeleteBitmap")]
		public static extern bool DeleteBitmap(TLN_Bitmap bitmap);

		// ------------------------------------------------------------------------------------
		// - Objects
		// -	ObjectList resources management.
		// ------------------------------------------------------------------------------------
		// // Creates a TLN_ObjectList The list is created empty, it must be populated with TLN_AddSpriteToList() and assigned to a layer with TLN_SetLayerObjects()
		[LinkName("TLN_CreateObjectList")]
		public static extern TLN_ObjectList CreateObjectList();
		// // Adds an image-based Tileset item to given TLN_ObjectList.
		[LinkName("TLN_AddTileObjectToList")]
		public static extern bool AddTileObjectToList(TLN_ObjectList list, uint16 id, uint16 gid, uint16 flags, int x, int y);
		// // Loads an Object List from a Tiled Object Layer.
		[LinkName("TLN_LoadObjectList")]
		public static extern TLN_ObjectList LoadObjectList(char8* filename, char8* layername);
		// // Creates a duplicate of a given TLN_ObjectList Object.
		[LinkName("TLN_CloneObjectList")]
		public static extern TLN_ObjectList CloneObjectList(TLN_ObjectList src);
		// // Returns number of items in TLN_ObjectList.
		[LinkName("TLN_GetListNumObjects")]
		public static extern int GetListNumObjects(TLN_ObjectList list);
		// // Iterates over elements in a TLN_ObjectList.
		[LinkName("TLN_GetListObject")]
		public static extern bool GetListObject(TLN_ObjectList list, ObjectInfo* info);
		// // Deletes Object List.
		[LinkName("TLN_DeleteObjectList")]
		public static extern bool DeleteObjectList(TLN_ObjectList list);

		// ------------------------------------------------------------------------------------
		// - Layers
		// -	Background layers management.
		// ------------------------------------------------------------------------------------
		// // Configures a background layer with the specified tileset and tilemap.
		// // This function doesn't modify the current position nor the blend mode, but assigns the palette of the specified tileset.
		[LinkName("TLN_SetLayer")]
		public static extern bool SetLayer(int nlayer, TLN_Tileset tileset, TLN_Tilemap tilemap);
		// // Configures a background layer with the specified full bitmap.
		// // This function doesn't modify the current position nor the blend mode, but assigns the palette of the specified bitmap.
		[LinkName("TLN_SetLayerBitmap")]
		public static extern bool SetLayerBitmap(int nlayer, TLN_Bitmap bitmap);
		// // Sets the color palette to the layer.
		// // When a layer is assigned with a tileset with the function TLN_SetLayer(), it automatically sets the palette of the assigned tileset to the layer.
		// // Use this function to override it and set another palette
		// // Call this function inside a raster callback to change the palette in the middle of the frame to get raster effect colors, like and "underwater" palette below the water line in a partially submerged background, or a gradient palette in an area at the top of the screen to simulate a "depth fog effect" in a pseudo 3d background
		[LinkName("TLN_SetLayerPalette")]
		public static extern bool SetLayerPalette(int nlayer, TLN_Palette palette);
		// // Sets the position of the tileset that corresponds to the upper left corner.
		// // The tileset usually spans an area much bigger than the viewport. Use this function to move the viewport insde the tileset. Change this value progressively for each frame to get a scrolling effect.
		// // Call this function inside a raster callback to get a raster scrolling effect. Use this to create horizontal strips of the same layer that move at different speeds to simulate depth. The extreme case of this effect, where the position is changed in each scanline, is called "line scroll" and was the technique used by games such as Street Fighter II to simualte a pseudo 3d floor, or many racing games to simulate a 3D road.
		[LinkName("TLN_SetLayerPosition")]
		public static extern bool SetLayerPosition(int nlayer, int hstart, int vstart);
		// // Sets simple scaling.
		// // By default the scaling factor of a given layer is 1.0f, 1.0f, which means no scaling. Use values below 1.0 to downscale (shrink) and above 1.0 to upscale (enlarge). Call TLN_ResetLayerMode() to disable scaling.
		[LinkName("TLN_SetLayerScaling")]
		public static extern bool SetLayerScaling(int nlayer, float xfactor, float yfactor);
		// // Sets affine transform matrix to enable rotating and scaling of this layer.
		// // Enable the transformation matrix to give the layer the capabilities of the famous Super Nintendo / Famicom Mode 7. Beware that the rendering of a transformed layer uses more CPU than a regular layer. Unlike the original Mode 7, that could only transform the single layer available, Tilengine can transform all the layers at the same time. The only limitation is the available CPU power.
		// // Call this function inside a raster callback to set the transformation matrix in the middle of the frame. Setting it for each scanline is the trick used by many Super Nintendo games to fake a 3D perspective projection.
		[LinkName("TLN_SetLayerAffineTransform")]
		public static extern bool SetLayerAffineTransform(int nlayer, Affine *affine);
		// // Sets affine transform matrix to enable rotating and scaling of this layer.
		// // This function is a simple wrapper to TLN_SetLayerAffineTransform() without using the TLN_Affine struct
		[LinkName("TLN_SetLayerTransform")]
		public static extern bool SetLayerTransform(int layer, float angle, float dx, float dy, float sx, float sy);
		// Sets the table for pixel mapping render mode.
		[LinkName("TLN_SetLayerPixelMapping")]
		public static extern bool SetLayerPixelMapping(int nlayer, PixelMap* table);
		// // Sets the blending mode (transparency effect).
		[LinkName("TLN_SetLayerBlendMode")]
		public static extern bool SetLayerBlendMode(int nlayer, Blend mode, uint8 factor);
		// // Enables column offset mode for this layer.
		// // Column offset is a value that is added or substracted (depeinding on the sign) to the vertical position for that layer (see TLN_SetLayerPosition) for each column in the tilemap assigned to that layer.
		// // This feature is tipically used to simulate vertical strips moving at different speeds, or combined with a line scroll effect, to fake rotations where the angle is small. The Sega Genesis games Puggsy and Chuck Rock II used this trick to simulate partially rotating backgrounds
		[LinkName("TLN_SetLayerColumnOffset")]
		public static extern bool SetLayerColumnOffset(int nlayer, int* offset);
		// // Enables clipping rectangle on selected layer.
		[LinkName("TLN_SetLayerClip")]
		public static extern bool SetLayerClip(int nlayer, int x1, int y1, int x2, int y2);
		// // Disables clipping rectangle on selected layer.
		[LinkName("TLN_DisableLayerClip")]
		public static extern bool DisableLayerClip(int nlayer);
		// // Enables mosaic effect (pixelation) for selected layer.
		[LinkName("TLN_SetLayerMosaic")]
		public static extern bool SetLayerMosaic(int nlayer, int width, int height);
		// // Disables mosaic effect for selected layer.
		[LinkName("TLN_DisableLayerMosaic")]
		public static extern bool DisableLayerMosaic(int nlayer);
		// // Disables scaling or affine transform for the layer.
		[LinkName("TLN_ResetLayerMode")]
		public static extern bool ResetLayerMode(int nlayer);
		// // Configures a background layer with a object list and an image-based tileset.
		[LinkName("TLN_SetLayerObjects")]
		public static extern bool SetLayerObjects(int nlayer, TLN_ObjectList objects, TLN_Tileset tileset);
		// // Sets full Layer priority, appearing in front of Sprites.
		[LinkName("TLN_SetLayerPriority")]
		public static extern bool SetLayerPriority(int nlayer, bool enable);
		// // Sets parent Layer index to scroll in sync.
		// // A layer with a parent gets scroll position from its parent, so they scroll together
		[LinkName("TLN_SetLayerParent")]
		public static extern bool SetLayerParent(int nlayer, int parent);
		// // Disables Layer parent.
		[LinkName("TLN_DisableLayerParent")]
		public static extern bool DisableLayerParent(int nlayer);
		// // Disables the specified Layer so it is not drawn.
		[LinkName("TLN_DisableLayer")]
		public static extern bool DisableLayer(int nlayer);
		// // Gets the attached Palette of a Layer.
		[LinkName("TLN_GetLayerPalette")]
		public static extern TLN_Palette GetLayerPalette(int nlayer);
		// // Gets info about the tile located in Tilemap space.
		// // Use this function to implement collision detection between sprites and the main background layer.
		[LinkName("TLN_GetLayerTile")]
		public static extern bool GetLayerTile(int nlayer, int x, int y, TileInfo* info);
		// Returns the Layer Width in pixels.
		[LinkName("TLN_GetLayerWidth")]
		public static extern int  GetLayerWidth(int nlayer);
		// // Returns the Layer Height in pixels.
		[LinkName("TLN_GetLayerHeight")]
		public static extern int  GetLayerHeight(int nlayer);

		// ------------------------------------------------------------------------------------
		// - Sprites
		// -	Sprites management.
		// ------------------------------------------------------------------------------------
		// // Configures a Sprite, setting Spriteset and flags at once
		[LinkName("TLN_ConfigSprite")]
		public static extern bool ConfigSprite(int nsprite, TLN_Spriteset spriteset, TileFlags flags);
		// // Assigns the spriteset and its palette to a given sprite.
		[LinkName("TLN_SetSpriteSet")]
		public static extern bool SetSpriteSet(int nsprite, TLN_Spriteset spriteset);
		// // Sets flags for a given sprite.
		[LinkName("TLN_SetSpriteFlags")]
		public static extern bool SetSpriteFlags(int nsprite, TileFlags flags);
		// // Sets the sprite position inside the viewport.
		// // Call this function inside a raster callback to so some vertical distortion effects (fake scaling) or sprite multiplexing (reusing a single sprite at different screen heights). This technique was used by some 8 bit games, with very few hardware sprites, to draw much more sprites in the screen, as long as they don't overlap vertically.
		[LinkName("TLN_SetSpritePosition")]
		public static extern bool SetSpritePosition(int nsprite, int x, int y);
		// // Sets the actual graphic to the sprite.
		[LinkName("TLN_SetSpritePicture")]
		public static extern bool SetSpritePicture(int nsprite, int entry);
		// // Assigns a palette to a sprite.
		[LinkName("TLN_SetSpritePalette")]
		public static extern bool SetSpritePalette(int nsprite, TLN_Palette palette);
		// // Sets the blending mode (transparency effect).
		[LinkName("TLN_SetSpriteBlendMode")]
		public static extern bool SetSpriteBlendMode(int nsprite, Blend mode, uint8 factor);
		// // Sets the scaling factor of the sprite.
		[LinkName("TLN_SetSpriteScaling")]
		public static extern bool SetSpriteScaling(int nsprite, float sx, float sy);
		// // Disables scaling for a given sprite.
		[LinkName("TLN_ResetSpriteScaling")]
		public static extern bool ResetSpriteScaling(int nsprite);
		/*// // Rotate Sprite
		[LinkName("TLN_SetSpriteRotation")]
		public static extern bool SetSpriteRotation (int nsprite, float angle);
		// // Reset	Sprite Rotation
		[LinkName("TLN_ResetSpriteRotation")]
		public static extern bool ResetSpriteRotation (int nsprite);*/
		// // Returns the index of the assigned picture from the Spriteset.
		[LinkName("TLN_GetSpritePicture")]
		public static extern int  GetSpritePicture(int nsprite);
		// // Finds an available (unused) Sprite.
		[LinkName("TLN_GetAvailableSprite")]
		public static extern int  GetAvailableSprite();
		// // Enable sprite collision checking at pixel level.
		// // Only sprites that have collision enabled are checked between them, so to detect a collision between two sprites, both of them must have collision detection enabled. Processing collision detection sprites take more a bit more CPU time compared to non-colliding sprites, so by default it is disabled on all sprites.
		[LinkName("TLN_EnableSpriteCollision")]
		public static extern bool EnableSpriteCollision(int nsprite, bool enable);
		// // Gets the collision status of a given sprite. Collision detection must be enabled for the sprite to get checked
		[LinkName("TLN_GetSpriteCollision")]
		public static extern bool GetSpriteCollision(int nsprite);
		// // Returns runtime info about a given sprite.
		// // Info may not be accurate if SpriteState.enabled member is returned as false
		[LinkName("TLN_GetSpriteState")]
		public static extern bool GetSpriteState(int nsprite, SpriteState* state);
		// // Sets the first sprite drawn (beginning of list)
		[LinkName("TLN_SetFirstSprite")]
		public static extern bool SetFirstSprite(int nsprite);
		// // Sets the next sprite to draw for a given sprite, builds list.
		[LinkName("TLN_SetNextSprite")]
		public static extern bool SetNextSprite(int nsprite, int next);
		// // Enables or disables masking for this sprite, if enabled it won't be drawn inside the region set up with TLN_SetSpritesMaskRegion()
		[LinkName("TLN_EnableSpriteMasking")]
		public static extern bool EnableSpriteMasking(int nsprite, bool enable);
		// // Defines a sprite masking region between the two scanlines. Sprites masked with TLN_EnableSpriteMasking() won't be drawn inside this region.
		[LinkName("TLN_SetSpritesMaskRegion")]
		public static extern void SetSpritesMaskRegion(int top_line, int bottom_line);
		// // Disables the sprite so it is not drawn.
		// // A sprite is also automatically disabled when assigned with an invalid spriteste or palette. Disabled sprites are returned by the function TLN_GetAvailableSprite as available
		[LinkName("TLN_DisableSprite")]
		public static extern bool DisableSprite(int nsprite);
		// // Gets the palette assigned to a given Sprite.
		[LinkName("TLN_GetSpritePalette")]
		public static extern TLN_Palette GetSpritePalette(int nsprite);

		// ------------------------------------------------------------------------------------
		// - Sequences
		// -	Resources management for Layer, Sprite and Palette animations.
		// ------------------------------------------------------------------------------------
		// // Creates a new Sequence for the animation engine.
		// // Use this function to create Tileset or Sprite animations
		[LinkName("TLN_CreateSequence")]
		public static extern TLN_Sequence CreateSequence(char8* name, int target, int num_frames, SequenceFrame* frames);
		// // Creates a Color Cycle Sequence for Palette animation.
		// // Use this function to create advanced Palette animation effects.
		[LinkName("TLN_CreateCycle")]
		public static extern TLN_Sequence CreateCycle(char8* name, int num_strips, ColorStrip* strips);
		// // Creates a name based Sprite Sequence.
		[LinkName("TLN_CreateSpriteSequence")]
		public static extern TLN_Sequence CreateSpriteSequence(char8* name, TLN_Spriteset spriteset, char8* basename, int delay);
		// // Creates a duplicate of the specified Sequence.
		[LinkName("TLN_CloneSequence")]
		public static extern TLN_Sequence CloneSequence(TLN_Sequence src);
		// // Returns runtime info about a given Sequence.
		[LinkName("TLN_GetSequenceInfo")]
		public static extern bool GetSequenceInfo(TLN_Sequence sequence, SequenceInfo* info);
		// // Deletes the sequence and frees resources.
		[LinkName("TLN_DeleteSequence")]
		public static extern bool DeleteSequence(TLN_Sequence sequence);

		// ------------------------------------------------------------------------------------
		// - SequencePacks
		// -	Sequence pack manager for grouping and finding sequences.
		// ------------------------------------------------------------------------------------
		// // Creates a new collection of Sequences.
		[LinkName("TLN_CreateSequencePack")]
		public static extern TLN_SequencePack CreateSequencePack();
		// // Loads a .sqx file containing one or more Sequences.
		// // A SQX file can contain many sequences. This function loads all of them inside a single TLN_SequencePack(). Individual Sequences can be later queried with TLN_FindSequence()
		[LinkName("TLN_LoadSequencePack")]
		public static extern TLN_SequencePack LoadSequencePack(char8* filename);
		// // Returns the nth Sequence inside a Sequence Pack.
		[LinkName("TLN_GetSequence")]
		public static extern TLN_Sequence GetSequence(TLN_SequencePack sp, int index);
		// // Finds a Sequence inside a Sequence Pack.
		[LinkName("TLN_FindSequence")]
		public static extern TLN_Sequence FindSequence(TLN_SequencePack sp, char8* name);
		// // Returns the number of Sequences inside a Sequence Pack.
		[LinkName("TLN_GetSequencePackCount")]
		public static extern int GetSequencePackCount(TLN_SequencePack sp);
		// // Adds a Sequence to a Sequence Pack.
		[LinkName("TLN_AddSequenceToPack")]
		public static extern bool AddSequenceToPack(TLN_SequencePack sp, TLN_Sequence sequence);
		// // Deletes the specified Sequence Pack and frees memory.
		[LinkName("TLN_DeleteSequencePack")]
		public static extern bool DeleteSequencePack(TLN_SequencePack sp);

		// ------------------------------------------------------------------------------------
		// - Animations
		// -	Animation engine manager.
		// ------------------------------------------------------------------------------------
		// // Starts a Palette animation.
		[LinkName("TLN_SetPaletteAnimation")]
		public static extern bool SetPaletteAnimation(int index, TLN_Palette palette, TLN_Sequence sequence, bool blend);
		// // Sets the source Palette of a Color Cycle animation.
		// // Use this function to change the palette assigned to a color cycle animation running. This is useful to combine color cycling and palette interpolation at the same time.
		[LinkName("TLN_SetPaletteAnimationSource")]
		public static extern bool SetPaletteAnimationSource(int index, TLN_Palette palette);
		// // Starts a Tileset animation.
		[LinkName("TLN_SetTilesetAnimation")]
		public static extern bool SetTilesetAnimation(int index, int nlayer, TLN_Sequence sequence);
		// // Starts a Tilemap animation.
		[LinkName("TLN_SetTilemapAnimation")]
		public static extern bool SetTilemapAnimation(int index, int nlayer, TLN_Sequence sequence);
		// // Starts a Sprite animation.
		[LinkName("TLN_SetSpriteAnimation")]
		public static extern bool SetSpriteAnimation(int index, int nsprite, TLN_Sequence sequence, int loop);
		// // Checks the state of the specified animation.
		[LinkName("TLN_GetAnimationState")]
		public static extern bool GetAnimationState(int index);
		// // Deprecated, each frame has its own delay.
		[LinkName("TLN_SetAnimationDelay")]
		public static extern bool SetAnimationDelay(int index, int delay);
		// // Finds an available (unused) animation.
		[LinkName("TLN_GetAvailableAnimation")]
		public static extern int  GetAvailableAnimation();
		// // Disables the animation so it stops playing and returns it to the list of available animations.
		[LinkName("TLN_DisableAnimation")]
		public static extern bool DisableAnimation(int index);
	}
}
