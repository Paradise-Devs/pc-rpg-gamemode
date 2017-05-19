/*******************************************************************************
* FILENAME :        modules/visual/fade.pwn
*
* DESCRIPTION :
*       Implements fade function to the game
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

static const DELAY = 10;
#define RGBToHex(%0,%1,%2,%3) %0 << 24 | %1 << 16 | %2 << 8 | %3

static PlayerText:textFade[MAX_PLAYERS];

//------------------------------------------------------------------------------

timer FadeIn[DELAY](playerid, A)
{
	PlayerTextDrawBoxColor(playerid, textFade[playerid], RGBToHex(0,0,0,A));
	PlayerTextDrawShow(playerid, textFade[playerid]);
	if (A)
		defer FadeIn(playerid, A - 1);
}

//------------------------------------------------------------------------------

timer FadeIn2[DELAY](playerid, A)
{
	PlayerTextDrawBoxColor(playerid, textFade[playerid], RGBToHex(0,0,0,A));
	PlayerTextDrawShow(playerid, textFade[playerid]);
	if (A)
		defer FadeIn(playerid, A - 1);
}

//------------------------------------------------------------------------------

timer FadeOut[DELAY](playerid, A)
{
	PlayerTextDrawBoxColor(playerid, textFade[playerid], RGBToHex(0, 0, 0, A));
	PlayerTextDrawShow(playerid, textFade[playerid]);
	if (A < 255)
		defer FadeOut(playerid, A + 1);
}

//------------------------------------------------------------------------------

hook OnPlayerConnect(playerid)
{
    textFade[playerid] = CreatePlayerTextDraw(playerid, 320, 0, "_");
	PlayerTextDrawUseBox(playerid, textFade[playerid], 1);
	PlayerTextDrawLetterSize(playerid, textFade[playerid], 1.0, 49.6);
	PlayerTextDrawTextSize(playerid, textFade[playerid], 1.0, 640);
	PlayerTextDrawBoxColor(playerid, textFade[playerid], 0x00000000);
	PlayerTextDrawAlignment(playerid, textFade[playerid], 2);
}
