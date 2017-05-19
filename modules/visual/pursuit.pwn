/* *************************************************************************** *
*  Description: pursuit visual module file.
*
*  Assignment: A script to handle front-end of the pursuit module.
*
*           Copyright Paradise Devs 2015.  All rights reserved.
* *************************************************************************** */

#if defined _MODULE_vspursuit
	#endinput
#endif
#define _MODULE_vspursuit

#include <YSI\y_hooks>

new PlayerText:PursuitText[20][MAX_PLAYERS];

stock ShowPlayerPursuitHUD(playerid)
{
	if(!GetPVarInt(playerid, "isPHudVisible"))
	{
		SetPVarInt(playerid, "isPHudVisible", 1);

		PursuitText[0][playerid] = CreatePlayerTextDraw(playerid, 69.333328, 117.807418, ConvertToGameText("EM PERSEGUIÇÃO!"));
		PlayerTextDrawLetterSize(playerid, PursuitText[0][playerid], 0.176666, 1.127111);
		PlayerTextDrawAlignment(playerid, PursuitText[0][playerid], 1);
		PlayerTextDrawColor(playerid, PursuitText[0][playerid], -33537);
		PlayerTextDrawSetShadow(playerid, PursuitText[0][playerid], 0);
		PlayerTextDrawSetOutline(playerid, PursuitText[0][playerid], 1);
		PlayerTextDrawBackgroundColor(playerid, PursuitText[0][playerid], 51);
		PlayerTextDrawFont(playerid, PursuitText[0][playerid], 2);
		PlayerTextDrawSetProportional(playerid, PursuitText[0][playerid], 1);

		PursuitText[1][playerid] = CreatePlayerTextDraw(playerid, 14.666669, 117.392593, "_");
		PlayerTextDrawLetterSize(playerid, PursuitText[1][playerid], 1.389666, 8.187259);
		PlayerTextDrawTextSize(playerid, PursuitText[1][playerid], 185.666625, -0.414815);
		PlayerTextDrawAlignment(playerid, PursuitText[1][playerid], 1);
		PlayerTextDrawColor(playerid, PursuitText[1][playerid], -1);
		PlayerTextDrawUseBox(playerid, PursuitText[1][playerid], true);
		PlayerTextDrawBoxColor(playerid, PursuitText[1][playerid], 35);
		PlayerTextDrawSetShadow(playerid, PursuitText[1][playerid], 0);
		PlayerTextDrawSetOutline(playerid, PursuitText[1][playerid], 1);
		PlayerTextDrawBackgroundColor(playerid, PursuitText[1][playerid], 255);
		PlayerTextDrawFont(playerid, PursuitText[1][playerid], 1);

		PursuitText[3][playerid] = CreatePlayerTextDraw(playerid, 4.666694, 115.318450, "-");
		PlayerTextDrawLetterSize(playerid, PursuitText[3][playerid], 13.185685, 0.073481);
		PlayerTextDrawAlignment(playerid, PursuitText[3][playerid], 1);
		PlayerTextDrawColor(playerid, PursuitText[3][playerid], -1);
		PlayerTextDrawSetShadow(playerid, PursuitText[3][playerid], -1);
		PlayerTextDrawSetOutline(playerid, PursuitText[3][playerid], 0);
		PlayerTextDrawBackgroundColor(playerid, PursuitText[3][playerid], 51);
		PlayerTextDrawFont(playerid, PursuitText[3][playerid], 1);
		PlayerTextDrawSetProportional(playerid, PursuitText[3][playerid], 1);

		PursuitText[4][playerid] = CreatePlayerTextDraw(playerid, 6.666694, 130.007354, "-");
		PlayerTextDrawLetterSize(playerid, PursuitText[4][playerid], 13.185685, 0.119111);
		PlayerTextDrawAlignment(playerid, PursuitText[4][playerid], 1);
		PlayerTextDrawColor(playerid, PursuitText[4][playerid], -1);
		PlayerTextDrawSetShadow(playerid, PursuitText[4][playerid], -1);
		PlayerTextDrawSetOutline(playerid, PursuitText[4][playerid], 0);
		PlayerTextDrawBackgroundColor(playerid, PursuitText[4][playerid], 51);
		PlayerTextDrawFont(playerid, PursuitText[4][playerid], 1);
		PlayerTextDrawSetProportional(playerid, PursuitText[4][playerid], 1);

		PursuitText[5][playerid] = CreatePlayerTextDraw(playerid, 15.666669, 118.392593, "_");
		PlayerTextDrawLetterSize(playerid, PursuitText[5][playerid], 1.336333, 1.156148);
		PlayerTextDrawTextSize(playerid, PursuitText[5][playerid], 184.666580, -2.488889);
		PlayerTextDrawAlignment(playerid, PursuitText[5][playerid], 1);
		PlayerTextDrawColor(playerid, PursuitText[5][playerid], -1);
		PlayerTextDrawUseBox(playerid, PursuitText[5][playerid], true);
		PlayerTextDrawBoxColor(playerid, PursuitText[5][playerid], 35);
		PlayerTextDrawSetShadow(playerid, PursuitText[5][playerid], 0);
		PlayerTextDrawSetOutline(playerid, PursuitText[5][playerid], 1);
		PlayerTextDrawBackgroundColor(playerid, PursuitText[5][playerid], 255);
		PlayerTextDrawFont(playerid, PursuitText[5][playerid], 1);

		PursuitText[6][playerid] = CreatePlayerTextDraw(playerid, 15.666666, 164.192657, "_");
		PlayerTextDrawLetterSize(playerid, PursuitText[6][playerid], 1.343332, 2.832000);
		PlayerTextDrawTextSize(playerid, PursuitText[6][playerid], 184.666610, -3.318518);
		PlayerTextDrawAlignment(playerid, PursuitText[6][playerid], 1);
		PlayerTextDrawColor(playerid, PursuitText[6][playerid], -1);
		PlayerTextDrawUseBox(playerid, PursuitText[6][playerid], true);
		PlayerTextDrawBoxColor(playerid, PursuitText[6][playerid], 35);
		PlayerTextDrawSetShadow(playerid, PursuitText[6][playerid], 0);
		PlayerTextDrawSetOutline(playerid, PursuitText[6][playerid], 1);
		PlayerTextDrawBackgroundColor(playerid, PursuitText[6][playerid], 255);
		PlayerTextDrawFont(playerid, PursuitText[6][playerid], 2);

		PursuitText[8][playerid] = CreatePlayerTextDraw(playerid, 6.000027, 161.703704, "-");
		PlayerTextDrawLetterSize(playerid, PursuitText[8][playerid], 13.185351, 0.081778);
		PlayerTextDrawAlignment(playerid, PursuitText[8][playerid], 1);
		PlayerTextDrawColor(playerid, PursuitText[8][playerid], -1);
		PlayerTextDrawSetShadow(playerid, PursuitText[8][playerid], -1);
		PlayerTextDrawSetOutline(playerid, PursuitText[8][playerid], 0);
		PlayerTextDrawBackgroundColor(playerid, PursuitText[8][playerid], 51);
		PlayerTextDrawFont(playerid, PursuitText[8][playerid], 1);
		PlayerTextDrawSetProportional(playerid, PursuitText[8][playerid], 1);

		PursuitText[9][playerid] = CreatePlayerTextDraw(playerid, 5.666694, 191.740783, "-");
		PlayerTextDrawLetterSize(playerid, PursuitText[9][playerid], 13.185351, 0.056889);
		PlayerTextDrawAlignment(playerid, PursuitText[9][playerid], 1);
		PlayerTextDrawColor(playerid, PursuitText[9][playerid], -1);
		PlayerTextDrawSetShadow(playerid, PursuitText[9][playerid], -1);
		PlayerTextDrawSetOutline(playerid, PursuitText[9][playerid], 0);
		PlayerTextDrawBackgroundColor(playerid, PursuitText[9][playerid], 51);
		PlayerTextDrawFont(playerid, PursuitText[9][playerid], 1);
		PlayerTextDrawSetProportional(playerid, PursuitText[9][playerid], 1);

		PursuitText[14][playerid] = CreatePlayerTextDraw(playerid, 103.666641, 175.466674, "_");
		PlayerTextDrawLetterSize(playerid, PursuitText[14][playerid], 0.487333, 1.114666);
		PlayerTextDrawTextSize(playerid, PursuitText[14][playerid], 15.000001, -31.525924);
		PlayerTextDrawAlignment(playerid, PursuitText[14][playerid], 1);
		PlayerTextDrawColor(playerid, PursuitText[14][playerid], -1);
		PlayerTextDrawUseBox(playerid, PursuitText[14][playerid], true);
		PlayerTextDrawBoxColor(playerid, PursuitText[14][playerid], -1275068370);
		PlayerTextDrawSetShadow(playerid, PursuitText[14][playerid], 0);
		PlayerTextDrawSetOutline(playerid, PursuitText[14][playerid], 0);
		PlayerTextDrawBackgroundColor(playerid, PursuitText[14][playerid], 51);
		PlayerTextDrawFont(playerid, PursuitText[14][playerid], 1);
		PlayerTextDrawSetProportional(playerid, PursuitText[14][playerid], 1);

		PursuitText[15][playerid] = CreatePlayerTextDraw(playerid, 185.333297, 175.222198, "_");
		PlayerTextDrawLetterSize(playerid, PursuitText[15][playerid], 0.470666, 1.135407);
		PlayerTextDrawTextSize(playerid, PursuitText[15][playerid], 101.333343, -41.066658);
		PlayerTextDrawAlignment(playerid, PursuitText[15][playerid], 1);
		PlayerTextDrawColor(playerid, PursuitText[15][playerid], -1);
		PlayerTextDrawUseBox(playerid, PursuitText[15][playerid], true);
		PlayerTextDrawBoxColor(playerid, PursuitText[15][playerid], 16384046);
		PlayerTextDrawSetShadow(playerid, PursuitText[15][playerid], 0);
		PlayerTextDrawSetOutline(playerid, PursuitText[15][playerid], 1);
		PlayerTextDrawBackgroundColor(playerid, PursuitText[15][playerid], 51);
		PlayerTextDrawFont(playerid, PursuitText[15][playerid], 1);
		PlayerTextDrawSetProportional(playerid, PursuitText[15][playerid], 1);

		PursuitText[18][playerid] = CreatePlayerTextDraw(playerid, 103.999893, 176.222198, "_");
		PlayerTextDrawLetterSize(playerid, PursuitText[18][playerid], 0.438999, 0.961185);
		PlayerTextDrawTextSize(playerid, PursuitText[18][playerid], 101.333358, -42.311103);
		PlayerTextDrawAlignment(playerid, PursuitText[18][playerid], 1);
		PlayerTextDrawColor(playerid, PursuitText[18][playerid], -1);
		PlayerTextDrawUseBox(playerid, PursuitText[18][playerid], true);
		PlayerTextDrawBoxColor(playerid, PursuitText[18][playerid], 16384255);
		PlayerTextDrawSetShadow(playerid, PursuitText[18][playerid], -51);
		PlayerTextDrawSetOutline(playerid, PursuitText[18][playerid], 0);
		PlayerTextDrawBackgroundColor(playerid, PursuitText[18][playerid], 51);
		PlayerTextDrawFont(playerid, PursuitText[18][playerid], 1);
		PlayerTextDrawSetProportional(playerid, PursuitText[18][playerid], 1);

		PursuitText[19][playerid] = CreatePlayerTextDraw(playerid, 103.999969, 176.051864, "_");
		PlayerTextDrawLetterSize(playerid, PursuitText[19][playerid], 0.514666, 0.961184);
		PlayerTextDrawTextSize(playerid, PursuitText[19][playerid], 101.333274, -26.962961);
		PlayerTextDrawAlignment(playerid, PursuitText[19][playerid], 1);
		PlayerTextDrawColor(playerid, PursuitText[19][playerid], -1);
		PlayerTextDrawUseBox(playerid, PursuitText[19][playerid], true);
		PlayerTextDrawBoxColor(playerid, PursuitText[19][playerid], -1275068161);
		PlayerTextDrawSetShadow(playerid, PursuitText[19][playerid], 0);
		PlayerTextDrawSetOutline(playerid, PursuitText[19][playerid], 0);
		PlayerTextDrawBackgroundColor(playerid, PursuitText[19][playerid], 51);
		PlayerTextDrawFont(playerid, PursuitText[19][playerid], 1);
		PlayerTextDrawSetProportional(playerid, PursuitText[19][playerid], 1);

		PursuitText[2][playerid] = CreatePlayerTextDraw(playerid, 16.333345, 133.570404, ConvertToGameText("Tempo de perseguição:"));
		PlayerTextDrawLetterSize(playerid, PursuitText[2][playerid], 0.181666, 0.907258);
		PlayerTextDrawAlignment(playerid, PursuitText[2][playerid], 1);
		PlayerTextDrawColor(playerid, PursuitText[2][playerid], -1);
		PlayerTextDrawSetShadow(playerid, PursuitText[2][playerid], 0);
		PlayerTextDrawSetOutline(playerid, PursuitText[2][playerid], 1);
		PlayerTextDrawBackgroundColor(playerid, PursuitText[2][playerid], 51);
		PlayerTextDrawFont(playerid, PursuitText[2][playerid], 3);
		PlayerTextDrawSetProportional(playerid, PursuitText[2][playerid], 1);

		PursuitText[7][playerid] = CreatePlayerTextDraw(playerid, 16.666732, 163.533447, "PRESO");
		PlayerTextDrawLetterSize(playerid, PursuitText[7][playerid], 0.158333, 0.977777);
		PlayerTextDrawAlignment(playerid, PursuitText[7][playerid], 1);
		PlayerTextDrawColor(playerid, PursuitText[7][playerid], -2139062017);
		PlayerTextDrawSetShadow(playerid, PursuitText[7][playerid], 0);
		PlayerTextDrawSetOutline(playerid, PursuitText[7][playerid], 1);
		PlayerTextDrawBackgroundColor(playerid, PursuitText[7][playerid], 51);
		PlayerTextDrawFont(playerid, PursuitText[7][playerid], 2);
		PlayerTextDrawSetProportional(playerid, PursuitText[7][playerid], 1);

		PursuitText[10][playerid] = CreatePlayerTextDraw(playerid, 165.000106, 162.874176, "FUGA");
		PlayerTextDrawLetterSize(playerid, PursuitText[10][playerid], 0.158333, 0.977777);
		PlayerTextDrawAlignment(playerid, PursuitText[10][playerid], 1);
		PlayerTextDrawColor(playerid, PursuitText[10][playerid], -2139062017);
		PlayerTextDrawSetShadow(playerid, PursuitText[10][playerid], 0);
		PlayerTextDrawSetOutline(playerid, PursuitText[10][playerid], 1);
		PlayerTextDrawBackgroundColor(playerid, PursuitText[10][playerid], 51);
		PlayerTextDrawFont(playerid, PursuitText[10][playerid], 2);
		PlayerTextDrawSetProportional(playerid, PursuitText[10][playerid], 1);

		PursuitText[11][playerid] = CreatePlayerTextDraw(playerid, 16.333343, 147.014801, "Crimes Cometidos:");
		PlayerTextDrawLetterSize(playerid, PursuitText[11][playerid], 0.181666, 0.907258);
		PlayerTextDrawAlignment(playerid, PursuitText[11][playerid], 1);
		PlayerTextDrawColor(playerid, PursuitText[11][playerid], -1);
		PlayerTextDrawSetShadow(playerid, PursuitText[11][playerid], 0);
		PlayerTextDrawSetOutline(playerid, PursuitText[11][playerid], 1);
		PlayerTextDrawBackgroundColor(playerid, PursuitText[11][playerid], 51);
		PlayerTextDrawFont(playerid, PursuitText[11][playerid], 3);
		PlayerTextDrawSetProportional(playerid, PursuitText[11][playerid], 1);

		PursuitText[12][playerid] = CreatePlayerTextDraw(playerid, 186.333328, 78.399986, "I");
		PlayerTextDrawLetterSize(playerid, PursuitText[12][playerid], 0.053333, 14.762070);
		PlayerTextDrawAlignment(playerid, PursuitText[12][playerid], 1);
		PlayerTextDrawColor(playerid, PursuitText[12][playerid], -1);
		PlayerTextDrawSetShadow(playerid, PursuitText[12][playerid], 0);
		PlayerTextDrawSetOutline(playerid, PursuitText[12][playerid], 0);
		PlayerTextDrawBackgroundColor(playerid, PursuitText[12][playerid], 51);
		PlayerTextDrawFont(playerid, PursuitText[12][playerid], 2);
		PlayerTextDrawSetProportional(playerid, PursuitText[12][playerid], 1);

		PursuitText[13][playerid] = CreatePlayerTextDraw(playerid, 12.999995, 78.570381, "I");
		PlayerTextDrawLetterSize(playerid, PursuitText[13][playerid], 0.053333, 14.762070);
		PlayerTextDrawAlignment(playerid, PursuitText[13][playerid], 1);
		PlayerTextDrawColor(playerid, PursuitText[13][playerid], -1);
		PlayerTextDrawSetShadow(playerid, PursuitText[13][playerid], 0);
		PlayerTextDrawSetOutline(playerid, PursuitText[13][playerid], 0);
		PlayerTextDrawBackgroundColor(playerid, PursuitText[13][playerid], 51);
		PlayerTextDrawFont(playerid, PursuitText[13][playerid], 2);
		PlayerTextDrawSetProportional(playerid, PursuitText[13][playerid], 1);

		PursuitText[16][playerid] = CreatePlayerTextDraw(playerid, 184.000106, 133.570358, "-");
		PlayerTextDrawLetterSize(playerid, PursuitText[16][playerid], 0.257333, 0.965333);
		PlayerTextDrawAlignment(playerid, PursuitText[16][playerid], 3);
		PlayerTextDrawColor(playerid, PursuitText[16][playerid], -16776961);
		PlayerTextDrawSetShadow(playerid, PursuitText[16][playerid], 0);
		PlayerTextDrawSetOutline(playerid, PursuitText[16][playerid], 1);
		PlayerTextDrawBackgroundColor(playerid, PursuitText[16][playerid], 51);
		PlayerTextDrawFont(playerid, PursuitText[16][playerid], 3);
		PlayerTextDrawSetProportional(playerid, PursuitText[16][playerid], 1);

		PursuitText[17][playerid] = CreatePlayerTextDraw(playerid, 183.000198, 145.770385, "-");
		PlayerTextDrawLetterSize(playerid, PursuitText[17][playerid], 0.257333, 0.965333);
		PlayerTextDrawAlignment(playerid, PursuitText[17][playerid], 3);
		PlayerTextDrawColor(playerid, PursuitText[17][playerid], -16776961);
		PlayerTextDrawSetShadow(playerid, PursuitText[17][playerid], 0);
		PlayerTextDrawSetOutline(playerid, PursuitText[17][playerid], 1);
		PlayerTextDrawBackgroundColor(playerid, PursuitText[17][playerid], 51);
		PlayerTextDrawFont(playerid, PursuitText[17][playerid], 3);
		PlayerTextDrawSetProportional(playerid, PursuitText[17][playerid], 1);

		for (new i = 0; i < sizeof(PursuitText); i++)
			PlayerTextDrawShow(playerid, PursuitText[i][playerid]);
	}
	return 1;
}

