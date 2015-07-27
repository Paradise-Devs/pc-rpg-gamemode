/*******************************************************************************
* FILENAME :        modules/visual/speedo.pwn
*
* DESCRIPTION :
*       Create/Destroy and Show speedo GUI functions.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

static bool:gpIsSpeedoVisible[MAX_PLAYERS];
static PlayerText:Speedo[MAX_PLAYERS][32];

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
    gpIsSpeedoVisible[playerid] = false;
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
        ShowPlayerSpeedo(playerid, GetPlayerVehicleID(playerid));
    else if(oldstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_PASSENGER)
        HidePlayerSpeedo(playerid);
    return 1;
}

//------------------------------------------------------------------------------

stock ShowPlayerSpeedo(playerid, vehicleid)
{
	if(!gpIsSpeedoVisible[playerid])
	{
		new Float:health;
		GetVehicleHealth(vehicleid, health);

		for(new i = 0; i < sizeof(Speedo[]); i++)
			Speedo[playerid][i] = PlayerText:INVALID_TEXT_DRAW;

		Speedo[playerid][0] = CreatePlayerTextDraw(playerid, 612.766174, 341.081695, "box");
		PlayerTextDrawLetterSize(playerid, Speedo[playerid][0], 0.000000, 9.000012);
		PlayerTextDrawTextSize(playerid, Speedo[playerid][0], 496.231231, 0.000000);
		PlayerTextDrawAlignment(playerid, Speedo[playerid][0], 1);
		PlayerTextDrawColor(playerid, Speedo[playerid][0], -1);
		PlayerTextDrawUseBox(playerid, Speedo[playerid][0], 1);
		PlayerTextDrawBoxColor(playerid, Speedo[playerid][0], 40);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][0], 0);
		PlayerTextDrawSetOutline(playerid, Speedo[playerid][0], 0);
		PlayerTextDrawBackgroundColor(playerid, Speedo[playerid][0], 255);
		PlayerTextDrawFont(playerid, Speedo[playerid][0], 1);
		PlayerTextDrawSetProportional(playerid, Speedo[playerid][0], 1);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][0], 0);

		Speedo[playerid][1] = CreatePlayerTextDraw(playerid, 499.733489, 342.396545, "box");
		PlayerTextDrawLetterSize(playerid, Speedo[playerid][1], 0.000000, 7.531681);
		PlayerTextDrawTextSize(playerid, Speedo[playerid][1], 553.103515, 0.000000);
		PlayerTextDrawAlignment(playerid, Speedo[playerid][1], 1);
		PlayerTextDrawColor(playerid, Speedo[playerid][1], -1);
		PlayerTextDrawUseBox(playerid, Speedo[playerid][1], 1);
		PlayerTextDrawBoxColor(playerid, Speedo[playerid][1], 40);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][1], 0);
		PlayerTextDrawSetOutline(playerid, Speedo[playerid][1], 0);
		PlayerTextDrawBackgroundColor(playerid, Speedo[playerid][1], 255);
		PlayerTextDrawFont(playerid, Speedo[playerid][1], 1);
		PlayerTextDrawSetProportional(playerid, Speedo[playerid][1], 1);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][1], 0);

		Speedo[playerid][2] = CreatePlayerTextDraw(playerid, 554.733154, 328.326416, "");
		PlayerTextDrawLetterSize(playerid, Speedo[playerid][2], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, Speedo[playerid][2], 57.000007, 85.851829);
		PlayerTextDrawAlignment(playerid, Speedo[playerid][2], 1);
		PlayerTextDrawColor(playerid, Speedo[playerid][2], -1);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][2], 0);
		PlayerTextDrawSetOutline(playerid, Speedo[playerid][2], 0);
		PlayerTextDrawBackgroundColor(playerid, Speedo[playerid][2], 0);
		PlayerTextDrawFont(playerid, Speedo[playerid][2], 5);
		PlayerTextDrawSetProportional(playerid, Speedo[playerid][2], 0);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][2], 0);
		PlayerTextDrawSetPreviewModel(playerid, Speedo[playerid][2], GetVehicleModel(vehicleid));
		PlayerTextDrawSetPreviewRot(playerid, Speedo[playerid][2], 0.000000, 0.000000, 90.000000, 1.000000);
		new color1, color2;
		GetVehicleColor(vehicleid, color1, color2);
		PlayerTextDrawSetPreviewVehCol(playerid, Speedo[playerid][2], color1, color2);

		Speedo[playerid][3] = CreatePlayerTextDraw(playerid, 582.200012, 387.125854, GetVehicleName(vehicleid));
		PlayerTextDrawLetterSize(playerid, Speedo[playerid][3], 0.102666, 0.919703);
		PlayerTextDrawAlignment(playerid, Speedo[playerid][3], 2);
		PlayerTextDrawColor(playerid, Speedo[playerid][3], -1);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][3], 0);
		PlayerTextDrawSetOutline(playerid, Speedo[playerid][3], 0);
		PlayerTextDrawBackgroundColor(playerid, Speedo[playerid][3], 255);
		PlayerTextDrawFont(playerid, Speedo[playerid][3], 2);
		PlayerTextDrawSetProportional(playerid, Speedo[playerid][3], 1);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][3], 0);

		Speedo[playerid][4] = CreatePlayerTextDraw(playerid, 556.066284, 342.696533, "box");
		PlayerTextDrawLetterSize(playerid, Speedo[playerid][4], 0.000000, 7.503683);
		PlayerTextDrawTextSize(playerid, Speedo[playerid][4], 609.102966, 0.000000);
		PlayerTextDrawAlignment(playerid, Speedo[playerid][4], 1);
		PlayerTextDrawColor(playerid, Speedo[playerid][4], -1);
		PlayerTextDrawUseBox(playerid, Speedo[playerid][4], 1);
		PlayerTextDrawBoxColor(playerid, Speedo[playerid][4], 40);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][4], 0);
		PlayerTextDrawSetOutline(playerid, Speedo[playerid][4], 0);
		PlayerTextDrawBackgroundColor(playerid, Speedo[playerid][4], 255);
		PlayerTextDrawFont(playerid, Speedo[playerid][4], 1);
		PlayerTextDrawSetProportional(playerid, Speedo[playerid][4], 1);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][4], 0);

		Speedo[playerid][6] = CreatePlayerTextDraw(playerid, 556.699768, 400.900054, "box");
		PlayerTextDrawLetterSize(playerid, Speedo[playerid][6], 0.000000, 0.916666);
		PlayerTextDrawTextSize(playerid, Speedo[playerid][6], 608.431152, 0.000000);
		PlayerTextDrawAlignment(playerid, Speedo[playerid][6], 1);
		PlayerTextDrawColor(playerid, Speedo[playerid][6], -1);
		PlayerTextDrawUseBox(playerid, Speedo[playerid][6], 1);
		PlayerTextDrawBoxColor(playerid, Speedo[playerid][6], 67);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][6], 77);
		PlayerTextDrawSetOutline(playerid, Speedo[playerid][6], 0);
		PlayerTextDrawBackgroundColor(playerid, Speedo[playerid][6], 255);
		PlayerTextDrawFont(playerid, Speedo[playerid][6], 1);
		PlayerTextDrawSetProportional(playerid, Speedo[playerid][6], 1);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][6], 77);

		Speedo[playerid][7] = CreatePlayerTextDraw(playerid, 554.933471, 380.800201, ".");
		PlayerTextDrawLetterSize(playerid, Speedo[playerid][7], 5.012997, 0.355555);
		PlayerTextDrawAlignment(playerid, Speedo[playerid][7], 1);
		PlayerTextDrawColor(playerid, Speedo[playerid][7], 82);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][7], 0);
		PlayerTextDrawSetOutline(playerid, Speedo[playerid][7], 0);
		PlayerTextDrawBackgroundColor(playerid, Speedo[playerid][7], 255);
		PlayerTextDrawFont(playerid, Speedo[playerid][7], 1);
		PlayerTextDrawSetProportional(playerid, Speedo[playerid][7], 1);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][7], 0);

		Speedo[playerid][8] = CreatePlayerTextDraw(playerid, 499.235595, 380.800201, ".");
		PlayerTextDrawLetterSize(playerid, Speedo[playerid][8], 5.012997, 0.355555);
		PlayerTextDrawAlignment(playerid, Speedo[playerid][8], 1);
		PlayerTextDrawColor(playerid, Speedo[playerid][8], 82);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][8], 0);
		PlayerTextDrawSetOutline(playerid, Speedo[playerid][8], 0);
		PlayerTextDrawBackgroundColor(playerid, Speedo[playerid][8], 255);
		PlayerTextDrawFont(playerid, Speedo[playerid][8], 1);
		PlayerTextDrawSetProportional(playerid, Speedo[playerid][8], 1);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][8], 0);

		Speedo[playerid][9] = CreatePlayerTextDraw(playerid, 527.467041, 354.899993, "0");
		PlayerTextDrawLetterSize(playerid, Speedo[playerid][9], 0.488999, 3.205335);
		PlayerTextDrawAlignment(playerid, Speedo[playerid][9], 2);
		PlayerTextDrawColor(playerid, Speedo[playerid][9], -1);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][9], 1);
		PlayerTextDrawSetOutline(playerid, Speedo[playerid][9], 0);
		PlayerTextDrawBackgroundColor(playerid, Speedo[playerid][9], 255);
		PlayerTextDrawFont(playerid, Speedo[playerid][9], 2);
		PlayerTextDrawSetProportional(playerid, Speedo[playerid][9], 1);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][9], 1);

		Speedo[playerid][10] = CreatePlayerTextDraw(playerid, 522.699951, 384.648437, "km/h");
		PlayerTextDrawLetterSize(playerid, Speedo[playerid][10], 0.113333, 0.791111);
		PlayerTextDrawAlignment(playerid, Speedo[playerid][10], 1);
		PlayerTextDrawColor(playerid, Speedo[playerid][10], -2139062017);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][10], 0);
		PlayerTextDrawSetOutline(playerid, Speedo[playerid][10], 0);
		PlayerTextDrawBackgroundColor(playerid, Speedo[playerid][10], 255);
		PlayerTextDrawFont(playerid, Speedo[playerid][10], 1);
		PlayerTextDrawSetProportional(playerid, Speedo[playerid][10], 1);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][10], 0);

		Speedo[playerid][11] = CreatePlayerTextDraw(playerid, 500.609985, 400.900054, "box");
		PlayerTextDrawLetterSize(playerid, Speedo[playerid][11], 0.000000, 0.783333);
		PlayerTextDrawTextSize(playerid, Speedo[playerid][11], 552.432189, 0.000000);
		PlayerTextDrawAlignment(playerid, Speedo[playerid][11], 1);
		PlayerTextDrawColor(playerid, Speedo[playerid][11], -1);
		PlayerTextDrawUseBox(playerid, Speedo[playerid][11], 1);
		PlayerTextDrawBoxColor(playerid, Speedo[playerid][11], 67);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][11], 77);
		PlayerTextDrawSetOutline(playerid, Speedo[playerid][11], 0);
		PlayerTextDrawBackgroundColor(playerid, Speedo[playerid][11], 255);
		PlayerTextDrawFont(playerid, Speedo[playerid][11], 1);
		PlayerTextDrawSetProportional(playerid, Speedo[playerid][11], 1);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][11], 77);

		Speedo[playerid][12] = CreatePlayerTextDraw(playerid, 501.143341, 401.914916, "box");
		PlayerTextDrawLetterSize(playerid, Speedo[playerid][12], 0.000000, 0.674002);
		PlayerTextDrawTextSize(playerid, Speedo[playerid][12], 551.870056, 0.000000);
		PlayerTextDrawAlignment(playerid, Speedo[playerid][12], 1);
		PlayerTextDrawColor(playerid, Speedo[playerid][12], -114);
		PlayerTextDrawUseBox(playerid, Speedo[playerid][12], 1);
		PlayerTextDrawBoxColor(playerid, Speedo[playerid][12], 12386171);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][12], 77);
		PlayerTextDrawSetOutline(playerid, Speedo[playerid][12], 0);
		PlayerTextDrawBackgroundColor(playerid, Speedo[playerid][12], 255);
		PlayerTextDrawFont(playerid, Speedo[playerid][12], 1);
		PlayerTextDrawSetProportional(playerid, Speedo[playerid][12], 1);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][12], 77);

		new Float:fGasPercentage = GetVehicleFuel(vehicleid);
		fGasPercentage *= 0.53;
		fGasPercentage += 498.487945;
		Speedo[playerid][13] = CreatePlayerTextDraw(playerid, 501.143341, 402.000122, "gas");
		PlayerTextDrawLetterSize(playerid, Speedo[playerid][13], 0.000000, 0.673668);
		PlayerTextDrawTextSize(playerid, Speedo[playerid][13], fGasPercentage, 0.749999);// 551 max | 498 min | 1% = 1,88679
		PlayerTextDrawAlignment(playerid, Speedo[playerid][13], 1);
		PlayerTextDrawColor(playerid, Speedo[playerid][13], -1);
		PlayerTextDrawUseBox(playerid, Speedo[playerid][13], 1);
		PlayerTextDrawBoxColor(playerid, Speedo[playerid][13], 11927551);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][13], 77);
		PlayerTextDrawSetOutline(playerid, Speedo[playerid][13], 0);
		PlayerTextDrawBackgroundColor(playerid, Speedo[playerid][13], 255);
		PlayerTextDrawFont(playerid, Speedo[playerid][13], 1);
		PlayerTextDrawSetProportional(playerid, Speedo[playerid][13], 1);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][13], 77);

		Speedo[playerid][14] = CreatePlayerTextDraw(playerid, 557.499572, 402.000122, "box");
		PlayerTextDrawLetterSize(playerid, Speedo[playerid][14], 0.000000, 0.740000);
		PlayerTextDrawTextSize(playerid, Speedo[playerid][14], 607.893310, 0.000000);
		PlayerTextDrawAlignment(playerid, Speedo[playerid][14], 1);
		PlayerTextDrawColor(playerid, Speedo[playerid][14], -1);
		PlayerTextDrawUseBox(playerid, Speedo[playerid][14], 1);
		PlayerTextDrawBoxColor(playerid, Speedo[playerid][14], -5963670);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][14], 77);
		PlayerTextDrawSetOutline(playerid, Speedo[playerid][14], 0);
		PlayerTextDrawBackgroundColor(playerid, Speedo[playerid][14], 12648703);
		PlayerTextDrawFont(playerid, Speedo[playerid][14], 1);
		PlayerTextDrawSetProportional(playerid, Speedo[playerid][14], 1);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][14], 77);

		new Float:fHealthPercentage = floatdiv(health, 10.0);
		fHealthPercentage *= 0.53;
		fHealthPercentage += 554.873291;
		Speedo[playerid][15] = CreatePlayerTextDraw(playerid, 557.499572, 402.000122, "dano");
		PlayerTextDrawLetterSize(playerid, Speedo[playerid][15], 0.000333, 0.704111);
		PlayerTextDrawTextSize(playerid, Speedo[playerid][15], fHealthPercentage, 0.749999);// 607 max | 554 min | 1% = 1,88679
		PlayerTextDrawAlignment(playerid, Speedo[playerid][15], 1);
		PlayerTextDrawColor(playerid, Speedo[playerid][15], -1);
		PlayerTextDrawUseBox(playerid, Speedo[playerid][15], 1);
		PlayerTextDrawBoxColor(playerid, Speedo[playerid][15], -5963616);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][15], 77);
		PlayerTextDrawSetOutline(playerid, Speedo[playerid][15], 0);
		PlayerTextDrawBackgroundColor(playerid, Speedo[playerid][15], 12648703);
		PlayerTextDrawFont(playerid, Speedo[playerid][15], 1);
		PlayerTextDrawSetProportional(playerid, Speedo[playerid][15], 1);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][15], 77);

		Speedo[playerid][16] = CreatePlayerTextDraw(playerid, 556.733032, 399.129577, "");
		PlayerTextDrawLetterSize(playerid, Speedo[playerid][16], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, Speedo[playerid][16], 8.333339, 11.185173);
		PlayerTextDrawAlignment(playerid, Speedo[playerid][16], 1);
		PlayerTextDrawColor(playerid, Speedo[playerid][16], -1);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][16], 0);
		PlayerTextDrawSetOutline(playerid, Speedo[playerid][16], 0);
		PlayerTextDrawBackgroundColor(playerid, Speedo[playerid][16], 0);
		PlayerTextDrawFont(playerid, Speedo[playerid][16], 5);
		PlayerTextDrawSetProportional(playerid, Speedo[playerid][16], 0);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][16], 0);
		PlayerTextDrawSetPreviewModel(playerid, Speedo[playerid][16], 1240);
		PlayerTextDrawSetPreviewRot(playerid, Speedo[playerid][16], 0.000000, 0.000000, 0.000000, 1.000000);

		Speedo[playerid][17] = CreatePlayerTextDraw(playerid, 498.899658, 400.329772, "");
		PlayerTextDrawLetterSize(playerid, Speedo[playerid][17], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, Speedo[playerid][17], 8.999996, 9.525929);
		PlayerTextDrawAlignment(playerid, Speedo[playerid][17], 1);
		PlayerTextDrawColor(playerid, Speedo[playerid][17], -1);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][17], 0);
		PlayerTextDrawSetOutline(playerid, Speedo[playerid][17], 0);
		PlayerTextDrawBackgroundColor(playerid, Speedo[playerid][17], 0);
		PlayerTextDrawFont(playerid, Speedo[playerid][17], 5);
		PlayerTextDrawSetProportional(playerid, Speedo[playerid][17], 0);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][17], 0);
		PlayerTextDrawSetPreviewModel(playerid, Speedo[playerid][17], 1676);
		PlayerTextDrawSetPreviewRot(playerid, Speedo[playerid][17], 0.000000, 0.000000, 0.000000, 1.000000);

		new sGas[9];
		format(sGas, sizeof(sGas), "%.0f%%", GetVehicleFuel(vehicleid));
		Speedo[playerid][18] = CreatePlayerTextDraw(playerid, 528.000000, 401.000000, sGas);
		PlayerTextDrawLetterSize(playerid, Speedo[playerid][18], 0.196333, 0.853333);
		PlayerTextDrawAlignment(playerid, Speedo[playerid][18], 2);
		PlayerTextDrawColor(playerid, Speedo[playerid][18], -1);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][18], 0);
		PlayerTextDrawSetOutline(playerid, Speedo[playerid][18], 0);
		PlayerTextDrawBackgroundColor(playerid, Speedo[playerid][18], 255);
		PlayerTextDrawFont(playerid, Speedo[playerid][18], 3);
		PlayerTextDrawSetProportional(playerid, Speedo[playerid][18], 1);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][18], 0);

		Speedo[playerid][19] = CreatePlayerTextDraw(playerid, 546.786193, 343.444488, "LD_POOL:BALL");
		PlayerTextDrawLetterSize(playerid, Speedo[playerid][19], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, Speedo[playerid][19], 5.333338, 6.622231);
		PlayerTextDrawAlignment(playerid, Speedo[playerid][19], 1);
		PlayerTextDrawColor(playerid, Speedo[playerid][19], -1);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][19], 0);
		PlayerTextDrawSetOutline(playerid, Speedo[playerid][19], 0);
		PlayerTextDrawBackgroundColor(playerid, Speedo[playerid][19], 255);
		PlayerTextDrawFont(playerid, Speedo[playerid][19], 4);
		PlayerTextDrawSetProportional(playerid, Speedo[playerid][19], 0);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][19], 0);

		Speedo[playerid][20] = CreatePlayerTextDraw(playerid, 500.000061, 414.400024, "motor");
		PlayerTextDrawLetterSize(playerid, Speedo[playerid][20], 0.000000, 0.709665);
		PlayerTextDrawTextSize(playerid, Speedo[playerid][20], 525.042175, 0.000000);
		PlayerTextDrawAlignment(playerid, Speedo[playerid][20], 1);
		PlayerTextDrawColor(playerid, Speedo[playerid][20], -1);
		PlayerTextDrawUseBox(playerid, Speedo[playerid][20], 1);
		PlayerTextDrawBoxColor(playerid, Speedo[playerid][20], 8388863);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][20], 0);
		PlayerTextDrawSetOutline(playerid, Speedo[playerid][20], 0);
		PlayerTextDrawBackgroundColor(playerid, Speedo[playerid][20], 255);
		PlayerTextDrawFont(playerid, Speedo[playerid][20], 1);
		PlayerTextDrawSetProportional(playerid, Speedo[playerid][20], 1);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][20], 0);

		Speedo[playerid][21] = CreatePlayerTextDraw(playerid, 528.196838, 414.400024, "janelas");
		PlayerTextDrawLetterSize(playerid, Speedo[playerid][21], 0.000000, 0.739665);
		PlayerTextDrawTextSize(playerid, Speedo[playerid][21], 553.065124, 0.000000);
		PlayerTextDrawAlignment(playerid, Speedo[playerid][21], 1);
		PlayerTextDrawColor(playerid, Speedo[playerid][21], -1);
		PlayerTextDrawUseBox(playerid, Speedo[playerid][21], 1);
		PlayerTextDrawBoxColor(playerid, Speedo[playerid][21], -1523963137);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][21], 0);
		PlayerTextDrawSetOutline(playerid, Speedo[playerid][21], 0);
		PlayerTextDrawBackgroundColor(playerid, Speedo[playerid][21], 255);
		PlayerTextDrawFont(playerid, Speedo[playerid][21], 1);
		PlayerTextDrawSetProportional(playerid, Speedo[playerid][21], 1);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][21], 0);

		Speedo[playerid][22] = CreatePlayerTextDraw(playerid, 556.090026, 414.400024, "farois");
		PlayerTextDrawLetterSize(playerid, Speedo[playerid][22], 0.000000, 0.709665);
		PlayerTextDrawTextSize(playerid, Speedo[playerid][22], 580.958312, 0.000000);
		PlayerTextDrawAlignment(playerid, Speedo[playerid][22], 1);
		PlayerTextDrawColor(playerid, Speedo[playerid][22], -1);
		PlayerTextDrawUseBox(playerid, Speedo[playerid][22], 1);
		PlayerTextDrawBoxColor(playerid, Speedo[playerid][22], 8388863);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][22], 0);
		PlayerTextDrawSetOutline(playerid, Speedo[playerid][22], 0);
		PlayerTextDrawBackgroundColor(playerid, Speedo[playerid][22], 255);
		PlayerTextDrawFont(playerid, Speedo[playerid][22], 1);
		PlayerTextDrawSetProportional(playerid, Speedo[playerid][22], 1);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][22], 0);

		Speedo[playerid][23] = CreatePlayerTextDraw(playerid, 583.983215, 414.400024, "portas");
		PlayerTextDrawLetterSize(playerid, Speedo[playerid][23], 0.000000, 0.711331);
		PlayerTextDrawTextSize(playerid, Speedo[playerid][23], 609.098754, 0.000000);
		PlayerTextDrawAlignment(playerid, Speedo[playerid][23], 1);
		PlayerTextDrawColor(playerid, Speedo[playerid][23], -1);
		PlayerTextDrawUseBox(playerid, Speedo[playerid][23], 1);
		PlayerTextDrawBoxColor(playerid, Speedo[playerid][23], -1523963137);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][23], 0);
		PlayerTextDrawSetOutline(playerid, Speedo[playerid][23], 0);
		PlayerTextDrawBackgroundColor(playerid, Speedo[playerid][23], 255);
		PlayerTextDrawFont(playerid, Speedo[playerid][23], 1);
		PlayerTextDrawSetProportional(playerid, Speedo[playerid][23], 1);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][23], 0);

		Speedo[playerid][24] = CreatePlayerTextDraw(playerid, 611.716735, 414.400024, "fx stats");
		PlayerTextDrawLetterSize(playerid, Speedo[playerid][24], 0.000000, 0.110331);
		PlayerTextDrawTextSize(playerid, Speedo[playerid][24], 497.271514, 0.000000);
		PlayerTextDrawAlignment(playerid, Speedo[playerid][24], 1);
		PlayerTextDrawColor(playerid, Speedo[playerid][24], -1);
		PlayerTextDrawUseBox(playerid, Speedo[playerid][24], 1);
		PlayerTextDrawBoxColor(playerid, Speedo[playerid][24], -226);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][24], 0);
		PlayerTextDrawSetOutline(playerid, Speedo[playerid][24], 0);
		PlayerTextDrawBackgroundColor(playerid, Speedo[playerid][24], 255);
		PlayerTextDrawFont(playerid, Speedo[playerid][24], 1);
		PlayerTextDrawSetProportional(playerid, Speedo[playerid][24], 1);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][24], 0);

		Speedo[playerid][25] = CreatePlayerTextDraw(playerid, 511.867065, 414.400024, "motor");
		PlayerTextDrawLetterSize(playerid, Speedo[playerid][25], 0.117000, 0.637629);
		PlayerTextDrawAlignment(playerid, Speedo[playerid][25], 2);
		PlayerTextDrawColor(playerid, Speedo[playerid][25], -1);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][25], 0);
		PlayerTextDrawSetOutline(playerid, Speedo[playerid][25], 0);
		PlayerTextDrawBackgroundColor(playerid, Speedo[playerid][25], 255);
		PlayerTextDrawFont(playerid, Speedo[playerid][25], 2);
		PlayerTextDrawSetProportional(playerid, Speedo[playerid][25], 1);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][25], 0);

		Speedo[playerid][26] = CreatePlayerTextDraw(playerid, 540.460021, 414.400024, "janelas");
		PlayerTextDrawLetterSize(playerid, Speedo[playerid][26], 0.117000, 0.637629);
		PlayerTextDrawAlignment(playerid, Speedo[playerid][26], 2);
		PlayerTextDrawColor(playerid, Speedo[playerid][26], -1);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][26], 0);
		PlayerTextDrawSetOutline(playerid, Speedo[playerid][26], 0);
		PlayerTextDrawBackgroundColor(playerid, Speedo[playerid][26], 255);
		PlayerTextDrawFont(playerid, Speedo[playerid][26], 2);
		PlayerTextDrawSetProportional(playerid, Speedo[playerid][26], 1);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][26], 0);

		Speedo[playerid][27] = CreatePlayerTextDraw(playerid, 560.021545, 414.400024, "farois");
		PlayerTextDrawLetterSize(playerid, Speedo[playerid][27], 0.117000, 0.637629);
		PlayerTextDrawAlignment(playerid, Speedo[playerid][27], 1);
		PlayerTextDrawColor(playerid, Speedo[playerid][27], -1);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][27], 0);
		PlayerTextDrawSetOutline(playerid, Speedo[playerid][27], 0);
		PlayerTextDrawBackgroundColor(playerid, Speedo[playerid][27], 255);
		PlayerTextDrawFont(playerid, Speedo[playerid][27], 2);
		PlayerTextDrawSetProportional(playerid, Speedo[playerid][27], 1);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][27], 0);

		Speedo[playerid][28] = CreatePlayerTextDraw(playerid, 587.714782, 414.400024, "portas");
		PlayerTextDrawLetterSize(playerid, Speedo[playerid][28], 0.117000, 0.637629);
		PlayerTextDrawAlignment(playerid, Speedo[playerid][28], 1);
		PlayerTextDrawColor(playerid, Speedo[playerid][28], -1);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][28], 0);
		PlayerTextDrawSetOutline(playerid, Speedo[playerid][28], 0);
		PlayerTextDrawBackgroundColor(playerid, Speedo[playerid][28], 255);
		PlayerTextDrawFont(playerid, Speedo[playerid][28], 2);
		PlayerTextDrawSetProportional(playerid, Speedo[playerid][28], 1);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][28], 0);

		Speedo[playerid][29] = CreatePlayerTextDraw(playerid, 548.733215, 406.581542, "LD_POOL:BALL"); // Gas
		PlayerTextDrawLetterSize(playerid, Speedo[playerid][29], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, Speedo[playerid][29], 2.333338, -2.918508);
		PlayerTextDrawAlignment(playerid, Speedo[playerid][29], 1);
		PlayerTextDrawColor(playerid, Speedo[playerid][29], 16711935);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][29], 0);
		PlayerTextDrawSetOutline(playerid, Speedo[playerid][29], 0);
		PlayerTextDrawBackgroundColor(playerid, Speedo[playerid][29], 255);
		PlayerTextDrawFont(playerid, Speedo[playerid][29], 4);
		PlayerTextDrawSetProportional(playerid, Speedo[playerid][29], 0);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][29], 0);

		new sHealth[9];
		format(sHealth, sizeof(sHealth), "%.0f%%", floatdiv(health, 10.0));
		Speedo[playerid][30] = CreatePlayerTextDraw(playerid, 584.000000, 401.000000, sHealth);
		PlayerTextDrawLetterSize(playerid, Speedo[playerid][30], 0.196333, 0.853333);
		PlayerTextDrawAlignment(playerid, Speedo[playerid][30], 2);
		PlayerTextDrawColor(playerid, Speedo[playerid][30], -1);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][30], 0);
		PlayerTextDrawSetOutline(playerid, Speedo[playerid][30], 0);
		PlayerTextDrawBackgroundColor(playerid, Speedo[playerid][30], 255);
		PlayerTextDrawFont(playerid, Speedo[playerid][30], 3);
		PlayerTextDrawSetProportional(playerid, Speedo[playerid][30], 1);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][30], 0);

		Speedo[playerid][31] = CreatePlayerTextDraw(playerid, 604.453002, 406.581542, "LD_POOL:BALL"); // Health
		PlayerTextDrawLetterSize(playerid, Speedo[playerid][31], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, Speedo[playerid][31], 2.333338, -2.918508);
		PlayerTextDrawAlignment(playerid, Speedo[playerid][31], 1);
		PlayerTextDrawColor(playerid, Speedo[playerid][31], 16711935);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][31], 0);
		PlayerTextDrawSetOutline(playerid, Speedo[playerid][31], 0);
		PlayerTextDrawBackgroundColor(playerid, Speedo[playerid][31], 255);
		PlayerTextDrawFont(playerid, Speedo[playerid][31], 4);
		PlayerTextDrawSetProportional(playerid, Speedo[playerid][31], 0);
		PlayerTextDrawSetShadow(playerid, Speedo[playerid][31], 0);

		for(new i = 0; i < sizeof(Speedo[]); i++)
			if(Speedo[playerid][i] != PlayerText:INVALID_TEXT_DRAW)
				PlayerTextDrawShow(playerid, Speedo[playerid][i]);

        gpIsSpeedoVisible[playerid] = true;
	}
}

ptask UpdatePlayerSpeedo[100](playerid)
{
    if(!gpIsSpeedoVisible[playerid])
        return 1;

	new	Float:health, Float:speed = GetPlayerSpeed(playerid), vehicleid = GetPlayerVehicleID(playerid);
	GetVehicleHealth(vehicleid, health);

	new engine, lights, doors, alarm, bonnet, boot, objective;
	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

    new driver, passenger, backleft, backright, window;
    GetVehicleParamsCarWindows(vehicleid, driver, passenger, backleft, backright);
    switch(GetPlayerVehicleSeat(playerid))
    {
        case 0:
            window = driver;
        case 1:
            window = passenger;
        case 2:
            window = backleft;
        default:
            window = backright;
    }

	PlayerTextDrawColor(playerid, Speedo[playerid][19], (speed > 59) ? 0xFF0000FF : 0xFFFFFFFF);
	PlayerTextDrawBoxColor(playerid, Speedo[playerid][20], (engine == VEHICLE_PARAMS_ON) ? 8388863 : -1523963137);
	PlayerTextDrawBoxColor(playerid, Speedo[playerid][21], (!window) ? 8388863 : -1523963137);
	PlayerTextDrawBoxColor(playerid, Speedo[playerid][22], (lights == VEHICLE_PARAMS_ON) ? 8388863 : -1523963137);
	PlayerTextDrawBoxColor(playerid, Speedo[playerid][23], (doors == VEHICLE_PARAMS_ON) ? 8388863 : -1523963137);

	new
		Float:tenH = floatdiv(health - 350.0, 6.5),
    	red = 255,
    	green = 0,
    	blue = 0,
		col
	;

	if(tenH >= 75.0) {
		red -= floatround(2.55 * tenH);
		green = 255;
	}
	else if(tenH > 50.0 && tenH < 75.0) {
    	red -= floatround(2.55 * (tenH - 50));
		green = 255;
	} else {
    	green += floatround(5.1 * tenH);
	}

	if(health > 349.0) col = red << 24 | green << 16 | blue << 8 | 0xFF;
	else col = 255 << 24 | 0 << 16 | 0 << 8 | 0xFF;
	PlayerTextDrawColor(playerid, Speedo[playerid][31], col);

	tenH = GetVehicleFuel(vehicleid);
	red = 255;
	green = 0;
	if(GetVehicleFuel(vehicleid) > 50) {
		red -= floatround(2.55 * (tenH - 50));
		green = 255;
	} else {
    	green += floatround(5.1 * tenH);
	}

	col = red << 24 | green << 16 | blue << 8 | 0xFF;
	PlayerTextDrawColor(playerid, Speedo[playerid][29], col);

	new sHealth[9];
	format(sHealth, sizeof(sHealth), "%.0f%%", floatdiv(health, 10.0));
	PlayerTextDrawSetString(playerid, Speedo[playerid][30],sHealth);

	new sGas[9];
	format(sGas, sizeof(sGas), "%d%%", GetVehicleFuel(vehicleid));
	PlayerTextDrawSetString(playerid, Speedo[playerid][18], sGas);

	new sSpeed[9];
	format(sSpeed, sizeof(sSpeed), "%.0f", speed);
	PlayerTextDrawSetString(playerid, Speedo[playerid][9], sSpeed);

	new Float:fGasPercentage = GetVehicleFuel(vehicleid);
	fGasPercentage *= 0.53;
	fGasPercentage += 498.487945;
	PlayerTextDrawTextSize(playerid, Speedo[playerid][13], fGasPercentage, 0.000000);

	new Float:fHealthPercentage = floatdiv(health, 10.0);
	fHealthPercentage *= 0.53;
	fHealthPercentage += 554.873291;
	PlayerTextDrawTextSize(playerid, Speedo[playerid][15], fHealthPercentage, 0.749999);

	PlayerTextDrawShow(playerid, Speedo[playerid][13]);
	PlayerTextDrawShow(playerid, Speedo[playerid][15]);
	PlayerTextDrawShow(playerid, Speedo[playerid][19]);
	PlayerTextDrawShow(playerid, Speedo[playerid][20]);
	PlayerTextDrawShow(playerid, Speedo[playerid][21]);
	PlayerTextDrawShow(playerid, Speedo[playerid][22]);
	PlayerTextDrawShow(playerid, Speedo[playerid][23]);
	PlayerTextDrawShow(playerid, Speedo[playerid][29]);
	PlayerTextDrawShow(playerid, Speedo[playerid][31]);
    return 1;
}

stock HidePlayerSpeedo(playerid)
{
	if(gpIsSpeedoVisible[playerid])
	{
        gpIsSpeedoVisible[playerid] = false;
		for(new i = 0; i < sizeof(Speedo[]); i++)
			PlayerTextDrawDestroy(playerid, Speedo[playerid][i]);
	}
}
