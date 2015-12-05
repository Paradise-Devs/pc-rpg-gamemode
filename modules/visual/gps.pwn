/* *************************************************************************** *
*  Description: GPS module file.
*
*  Assignment: A script that adds GPS for players.
*
*           Copyright Paradise Devs 2015.  All rights reserved.
* *************************************************************************** */

#include <YSI\y_hooks>

new PlayerText:td_debug[MAX_PLAYERS];
static PlayerText:textDistrict[MAX_PLAYERS];
static PlayerText:textUnGPS[MAX_PLAYERS];
static PlayerText:textBuy[MAX_PLAYERS];
static PlayerText:textBGGPS[MAX_PLAYERS];

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
    td_debug[playerid] = CreatePlayerTextDraw(playerid, 85.333351, 320.237060, "_");

    textDistrict[playerid] = CreatePlayerTextDraw(playerid, 85.333351, 320.237060, "Los Santos");
	PlayerTextDrawLetterSize(playerid, textDistrict[playerid], 0.449999, 1.600000);
	PlayerTextDrawAlignment(playerid, textDistrict[playerid], 2);
	PlayerTextDrawColor(playerid, textDistrict[playerid], -1);
	PlayerTextDrawSetShadow(playerid, textDistrict[playerid], 0);
	PlayerTextDrawSetOutline(playerid, textDistrict[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, textDistrict[playerid], 51);
	PlayerTextDrawFont(playerid, textDistrict[playerid], 0);
	PlayerTextDrawSetProportional(playerid, textDistrict[playerid], 1);

    textBGGPS[playerid] = CreatePlayerTextDraw(playerid, 29.333312, 328.948059, "ld_pool:ball");
	PlayerTextDrawLetterSize(playerid, textBGGPS[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, textBGGPS[playerid], 114.000045, 100.800025);
	PlayerTextDrawAlignment(playerid, textBGGPS[playerid], 1);
	PlayerTextDrawColor(playerid, textBGGPS[playerid], 255);
	PlayerTextDrawSetShadow(playerid, textBGGPS[playerid], 0);
	PlayerTextDrawSetOutline(playerid, textBGGPS[playerid], 0);
	PlayerTextDrawFont(playerid, textBGGPS[playerid], 4);

	textUnGPS[playerid] = CreatePlayerTextDraw(playerid, 44.333354, 348.859252, "GPS INDISPONIVEL");
	PlayerTextDrawLetterSize(playerid, textUnGPS[playerid], 0.228666, 1.948443);
	PlayerTextDrawAlignment(playerid, textUnGPS[playerid], 1);
	PlayerTextDrawColor(playerid, textUnGPS[playerid], -16776961);
	PlayerTextDrawSetShadow(playerid, textUnGPS[playerid], 0);
	PlayerTextDrawSetOutline(playerid, textUnGPS[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, textUnGPS[playerid], 51);
	PlayerTextDrawFont(playerid, textUnGPS[playerid], 2);
	PlayerTextDrawSetProportional(playerid, textUnGPS[playerid], 1);

	textBuy[playerid] = CreatePlayerTextDraw(playerid, 88.000015, 383.703704, "Adquira um na 24/7~n~mais proxima");
	PlayerTextDrawLetterSize(playerid, textBuy[playerid], 0.176000, 1.591703);
	PlayerTextDrawAlignment(playerid, textBuy[playerid], 2);
	PlayerTextDrawColor(playerid, textBuy[playerid], -1);
	PlayerTextDrawSetShadow(playerid, textBuy[playerid], 0);
	PlayerTextDrawSetOutline(playerid, textBuy[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, textBuy[playerid], 51);
	PlayerTextDrawFont(playerid, textBuy[playerid], 2);
	PlayerTextDrawSetProportional(playerid, textBuy[playerid], 1);
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
	GangZoneShowForPlayer(playerid, zone, 0x000000FF);
    return 1;
}

ShowPlayerGPS(playerid)
{
    isVisible[playerid] = true;
	PlayerTextDrawShow(playerid, textDistrict[playerid]);
	PlayerTextDrawHide(playerid, textBGGPS[playerid]);
	PlayerTextDrawHide(playerid, textUnGPS[playerid]);
	PlayerTextDrawHide(playerid, textBuy[playerid]);
	GangZoneHideForPlayer(playerid, zone);
    return 1;
}