stock HidePlayerPursuitHUD(playerid)
{
	if(GetPVarInt(playerid, "isPHudVisible"))
	{
		for (new i = 0; i < sizeof(PursuitText); i++)
			PlayerTextDrawDestroy(playerid, PursuitText[i][playerid]);

		DeletePVar(playerid, "isPHudVisible");
	}
	return 1;
}

stock SetPlayerPursuitTimeHUD(playerid, string[])
{
	if(!GetPVarInt(playerid, "isPHudVisible"))
		return 0;

	PlayerTextDrawSetString(playerid, PursuitText[16][playerid], string);
	return 1;
}

stock SetPlayerPursuitBar(playerid, Float:value)
{
	if(!GetPVarInt(playerid, "isPHudVisible"))
		return 0;

	PlayerTextDrawHide(playerid, PursuitText[18][playerid]);
	PlayerTextDrawHide(playerid, PursuitText[19][playerid]);

	if(value == 50)
	{
		PlayerTextDrawTextSize(playerid, PursuitText[18][playerid], 101.333358, -42.311103);
		PlayerTextDrawTextSize(playerid, PursuitText[19][playerid], 101.333274, -26.962961);

		PlayerTextDrawShow(playerid, PursuitText[18][playerid]);
		PlayerTextDrawShow(playerid, PursuitText[19][playerid]);
		return 1;
	}
	else if(value <= 0)
	{
		PlayerTextDrawTextSize(playerid, PursuitText[18][playerid], 101.333358, -42.311103);
		PlayerTextDrawTextSize(playerid, PursuitText[19][playerid], 16.3332970, -27.792591);
		PlayerTextDrawShow(playerid, PursuitText[18][playerid]);
		PlayerTextDrawShow(playerid, PursuitText[19][playerid]);
		return 1;
	}
	else if(value >= 100)
	{
		PlayerTextDrawTextSize(playerid, PursuitText[18][playerid], 181.666671, -40.651844);
		PlayerTextDrawTextSize(playerid, PursuitText[19][playerid], 101.333274, -26.962961);
		PlayerTextDrawShow(playerid, PursuitText[18][playerid]);
		PlayerTextDrawShow(playerid, PursuitText[19][playerid]);
		return 1;
	}

	// 18: Green Bar
	// 19: Red Bar

	if(value > 50)
	{
		value = floatsub(value, 50.0);
		value = floatmul(value, 1.6);
		value = floatadd(value, 101.666671);
		PlayerTextDrawTextSize(playerid, PursuitText[18][playerid], value, -40.651844);
		PlayerTextDrawTextSize(playerid, PursuitText[19][playerid], 101.333274, -26.962961);
	}
	else if(value < 50)
	{
		value = floatmul(value, 1.7);
		value = floatadd(value, 16.3332970);
		PlayerTextDrawTextSize(playerid, PursuitText[18][playerid], 101.333358, -42.311103);
		PlayerTextDrawTextSize(playerid, PursuitText[19][playerid], value, -27.792591);
	}
	PlayerTextDrawShow(playerid, PursuitText[18][playerid]);
	PlayerTextDrawShow(playerid, PursuitText[19][playerid]);
	return 1;
}