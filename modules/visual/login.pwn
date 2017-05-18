/* *************************************************************************** *
*  Description: Login visual module file.
*
*  Assignment: A script to handle login textdraws.
*
*           Copyright Paradise Devs 2015.  All rights reserved.
* *************************************************************************** */

#if defined _MODULE_vslogin
	#endinput
#endif
#define _MODULE_vslogin

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

static PlayerText:gptLogin[MAX_PLAYERS][102];
static PlayerText:gptRegister[MAX_PLAYERS][23];
static bool:gptIsVisible[MAX_PLAYERS];
static gpSelectedVehicle[MAX_PLAYERS];
static gpTotalVehicles[MAX_PLAYERS];

VSL_ShowPlayerTextdraw(playerid)
{
    if(gptIsVisible[playerid])
        return 1;

    gptIsVisible[playerid] = true;
    gpSelectedVehicle[playerid] = 0;
    gptLogin[playerid][0] = CreatePlayerTextDraw(playerid, 23.333286, 62.237049, "fundo personagem");
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][0], 0.000000, 38.735752);
    PlayerTextDrawTextSize(playerid, gptLogin[playerid][0], 161.149810, 0.000000);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][0], 1);
    PlayerTextDrawColor(playerid, gptLogin[playerid][0], -1);
    PlayerTextDrawUseBox(playerid, gptLogin[playerid][0], 1);
    PlayerTextDrawBoxColor(playerid, gptLogin[playerid][0], 50);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][0], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][0], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][0], 255);
    PlayerTextDrawFont(playerid, gptLogin[playerid][0], 2);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][0], 0);

    gptLogin[playerid][1] = CreatePlayerTextDraw(playerid, 24.233289, 63.237033, "fundo titulo personagem");
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][1], 0.000000, 0.974998);
    PlayerTextDrawTextSize(playerid, gptLogin[playerid][1], 160.426193, 0.000000);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][1], 1);
    PlayerTextDrawColor(playerid, gptLogin[playerid][1], -1);
    PlayerTextDrawUseBox(playerid, gptLogin[playerid][1], 1);
    PlayerTextDrawBoxColor(playerid, gptLogin[playerid][1], 50);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][1], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][1], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][1], 255);
    PlayerTextDrawFont(playerid, gptLogin[playerid][1], 2);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][1], 0);

    gptLogin[playerid][2] = CreatePlayerTextDraw(playerid, 20.666656, 62.081485, "");
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][2], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, gptLogin[playerid][2], 13.666652, 12.014820);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][2], 1);
    PlayerTextDrawColor(playerid, gptLogin[playerid][2], -1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][2], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][2], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][2], 0);
    PlayerTextDrawFont(playerid, gptLogin[playerid][2], 5);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][2], 0);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][2], 0);
    PlayerTextDrawSetPreviewModel(playerid, gptLogin[playerid][2], 1314);
    PlayerTextDrawSetPreviewRot(playerid, gptLogin[playerid][2], 0.000000, 0.000000, -40.000000, 1.000000);

    gptLogin[playerid][3] = CreatePlayerTextDraw(playerid, 33.333305, 63.481475, "seu personagem");
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][3], 0.154333, 0.874074);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][3], 1);
    PlayerTextDrawColor(playerid, gptLogin[playerid][3], -1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][3], 1);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][3], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][3], 255);
    PlayerTextDrawFont(playerid, gptLogin[playerid][3], 3);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][3], 1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][3], 1);

    gptLogin[playerid][4] = CreatePlayerTextDraw(playerid, 30.366685, 60.981559, "");
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][4], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, gptLogin[playerid][4], 120.333435, 174.207473);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][4], 1);
    PlayerTextDrawColor(playerid, gptLogin[playerid][4], -1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][4], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][4], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][4], 0);
    PlayerTextDrawFont(playerid, gptLogin[playerid][4], 5);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][4], 0);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][4], 0);
    PlayerTextDrawSetPreviewModel(playerid, gptLogin[playerid][4], GetPlayerSavedSkin(playerid));
    PlayerTextDrawSetPreviewRot(playerid, gptLogin[playerid][4], 0.000000, 0.000000, 0.000000, 1.000000);

    gptLogin[playerid][5] = CreatePlayerTextDraw(playerid, 64.699958, 221.414810, ".");
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][5], 5.348665, 0.538074);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][5], 1);
    PlayerTextDrawColor(playerid, gptLogin[playerid][5], 49);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][5], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][5], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][5], 255);
    PlayerTextDrawFont(playerid, gptLogin[playerid][5], 1);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][5], 1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][5], 0);

    gptLogin[playerid][6] = CreatePlayerTextDraw(playerid, 24.000000, 229.000000, "fundo stats char");
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][6], 0.000000, 20.092641);
    PlayerTextDrawTextSize(playerid, gptLogin[playerid][6], 160.616287, 0.000000);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][6], 1);
    PlayerTextDrawColor(playerid, gptLogin[playerid][6], -1);
    PlayerTextDrawUseBox(playerid, gptLogin[playerid][6], 1);
    PlayerTextDrawBoxColor(playerid, gptLogin[playerid][6], 43);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][6], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][6], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][6], 255);
    PlayerTextDrawFont(playerid, gptLogin[playerid][6], 1);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][6], 1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][6], 0);

    new sMemberSince[48];
    format(sMemberSince, sizeof(sMemberSince), "Membro desde~n~%s", convertTimestamp(GetPlayerRegDataUnix(playerid)));
    gptLogin[playerid][7] = CreatePlayerTextDraw(playerid, 324.333526, 33.199985, sMemberSince);
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][7], 0.084666, 0.683259);
    //PlayerTextDrawTextSize(playerid, gptLogin[playerid][7], 650.4933, 5.0000);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][7], 2);
    PlayerTextDrawColor(playerid, gptLogin[playerid][7], -1061109505);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][7], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][7], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][7], 255);
    PlayerTextDrawFont(playerid, gptLogin[playerid][7], 2);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][7], 1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][7], 0);

    new sDbId[10];
    valstr(sDbId, GetPlayerDatabaseID(playerid));
    gptLogin[playerid][8] = CreatePlayerTextDraw(playerid, 159.999908, 63.066677, sDbId);
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][8], 0.238666, 0.903111);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][8], 3);
    PlayerTextDrawColor(playerid, gptLogin[playerid][8], -2139062017);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][8], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][8], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][8], 255);
    PlayerTextDrawFont(playerid, gptLogin[playerid][8], 3);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][8], 1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][8], 0);

    gptLogin[playerid][9] = CreatePlayerTextDraw(playerid, 243.666702, 6.651847, "bordas topo");
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][9], 0.000000, 4.599997);
    PlayerTextDrawTextSize(playerid, gptLogin[playerid][9], 400.666687, 0.000000);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][9], 1);
    PlayerTextDrawColor(playerid, gptLogin[playerid][9], -1);
    PlayerTextDrawUseBox(playerid, gptLogin[playerid][9], 1);
    PlayerTextDrawBoxColor(playerid, gptLogin[playerid][9], 50);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][9], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][9], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][9], 255);
    PlayerTextDrawFont(playerid, gptLogin[playerid][9], 1);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][9], 1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][9], 0);

    gptLogin[playerid][10] = CreatePlayerTextDraw(playerid, 244.666763, 7.451847, "fundo topo");
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][10], 0.000000, 4.405347);
    PlayerTextDrawTextSize(playerid, gptLogin[playerid][10], 399.844970, 0.000000);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][10], 1);
    PlayerTextDrawColor(playerid, gptLogin[playerid][10], -1);
    PlayerTextDrawUseBox(playerid, gptLogin[playerid][10], 1);
    PlayerTextDrawBoxColor(playerid, gptLogin[playerid][10], 50);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][10], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][10], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][10], 255);
    PlayerTextDrawFont(playerid, gptLogin[playerid][10], 1);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][10], 1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][10], 0);

    gptLogin[playerid][11] = CreatePlayerTextDraw(playerid, 324.000091, 8.903692, GetPlayerFirstName(playerid));
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][11], 0.301333, 2.545778);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][11], 2);
    PlayerTextDrawColor(playerid, gptLogin[playerid][11], -1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][11], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][11], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][11], 255);
    PlayerTextDrawFont(playerid, gptLogin[playerid][11], 2);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][11], 1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][11], 0);

    gptLogin[playerid][12] = CreatePlayerTextDraw(playerid, 248.766464, 27.766801, ".");
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][12], 14.299658, 0.592000);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][12], 1);
    PlayerTextDrawColor(playerid, gptLogin[playerid][12], 49);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][12], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][12], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][12], 255);
    PlayerTextDrawFont(playerid, gptLogin[playerid][12], 1);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][12], 1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][12], 0);

    gptLogin[playerid][13] = CreatePlayerTextDraw(playerid, 24.799999, 230.799987, "Conta:~n~~n~Level:~n~~n~XP:~n~~n~Emprego:~n~~n~GPS:~n~~n~Celular:~n~~n~Faccao:~n~~n~Cargo:~n~~n~Porte de Armas:");
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][13], 0.122000, 0.749629);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][13], 1);
    PlayerTextDrawColor(playerid, gptLogin[playerid][13], -1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][13], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][13], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][13], 255);
    PlayerTextDrawFont(playerid, gptLogin[playerid][13], 2);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][13], 1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][13], 0);

    gptLogin[playerid][14] = CreatePlayerTextDraw(playerid, 24.666681, 349.703735, "fundo habilitacoes");
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][14], 0.000000, 6.633333);
    PlayerTextDrawTextSize(playerid, gptLogin[playerid][14], 160.156860, 0.000000);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][14], 1);
    PlayerTextDrawColor(playerid, gptLogin[playerid][14], -1);
    PlayerTextDrawUseBox(playerid, gptLogin[playerid][14], 1);
    PlayerTextDrawBoxColor(playerid, gptLogin[playerid][14], 38);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][14], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][14], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][14], 67);
    PlayerTextDrawFont(playerid, gptLogin[playerid][14], 2);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][14], 1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][14], 0);

    gptLogin[playerid][15] = CreatePlayerTextDraw(playerid, 77.633323, 350.178039, "Habilitacoes");
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][15], 0.122000, 0.749629);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][15], 1);
    PlayerTextDrawColor(playerid, gptLogin[playerid][15], -5963521);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][15], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][15], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][15], 255);
    PlayerTextDrawFont(playerid, gptLogin[playerid][15], 2);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][15], 1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][15], 0);

	new helilic = GetPlayerHeliLicense(playerid);
    gptLogin[playerid][16] = CreatePlayerTextDraw(playerid, 67.299781, 373.177947, "");
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][16], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, gptLogin[playerid][16], 40.666667, 55.570346);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][16], 1);
    PlayerTextDrawColor(playerid, gptLogin[playerid][16], -1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][16], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][16], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][16], 0);
    PlayerTextDrawFont(playerid, gptLogin[playerid][16], 5);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][16], 0);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][16], 0);
    PlayerTextDrawSetPreviewModel(playerid, gptLogin[playerid][16], 487);
    PlayerTextDrawSetPreviewRot(playerid, gptLogin[playerid][16], 0.000000, 0.000000, -90.000000, 1.000000);
    PlayerTextDrawSetPreviewVehCol(playerid, gptLogin[playerid][16], (helilic) ? 3 : 1, (helilic) ? 3 : 1);

	new carlic = GetPlayerCarLicense(playerid);
    gptLogin[playerid][17] = CreatePlayerTextDraw(playerid, 25.099977, 345.888854, "");
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][17], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, gptLogin[playerid][17], 40.000015, 59.718471);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][17], 1);
    PlayerTextDrawColor(playerid, gptLogin[playerid][17], -1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][17], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][17], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][17], 0);
    PlayerTextDrawFont(playerid, gptLogin[playerid][17], 5);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][17], 0);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][17], 0);
    PlayerTextDrawSetPreviewModel(playerid, gptLogin[playerid][17], 405);
    PlayerTextDrawSetPreviewRot(playerid, gptLogin[playerid][17], 0.000000, 0.000000, -90.000000, 1.000000);
    PlayerTextDrawSetPreviewVehCol(playerid, gptLogin[playerid][17], (carlic > gettime()) ? 3 : 1, (carlic > gettime()) ? 3 : 1);

	new bikelic = GetPlayerBikeLicense(playerid);
    gptLogin[playerid][18] = CreatePlayerTextDraw(playerid, 27.100028, 376.592895, "");
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][18], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, gptLogin[playerid][18], 34.000015, 47.688865);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][18], 1);
    PlayerTextDrawColor(playerid, gptLogin[playerid][18], -1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][18], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][18], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][18], 0);
    PlayerTextDrawFont(playerid, gptLogin[playerid][18], 5);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][18], 0);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][18], 0);
    PlayerTextDrawSetPreviewModel(playerid, gptLogin[playerid][18], 522);
    PlayerTextDrawSetPreviewRot(playerid, gptLogin[playerid][18], 0.000000, 0.000000, -90.000000, 1.000000);
    PlayerTextDrawSetPreviewVehCol(playerid, gptLogin[playerid][18], (bikelic) ? 3 : 1, (bikelic) ? 3 : 1);

	new trucklic = GetPlayerTruckLicense(playerid);
    gptLogin[playerid][19] = CreatePlayerTextDraw(playerid, 73.866477, 345.800140, "");
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][19], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, gptLogin[playerid][19], 38.999996, 55.985160);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][19], 1);
    PlayerTextDrawColor(playerid, gptLogin[playerid][19], -1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][19], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][19], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][19], 0);
    PlayerTextDrawFont(playerid, gptLogin[playerid][19], 5);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][19], 0);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][19], 0);
    PlayerTextDrawSetPreviewModel(playerid, gptLogin[playerid][19], 403);
    PlayerTextDrawSetPreviewRot(playerid, gptLogin[playerid][19], 0.000000, 0.000000, -90.000000, 1.000000);
    PlayerTextDrawSetPreviewVehCol(playerid, gptLogin[playerid][19], (trucklic) ? 3 : 1, (trucklic) ? 3 : 1);

	new planelic = GetPlayerPlaneLicense(playerid);
    gptLogin[playerid][20] = CreatePlayerTextDraw(playerid, 103.599906, 335.733306, "");
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][20], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, gptLogin[playerid][20], 56.000011, 71.748138);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][20], 1);
    PlayerTextDrawColor(playerid, gptLogin[playerid][20], -1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][20], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][20], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][20], 0);
    PlayerTextDrawFont(playerid, gptLogin[playerid][20], 5);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][20], 0);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][20], 0);
    PlayerTextDrawSetPreviewModel(playerid, gptLogin[playerid][20], 513);
    PlayerTextDrawSetPreviewRot(playerid, gptLogin[playerid][20], 0.000000, 0.000000, -90.000000, 1.000000);
    PlayerTextDrawSetPreviewVehCol(playerid, gptLogin[playerid][20], (planelic) ? 3 : 1, (planelic) ? 3 : 1);

	new boatlic = GetPlayerBoatLicense(playerid);
    gptLogin[playerid][21] = CreatePlayerTextDraw(playerid, 106.433204, 366.437438, "");
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][21], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, gptLogin[playerid][21], 60.666675, 68.429611);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][21], 1);
    PlayerTextDrawColor(playerid, gptLogin[playerid][21], -1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][21], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][21], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][21], 0);
    PlayerTextDrawFont(playerid, gptLogin[playerid][21], 5);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][21], 0);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][21], 0);
    PlayerTextDrawSetPreviewModel(playerid, gptLogin[playerid][21], 473);
    PlayerTextDrawSetPreviewRot(playerid, gptLogin[playerid][21], 0.000000, 0.000000, -90.000000, 1.000000);
    PlayerTextDrawSetPreviewVehCol(playerid, gptLogin[playerid][21], (boatlic) ? 3 : 1, (boatlic) ? 3 : 1);

    gptLogin[playerid][22] = CreatePlayerTextDraw(playerid, 159.701889, 231.151916, GetPlayerRankName(playerid, true));
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][22], 0.139666, 0.687407);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][22], 3);
    PlayerTextDrawColor(playerid, gptLogin[playerid][22], 16711935);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][22], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][22], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][22], 255);
    PlayerTextDrawFont(playerid, gptLogin[playerid][22], 2);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][22], 1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][22], 0);

    new sPlayerLevel[4];
    valstr(sPlayerLevel, GetPlayerLevel(playerid));
    gptLogin[playerid][23] = CreatePlayerTextDraw(playerid, 160.199981, 244.337936, sPlayerLevel);
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][23], 0.139666, 0.687407);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][23], 3);
    PlayerTextDrawColor(playerid, gptLogin[playerid][23], -1061109505);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][23], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][23], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][23], 255);
    PlayerTextDrawFont(playerid, gptLogin[playerid][23], 2);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][23], 1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][23], 0);

    new sLvlXp[18];
    format(sLvlXp, sizeof(sLvlXp), "%i/%i", GetPlayerXP(playerid), GetPlayerRequiredXP(playerid));
    gptLogin[playerid][24] = CreatePlayerTextDraw(playerid, 160.199981, 258.538787, sLvlXp);
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][24], 0.139666, 0.687407);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][24], 3);
    PlayerTextDrawColor(playerid, gptLogin[playerid][24], -1061109505);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][24], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][24], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][24], 255);
    PlayerTextDrawFont(playerid, gptLogin[playerid][24], 2);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][24], 1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][24], 0);

    gptLogin[playerid][25] = CreatePlayerTextDraw(playerid, 160.199981, 272.139617, GetJobName(GetPlayerJobID(playerid)));
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][25], 0.139666, 0.687407);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][25], 3);
    PlayerTextDrawColor(playerid, gptLogin[playerid][25], -1061109505);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][25], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][25], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][25], 255);
    PlayerTextDrawFont(playerid, gptLogin[playerid][25], 2);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][25], 1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][25], 0);

    new gps = GetPlayerGPS(playerid);
    gptLogin[playerid][26] = CreatePlayerTextDraw(playerid, 160.199981, 285.240417, gps != 0 ? "Sim" : "Nao");
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][26], 0.139666, 0.687407);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][26], 3);
    PlayerTextDrawColor(playerid, gptLogin[playerid][26], (gps) ? 16711935 : 0xf62a2aff);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][26], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][26], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][26], 255);
    PlayerTextDrawFont(playerid, gptLogin[playerid][26], 2);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][26], 1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][26], 0);

    new sPhoneNumber[] = "Nenhum";
    if(GetPlayerPhoneNumber(playerid) != 0) valstr(sPhoneNumber, GetPlayerPhoneNumber(playerid));
    gptLogin[playerid][27] = CreatePlayerTextDraw(playerid, 160.199981, 298.841247, sPhoneNumber);
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][27], 0.139666, 0.687407);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][27], 3);
    PlayerTextDrawColor(playerid, gptLogin[playerid][27], -1061109505);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][27], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][27], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][27], 255);
    PlayerTextDrawFont(playerid, gptLogin[playerid][27], 2);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][27], 1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][27], 0);

    gptLogin[playerid][28] = CreatePlayerTextDraw(playerid, 160.199981, 312.242065, GetFactionName(GetPlayerFactionID(playerid)));
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][28], 0.139666, 0.687407);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][28], 3);
    PlayerTextDrawColor(playerid, gptLogin[playerid][28], -1061109505);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][28], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][28], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][28], 255);
    PlayerTextDrawFont(playerid, gptLogin[playerid][28], 2);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][28], 1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][28], 0);

    gptLogin[playerid][29] = CreatePlayerTextDraw(playerid, 160.199981, 326.142913, ConvertToGameText(GetFactionRankName(GetPlayerFactionID(playerid), GetPlayerFactionRankID(playerid))));
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][29], 0.139666, 0.687407);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][29], 3);
    PlayerTextDrawColor(playerid, gptLogin[playerid][29], -1061109505);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][29], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][29], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][29], 255);
    PlayerTextDrawFont(playerid, gptLogin[playerid][29], 2);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][29], 1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][29], 0);

    gptLogin[playerid][30] = CreatePlayerTextDraw(playerid, 160.266677, 338.969116, "nao");
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][30], 0.139666, 0.687407);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][30], 3);
    PlayerTextDrawColor(playerid, gptLogin[playerid][30], 0xf62a2aff);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][30], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][30], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][30], 255);
    PlayerTextDrawFont(playerid, gptLogin[playerid][30], 2);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][30], 1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][30], 0);

    // Vehicles

    new v = 0, h = 0;
    for(new i = 0; i < MAX_VEHICLES_PER_PLAYER; i++)
    {
        if(GetDealershipVehicleModel(playerid, i) != 0)
        {
            v++;
            h = 1;
        }
    }

    gpTotalVehicles[playerid] = v;

    gptLogin[playerid][31] = CreatePlayerTextDraw(playerid, 168.599929, 63.251853, "fundo titulo car");
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][31], 0.000000, 0.974997);
    PlayerTextDrawTextSize(playerid, gptLogin[playerid][31], 305.126220, 0.000000);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][31], 1);
    PlayerTextDrawColor(playerid, gptLogin[playerid][31], -1);
    PlayerTextDrawUseBox(playerid, gptLogin[playerid][31], 1);
    PlayerTextDrawBoxColor(playerid, gptLogin[playerid][31], 50);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][31], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][31], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][31], 255);
    PlayerTextDrawFont(playerid, gptLogin[playerid][31], 2);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][31], 1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][31], 0);

	gptLogin[playerid][32] = CreatePlayerTextDraw(playerid, 167.933853, 62.181510, "fundo carro");
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][32], 0.000000, 18.202425);
	PlayerTextDrawTextSize(playerid, gptLogin[playerid][32], 305.750122, 0.000000);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][32], 1);
	PlayerTextDrawColor(playerid, gptLogin[playerid][32], -1);
	PlayerTextDrawUseBox(playerid, gptLogin[playerid][32], 1);
	PlayerTextDrawBoxColor(playerid, gptLogin[playerid][32], 50);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][32], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][32], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][32], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][32], 2);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][32], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][32], 0);

	if(h)
	{
		new color1 = 1, color2 = 3;
		if(h) GetDealershipVehicleColor(playerid, 0, color1, color2);
	    gptLogin[playerid][33] = CreatePlayerTextDraw(playerid, 191.000000, 51.000000, "");
	    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][33], 0.000000, 0.000000);
	    PlayerTextDrawTextSize(playerid, gptLogin[playerid][33], 93.000061, 114.474143);
	    PlayerTextDrawAlignment(playerid, gptLogin[playerid][33], 1);
	    PlayerTextDrawColor(playerid, gptLogin[playerid][33], -1);
	    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][33], 0);
	    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][33], 0);
	    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][33], 0);
	    PlayerTextDrawFont(playerid, gptLogin[playerid][33], 5);
	    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][33], 0);
	    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][33], 0);
	    PlayerTextDrawSetPreviewModel(playerid, gptLogin[playerid][33], (h) ? GetDealershipVehicleModel(playerid, 0) : 400);
	    PlayerTextDrawSetPreviewRot(playerid, gptLogin[playerid][33], 0.000000, 0.000000, -90.000000, 1.000000);
	    PlayerTextDrawSetPreviewVehCol(playerid, gptLogin[playerid][33], color1, color2);
	}
	else
	{
		gptLogin[playerid][33] = CreatePlayerTextDraw(playerid, 241.000000, 91.000000, "X");// carro
		PlayerTextDrawLetterSize(playerid, gptLogin[playerid][33], 0.682999, 2.686815);
		PlayerTextDrawAlignment(playerid, gptLogin[playerid][33], 2);
		PlayerTextDrawColor(playerid, gptLogin[playerid][33], 0xc90000ff);
		PlayerTextDrawSetShadow(playerid, gptLogin[playerid][33], 0);
		PlayerTextDrawSetOutline(playerid, gptLogin[playerid][33], 0);
		PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][33], 255);
		PlayerTextDrawFont(playerid, gptLogin[playerid][33], 1);
		PlayerTextDrawSetProportional(playerid, gptLogin[playerid][33], 1);
		PlayerTextDrawSetShadow(playerid, gptLogin[playerid][33], 0);
	}

    gptLogin[playerid][34] = CreatePlayerTextDraw(playerid, 162.000000, 129.000000, ".");
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][34], 14.299657, 0.592000);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][34], 1);
    PlayerTextDrawColor(playerid, gptLogin[playerid][34], 49);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][34], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][34], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][34], 255);
    PlayerTextDrawFont(playerid, gptLogin[playerid][34], 1);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][34], 1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][34], 0);

    gptLogin[playerid][35] = CreatePlayerTextDraw(playerid, 173.000000, 111.000000, "ld_beat:left");
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][35], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, gptLogin[playerid][35], 13.000000, 13.688888);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][35], 1);
    PlayerTextDrawColor(playerid, gptLogin[playerid][35], -1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][35], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][35], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][35], 255);
    PlayerTextDrawFont(playerid, gptLogin[playerid][35], 4);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][35], 0);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][35], 0);
    PlayerTextDrawSetSelectable(playerid, gptLogin[playerid][35], true);

    new location[MAX_ZONE_NAME], Float:x, Float:y;
    GetDealershipVehicle2DPos(playerid, 0, x, y);
    Get2DZoneName(location, x, y);

    new sCarData[64];
    if(h)
        format(sCarData, sizeof(sCarData), "%s~n~~n~$%d~n~~n~%s~n~~n~", GetVehicleNameFromModel(GetDealershipVehicleModel(playerid, 0)), GetDealershipVehicleFines(playerid, 0), location);
    else
        format(sCarData, sizeof(sCarData), "Nenhum~n~~n~-~n~~n~-~n~~n~");
    gptLogin[playerid][36] = CreatePlayerTextDraw(playerid, 303.568389, 134.777694, sCarData);
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][36], 0.122000, 0.749629);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][36], 3);
    PlayerTextDrawColor(playerid, gptLogin[playerid][36], -1061109505);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][36], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][36], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][36], 255);
    PlayerTextDrawFont(playerid, gptLogin[playerid][36], 2);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][36], 1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][36], 0);

    gptLogin[playerid][37] = CreatePlayerTextDraw(playerid, 168.599914, 136.299957, "fundo stats char");
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][37], 0.000000, 9.877712);
    PlayerTextDrawTextSize(playerid, gptLogin[playerid][37], 305.186859, 0.000000);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][37], 1);
    PlayerTextDrawColor(playerid, gptLogin[playerid][37], -1);
    PlayerTextDrawUseBox(playerid, gptLogin[playerid][37], 1);
    PlayerTextDrawBoxColor(playerid, gptLogin[playerid][37], 43);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][37], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][37], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][37], 255);
    PlayerTextDrawFont(playerid, gptLogin[playerid][37], 1);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][37], 1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][37], 0);

    gptLogin[playerid][38] = CreatePlayerTextDraw(playerid, 304.968475, 188.812774, (h) ? "SIM" : "-");
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][38], 0.122000, 0.749629);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][38], 3);
    PlayerTextDrawColor(playerid, gptLogin[playerid][38], 16711935);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][38], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][38], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][38], 255);
    PlayerTextDrawFont(playerid, gptLogin[playerid][38], 2);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][38], 1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][38], 0);

    new sFuelStr[10];
    format(sFuelStr, sizeof(sFuelStr), "%.2f%%", GetDealershipVehicleFuel(playerid, 0));
    gptLogin[playerid][39] = CreatePlayerTextDraw(playerid, 304.968475, 201.913574, (h) ? sFuelStr : "-");
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][39], 0.122000, 0.749629);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][39], 3);
    PlayerTextDrawColor(playerid, gptLogin[playerid][39], 16711935);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][39], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][39], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][39], 255);
    PlayerTextDrawFont(playerid, gptLogin[playerid][39], 2);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][39], 1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][39], 0);

    gptLogin[playerid][40] = CreatePlayerTextDraw(playerid, 304.968475, 175.211944, (h) ? "INDISPONIVEL" : "-");
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][40], 0.122000, 0.749629);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][40], 3);
    PlayerTextDrawColor(playerid, gptLogin[playerid][40], 16711935);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][40], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][40], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][40], 255);
    PlayerTextDrawFont(playerid, gptLogin[playerid][40], 2);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][40], 1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][40], 0);

	new Float:vHealth = GetDealershipVehicleHealth(playerid, 0);
	new healthcolor = 0x00ff00ff;
	if(vHealth < 450.0)
		healthcolor = 0xff0000ff;
	else if(vHealth < 750.0)
		healthcolor = 0xffff00ff;

    new sHealthStr[10];
    format(sHealthStr, sizeof(sHealthStr), "%d%%", floatround(vHealth));
    gptLogin[playerid][41] = CreatePlayerTextDraw(playerid, 304.968475, 215.714416, (h) ? sHealthStr : "-");
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][41], 0.122000, 0.749629);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][41], 3);
    PlayerTextDrawColor(playerid, gptLogin[playerid][41], healthcolor);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][41], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][41], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][41], 255);
    PlayerTextDrawFont(playerid, gptLogin[playerid][41], 2);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][41], 1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][41], 0);

    gptLogin[playerid][42] = CreatePlayerTextDraw(playerid, 168.400009, 135.062927, "Modelo:~n~~n~Multas:~n~~n~Local:~n~~n~Personalizado:~n~~n~Seguro:~n~~n~Gasolina:~n~~n~Vida:");
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][42], 0.122000, 0.749629);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][42], 1);
    PlayerTextDrawColor(playerid, gptLogin[playerid][42], -1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][42], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][42], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][42], 255);
    PlayerTextDrawFont(playerid, gptLogin[playerid][42], 2);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][42], 1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][42], 0);

    gptLogin[playerid][43] = CreatePlayerTextDraw(playerid, 292.000000, 111.000000, "ld_beat:right");
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][43], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, gptLogin[playerid][43], 13.000000, 13.688888);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][43], 1);
    PlayerTextDrawColor(playerid, gptLogin[playerid][43], -1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][43], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][43], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][43], 255);
    PlayerTextDrawFont(playerid, gptLogin[playerid][43], 4);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][43], 0);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][43], 0);
    PlayerTextDrawSetSelectable(playerid, gptLogin[playerid][43], true);

    new sVehiclesAmount[8];
    format(sVehiclesAmount, sizeof(sVehiclesAmount), "%i/%i", h, v);
    gptLogin[playerid][44] = CreatePlayerTextDraw(playerid, 236.000000, 76.000000, (h) ? sVehiclesAmount : "-/-");
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][44], 0.217666, 0.774519);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][44], 2);
    PlayerTextDrawColor(playerid, gptLogin[playerid][44], -1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][44], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][44], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][44], 255);
    PlayerTextDrawFont(playerid, gptLogin[playerid][44], 3);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][44], 1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][44], 0);

	new sVehicleDBID[4];
	valstr(sVehicleDBID, g_pDealershipData[playerid][0][E_DEALERSHIP_VEHICLE_DBID]);
    gptLogin[playerid][45] = CreatePlayerTextDraw(playerid, 304.000000, 63.000000, (h) ? sVehicleDBID : "-");
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][45], 0.257333, 0.965333);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][45], 3);
    if(h) PlayerTextDrawColor(playerid, gptLogin[playerid][45], -2139062017);
    else PlayerTextDrawColor(playerid, gptLogin[playerid][45], 0xffffff00);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][45], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][45], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][45], 255);
    PlayerTextDrawFont(playerid, gptLogin[playerid][45], 3);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][45], 1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][45], 0);

    gptLogin[playerid][46] = CreatePlayerTextDraw(playerid, 166.000000, 52.125930, ""); // Ex-26 on bug
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][46], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, gptLogin[playerid][46], 20.666656, 31.511116);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][46], 1);
    PlayerTextDrawColor(playerid, gptLogin[playerid][46], -1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][46], 0);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][46], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][46], 0);
    PlayerTextDrawFont(playerid, gptLogin[playerid][46], 5);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][46], 0);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][46], 0);
    PlayerTextDrawSetPreviewModel(playerid, gptLogin[playerid][46], 475);
    PlayerTextDrawSetPreviewRot(playerid, gptLogin[playerid][46], 0.000000, 0.000000, -40.000000, 1.000000);
    PlayerTextDrawSetPreviewVehCol(playerid, gptLogin[playerid][46], 17, 1);

	// Houses

	new houseid = GetPlayerHouseID(playerid);
	if(houseid < 0) houseid = 0;

	gptLogin[playerid][47] = CreatePlayerTextDraw(playerid, 167.499908, 234.900054, "fundo residencia");
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][47], 0.000000, 19.529703);
	PlayerTextDrawTextSize(playerid, gptLogin[playerid][47], 305.683410, 0.000000);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][47], 1);
	PlayerTextDrawColor(playerid, gptLogin[playerid][47], -1);
	PlayerTextDrawUseBox(playerid, gptLogin[playerid][47], 1);
	PlayerTextDrawBoxColor(playerid, gptLogin[playerid][47], 50);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][47], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][47], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][47], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][47], 2);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][47], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][47], 0);

	gptLogin[playerid][48] = CreatePlayerTextDraw(playerid, 168.100006, 236.000000, "fundo titulo car");
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][48], 0.000000, 0.974996);
	PlayerTextDrawTextSize(playerid, gptLogin[playerid][48], 305.147125, 0.000000);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][48], 1);
	PlayerTextDrawColor(playerid, gptLogin[playerid][48], -1);
	PlayerTextDrawUseBox(playerid, gptLogin[playerid][48], 1);
	PlayerTextDrawBoxColor(playerid, gptLogin[playerid][48], 50);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][48], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][48], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][48], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][48], 2);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][48], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][48], 0);

	gptLogin[playerid][49] = CreatePlayerTextDraw(playerid, 158.50000, 227.50000, "");
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][49], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, gptLogin[playerid][49], 26.00000, 26.00000);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][49], 1);
	PlayerTextDrawColor(playerid, gptLogin[playerid][49], -1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][49], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][49], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][49], 0);
	PlayerTextDrawFont(playerid, gptLogin[playerid][49], 5);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][49], 0);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][49], 0);
	PlayerTextDrawSetPreviewModel(playerid, gptLogin[playerid][49], 19522);
	PlayerTextDrawSetPreviewRot(playerid, gptLogin[playerid][49], 0.000000, 0.000000, 0.000000, 1.000000);

	gptLogin[playerid][50] = CreatePlayerTextDraw(playerid, 180.000000, 235.999938, "Sua casa");
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][50], 0.154331, 0.874073);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][50], 1);
	PlayerTextDrawColor(playerid, gptLogin[playerid][50], -1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][50], 1);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][50], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][50], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][50], 3);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][50], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][50], 1);

	if(GetPlayerHouseID(playerid) != INVALID_HOUSE_ID)
	{
		gptLogin[playerid][51] = CreatePlayerTextDraw(playerid, 199.000000, 242.000000, "");
		PlayerTextDrawLetterSize(playerid, gptLogin[playerid][51], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, gptLogin[playerid][51], 90.000000, 90.000000);
		PlayerTextDrawAlignment(playerid, gptLogin[playerid][51], 1);
		PlayerTextDrawColor(playerid, gptLogin[playerid][51], -1);
		PlayerTextDrawSetShadow(playerid, gptLogin[playerid][51], 0);
		PlayerTextDrawSetOutline(playerid, gptLogin[playerid][51], 0);
		PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][51], 0);
		PlayerTextDrawFont(playerid, gptLogin[playerid][51], 5);
		PlayerTextDrawSetProportional(playerid, gptLogin[playerid][51], 0);
		PlayerTextDrawSetShadow(playerid, gptLogin[playerid][51], 0);
		PlayerTextDrawSetPreviewModel(playerid, gptLogin[playerid][51], 6391);
		PlayerTextDrawSetPreviewRot(playerid, gptLogin[playerid][51], 0.000000, 0.000000, 40.000000, 1.000000);
	}
	else
	{
		gptLogin[playerid][51] = CreatePlayerTextDraw(playerid, 241.000000, 274.000000, "X"); // casa
		PlayerTextDrawLetterSize(playerid, gptLogin[playerid][51], 0.682999, 2.686815);
		PlayerTextDrawAlignment(playerid, gptLogin[playerid][51], 2);
		PlayerTextDrawColor(playerid, gptLogin[playerid][51], 0xc90000ff);
		PlayerTextDrawSetShadow(playerid, gptLogin[playerid][51], 0);
		PlayerTextDrawSetOutline(playerid, gptLogin[playerid][51], 0);
		PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][51], 255);
		PlayerTextDrawFont(playerid, gptLogin[playerid][51], 1);
		PlayerTextDrawSetProportional(playerid, gptLogin[playerid][51], 1);
		PlayerTextDrawSetShadow(playerid, gptLogin[playerid][51], 0);
	}

	new sHouseDBID[5];
	valstr(sHouseDBID, GetHouseDatabaseID(houseid));
	gptLogin[playerid][52] = CreatePlayerTextDraw(playerid, 304.600036, 235.899932, sHouseDBID);
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][52], 0.238664, 0.903110);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][52], 3);
	if(GetPlayerHouseID(playerid) != INVALID_HOUSE_ID) PlayerTextDrawColor(playerid, gptLogin[playerid][52], -2139062017);
	else PlayerTextDrawColor(playerid, gptLogin[playerid][52], 0xffffff00);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][52], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][52], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][52], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][52], 3);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][52], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][52], 0);

	gptLogin[playerid][53] = CreatePlayerTextDraw(playerid, 168.300018, 328.000000, "fundo stats car");
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][53], 0.000000, 9.061387);
	PlayerTextDrawTextSize(playerid, gptLogin[playerid][53], 305.078094, 0.000000);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][53], 1);
	PlayerTextDrawColor(playerid, gptLogin[playerid][53], -1);
	PlayerTextDrawUseBox(playerid, gptLogin[playerid][53], 1);
	PlayerTextDrawBoxColor(playerid, gptLogin[playerid][53], 43);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][53], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][53], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][53], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][53], 1);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][53], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][53], 0);

	gptLogin[playerid][54] = CreatePlayerTextDraw(playerid, 169.033309, 331.600158, "Comodos:~n~~n~Camas:~n~~n~Local:~n~~n~Status:~n~~n~Aluguel:~n~~n~Personalizada:");
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][54], 0.122000, 0.749629);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][54], 1);
	PlayerTextDrawColor(playerid, gptLogin[playerid][54], -1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][54], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][54], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][54], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][54], 2);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][54], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][54], 0);

	new Float:z;
	GetHouseEntrance(houseid, x, y, z);
	Get2DZoneName(location, x, y);

	new sHouseData[64];
	format(sHouseData, sizeof(sHouseData), "%d~n~~n~%d~n~~n~%s~n~~n~", GetHouseRooms(houseid), GetHouseBeds(houseid), location);
	gptLogin[playerid][55] = CreatePlayerTextDraw(playerid, 302.201690, 331.300109, (GetPlayerHouseID(playerid) == INVALID_HOUSE_ID) ? "-~n~~n~-~n~~n~-~n~~n~" : sHouseData);
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][55], 0.122000, 0.749629);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][55], 3);
	PlayerTextDrawColor(playerid, gptLogin[playerid][55], -1061109505);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][55], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][55], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][55], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][55], 2);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][55], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][55], 0);

	new hlockstate = GetHouseLockState(houseid);
	new sHouseLockState[] = "Destrancada";
	if(hlockstate) sHouseLockState = "Trancada";

	gptLogin[playerid][56] = CreatePlayerTextDraw(playerid, 303.699981, 372.000000, (GetPlayerHouseID(playerid) == INVALID_HOUSE_ID) ? "-" : sHouseLockState);
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][56], 0.122000, 0.749629);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][56], 3);
	PlayerTextDrawColor(playerid, gptLogin[playerid][56], (hlockstate) ? -16776961 : 0x80d61eff);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][56], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][56], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][56], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][56], 2);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][56], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][56], 0);

	gptLogin[playerid][57] = CreatePlayerTextDraw(playerid, 303.699981, 385.400817, (GetPlayerHouseID(playerid) == INVALID_HOUSE_ID) ? "-" : "INDISPONIVEL");
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][57], 0.122000, 0.749629);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][57], 3);
	PlayerTextDrawColor(playerid, gptLogin[playerid][57], 16711935);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][57], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][57], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][57], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][57], 2);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][57], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][57], 0);

	gptLogin[playerid][58] = CreatePlayerTextDraw(playerid, 303.299957, 398.501617, (GetPlayerHouseID(playerid) == INVALID_HOUSE_ID) ? "-" : "INDISPONIVEL");
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][58], 0.122000, 0.749629);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][58], 3);
	PlayerTextDrawColor(playerid, gptLogin[playerid][58], 0xff0000ff);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][58], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][58], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][58], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][58], 2);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][58], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][58], 0);

	gptLogin[playerid][59] = CreatePlayerTextDraw(playerid, 458.400146, 62.300010, "box");
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][59], 0.000000, 38.699989);
	PlayerTextDrawTextSize(playerid, gptLogin[playerid][59], 622.065917, 0.000000);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][59], 1);
	PlayerTextDrawColor(playerid, gptLogin[playerid][59], -1);
	PlayerTextDrawUseBox(playerid, gptLogin[playerid][59], 1);
	PlayerTextDrawBoxColor(playerid, gptLogin[playerid][59], -2147483393);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][59], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][59], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][59], -5963521);
	PlayerTextDrawFont(playerid, gptLogin[playerid][59], 3);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][59], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][59], 0);

	gptLogin[playerid][60] = CreatePlayerTextDraw(playerid, 460.000000, 64.000000, "box");
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][60], 0.000000, 38.399993);
	PlayerTextDrawTextSize(playerid, gptLogin[playerid][60], 621.065917, 0.000000);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][60], 1);
	PlayerTextDrawColor(playerid, gptLogin[playerid][60], -1);
	PlayerTextDrawUseBox(playerid, gptLogin[playerid][60], 1);
	PlayerTextDrawBoxColor(playerid, gptLogin[playerid][60], -1523963137);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][60], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][60], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][60], -5963521);
	PlayerTextDrawFont(playerid, gptLogin[playerid][60], 3);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][60], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][60], 0);

	gptLogin[playerid][61] = CreatePlayerTextDraw(playerid, 469.000000, 127.000000, "botao login");
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][61], 0.000000, 5.133335);
	PlayerTextDrawTextSize(playerid, gptLogin[playerid][61], 612.400390, 30.100000);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][61], 1);
	PlayerTextDrawColor(playerid, gptLogin[playerid][61], 16777215);
	PlayerTextDrawUseBox(playerid, gptLogin[playerid][61], 1);
	if(IsPlayerRegistered(playerid)) PlayerTextDrawBoxColor(playerid, gptLogin[playerid][61], -663461121);// habilitado
	else PlayerTextDrawBoxColor(playerid, gptLogin[playerid][61], -663461351); // desabilitado
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][61], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][61], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][61], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][61], 1);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][61], 0);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][61], 0);
	PlayerTextDrawSetSelectable(playerid, gptLogin[playerid][61], true);

	gptLogin[playerid][62] = CreatePlayerTextDraw(playerid, 460.000000, 64.000000, "box");
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][62], 0.000000, 5.033337);
	PlayerTextDrawTextSize(playerid, gptLogin[playerid][62], 621.309082, 0.000000);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][62], 1);
	PlayerTextDrawColor(playerid, gptLogin[playerid][62], -1);
	PlayerTextDrawUseBox(playerid, gptLogin[playerid][62], 1);
	PlayerTextDrawBoxColor(playerid, gptLogin[playerid][62], 141);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][62], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][62], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][62], -5963521);
	PlayerTextDrawFont(playerid, gptLogin[playerid][62], 3);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][62], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][62], 0);

	gptLogin[playerid][63] = CreatePlayerTextDraw(playerid, 498.000000, 71.000000, "PC");
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][63], 0.657333, 3.114075);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][63], 1);
	PlayerTextDrawColor(playerid, gptLogin[playerid][63], -293376257);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][63], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][63], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][63], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][63], 3);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][63], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][63], 0);

	gptLogin[playerid][64] = CreatePlayerTextDraw(playerid, 528.000000, 71.000000, ":");
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][64], 0.657333, 3.114075);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][64], 1);
	PlayerTextDrawColor(playerid, gptLogin[playerid][64], -1061109505);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][64], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][64], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][64], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][64], 3);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][64], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][64], 0);

	gptLogin[playerid][65] = CreatePlayerTextDraw(playerid, 544.000000, 71.000000, "RPG");
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][65], 0.657333, 3.114075);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][65], 1);
	PlayerTextDrawColor(playerid, gptLogin[playerid][65], 1116457727);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][65], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][65], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][65], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][65], 3);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][65], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][65], 0);

	gptLogin[playerid][66] = CreatePlayerTextDraw(playerid, 469.499969, 201.000000, "botao registro");
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][66], 0.000000, 5.166668);
	PlayerTextDrawTextSize(playerid, gptLogin[playerid][66], 611.664184, 30.100000);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][66], 1);
	PlayerTextDrawColor(playerid, gptLogin[playerid][66], 16777215);
	PlayerTextDrawUseBox(playerid, gptLogin[playerid][66], 1);
	if(!IsPlayerRegistered(playerid)) PlayerTextDrawBoxColor(playerid, gptLogin[playerid][66], -663461121);// habilitado
	else PlayerTextDrawBoxColor(playerid, gptLogin[playerid][66], -663461351); // desabilitado
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][66], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][66], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][66], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][66], 1);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][66], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][66], 0);
	PlayerTextDrawSetSelectable(playerid, gptLogin[playerid][66], true);

	gptLogin[playerid][67] = CreatePlayerTextDraw(playerid, 470.000000, 276.000000, "botao ajuda");
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][67], 0.000000, 5.166668);
	PlayerTextDrawTextSize(playerid, gptLogin[playerid][67], 611.778259, 30.100000);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][67], 1);
	PlayerTextDrawColor(playerid, gptLogin[playerid][67], 16777215);
	PlayerTextDrawUseBox(playerid, gptLogin[playerid][67], 1);
	PlayerTextDrawBoxColor(playerid, gptLogin[playerid][67], 1149023231);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][67], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][67], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][67], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][67], 1);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][67], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][67], 0);
	PlayerTextDrawSetSelectable(playerid, gptLogin[playerid][67], true);

	gptLogin[playerid][68] = CreatePlayerTextDraw(playerid, 470.300018, 351.899932, "botao creditos");
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][68], 0.000000, 5.166668);
	PlayerTextDrawTextSize(playerid, gptLogin[playerid][68], 611.311523, 30.100000);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][68], 1);
	PlayerTextDrawColor(playerid, gptLogin[playerid][68], 16777215);
	PlayerTextDrawUseBox(playerid, gptLogin[playerid][68], 1);
	PlayerTextDrawBoxColor(playerid, gptLogin[playerid][68], 1149023231);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][68], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][68], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][68], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][68], 0);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][68], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][68], 0);
	PlayerTextDrawSetSelectable(playerid, gptLogin[playerid][68], true);

	gptLogin[playerid][69] = CreatePlayerTextDraw(playerid, 470.300018, 351.899932, "fx");
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][69], 0.000000, 2.633335);
	PlayerTextDrawTextSize(playerid, gptLogin[playerid][69], 611.311706, 0.000000);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][69], 1);
	PlayerTextDrawColor(playerid, gptLogin[playerid][69], -1);
	PlayerTextDrawUseBox(playerid, gptLogin[playerid][69], 1);
	PlayerTextDrawBoxColor(playerid, gptLogin[playerid][69], -226);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][69], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][69], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][69], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][69], 1);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][69], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][69], 0);

	gptLogin[playerid][70] = CreatePlayerTextDraw(playerid, 470.000000, 276.000000, "fx");
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][70], 0.000000, 2.666669);
	PlayerTextDrawTextSize(playerid, gptLogin[playerid][70], 611.729125, 0.000000);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][70], 1);
	PlayerTextDrawColor(playerid, gptLogin[playerid][70], -1);
	PlayerTextDrawUseBox(playerid, gptLogin[playerid][70], 1);
	PlayerTextDrawBoxColor(playerid, gptLogin[playerid][70], -226);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][70], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][70], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][70], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][70], 1);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][70], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][70], 0);

	gptLogin[playerid][71] = CreatePlayerTextDraw(playerid, 469.499969, 201.000000, "fx");
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][71], 0.000000, 2.766666);
	PlayerTextDrawTextSize(playerid, gptLogin[playerid][71], 611.477478, 0.000000);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][71], 1);
	PlayerTextDrawColor(playerid, gptLogin[playerid][71], -1);
	PlayerTextDrawUseBox(playerid, gptLogin[playerid][71], 1);
	PlayerTextDrawBoxColor(playerid, gptLogin[playerid][71], -226);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][71], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][71], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][71], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][71], 1);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][71], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][71], 0);

	gptLogin[playerid][72] = CreatePlayerTextDraw(playerid, 469.000000, 127.000000, "fx");
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][72], 0.000000, 2.466669);
	PlayerTextDrawTextSize(playerid, gptLogin[playerid][72], 612.101196, 0.000000);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][72], 1);
	PlayerTextDrawColor(playerid, gptLogin[playerid][72], -1);
	PlayerTextDrawUseBox(playerid, gptLogin[playerid][72], 1);
	PlayerTextDrawBoxColor(playerid, gptLogin[playerid][72], -226);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][72], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][72], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][72], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][72], 1);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][72], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][72], 0);

	gptLogin[playerid][73] = CreatePlayerTextDraw(playerid, 540.000000, 369.000000, "Creditos");
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][73], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][73], 2);
	PlayerTextDrawColor(playerid, gptLogin[playerid][73], -1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][73], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][73], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][73], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][73], 2);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][73], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][73], 0);

	gptLogin[playerid][74] = CreatePlayerTextDraw(playerid, 538.000000, 292.000000, "ajuda");
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][74], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][74], 2);
	PlayerTextDrawColor(playerid, gptLogin[playerid][74], -1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][74], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][74], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][74], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][74], 2);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][74], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][74], 0);

	gptLogin[playerid][75] = CreatePlayerTextDraw(playerid, 540.000000, 218.000000, "cadastro");
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][75], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][75], 2);
	if(!IsPlayerRegistered(playerid)) PlayerTextDrawColor(playerid, gptLogin[playerid][75], -1);
	else PlayerTextDrawColor(playerid, gptLogin[playerid][75], -216);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][75], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][75], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][75], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][75], 2);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][75], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][75], 0);

	gptLogin[playerid][76] = CreatePlayerTextDraw(playerid, 540.000000, 142.000000, "login");
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][76], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][76], 2);
	if(IsPlayerRegistered(playerid)) PlayerTextDrawColor(playerid, gptLogin[playerid][76], -1);
	else PlayerTextDrawColor(playerid, gptLogin[playerid][76], -216);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][76], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][76], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][76], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][76], 2);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][76], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][76], 0);

	// Empresas
	new businessid = GetPlayerBusinessID(playerid);
	if(businessid < 0) businessid = 0;

	gptLogin[playerid][77] = CreatePlayerTextDraw(playerid, 311.366668, 60.422264, "");
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][77], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, gptLogin[playerid][77], 12.333315, 14.918522);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][77], 1);
	PlayerTextDrawColor(playerid, gptLogin[playerid][77], -1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][77], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][77], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][77], 0);
	PlayerTextDrawFont(playerid, gptLogin[playerid][77], 5);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][77], 0);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][77], 0);
	PlayerTextDrawSetPreviewModel(playerid, gptLogin[playerid][77], 1272);
	PlayerTextDrawSetPreviewRot(playerid, gptLogin[playerid][77], 0.000000, 0.000000, 0.000000, 1.000000);

	gptLogin[playerid][78] = CreatePlayerTextDraw(playerid, 312.800109, 62.299995, "fundo empresa");
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][78], 0.000000, 18.161151);
	PlayerTextDrawTextSize(playerid, gptLogin[playerid][78], 450.816802, 0.000000);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][78], 1);
	PlayerTextDrawColor(playerid, gptLogin[playerid][78], -1);
	PlayerTextDrawUseBox(playerid, gptLogin[playerid][78], 1);
	PlayerTextDrawBoxColor(playerid, gptLogin[playerid][78], 50);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][78], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][78], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][78], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][78], 2);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][78], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][78], 0);

	gptLogin[playerid][79] = CreatePlayerTextDraw(playerid, 312.399932, 232.700057, "");
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][79], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, gptLogin[playerid][79], 12.333314, 14.918521);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][79], 1);
	PlayerTextDrawColor(playerid, gptLogin[playerid][79], -1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][79], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][79], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][79], 0);
	PlayerTextDrawFont(playerid, gptLogin[playerid][79], 5);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][79], 0);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][79], 0);
	PlayerTextDrawSetPreviewModel(playerid, gptLogin[playerid][79], 1239);
	PlayerTextDrawSetPreviewRot(playerid, gptLogin[playerid][79], 0.000000, 0.000000, 180.000000, 1.000000);

	gptLogin[playerid][80] = CreatePlayerTextDraw(playerid, 313.399963, 63.299995, "fundo titulo empresa");
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][80], 0.000000, 0.974995);
	PlayerTextDrawTextSize(playerid, gptLogin[playerid][80], 450.057800, 0.000000);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][80], 1);
	PlayerTextDrawColor(playerid, gptLogin[playerid][80], -1);
	PlayerTextDrawUseBox(playerid, gptLogin[playerid][80], 1);
	PlayerTextDrawBoxColor(playerid, gptLogin[playerid][80], 50);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][80], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][80], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][80], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][80], 2);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][80], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][80], 0);

	gptLogin[playerid][81] = CreatePlayerTextDraw(playerid, 313.399902, 228.300079, "fundo server stats");
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][81], 0.000000, -9.425692);
	PlayerTextDrawTextSize(playerid, gptLogin[playerid][81], 450.144317, 0.000000);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][81], 1);
	PlayerTextDrawColor(playerid, gptLogin[playerid][81], -1);
	PlayerTextDrawUseBox(playerid, gptLogin[playerid][81], 1);
	PlayerTextDrawBoxColor(playerid, gptLogin[playerid][81], 43);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][81], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][81], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][81], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][81], 1);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][81], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][81], 0);

	gptLogin[playerid][82] = CreatePlayerTextDraw(playerid, 315.000000, 148.000000, "Nome da empresa:~n~~n~Local:~n~~n~Tipo:~n~~n~Valor por produto:~n~~n~Cofre:~n~~n~Status:");
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][82], 0.122000, 0.749629);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][82], 1);
	PlayerTextDrawColor(playerid, gptLogin[playerid][82], -1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][82], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][82], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][82], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][82], 2);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][82], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][82], 0);

	if(GetPlayerBusinessID(playerid) != INVALID_BUSINESS_ID)
	{
		gptLogin[playerid][83] = CreatePlayerTextDraw(playerid, 325.000000, 38.000000, "");
		PlayerTextDrawLetterSize(playerid, gptLogin[playerid][83], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, gptLogin[playerid][83], 105.000038, 141.022262);
		PlayerTextDrawAlignment(playerid, gptLogin[playerid][83], 1);
		PlayerTextDrawColor(playerid, gptLogin[playerid][83], -1);
		PlayerTextDrawSetShadow(playerid, gptLogin[playerid][83], 0);
		PlayerTextDrawSetOutline(playerid, gptLogin[playerid][83], 0);
		PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][83], 0);
		PlayerTextDrawFont(playerid, gptLogin[playerid][83], 5);
		PlayerTextDrawSetProportional(playerid, gptLogin[playerid][83], 0);
		PlayerTextDrawSetShadow(playerid, gptLogin[playerid][83], 0);
		PlayerTextDrawSetPreviewModel(playerid, gptLogin[playerid][83], 5532);
		PlayerTextDrawSetPreviewRot(playerid, gptLogin[playerid][83], 0.000000, 0.000000, 0.000000, 1.000000);
	}
	else
	{

		gptLogin[playerid][83] = CreatePlayerTextDraw(playerid, 383.000000, 93.000000, "X");// empresa
		PlayerTextDrawLetterSize(playerid, gptLogin[playerid][83], 0.682999, 2.686815);
		PlayerTextDrawAlignment(playerid, gptLogin[playerid][83], 2);
		PlayerTextDrawColor(playerid, gptLogin[playerid][83], 0xc90000ff);
		PlayerTextDrawSetShadow(playerid, gptLogin[playerid][83], 0);
		PlayerTextDrawSetOutline(playerid, gptLogin[playerid][83], 0);
		PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][83], 255);
		PlayerTextDrawFont(playerid, gptLogin[playerid][83], 1);
		PlayerTextDrawSetProportional(playerid, gptLogin[playerid][83], 1);
		PlayerTextDrawSetShadow(playerid, gptLogin[playerid][83], 0);
	}

	new sBusinessData[90];
	format(sBusinessData, sizeof(sBusinessData), "%s~n~~n~%s~n~~n~%s", GetBusinessName(businessid), GetBusinessLocation(businessid), GetBusinessTypeName(businessid));
	gptLogin[playerid][84] = CreatePlayerTextDraw(playerid, 447.800048, 147.000000, (GetPlayerBusinessID(playerid) == INVALID_BUSINESS_ID) ? "Nenhuma~n~~n~-~n~~n~-" : sBusinessData);
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][84], 0.122000, 0.749629);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][84], 3);
	PlayerTextDrawColor(playerid, gptLogin[playerid][84], -1061109505);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][84], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][84], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][84], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][84], 2);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][84], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][84], 0);

	new sBusinessProdPrice[10];
	format(sBusinessProdPrice, sizeof(sBusinessProdPrice), "$%d", GetBusinessProductsPrice(businessid));
	gptLogin[playerid][85] = CreatePlayerTextDraw(playerid, 449.200073, 187.500030, (GetPlayerBusinessID(playerid) == INVALID_BUSINESS_ID) ? "-" : sBusinessProdPrice);
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][85], 0.122000, 0.749629);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][85], 3);
	PlayerTextDrawColor(playerid, gptLogin[playerid][85], 16711935);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][85], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][85], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][85], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][85], 2);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][85], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][85], 0);

	new sBusinessTill[10];
	format(sBusinessTill, sizeof(sBusinessTill), "$%d", GetBusinessTill(businessid));
	gptLogin[playerid][86] = CreatePlayerTextDraw(playerid, 449.200073, 200.900848, (GetPlayerBusinessID(playerid) == INVALID_BUSINESS_ID) ? "-" : sBusinessTill);
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][86], 0.122000, 0.749629);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][86], 3);
	PlayerTextDrawColor(playerid, gptLogin[playerid][86], 16711935);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][86], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][86], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][86], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][86], 2);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][86], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][86], 0);

	new sBusinessLock[] = "Trancada";
	if(!GetBusinessLockState(businessid))
		format(sBusinessLock, sizeof(sBusinessLock), "Aberta");
	gptLogin[playerid][87] = CreatePlayerTextDraw(playerid, 449.200073, 214.201660, (GetPlayerBusinessID(playerid) == INVALID_BUSINESS_ID) ? "-" : sBusinessLock);
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][87], 0.122000, 0.749629);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][87], 3);
	PlayerTextDrawColor(playerid, gptLogin[playerid][87], 16711935);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][87], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][87], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][87], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][87], 2);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][87], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][87], 0);

	gptLogin[playerid][88] = CreatePlayerTextDraw(playerid, 314.200012, 413.499847, "fundo stats car");
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][88], 0.000000, -18.635896);
	PlayerTextDrawTextSize(playerid, gptLogin[playerid][88], 450.135742, 0.000000);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][88], 1);
	PlayerTextDrawColor(playerid, gptLogin[playerid][88], -1);
	PlayerTextDrawUseBox(playerid, gptLogin[playerid][88], 1);
	PlayerTextDrawBoxColor(playerid, gptLogin[playerid][88], 43);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][88], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][88], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][88], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][88], 1);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][88], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][88], 0);

	gptLogin[playerid][89] = CreatePlayerTextDraw(playerid, 316.000000, 253.000122, "Nome:~n~~n~Versao:~n~~n~Jogadores cadastrados:~n~~n~Jogadores online:~n~~n~Membros da equipe online:~n~~n~Backups online:");
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][89], 0.122000, 0.749629);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][89], 1);
	PlayerTextDrawColor(playerid, gptLogin[playerid][89], -1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][89], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][89], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][89], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][89], 2);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][89], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][89], 0);

	gptLogin[playerid][90] = CreatePlayerTextDraw(playerid, 329.500152, 337.000000, "-");
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][90], 7.285999, -0.200296);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][90], 1);
	PlayerTextDrawColor(playerid, gptLogin[playerid][90], -1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][90], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][90], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][90], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][90], 1);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][90], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][90], 0);

	gptLogin[playerid][91] = CreatePlayerTextDraw(playerid, 316.700042, 341.800781, "Site:~n~~n~Forum:~n~~n~TS3:~n~~n~E-mail:~n~~n~Fan Page:");
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][91], 0.122000, 0.749629);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][91], 1);
	PlayerTextDrawColor(playerid, gptLogin[playerid][91], -1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][91], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][91], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][91], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][91], 2);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][91], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][91], 0);

	new sVersion[38];
	format(sVersion, sizeof(sVersion), "Paradise City RPG~n~~n~%s.%s%s~n~~n~%d", SCRIPT_VERSION_MAJOR, SCRIPT_VERSION_MINOR, SCRIPT_VERSION_PATCH, g_RegisteredPlayers);
	gptLogin[playerid][92] = CreatePlayerTextDraw(playerid, 448.400024, 253.000167, sVersion);
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][92], 0.122000, 0.749629);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][92], 3);
	PlayerTextDrawColor(playerid, gptLogin[playerid][92], -1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][92], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][92], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][92], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][92], 2);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][92], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][92], 0);

	new sOnlinePlayers[5];
	new online_players = 0;
	new online_admins = 0;
	new online_backups = 0;
	foreach(new i: Player)
	{
		if(GetPlayerRank(i) > PLAYER_RANK_PARADISER)
			online_admins++;
		else if(GetPlayerRank(i) == PLAYER_RANK_PARADISER)
			online_backups++;
		online_players++;
	}
	valstr(sOnlinePlayers, online_players);
	gptLogin[playerid][93] = CreatePlayerTextDraw(playerid, 449.900054, 294.100006, sOnlinePlayers); // Playerss
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][93], 0.122000, 0.749629);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][93], 3);
	PlayerTextDrawColor(playerid, gptLogin[playerid][93], 16711935);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][93], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][93], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][93], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][93], 2);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][93], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][93], 0);

	valstr(sOnlinePlayers, online_admins);
	gptLogin[playerid][94] = CreatePlayerTextDraw(playerid, 449.900054, 307.500823, sOnlinePlayers); // Admins
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][94], 0.122000, 0.749629);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][94], 3);
	PlayerTextDrawColor(playerid, gptLogin[playerid][94], 16711935);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][94], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][94], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][94], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][94], 2);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][94], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][94], 0);

	valstr(sOnlinePlayers, online_backups);
	gptLogin[playerid][95] = CreatePlayerTextDraw(playerid, 449.900054, 321.101654, sOnlinePlayers);// Backups
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][95], 0.122000, 0.749629);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][95], 3);
	PlayerTextDrawColor(playerid, gptLogin[playerid][95], 16711935);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][95], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][95], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][95], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][95], 2);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][95], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][95], 0);

	gptLogin[playerid][96] = CreatePlayerTextDraw(playerid, 448.300201, 341.730407, "pc-rpg.com~n~~n~forum.pc-rpg.com~n~~n~ts3.pc-rpg.com~n~~n~contato@pc-rpg.com~n~~n~facebook.com/paradisecityrpg");
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][96], 0.122000, 0.749629);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][96], 3);
	PlayerTextDrawColor(playerid, gptLogin[playerid][96], -1061109505);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][96], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][96], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][96], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][96], 2);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][96], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][96], 0);

	gptLogin[playerid][97] = CreatePlayerTextDraw(playerid, 324.666687, 63.022159, "sua empresa");
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][97], 0.154330, 0.874073);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][97], 1);
	PlayerTextDrawColor(playerid, gptLogin[playerid][97], -1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][97], 1);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][97], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][97], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][97], 3);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][97], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][97], 1);

	gptLogin[playerid][98] = CreatePlayerTextDraw(playerid, 324.833404, 235.985183, "servidor");
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][98], 0.154330, 0.874073);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][98], 1);
	PlayerTextDrawColor(playerid, gptLogin[playerid][98], -1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][98], 1);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][98], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][98], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][98], 3);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][98], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][98], 1);

	gptLogin[playerid][99] = CreatePlayerTextDraw(playerid, 314.100067, 236.100189, "fundo titulo server");
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][99], 0.000000, 0.974995);
	PlayerTextDrawTextSize(playerid, gptLogin[playerid][99], 450.099853, 0.000000);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][99], 1);
	PlayerTextDrawColor(playerid, gptLogin[playerid][99], -1);
	PlayerTextDrawUseBox(playerid, gptLogin[playerid][99], 1);
	PlayerTextDrawBoxColor(playerid, gptLogin[playerid][99], 50);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][99], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][99], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][99], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][99], 2);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][99], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][99], 0);

	gptLogin[playerid][100] = CreatePlayerTextDraw(playerid, 184.999969, 63.481456, "Seu carro");
    PlayerTextDrawLetterSize(playerid, gptLogin[playerid][100], 0.154332, 0.874073);
    PlayerTextDrawAlignment(playerid, gptLogin[playerid][100], 1);
    PlayerTextDrawColor(playerid, gptLogin[playerid][100], -1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][100], 1);
    PlayerTextDrawSetOutline(playerid, gptLogin[playerid][100], 0);
    PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][100], 255);
    PlayerTextDrawFont(playerid, gptLogin[playerid][100], 3);
    PlayerTextDrawSetProportional(playerid, gptLogin[playerid][100], 1);
    PlayerTextDrawSetShadow(playerid, gptLogin[playerid][100], 1);

	gptLogin[playerid][101] = CreatePlayerTextDraw(playerid, 313.599914, 235.099273, "fundo server");
	PlayerTextDrawLetterSize(playerid, gptLogin[playerid][101], 0.000000, 19.507417);
	PlayerTextDrawTextSize(playerid, gptLogin[playerid][101], 450.794006, 0.000000);
	PlayerTextDrawAlignment(playerid, gptLogin[playerid][101], 1);
	PlayerTextDrawColor(playerid, gptLogin[playerid][101], -1);
	PlayerTextDrawUseBox(playerid, gptLogin[playerid][101], 1);
	PlayerTextDrawBoxColor(playerid, gptLogin[playerid][101], 50);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][101], 0);
	PlayerTextDrawSetOutline(playerid, gptLogin[playerid][101], 0);
	PlayerTextDrawBackgroundColor(playerid, gptLogin[playerid][101], 255);
	PlayerTextDrawFont(playerid, gptLogin[playerid][101], 2);
	PlayerTextDrawSetProportional(playerid, gptLogin[playerid][101], 1);
	PlayerTextDrawSetShadow(playerid, gptLogin[playerid][101], 0);

    for (new i = 0; i < sizeof(gptLogin[]); i++)
	{
		if(!IsPlayerRegistered(playerid) && (i < 59 || i > 76))
			continue;
        PlayerTextDrawShow(playerid, gptLogin[playerid][i]);
	}

	if(!IsPlayerRegistered(playerid))
	{
		gptRegister[playerid][0] = CreatePlayerTextDraw(playerid, 23.199996, 62.300010, "fundo reg");
		PlayerTextDrawLetterSize(playerid, gptRegister[playerid][0], 0.000000, 38.702060);
		PlayerTextDrawTextSize(playerid, gptRegister[playerid][0], 455.189208, 0.000000);
		PlayerTextDrawAlignment(playerid, gptRegister[playerid][0], 1);
		PlayerTextDrawColor(playerid, gptRegister[playerid][0], -1);
		PlayerTextDrawUseBox(playerid, gptRegister[playerid][0], 1);
		PlayerTextDrawBoxColor(playerid, gptRegister[playerid][0], 50);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][0], 0);
		PlayerTextDrawSetOutline(playerid, gptRegister[playerid][0], 0);
		PlayerTextDrawBackgroundColor(playerid, gptRegister[playerid][0], 255);
		PlayerTextDrawFont(playerid, gptRegister[playerid][0], 2);
		PlayerTextDrawSetProportional(playerid, gptRegister[playerid][0], 1);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][0], 0);

		gptRegister[playerid][1] = CreatePlayerTextDraw(playerid, 24.000000, 78.199768, "fundo registro txt");
		PlayerTextDrawLetterSize(playerid, gptRegister[playerid][1], 0.000000, 36.822044);
		PlayerTextDrawTextSize(playerid, gptRegister[playerid][1], 454.553009, 0.000000);
		PlayerTextDrawAlignment(playerid, gptRegister[playerid][1], 1);
		PlayerTextDrawColor(playerid, gptRegister[playerid][1], -1);
		PlayerTextDrawUseBox(playerid, gptRegister[playerid][1], 1);
		PlayerTextDrawBoxColor(playerid, gptRegister[playerid][1], 50);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][1], 0);
		PlayerTextDrawSetOutline(playerid, gptRegister[playerid][1], 0);
		PlayerTextDrawBackgroundColor(playerid, gptRegister[playerid][1], 255);
		PlayerTextDrawFont(playerid, gptRegister[playerid][1], 2);
		PlayerTextDrawSetProportional(playerid, gptRegister[playerid][1], 1);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][1], 0);

		gptRegister[playerid][2] = CreatePlayerTextDraw(playerid, 24.000000, 63.199996, "fundo titulo registro");
		PlayerTextDrawLetterSize(playerid, gptRegister[playerid][2], 0.000000, 1.188704);
		PlayerTextDrawTextSize(playerid, gptRegister[playerid][2], 454.553009, 0.000000);
		PlayerTextDrawAlignment(playerid, gptRegister[playerid][2], 1);
		PlayerTextDrawColor(playerid, gptRegister[playerid][2], -1);
		PlayerTextDrawUseBox(playerid, gptRegister[playerid][2], 1);
		PlayerTextDrawBoxColor(playerid, gptRegister[playerid][2], 50);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][2], 0);
		PlayerTextDrawSetOutline(playerid, gptRegister[playerid][2], 0);
		PlayerTextDrawBackgroundColor(playerid, gptRegister[playerid][2], 255);
		PlayerTextDrawFont(playerid, gptRegister[playerid][2], 2);
		PlayerTextDrawSetProportional(playerid, gptRegister[playerid][2], 1);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][2], 0);

		gptRegister[playerid][3] = CreatePlayerTextDraw(playerid, 163.599975, 93.300010, "-");
		PlayerTextDrawLetterSize(playerid, gptRegister[playerid][3], 10.100001, 0.438517);
		PlayerTextDrawAlignment(playerid, gptRegister[playerid][3], 1);
		PlayerTextDrawColor(playerid, gptRegister[playerid][3], -1);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][3], 0);
		PlayerTextDrawSetOutline(playerid, gptRegister[playerid][3], 0);
		PlayerTextDrawBackgroundColor(playerid, gptRegister[playerid][3], 255);
		PlayerTextDrawFont(playerid, gptRegister[playerid][3], 1);
		PlayerTextDrawSetProportional(playerid, gptRegister[playerid][3], 1);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][3], 0);

		gptRegister[playerid][4] = CreatePlayerTextDraw(playerid, 42.200057, 56.399993, "");
		PlayerTextDrawLetterSize(playerid, gptRegister[playerid][4], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, gptRegister[playerid][4], -20.666658, 24.044450);
		PlayerTextDrawAlignment(playerid, gptRegister[playerid][4], 1);
		PlayerTextDrawColor(playerid, gptRegister[playerid][4], -1);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][4], 0);
		PlayerTextDrawSetOutline(playerid, gptRegister[playerid][4], 0);
		PlayerTextDrawBackgroundColor(playerid, gptRegister[playerid][4], 0);
		PlayerTextDrawFont(playerid, gptRegister[playerid][4], 5);
		PlayerTextDrawSetProportional(playerid, gptRegister[playerid][4], 0);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][4], 0);
		PlayerTextDrawSetPreviewModel(playerid, gptRegister[playerid][4], 1581);
		PlayerTextDrawSetPreviewRot(playerid, gptRegister[playerid][4], 0.000000, 0.000000, 180.000000, 1.000000);

		gptRegister[playerid][5] = CreatePlayerTextDraw(playerid, 44.000000, 65.000000, "PC:RPG - REGISTRO");
		PlayerTextDrawLetterSize(playerid, gptRegister[playerid][5], 0.156665, 0.741333);
		PlayerTextDrawAlignment(playerid, gptRegister[playerid][5], 1);
		PlayerTextDrawColor(playerid, gptRegister[playerid][5], -1);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][5], 1);
		PlayerTextDrawSetOutline(playerid, gptRegister[playerid][5], 0);
		PlayerTextDrawBackgroundColor(playerid, gptRegister[playerid][5], 255);
		PlayerTextDrawFont(playerid, gptRegister[playerid][5], 3);
		PlayerTextDrawSetProportional(playerid, gptRegister[playerid][5], 1);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][5], 1);

		gptRegister[playerid][6] = CreatePlayerTextDraw(playerid, 28.000000, 109.000000, "E uma grande satisfacao ter voce aqui! Muitas das horas do nosso dia e da nossa vida, passamos no trabalho deste servidor,");
		PlayerTextDrawLetterSize(playerid, gptRegister[playerid][6], 0.203333, 1.176887);
		PlayerTextDrawAlignment(playerid, gptRegister[playerid][6], 1);
		PlayerTextDrawColor(playerid, gptRegister[playerid][6], -1);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][6], 0);
		PlayerTextDrawSetOutline(playerid, gptRegister[playerid][6], 0);
		PlayerTextDrawBackgroundColor(playerid, gptRegister[playerid][6], 255);
		PlayerTextDrawFont(playerid, gptRegister[playerid][6], 1);
		PlayerTextDrawSetProportional(playerid, gptRegister[playerid][6], 1);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][6], 0);

		gptRegister[playerid][7] = CreatePlayerTextDraw(playerid, 180.000000, 82.000000, "Bem vindo ao PC:RPG");
		PlayerTextDrawLetterSize(playerid, gptRegister[playerid][7], 0.250999, 1.388443);
		PlayerTextDrawAlignment(playerid, gptRegister[playerid][7], 1);
		PlayerTextDrawColor(playerid, gptRegister[playerid][7], -5963521);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][7], 0);
		PlayerTextDrawSetOutline(playerid, gptRegister[playerid][7], 0);
		PlayerTextDrawBackgroundColor(playerid, gptRegister[playerid][7], 255);
		PlayerTextDrawFont(playerid, gptRegister[playerid][7], 2);
		PlayerTextDrawSetProportional(playerid, gptRegister[playerid][7], 1);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][7], 0);

		gptRegister[playerid][8] = CreatePlayerTextDraw(playerid, 31.300012, 118.899848, "por isso tentamos sempre fazer com que o tempo no mesmo seja, alem de divertido, muito agradavel, criando sempre um");
		PlayerTextDrawLetterSize(playerid, gptRegister[playerid][8], 0.203333, 1.176887);
		PlayerTextDrawAlignment(playerid, gptRegister[playerid][8], 1);
		PlayerTextDrawColor(playerid, gptRegister[playerid][8], -1);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][8], 0);
		PlayerTextDrawSetOutline(playerid, gptRegister[playerid][8], 0);
		PlayerTextDrawBackgroundColor(playerid, gptRegister[playerid][8], 255);
		PlayerTextDrawFont(playerid, gptRegister[playerid][8], 1);
		PlayerTextDrawSetProportional(playerid, gptRegister[playerid][8], 1);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][8], 0);

		gptRegister[playerid][9] = CreatePlayerTextDraw(playerid, 185.032882, 129.173706, "ambiente saudavel e amistoso.");
		PlayerTextDrawLetterSize(playerid, gptRegister[playerid][9], 0.203333, 1.176887);
		PlayerTextDrawAlignment(playerid, gptRegister[playerid][9], 1);
		PlayerTextDrawColor(playerid, gptRegister[playerid][9], -1);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][9], 0);
		PlayerTextDrawSetOutline(playerid, gptRegister[playerid][9], 0);
		PlayerTextDrawBackgroundColor(playerid, gptRegister[playerid][9], 255);
		PlayerTextDrawFont(playerid, gptRegister[playerid][9], 1);
		PlayerTextDrawSetProportional(playerid, gptRegister[playerid][9], 1);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][9], 0);

		gptRegister[playerid][10] = CreatePlayerTextDraw(playerid, 34.399978, 155.701400, "Este servidor possui regras pre-estabelecidas, elaboradas criteriosamente com a finalidade de instruir nossos membros a");
		PlayerTextDrawLetterSize(playerid, gptRegister[playerid][10], 0.203333, 1.176887);
		PlayerTextDrawAlignment(playerid, gptRegister[playerid][10], 1);
		PlayerTextDrawColor(playerid, gptRegister[playerid][10], -1);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][10], 0);
		PlayerTextDrawSetOutline(playerid, gptRegister[playerid][10], 0);
		PlayerTextDrawBackgroundColor(playerid, gptRegister[playerid][10], 255);
		PlayerTextDrawFont(playerid, gptRegister[playerid][10], 1);
		PlayerTextDrawSetProportional(playerid, gptRegister[playerid][10], 1);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][10], 0);

		gptRegister[playerid][11] = CreatePlayerTextDraw(playerid, 34.499992, 166.100006, "prestar o melhor nivel possivel de conduta e comportamento em pro da comunidade do PC:RPG. Apesar do rigoroso controle de");
		PlayerTextDrawLetterSize(playerid, gptRegister[playerid][11], 0.190332, 1.127110);
		PlayerTextDrawAlignment(playerid, gptRegister[playerid][11], 1);
		PlayerTextDrawColor(playerid, gptRegister[playerid][11], -1);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][11], 0);
		PlayerTextDrawSetOutline(playerid, gptRegister[playerid][11], 0);
		PlayerTextDrawBackgroundColor(playerid, gptRegister[playerid][11], 255);
		PlayerTextDrawFont(playerid, gptRegister[playerid][11], 1);
		PlayerTextDrawSetProportional(playerid, gptRegister[playerid][11], 1);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][11], 0);

		gptRegister[playerid][12] = CreatePlayerTextDraw(playerid, 34.399978, 177.302719, "conduta proposto pelas regras do servidor, o PC:RPG nao se responsabiliza por qualquer prejuizo, dano, vexame, injuria,");
		PlayerTextDrawLetterSize(playerid, gptRegister[playerid][12], 0.203333, 1.176887);
		PlayerTextDrawAlignment(playerid, gptRegister[playerid][12], 1);
		PlayerTextDrawColor(playerid, gptRegister[playerid][12], -1);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][12], 0);
		PlayerTextDrawSetOutline(playerid, gptRegister[playerid][12], 0);
		PlayerTextDrawBackgroundColor(playerid, gptRegister[playerid][12], 255);
		PlayerTextDrawFont(playerid, gptRegister[playerid][12], 1);
		PlayerTextDrawSetProportional(playerid, gptRegister[playerid][12], 1);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][12], 0);

		gptRegister[playerid][13] = CreatePlayerTextDraw(playerid, 34.399978, 187.788574, "calunia, sofrimento ou qualquer dano que venha a ser causado por regras pre-determinadas do servidor, assim como a relacao");
		PlayerTextDrawLetterSize(playerid, gptRegister[playerid][13], 0.194000, 1.131258);
		PlayerTextDrawAlignment(playerid, gptRegister[playerid][13], 1);
		PlayerTextDrawColor(playerid, gptRegister[playerid][13], -1);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][13], 0);
		PlayerTextDrawSetOutline(playerid, gptRegister[playerid][13], 0);
		PlayerTextDrawBackgroundColor(playerid, gptRegister[playerid][13], 255);
		PlayerTextDrawFont(playerid, gptRegister[playerid][13], 1);
		PlayerTextDrawSetProportional(playerid, gptRegister[playerid][13], 1);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][13], 0);

		gptRegister[playerid][14] = CreatePlayerTextDraw(playerid, 34.399978, 197.989196, "entre os usuarios, no entanto estamos a todo momento cuidando para que isso nao aconteca.");
		PlayerTextDrawLetterSize(playerid, gptRegister[playerid][14], 0.194000, 1.131258);
		PlayerTextDrawAlignment(playerid, gptRegister[playerid][14], 1);
		PlayerTextDrawColor(playerid, gptRegister[playerid][14], -1);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][14], 0);
		PlayerTextDrawSetOutline(playerid, gptRegister[playerid][14], 0);
		PlayerTextDrawBackgroundColor(playerid, gptRegister[playerid][14], 255);
		PlayerTextDrawFont(playerid, gptRegister[playerid][14], 1);
		PlayerTextDrawSetProportional(playerid, gptRegister[playerid][14], 1);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][14], 0);

		gptRegister[playerid][15] = CreatePlayerTextDraw(playerid, 24.000000, 106.099342, "fundo registro txt");
		PlayerTextDrawLetterSize(playerid, gptRegister[playerid][15], 0.000000, 4.159709);
		PlayerTextDrawTextSize(playerid, gptRegister[playerid][15], 454.420074, 0.000000);
		PlayerTextDrawAlignment(playerid, gptRegister[playerid][15], 1);
		PlayerTextDrawColor(playerid, gptRegister[playerid][15], -1);
		PlayerTextDrawUseBox(playerid, gptRegister[playerid][15], 1);
		PlayerTextDrawBoxColor(playerid, gptRegister[playerid][15], 50);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][15], 0);
		PlayerTextDrawSetOutline(playerid, gptRegister[playerid][15], 0);
		PlayerTextDrawBackgroundColor(playerid, gptRegister[playerid][15], 255);
		PlayerTextDrawFont(playerid, gptRegister[playerid][15], 2);
		PlayerTextDrawSetProportional(playerid, gptRegister[playerid][15], 1);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][15], 0);

		gptRegister[playerid][16] = CreatePlayerTextDraw(playerid, 23.966650, 335.410583, "fundo registro txt");
		PlayerTextDrawLetterSize(playerid, gptRegister[playerid][16], 0.000000, 8.259709);
		PlayerTextDrawTextSize(playerid, gptRegister[playerid][16], 454.053253, 0.000000);
		PlayerTextDrawAlignment(playerid, gptRegister[playerid][16], 1);
		PlayerTextDrawColor(playerid, gptRegister[playerid][16], -1);
		PlayerTextDrawUseBox(playerid, gptRegister[playerid][16], 1);
		PlayerTextDrawBoxColor(playerid, gptRegister[playerid][16], 50);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][16], 0);
		PlayerTextDrawSetOutline(playerid, gptRegister[playerid][16], 0);
		PlayerTextDrawBackgroundColor(playerid, gptRegister[playerid][16], 255);
		PlayerTextDrawFont(playerid, gptRegister[playerid][16], 2);
		PlayerTextDrawSetProportional(playerid, gptRegister[playerid][16], 1);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][16], 0);

		gptRegister[playerid][17] = CreatePlayerTextDraw(playerid, 210.666656, 335.899963, "Conecte-se");
		PlayerTextDrawLetterSize(playerid, gptRegister[playerid][17], 0.287666, 1.160295);
		PlayerTextDrawAlignment(playerid, gptRegister[playerid][17], 1);
		PlayerTextDrawColor(playerid, gptRegister[playerid][17], -5963521);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][17], 0);
		PlayerTextDrawSetOutline(playerid, gptRegister[playerid][17], 0);
		PlayerTextDrawBackgroundColor(playerid, gptRegister[playerid][17], 255);
		PlayerTextDrawFont(playerid, gptRegister[playerid][17], 2);
		PlayerTextDrawSetProportional(playerid, gptRegister[playerid][17], 1);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][17], 0);

		gptRegister[playerid][18] = CreatePlayerTextDraw(playerid, 24.833362, 347.826080, "Site:~n~~n~Forum:~n~~n~TS3:~n~~n~Fanpage:~n~~n~Twitter:~n~~n~Youtube:");
		PlayerTextDrawLetterSize(playerid, gptRegister[playerid][18], 0.166333, 0.629333);
		PlayerTextDrawAlignment(playerid, gptRegister[playerid][18], 1);
		PlayerTextDrawColor(playerid, gptRegister[playerid][18], -1);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][18], 0);
		PlayerTextDrawSetOutline(playerid, gptRegister[playerid][18], 0);
		PlayerTextDrawBackgroundColor(playerid, gptRegister[playerid][18], 255);
		PlayerTextDrawFont(playerid, gptRegister[playerid][18], 1);
		PlayerTextDrawSetProportional(playerid, gptRegister[playerid][18], 1);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][18], 0);

		gptRegister[playerid][19] = CreatePlayerTextDraw(playerid, 451.649963, 347.186798, "pc-rpg.com~n~~n~forum.pc-rpg.com~n~~n~ts3.pc-rpg.com~n~~n~facebook.com/paradisecityrpg~n~~n~p");
		PlayerTextDrawLetterSize(playerid, gptRegister[playerid][19], 0.166333, 0.629333);
		PlayerTextDrawAlignment(playerid, gptRegister[playerid][19], 3);
		PlayerTextDrawColor(playerid, gptRegister[playerid][19], -1061109505);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][19], 0);
		PlayerTextDrawSetOutline(playerid, gptRegister[playerid][19], 0);
		PlayerTextDrawBackgroundColor(playerid, gptRegister[playerid][19], 255);
		PlayerTextDrawFont(playerid, gptRegister[playerid][19], 1);
		PlayerTextDrawSetProportional(playerid, gptRegister[playerid][19], 1);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][19], 0);

		gptRegister[playerid][20] = CreatePlayerTextDraw(playerid, 454.882568, 392.575042, "twitter.com/paradisecityrpg");
		PlayerTextDrawLetterSize(playerid, gptRegister[playerid][20], 0.166333, 0.629333);
		PlayerTextDrawAlignment(playerid, gptRegister[playerid][20], 3);
		PlayerTextDrawColor(playerid, gptRegister[playerid][20], -1061109505);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][20], 0);
		PlayerTextDrawSetOutline(playerid, gptRegister[playerid][20], 0);
		PlayerTextDrawBackgroundColor(playerid, gptRegister[playerid][20], 255);
		PlayerTextDrawFont(playerid, gptRegister[playerid][20], 1);
		PlayerTextDrawSetProportional(playerid, gptRegister[playerid][20], 1);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][20], 0);

		gptRegister[playerid][21] = CreatePlayerTextDraw(playerid, 454.282714, 402.472625, "youtube.com/channel/UCGo6hd688I7PS3NzRa01yiw");
		PlayerTextDrawLetterSize(playerid, gptRegister[playerid][21], 0.166333, 0.629333);
		PlayerTextDrawAlignment(playerid, gptRegister[playerid][21], 3);
		PlayerTextDrawColor(playerid, gptRegister[playerid][21], -1061109505);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][21], 0);
		PlayerTextDrawSetOutline(playerid, gptRegister[playerid][21], 0);
		PlayerTextDrawBackgroundColor(playerid, gptRegister[playerid][21], 255);
		PlayerTextDrawFont(playerid, gptRegister[playerid][21], 1);
		PlayerTextDrawSetProportional(playerid, gptRegister[playerid][21], 1);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][21], 0);

		gptRegister[playerid][22] = CreatePlayerTextDraw(playerid, 71.000000, 319.000000, "Esperamos sinceramente que a sua experiencia conosco seja excelente e duradoura. Sinta-se muito bem acolhido.");
		PlayerTextDrawLetterSize(playerid, gptRegister[playerid][22], 0.182666, 0.853333);
		PlayerTextDrawAlignment(playerid, gptRegister[playerid][22], 1);
		PlayerTextDrawColor(playerid, gptRegister[playerid][22], -1);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][22], 0);
		PlayerTextDrawSetOutline(playerid, gptRegister[playerid][22], 0);
		PlayerTextDrawBackgroundColor(playerid, gptRegister[playerid][22], 255);
		PlayerTextDrawFont(playerid, gptRegister[playerid][22], 1);
		PlayerTextDrawSetProportional(playerid, gptRegister[playerid][22], 1);
		PlayerTextDrawSetShadow(playerid, gptRegister[playerid][22], 0);

		for (new i = 0; i < sizeof(gptRegister[]); i++)
			PlayerTextDrawShow(playerid, gptRegister[playerid][i]);
	}

	SelectTextDraw(playerid, 0x4d9de8ff);
	return 1;
}

