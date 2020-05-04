using System;
namespace TLN.Enums
{
	[AllowDuplicates]
	public enum Input : int		   // Standard inputs query for Window.GetInput()
	{
	    None,
		Up,
		Down,
		Left,
		Right,
		Button1,
		Button2,
		Button3,
		Button4,
		Button5,
		Button6,
		Start,
		Quit,				   // Window close (only Player 1 keyboard)
		CRT,				   // CRT toggle (only Player 1 keyboard)
		P1 = ((int)Player.P1 << 4), // Request player 1 input (default)	WARNING This may be bugged as Beef thinks this is a duplicate of None...
		P2 = ((int)Player.P2 << 4), // Request player 2 input
		P3 = ((int)Player.P3 << 4), // Request player 3 input
		P4 = ((int)Player.P4 << 4), // Request player 4 input

		// Compatibility Symbols for pre-1.18 Input model
		Button_A = Button1,
		Button_B = Button2,
		Button_C = Button3,
		Button_D = Button4,
		Button_E = Button5,
		Button_F = Button6
	}
}
