/*******************************************************************************
* FILENAME :        modules/visual/subtitles.pwn
*
* DESCRIPTION :
*       Create/Destroy and Show subtitles for players.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

//------------------------------------------------------------------------------

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

static PlayerText:gpTextDrawSub[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...};
static Text:WIDESCREEN_TOP;
static Text:WIDESCREEN_BOTTOM;

//------------------------------------------------------------------------------

CreatePlayerSubtitle(playerid, text[], bool:widescreen = false)
{
    if(gpTextDrawSub[playerid] != PlayerText:INVALID_TEXT_DRAW)
    {
        PlayerTextDrawSetString(playerid, gpTextDrawSub[playerid], text);
        return 1;
    }

    gpTextDrawSub[playerid] = CreatePlayerTextDraw(playerid, 325.666625, 425.563018, text);
    PlayerTextDrawLetterSize(playerid, gpTextDrawSub[playerid], 0.400000, 1.600000);
    PlayerTextDrawAlignment(playerid, gpTextDrawSub[playerid], 2);
    PlayerTextDrawColor(playerid, gpTextDrawSub[playerid], 0xe8e8e8ff);
    PlayerTextDrawSetShadow(playerid, gpTextDrawSub[playerid], 1);
    PlayerTextDrawSetOutline(playerid, gpTextDrawSub[playerid], 0);
    PlayerTextDrawBackgroundColor(playerid, gpTextDrawSub[playerid], 255);
    PlayerTextDrawFont(playerid, gpTextDrawSub[playerid], 1);
    PlayerTextDrawSetProportional(playerid, gpTextDrawSub[playerid], 1);
    PlayerTextDrawSetShadow(playerid, gpTextDrawSub[playerid], 1);
    PlayerTextDrawShow(playerid, gpTextDrawSub[playerid]);

    if(widescreen)
    {
        TextDrawShowForPlayer(playerid, WIDESCREEN_TOP);
        TextDrawShowForPlayer(playerid, WIDESCREEN_BOTTOM);
        HidePlayerClock(playerid);
        SelectTextDraw(playerid, 0xffffff00);
    }
    return 1;
}

//------------------------------------------------------------------------------

SetPlayerSubtitle(playerid, text[])
{
    if(gpTextDrawSub[playerid] == PlayerText:INVALID_TEXT_DRAW)
        return 1;

    PlayerTextDrawSetString(playerid, gpTextDrawSub[playerid], text);
    return 1;
}

//------------------------------------------------------------------------------

DestroyPlayerSubtitle(playerid)
{
    if(gpTextDrawSub[playerid] == PlayerText:INVALID_TEXT_DRAW)
        return 1;

    PlayerTextDrawDestroy(playerid, gpTextDrawSub[playerid]);
    gpTextDrawSub[playerid] = PlayerText:INVALID_TEXT_DRAW;

    TextDrawHideForPlayer(playerid, WIDESCREEN_TOP);
    TextDrawHideForPlayer(playerid, WIDESCREEN_BOTTOM);
    ShowPlayerClock(playerid);
    CancelSelectTextDraw(playerid);
    return 1;
}

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
    WIDESCREEN_TOP = TextDrawCreate(320.000000, 1.000000, "_");
	TextDrawAlignment(WIDESCREEN_TOP, 2);
	TextDrawBackgroundColor(WIDESCREEN_TOP, 255);
	TextDrawFont(WIDESCREEN_TOP, 1);
	TextDrawLetterSize(WIDESCREEN_TOP, 0.500000, 8.000000);
	TextDrawColor(WIDESCREEN_TOP, -1);
	TextDrawSetOutline(WIDESCREEN_TOP, 0);
	TextDrawSetProportional(WIDESCREEN_TOP, 1);
	TextDrawSetShadow(WIDESCREEN_TOP, 1);
	TextDrawUseBox(WIDESCREEN_TOP, 1);
	TextDrawBoxColor(WIDESCREEN_TOP, 255);
	TextDrawTextSize(WIDESCREEN_TOP, 0.000000, -660.000000);

	WIDESCREEN_BOTTOM = TextDrawCreate(320.000000, 381.000000, "_");
	TextDrawAlignment(WIDESCREEN_BOTTOM, 2);
	TextDrawBackgroundColor(WIDESCREEN_BOTTOM, 255);
	TextDrawFont(WIDESCREEN_BOTTOM, 1);
	TextDrawLetterSize(WIDESCREEN_BOTTOM, 0.500000, 8.000000);
	TextDrawColor(WIDESCREEN_BOTTOM, -1);
	TextDrawSetOutline(WIDESCREEN_BOTTOM, 0);
	TextDrawSetProportional(WIDESCREEN_BOTTOM, 1);
	TextDrawSetShadow(WIDESCREEN_BOTTOM, 1);
	TextDrawUseBox(WIDESCREEN_BOTTOM, 1);
	TextDrawBoxColor(WIDESCREEN_BOTTOM, 255);
	TextDrawTextSize(WIDESCREEN_BOTTOM, 0.000000, -660.000000);
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
    gpTextDrawSub[playerid] = PlayerText:INVALID_TEXT_DRAW;
    return 1;
}