//------------------------------------------------------------------------------

VSL_HidePlayerTextdraw(playerid)
{
    if(!gptIsVisible[playerid])
        return 1;

    for (new i = 0; i < sizeof(gptLogin[]); i++)
        PlayerTextDrawDestroy(playerid, gptLogin[playerid][i]);

	if(!IsPlayerRegistered(playerid))
	{
		for (new i = 0; i < sizeof(gptRegister[]); i++)
		{
        	PlayerTextDrawDestroy(playerid, gptRegister[playerid][i]);
		}
	}

	gptIsVisible[playerid] = false;
	CancelSelectTextDraw(playerid);
	return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
    gptIsVisible[playerid] = false;
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(_:clickedid == INVALID_TEXT_DRAW && gptIsVisible[playerid])
	{
		SelectTextDraw(playerid, 0x4d9de8ff);
	}
	return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
	if(!gptIsVisible[playerid])
		return 1;

    if(gptLogin[playerid][43] == playertextid)// right
    {
        if((gpSelectedVehicle[playerid]+1) > (gpTotalVehicles[playerid]-1))
            PlayErrorSound(playerid);
        else
        {
            gpSelectedVehicle[playerid]++;
            new i = gpSelectedVehicle[playerid];
            PlaySelectSound(playerid);

            new location[MAX_ZONE_NAME], Float:x, Float:y;
            GetDealershipVehicle2DPos(playerid, 0, x, y);
            Get2DZoneName(location, x, y);

            new sCarData[64];
            format(sCarData, sizeof(sCarData), "%s~n~~n~$%d~n~~n~%s~n~~n~", GetVehicleNameFromModel(GetDealershipVehicleModel(playerid, i)), GetDealershipVehicleFines(playerid, i), location);
            PlayerTextDrawSetString(playerid, gptLogin[playerid][36], sCarData);

            new sFuelStr[10];
            format(sFuelStr, sizeof(sFuelStr), "%.2f%%", GetDealershipVehicleFuel(playerid, i));
            PlayerTextDrawSetString(playerid, gptLogin[playerid][39], sFuelStr);

            new sHealthStr[10];
            format(sHealthStr, sizeof(sHealthStr), "%.d%%", GetDealershipVehicleHealth(playerid, i));
            PlayerTextDrawSetString(playerid, gptLogin[playerid][41], sHealthStr);

            new sVehiclesAmount[8];
            format(sVehiclesAmount, sizeof(sVehiclesAmount), "%i/%i", gpSelectedVehicle[playerid] + 1, gpTotalVehicles[playerid]);
            PlayerTextDrawSetString(playerid, gptLogin[playerid][44], sVehiclesAmount);

			new sVehicleDBID[4];
			valstr(sVehicleDBID, g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_DBID]);
			PlayerTextDrawSetString(playerid, gptLogin[playerid][45], sVehicleDBID);

			new color1, color2;
			GetDealershipVehicleColor(playerid, i, color1, color2);
			PlayerTextDrawSetPreviewModel(playerid, gptLogin[playerid][33], GetDealershipVehicleModel(playerid, i));
			PlayerTextDrawSetPreviewVehCol(playerid, gptLogin[playerid][33], color1, color2);
			PlayerTextDrawShow(playerid, gptLogin[playerid][33]);

        }
    }
    else if(gptLogin[playerid][35] == playertextid)// left
    {
        if((gpSelectedVehicle[playerid]-1) < 0)
            PlayErrorSound(playerid);
        else
        {
            gpSelectedVehicle[playerid]--;
            new i = gpSelectedVehicle[playerid];
            PlaySelectSound(playerid);

            new location[MAX_ZONE_NAME], Float:x, Float:y;
            GetDealershipVehicle2DPos(playerid, 0, x, y);
            Get2DZoneName(location, x, y);

            new sCarData[64];
            format(sCarData, sizeof(sCarData), "%s~n~~n~$%d~n~~n~%s~n~~n~", GetVehicleNameFromModel(GetDealershipVehicleModel(playerid, i)), GetDealershipVehicleFines(playerid, i), location);
            PlayerTextDrawSetString(playerid, gptLogin[playerid][36], sCarData);

            new sFuelStr[10];
            format(sFuelStr, sizeof(sFuelStr), "%.2f%%", GetDealershipVehicleFuel(playerid, i));
            PlayerTextDrawSetString(playerid, gptLogin[playerid][39], sFuelStr);

            new sHealthStr[10];
            format(sHealthStr, sizeof(sHealthStr), "%.d%%", GetDealershipVehicleHealth(playerid, i));
            PlayerTextDrawSetString(playerid, gptLogin[playerid][41], sHealthStr);

            new sVehiclesAmount[8];
            format(sVehiclesAmount, sizeof(sVehiclesAmount), "%i/%i", gpSelectedVehicle[playerid] + 1, gpTotalVehicles[playerid]);
            PlayerTextDrawSetString(playerid, gptLogin[playerid][44], sVehiclesAmount);

			new sVehicleDBID[4];
			valstr(sVehicleDBID, g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_DBID]);
			PlayerTextDrawSetString(playerid, gptLogin[playerid][45], sVehicleDBID);

			new color1, color2;
			GetDealershipVehicleColor(playerid, i, color1, color2);
			PlayerTextDrawSetPreviewModel(playerid, gptLogin[playerid][33], GetDealershipVehicleModel(playerid, i));
			PlayerTextDrawSetPreviewVehCol(playerid, gptLogin[playerid][33], color1, color2);
			PlayerTextDrawShow(playerid, gptLogin[playerid][33]);
        }
    }
	else if(gptLogin[playerid][61] == playertextid) // botao login
	{
		if(!IsPlayerRegistered(playerid))
		{
			PlayErrorSound(playerid);
			GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~r~~h~Essa conta nao esta~n~~r~registrada", 5000, 3);
			return 1;
		}

		if(GetPlayerLoginExpire(playerid) > 0)
		{
			PlayConfirmSound(playerid);
			ClearPlayerScreen(playerid);
			LoadPlayerAccount(playerid);
			VSL_HidePlayerTextdraw(playerid);
			SendClientMessage(playerid, COLOR_SUCCESS, "Conectado com sucesso!");
			return 1;
		}

		new	string[580 + MAX_PLAYER_NAME];
		format(string, sizeof(string),
			"{FFFFFF}Olá {00aeff}%s!\n\n{FFFFFF}Você já tem uma conta no {00aeff}Paradise City{FFFFFF}, faça login\ncom sua senha que você cadastrou no primeiro acesso.\
			\n{004747}=================================================\n{FFFFFF}Sua conta: \t\t\t\t{00aeff}%s\n{FFFFFF}Registrado: \t\t\t\t{00aeff}%s\n\
			{FFFFFF}Útimo login: \t\t\t\t{00aeff}%s\n\n{FFFFFF}Level: \t\t\t\t\t{00aeff}%d\n{FFFFFF}Sexo: \t\t\t\t\t{00aeff}%s\n{FFFFFF}Emprego atual: \t\t\t\t{00aeff}%s\n\
			{004747}=================================================\n{FFFFFF}Digite sua senha para log-in:\n",
			GetPlayerNamef(playerid), GetPlayerRankName(playerid, true), convertTimestamp(GetPlayerRegDataUnix(playerid)),
			(GetPlayerLastLoginUnix(playerid) == 0) ? "Nunca" : convertTimestamp(GetPlayerLastLoginUnix(playerid)),
			GetPlayerLevel(playerid), GetPlayerGenderName(playerid), GetJobName(GetPlayerJobID(playerid), true));

		PlaySelectSound(playerid);
		VSL_HidePlayerTextdraw(playerid);
	    ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login", string, "Login", "Sair");
	}
	else if(gptLogin[playerid][66] == playertextid) // botao registro
	{
		if(IsPlayerRegistered(playerid))
		{
			PlayErrorSound(playerid);
			GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~r~~h~Essa conta ja esta~n~~r~registrada", 5000, 3);
			return 1;
		}
		PlaySelectSound(playerid);
		VSL_HidePlayerTextdraw(playerid);
		ShowPlayerDialog(playerid, DIALOG_REGISTER_EMAIL, DIALOG_STYLE_INPUT, "Registrando Conta->Email", "{ffffff}Insira seu endereço de e-mail:", "Confirmar", "Sair");
	}
	else if(gptLogin[playerid][67] == playertextid) // botao ajuda
	{
		PlayErrorSound(playerid);
	}
	else if(gptLogin[playerid][68] == playertextid) // botao creditos
	{
		PlayErrorSound(playerid);
	}
    return 1;
}

hook OnGameModeInit()
{
    mysql_tquery(mysql, "SELECT * FROM `players`", "OnPlayerCount");
    return 1;
}

forward OnPlayerCount();
public OnPlayerCount()
{
	new rows, fields;
	cache_get_data(rows, fields, mysql);
	g_RegisteredPlayers = rows;
	return 1;
}
