/*******************************************************************************
* FILENAME :        modules/visual/tutorial.pwn
*
* DESCRIPTION :
*       Create/Destroy and Show tutorial GUI functions.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

static Text:gTutorialTextDraw[10];
static bool:gIsTextVisible[MAX_PLAYERS];
static PlayerText:gPTutorialTextDraw[MAX_PLAYERS];

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
    gIsTextVisible[playerid] = false;
    return 1;
}

//------------------------------------------------------------------------------

ShowTutorialTextForPlayer(playerid)
{
    if(gIsTextVisible[playerid])
        return 1;

    gIsTextVisible[playerid] = true;
    for(new i = 0; i < sizeof(gTutorialTextDraw); i++)
        TextDrawShowForPlayer(playerid, gTutorialTextDraw[i]);

    gPTutorialTextDraw[playerid] = CreatePlayerTextDraw(playerid, 110.000000, 139.000000, "-");
	PlayerTextDrawBackgroundColor(playerid, gPTutorialTextDraw[playerid], 255);
	PlayerTextDrawFont(playerid, gPTutorialTextDraw[playerid], 2);
	PlayerTextDrawLetterSize(playerid, gPTutorialTextDraw[playerid], 0.219999, 1.000000);
	PlayerTextDrawColor(playerid, gPTutorialTextDraw[playerid], -1);
	PlayerTextDrawSetOutline(playerid, gPTutorialTextDraw[playerid], 0);
	PlayerTextDrawSetProportional(playerid, gPTutorialTextDraw[playerid], 1);
	PlayerTextDrawSetShadow(playerid, gPTutorialTextDraw[playerid], 1);
    PlayerTextDrawShow(playerid, gPTutorialTextDraw[playerid]);
    SelectTextDraw(playerid, 0xDC322FFF);
    return 1;
}

//------------------------------------------------------------------------------

HideTutorialTextForPlayer(playerid)
{
    if(!gIsTextVisible[playerid])
        return 1;

    gIsTextVisible[playerid] = false;
    for(new i = 0; i < sizeof(gTutorialTextDraw); i++)
        TextDrawHideForPlayer(playerid, gTutorialTextDraw[i]);

    PlayerTextDrawDestroy(playerid, gPTutorialTextDraw[playerid]);
    CancelSelectTextDraw(playerid);
    return 1;
}

//------------------------------------------------------------------------------

SetPlayerTutorialText(playerid, message[])
{
    if(!gIsTextVisible[playerid])
        return 1;

    PlayerTextDrawSetString(playerid, gPTutorialTextDraw[playerid], message);
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerClickTextDraw(playerid, Text:clickedid)
{
    if(!gIsTextVisible[playerid])
        return 1;
    else if(clickedid == gTutorialTextDraw[7]) // Left Button
        OnPlayerClickTutorialButton(playerid, BUTTON_LEFT);
    else if(clickedid == gTutorialTextDraw[8]) // Right Button
        OnPlayerClickTutorialButton(playerid, BUTTON_RIGHT);
    else if(clickedid == Text:INVALID_TEXT_DRAW)
        SelectTextDraw(playerid, 0xDC322FFF);
    return 1;
}

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
    gTutorialTextDraw[0] = TextDrawCreate(839.000000, -52.000000, "_");
	TextDrawBackgroundColor(gTutorialTextDraw[0], 255);
	TextDrawFont(gTutorialTextDraw[0], 1);
	TextDrawLetterSize(gTutorialTextDraw[0], 0.500000, 17.799999);
	TextDrawColor(gTutorialTextDraw[0], -1);
	TextDrawSetOutline(gTutorialTextDraw[0], 0);
	TextDrawSetProportional(gTutorialTextDraw[0], 1);
	TextDrawSetShadow(gTutorialTextDraw[0], 1);
	TextDrawUseBox(gTutorialTextDraw[0], 1);
	TextDrawBoxColor(gTutorialTextDraw[0], 255);
	TextDrawTextSize(gTutorialTextDraw[0], -160.000000, 0.000000);
	TextDrawSetSelectable(gTutorialTextDraw[0], 0);

	gTutorialTextDraw[1] = TextDrawCreate(839.000000, 342.000000, "_");
	TextDrawBackgroundColor(gTutorialTextDraw[1], 255);
	TextDrawFont(gTutorialTextDraw[1], 1);
	TextDrawLetterSize(gTutorialTextDraw[1], 0.500000, 17.799999);
	TextDrawColor(gTutorialTextDraw[1], -1);
	TextDrawSetOutline(gTutorialTextDraw[1], 0);
	TextDrawSetProportional(gTutorialTextDraw[1], 1);
	TextDrawSetShadow(gTutorialTextDraw[1], 1);
	TextDrawUseBox(gTutorialTextDraw[1], 1);
	TextDrawBoxColor(gTutorialTextDraw[1], 255);
	TextDrawTextSize(gTutorialTextDraw[1], -160.000000, 0.000000);
	TextDrawSetSelectable(gTutorialTextDraw[1], 0);

	gTutorialTextDraw[2] = TextDrawCreate(523.000000, 120.000000, "_");
	TextDrawBackgroundColor(gTutorialTextDraw[2], 255);
	TextDrawFont(gTutorialTextDraw[2], 1);
	TextDrawLetterSize(gTutorialTextDraw[2], 0.500000, 23.200004);
	TextDrawColor(gTutorialTextDraw[2], -1);
	TextDrawSetOutline(gTutorialTextDraw[2], 0);
	TextDrawSetProportional(gTutorialTextDraw[2], 1);
	TextDrawSetShadow(gTutorialTextDraw[2], 1);
	TextDrawUseBox(gTutorialTextDraw[2], 1);
	TextDrawBoxColor(gTutorialTextDraw[2], 168430230);
	TextDrawTextSize(gTutorialTextDraw[2], 93.000000, 0.000000);
	TextDrawSetSelectable(gTutorialTextDraw[2], 0);

	gTutorialTextDraw[3] = TextDrawCreate(523.000000, 119.000000, "_");
	TextDrawBackgroundColor(gTutorialTextDraw[3], 255);
	TextDrawFont(gTutorialTextDraw[3], 1);
	TextDrawLetterSize(gTutorialTextDraw[3], 0.500000, 1.299999);
	TextDrawColor(gTutorialTextDraw[3], -1);
	TextDrawSetOutline(gTutorialTextDraw[3], 0);
	TextDrawSetProportional(gTutorialTextDraw[3], 1);
	TextDrawSetShadow(gTutorialTextDraw[3], 1);
	TextDrawUseBox(gTutorialTextDraw[3], 1);
	TextDrawBoxColor(gTutorialTextDraw[3], 1398435071);
	TextDrawTextSize(gTutorialTextDraw[3], 93.000000, 0.000000);
	TextDrawSetSelectable(gTutorialTextDraw[3], 0);

	gTutorialTextDraw[4] = TextDrawCreate(523.000000, 119.000000, "_");
	TextDrawBackgroundColor(gTutorialTextDraw[4], 255);
	TextDrawFont(gTutorialTextDraw[4], 1);
	TextDrawLetterSize(gTutorialTextDraw[4], 0.500000, 0.399999);
	TextDrawColor(gTutorialTextDraw[4], -1);
	TextDrawSetOutline(gTutorialTextDraw[4], 0);
	TextDrawSetProportional(gTutorialTextDraw[4], 1);
	TextDrawSetShadow(gTutorialTextDraw[4], 1);
	TextDrawUseBox(gTutorialTextDraw[4], 1);
	TextDrawBoxColor(gTutorialTextDraw[4], 1937478655);
	TextDrawTextSize(gTutorialTextDraw[4], 93.000000, -16.000000);
	TextDrawSetSelectable(gTutorialTextDraw[4], 0);

	gTutorialTextDraw[5] = TextDrawCreate(125.000000, 120.000000, "RPG");
	TextDrawBackgroundColor(gTutorialTextDraw[5], -231);
	TextDrawFont(gTutorialTextDraw[5], 1);
	TextDrawLetterSize(gTutorialTextDraw[5], 0.329998, 1.200000);
	TextDrawColor(gTutorialTextDraw[5], 1116457727);
	TextDrawSetOutline(gTutorialTextDraw[5], 0);
	TextDrawSetProportional(gTutorialTextDraw[5], 1);
	TextDrawSetShadow(gTutorialTextDraw[5], 1);
	TextDrawSetSelectable(gTutorialTextDraw[5], 0);

	gTutorialTextDraw[6] = TextDrawCreate(107.000000, 120.000000, "PC~w~:");
	TextDrawBackgroundColor(gTutorialTextDraw[6], -206);
	TextDrawFont(gTutorialTextDraw[6], 1);
	TextDrawLetterSize(gTutorialTextDraw[6], 0.329998, 1.200000);
	TextDrawColor(gTutorialTextDraw[6], -293376257);
	TextDrawSetOutline(gTutorialTextDraw[6], 0);
	TextDrawSetProportional(gTutorialTextDraw[6], 1);
	TextDrawSetShadow(gTutorialTextDraw[6], 0);
	TextDrawSetSelectable(gTutorialTextDraw[6], 0);

	gTutorialTextDraw[7] = TextDrawCreate(102.000000, 315.000000, "< VOLTAR");
	TextDrawBackgroundColor(gTutorialTextDraw[7], 0);
	TextDrawFont(gTutorialTextDraw[7], 1);
	TextDrawLetterSize(gTutorialTextDraw[7], 0.300000, 1.100000);
	TextDrawColor(gTutorialTextDraw[7], -1);
	TextDrawSetOutline(gTutorialTextDraw[7], 0);
	TextDrawSetProportional(gTutorialTextDraw[7], 1);
	TextDrawSetShadow(gTutorialTextDraw[7], 1);
	TextDrawUseBox(gTutorialTextDraw[7], 1);
	TextDrawBoxColor(gTutorialTextDraw[7], 1398435071);
	TextDrawTextSize(gTutorialTextDraw[7], 159.000000, 13.000000);
	TextDrawSetSelectable(gTutorialTextDraw[7], 1);

	gTutorialTextDraw[8] = TextDrawCreate(445.000000, 315.000000, "CONTINUAR >");
	TextDrawBackgroundColor(gTutorialTextDraw[8], 0);
	TextDrawFont(gTutorialTextDraw[8], 1);
	TextDrawLetterSize(gTutorialTextDraw[8], 0.300000, 1.100000);
	TextDrawColor(gTutorialTextDraw[8], -1);
	TextDrawSetOutline(gTutorialTextDraw[8], 0);
	TextDrawSetProportional(gTutorialTextDraw[8], 1);
	TextDrawSetShadow(gTutorialTextDraw[8], 1);
	TextDrawUseBox(gTutorialTextDraw[8], 1);
	TextDrawBoxColor(gTutorialTextDraw[8], 1398435071);
	TextDrawTextSize(gTutorialTextDraw[8], 514.000000, 13.000000);
	TextDrawSetSelectable(gTutorialTextDraw[8], 1);

	gTutorialTextDraw[9] = TextDrawCreate(276.000000, 120.000000, "BEM-VINDO!");
	TextDrawBackgroundColor(gTutorialTextDraw[9], -231);
	TextDrawFont(gTutorialTextDraw[9], 1);
	TextDrawLetterSize(gTutorialTextDraw[9], 0.270000, 1.200000);
	TextDrawColor(gTutorialTextDraw[9], -1);
	TextDrawSetOutline(gTutorialTextDraw[9], 0);
	TextDrawSetProportional(gTutorialTextDraw[9], 1);
	TextDrawSetShadow(gTutorialTextDraw[9], 1);
	TextDrawSetSelectable(gTutorialTextDraw[9], 0);
    return 1;
}
