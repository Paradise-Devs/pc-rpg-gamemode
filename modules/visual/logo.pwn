/* *************************************************************************** *
*  Description: PC logo visual module file.
*
*  Assignment: A script to add pc rpg logo.
*
*           Copyright Paradise Devs 2015.  All rights reserved.
* *************************************************************************** */

#if defined _MODULE_vslogo
	#endinput
#endif
#define _MODULE_vslogo

#include <YSI\y_hooks>

static Text:textLogoBG;
static Text:textLogo1;
static Text:textLogo2;
static Text:textLogo3;
static Text:textLogoWebsite;
static Text:textLogoBorder1;
static Text:textLogoBorder2;

ShowPlayerLogo(playerid)
{
    TextDrawShowForPlayer(playerid, textLogoBG);
    TextDrawShowForPlayer(playerid, textLogo1);
    TextDrawShowForPlayer(playerid, textLogo2);
    TextDrawShowForPlayer(playerid, textLogo3);
    TextDrawShowForPlayer(playerid, textLogoWebsite);
    TextDrawShowForPlayer(playerid, textLogoBorder1);
    TextDrawShowForPlayer(playerid, textLogoBorder2);
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
		HidePlayerLogo(playerid);
	else if(oldstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_PASSENGER)
		ShowPlayerLogo(playerid);
	return 1;
}

HidePlayerLogo(playerid)
{
    TextDrawHideForPlayer(playerid, textLogoBG);
    TextDrawHideForPlayer(playerid, textLogo1);
    TextDrawHideForPlayer(playerid, textLogo2);
    TextDrawHideForPlayer(playerid, textLogo3);
    TextDrawHideForPlayer(playerid, textLogoWebsite);
    TextDrawHideForPlayer(playerid, textLogoBorder1);
    TextDrawHideForPlayer(playerid, textLogoBorder2);
}

hook OnGameModeInit()
{
    textLogoBG = TextDrawCreate(541.000610, 386.607513, "_");
	TextDrawLetterSize(textLogoBG, 0.619000, 4.914369);
	TextDrawTextSize(textLogoBG, 613.667053, 22.399997);
	TextDrawAlignment(textLogoBG, 1);
	TextDrawColor(textLogoBG, -1);
	TextDrawUseBox(textLogoBG, true);
	TextDrawBoxColor(textLogoBG, 53);
	TextDrawSetShadow(textLogoBG, 0);
	TextDrawSetOutline(textLogoBG, 2);
	TextDrawBackgroundColor(textLogoBG, -216);
	TextDrawFont(textLogoBG, 0);
	TextDrawSetProportional(textLogoBG, 1);

	textLogo1 = TextDrawCreate(568.666381, 409.007415, "C I T Y");
	TextDrawLetterSize(textLogo1, 0.171666, 0.882370);
	TextDrawAlignment(textLogo1, 1);
	TextDrawColor(textLogo1, 16777215);
	TextDrawSetShadow(textLogo1, 0);
	TextDrawSetOutline(textLogo1, 1);
	TextDrawBackgroundColor(textLogo1, 51);
	TextDrawFont(textLogo1, 2);
	TextDrawSetProportional(textLogo1, 1);

	textLogo2 = TextDrawCreate(598.000122, 389.096466, "RPG");
	TextDrawLetterSize(textLogo2, 0.181666, 0.562962);
	TextDrawAlignment(textLogo2, 1);
	TextDrawColor(textLogo2, -5963521);
	TextDrawSetShadow(textLogo2, 0);
	TextDrawSetOutline(textLogo2, 1);
	TextDrawBackgroundColor(textLogo2, 51);
	TextDrawFont(textLogo2, 1);
	TextDrawSetProportional(textLogo2, 1);

	textLogo3 = TextDrawCreate(541.000610, 386.777862, "Paradise");
	TextDrawLetterSize(textLogo3, 0.626666, 2.471111);
	TextDrawAlignment(textLogo3, 1);
	TextDrawColor(textLogo3, -1);
	TextDrawSetShadow(textLogo3, 0);
	TextDrawSetOutline(textLogo3, 2);
	TextDrawBackgroundColor(textLogo3, 51);
	TextDrawFont(textLogo3, 0);
	TextDrawSetProportional(textLogo3, 1);

	textLogoWebsite = TextDrawCreate(552.333496, 422.281555, "www.pc-rpg.com.br");
	TextDrawLetterSize(textLogoWebsite, 0.142333, 0.708148);
	TextDrawAlignment(textLogoWebsite, 1);
	TextDrawColor(textLogoWebsite, -1);
	TextDrawSetShadow(textLogoWebsite, 0);
	TextDrawSetOutline(textLogoWebsite, 1);
	TextDrawBackgroundColor(textLogoWebsite, 51);
	TextDrawFont(textLogoWebsite, 1);
	TextDrawSetProportional(textLogoWebsite, 1);

	textLogoBorder1 = TextDrawCreate(535.999877, 387.437011, "-");
	TextDrawLetterSize(textLogoBorder1, 6.698994, -0.478222);
	TextDrawAlignment(textLogoBorder1, 1);
	TextDrawColor(textLogoBorder1, -169);
	TextDrawSetShadow(textLogoBorder1, 0);
	TextDrawSetOutline(textLogoBorder1, 0);
	TextDrawBackgroundColor(textLogoBorder1, 51);
	TextDrawFont(textLogoBorder1, 0);
	TextDrawSetProportional(textLogoBorder1, 1);

	textLogoBorder2 = TextDrawCreate(536.333312, 434.481445, "-");
	TextDrawLetterSize(textLogoBorder2, 6.698327, -0.453333);
	TextDrawAlignment(textLogoBorder2, 1);
	TextDrawColor(textLogoBorder2, -169);
	TextDrawSetShadow(textLogoBorder2, 0);
	TextDrawSetOutline(textLogoBorder2, 0);
	TextDrawBackgroundColor(textLogoBorder2, 51);
	TextDrawFont(textLogoBorder2, 0);
	TextDrawSetProportional(textLogoBorder2, 1);
    return 1;
}
