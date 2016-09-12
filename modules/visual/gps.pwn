/* *************************************************************************** *
*  Description: GPS module file.
*
*  Assignment: A script that adds GPS for players.
*
*           Copyright Paradise Devs 2015.  All rights reserved.
* *************************************************************************** */

#include <YSI\y_hooks>

// new PlayerText:td_debug[MAX_PLAYERS];
static PlayerText:textDistrict[MAX_PLAYERS];
static PlayerText:textUnGPS[MAX_PLAYERS];
static PlayerText:textBuy[MAX_PLAYERS];
static PlayerText:textBGGPS[MAX_PLAYERS];
static PlayerText:textFGGPS[MAX_PLAYERS];

static isVisible[MAX_PLAYERS];
static zone;

hook OnGameModeInit()
{
    zone = GangZoneCreate(-2989.536, -2954.502, 2977.858, 2977.858);
    return 1;
}

hook OnPlayerConnect(playerid)
{
    isVisible[playerid] = false;
    // td_debug[playerid] = CreatePlayerTextDraw(playerid, 85.333351, 320.237060, "_");

    textDistrict[playerid] = CreatePlayerTextDraw(playerid, 85.333351, 320.237060, "Los Santos");
	PlayerTextDrawLetterSize(playerid, textDistrict[playerid], 0.449999, 1.600000);
	PlayerTextDrawAlignment(playerid, textDistrict[playerid], 2);
	PlayerTextDrawColor(playerid, textDistrict[playerid], -1);
	PlayerTextDrawSetShadow(playerid, textDistrict[playerid], 0);
	PlayerTextDrawSetOutline(playerid, textDistrict[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, textDistrict[playerid], 51);
	PlayerTextDrawFont(playerid, textDistrict[playerid], 0);
	PlayerTextDrawSetProportional(playerid, textDistrict[playerid], 1);

    textBGGPS[playerid] = CreatePlayerTextDraw(playerid,32.000000, 332.000000, "LD_POOL:ball");
    PlayerTextDrawBackgroundColor(playerid,textBGGPS[playerid], 255);
    PlayerTextDrawFont(playerid,textBGGPS[playerid], 4);
    PlayerTextDrawLetterSize(playerid,textBGGPS[playerid], 0.500000, 1.000000);
    PlayerTextDrawColor(playerid,textBGGPS[playerid], -1);
    PlayerTextDrawSetOutline(playerid,textBGGPS[playerid], 0);
    PlayerTextDrawSetProportional(playerid,textBGGPS[playerid], 1);
    PlayerTextDrawSetShadow(playerid,textBGGPS[playerid], 1);
    PlayerTextDrawUseBox(playerid,textBGGPS[playerid], 1);
    PlayerTextDrawBoxColor(playerid,textBGGPS[playerid], 255);
    PlayerTextDrawTextSize(playerid,textBGGPS[playerid], 112.000000, 100.000000);
    PlayerTextDrawSetSelectable(playerid,textBGGPS[playerid], 0);

    textFGGPS[playerid] = CreatePlayerTextDraw(playerid,35.000000, 335.000000, "LD_POOL:ball");
    PlayerTextDrawBackgroundColor(playerid,textFGGPS[playerid], 255);
    PlayerTextDrawFont(playerid,textFGGPS[playerid], 4);
    PlayerTextDrawLetterSize(playerid,textFGGPS[playerid], 0.500000, 0.699998);
    PlayerTextDrawColor(playerid,textFGGPS[playerid], 1684301055);
    PlayerTextDrawSetOutline(playerid,textFGGPS[playerid], 0);
    PlayerTextDrawSetProportional(playerid,textFGGPS[playerid], 1);
    PlayerTextDrawSetShadow(playerid,textFGGPS[playerid], 1);
    PlayerTextDrawUseBox(playerid,textFGGPS[playerid], 1);
    PlayerTextDrawBoxColor(playerid,textFGGPS[playerid], 842150655);
    PlayerTextDrawTextSize(playerid,textFGGPS[playerid], 106.000000, 94.000000);
    PlayerTextDrawSetSelectable(playerid,textFGGPS[playerid], 0);

    textUnGPS[playerid] = CreatePlayerTextDraw(playerid,46.000000, 372.000000, "GPS INDISPONIVEL");
    PlayerTextDrawBackgroundColor(playerid,textUnGPS[playerid], 252645135);
    PlayerTextDrawFont(playerid,textUnGPS[playerid], 1);
    PlayerTextDrawLetterSize(playerid,textUnGPS[playerid], 0.270000, 1.000000);
    PlayerTextDrawColor(playerid,textUnGPS[playerid], -2686721);
    PlayerTextDrawSetOutline(playerid,textUnGPS[playerid], 1);
    PlayerTextDrawSetProportional(playerid,textUnGPS[playerid], 1);
    PlayerTextDrawSetSelectable(playerid,textUnGPS[playerid], 0);

    textBuy[playerid] = CreatePlayerTextDraw(playerid,89.000000, 382.000000, "Adquira um na 24/7~n~mais proxima");
    PlayerTextDrawAlignment(playerid,textBuy[playerid], 2);
    PlayerTextDrawBackgroundColor(playerid,textBuy[playerid], 252645135);
    PlayerTextDrawFont(playerid,textBuy[playerid], 1);
    PlayerTextDrawLetterSize(playerid,textBuy[playerid], 0.209999, 1.000000);
    PlayerTextDrawColor(playerid,textBuy[playerid], -1);
    PlayerTextDrawSetOutline(playerid,textBuy[playerid], 1);
    PlayerTextDrawSetProportional(playerid,textBuy[playerid], 1);
    PlayerTextDrawSetSelectable(playerid,textBuy[playerid], 0);
    return 1;
}

UpdatePlayerGPS(playerid)
{
    if(!isVisible[playerid])
        return 1;

	new districtString[28];
	GetPlayer2DZone(playerid, districtString, 28);
	PlayerTextDrawSetString(playerid, textDistrict[playerid], districtString);
    return 1;
}

HidePlayerGPS(playerid)
{
    isVisible[playerid] = false;
	PlayerTextDrawHide(playerid, textDistrict[playerid]);
	PlayerTextDrawShow(playerid, textBGGPS[playerid]);
	PlayerTextDrawShow(playerid, textBuy[playerid]);
	PlayerTextDrawShow(playerid, textUnGPS[playerid]);
    PlayerTextDrawShow(playerid, textFGGPS[playerid]);
	GangZoneShowForPlayer(playerid, zone, 0x000000FF);
    return 1;
}

ShowPlayerGPS(playerid, bool:partial = false)
{
    isVisible[playerid] = true;
	if(partial == false) PlayerTextDrawShow(playerid, textDistrict[playerid]);
    else PlayerTextDrawHide(playerid, textDistrict[playerid]);
	PlayerTextDrawHide(playerid, textBGGPS[playerid]);
	PlayerTextDrawHide(playerid, textUnGPS[playerid]);
	PlayerTextDrawHide(playerid, textBuy[playerid]);
    PlayerTextDrawHide(playerid, textFGGPS[playerid]);
	GangZoneHideForPlayer(playerid, zone);
    return 1;
}
