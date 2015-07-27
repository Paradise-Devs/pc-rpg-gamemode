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
static Text:gTextDrawSpeedo[17];
static PlayerText:gPTextDrawSpeedo[MAX_PLAYERS][14];

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
        ShowSpeedoForPlayer(playerid);
    else if(oldstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_PASSENGER)
        HideSpeedoForPlayer(playerid);
    return 1;
}

//------------------------------------------------------------------------------

HideSpeedoForPlayer(playerid)
{
    if(!gpIsSpeedoVisible[playerid])
        return 1;

    gpIsSpeedoVisible[playerid] = false;
    for(new i = 0; i < sizeof(gTextDrawSpeedo); i++)
        TextDrawHideForPlayer(playerid, gTextDrawSpeedo[i]);

    for(new i = 0; i < sizeof(gPTextDrawSpeedo[]); i++)
        PlayerTextDrawDestroy(playerid, gPTextDrawSpeedo[playerid][i]);
    return 1;
}

//------------------------------------------------------------------------------

ShowSpeedoForPlayer(playerid)
{
    if(gpIsSpeedoVisible[playerid])
        return 1;

    new vehicleid = GetPlayerVehicleID(playerid);
    new color1, color2;
    GetVehicleColor(vehicleid, color1, color2);
    gPTextDrawSpeedo[playerid][0] = CreatePlayerTextDraw(playerid, 554.733154, 328.326416, "");
    PlayerTextDrawLetterSize(playerid, gPTextDrawSpeedo[playerid][0], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, gPTextDrawSpeedo[playerid][0], 57.000007, 85.851829);
    PlayerTextDrawAlignment(playerid, gPTextDrawSpeedo[playerid][0], 1);
    PlayerTextDrawColor(playerid, gPTextDrawSpeedo[playerid][0], -1);
    PlayerTextDrawSetShadow(playerid, gPTextDrawSpeedo[playerid][0], 0);
    PlayerTextDrawSetOutline(playerid, gPTextDrawSpeedo[playerid][0], 0);
    PlayerTextDrawBackgroundColor(playerid, gPTextDrawSpeedo[playerid][0], 0);
    PlayerTextDrawFont(playerid, gPTextDrawSpeedo[playerid][0], 5);
    PlayerTextDrawSetProportional(playerid, gPTextDrawSpeedo[playerid][0], 0);
    PlayerTextDrawSetShadow(playerid, gPTextDrawSpeedo[playerid][0], 0);
    PlayerTextDrawSetPreviewModel(playerid, gPTextDrawSpeedo[playerid][0], GetVehicleModel(vehicleid));
    PlayerTextDrawSetPreviewRot(playerid, gPTextDrawSpeedo[playerid][0], 0.000000, 0.000000, 90.000000, 1.000000);
    PlayerTextDrawSetPreviewVehCol(playerid, gPTextDrawSpeedo[playerid][0], color1, color2);

    gPTextDrawSpeedo[playerid][1] = CreatePlayerTextDraw(playerid, 582.200012, 387.125854, GetVehicleName(vehicleid));
    PlayerTextDrawLetterSize(playerid, gPTextDrawSpeedo[playerid][1], 0.102666, 0.919703);
    PlayerTextDrawAlignment(playerid, gPTextDrawSpeedo[playerid][1], 2);
    PlayerTextDrawColor(playerid, gPTextDrawSpeedo[playerid][1], -1);
    PlayerTextDrawSetShadow(playerid, gPTextDrawSpeedo[playerid][1], 0);
    PlayerTextDrawSetOutline(playerid, gPTextDrawSpeedo[playerid][1], 0);
    PlayerTextDrawBackgroundColor(playerid, gPTextDrawSpeedo[playerid][1], 255);
    PlayerTextDrawFont(playerid, gPTextDrawSpeedo[playerid][1], 2);
    PlayerTextDrawSetProportional(playerid, gPTextDrawSpeedo[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid, gPTextDrawSpeedo[playerid][1], 0);

    gPTextDrawSpeedo[playerid][2] = CreatePlayerTextDraw(playerid, 527.467041, 354.899993, "0");
    PlayerTextDrawLetterSize(playerid, gPTextDrawSpeedo[playerid][2], 0.488999, 3.205335);
    PlayerTextDrawAlignment(playerid, gPTextDrawSpeedo[playerid][2], 2);
    PlayerTextDrawColor(playerid, gPTextDrawSpeedo[playerid][2], -1);
    PlayerTextDrawSetShadow(playerid, gPTextDrawSpeedo[playerid][2], 1);
    PlayerTextDrawSetOutline(playerid, gPTextDrawSpeedo[playerid][2], 0);
    PlayerTextDrawBackgroundColor(playerid, gPTextDrawSpeedo[playerid][2], 255);
    PlayerTextDrawFont(playerid, gPTextDrawSpeedo[playerid][2], 2);
    PlayerTextDrawSetProportional(playerid, gPTextDrawSpeedo[playerid][2], 1);
    PlayerTextDrawSetShadow(playerid, gPTextDrawSpeedo[playerid][2], 1);

    new Float:fGasPercentage = GetVehicleFuel(vehicleid);
    fGasPercentage *= 0.53;
    fGasPercentage += 498.487945;
    gPTextDrawSpeedo[playerid][3] = CreatePlayerTextDraw(playerid, 501.143341, 402.000122, "gas");
    PlayerTextDrawLetterSize(playerid, gPTextDrawSpeedo[playerid][3], 0.000000, 0.673668);
    PlayerTextDrawTextSize(playerid, gPTextDrawSpeedo[playerid][3], fGasPercentage, 0.749999);// 551 max | 498 min | 1% = 1,88679
    PlayerTextDrawAlignment(playerid, gPTextDrawSpeedo[playerid][3], 1);
    PlayerTextDrawColor(playerid, gPTextDrawSpeedo[playerid][3], -1);
    PlayerTextDrawUseBox(playerid, gPTextDrawSpeedo[playerid][3], 1);
    PlayerTextDrawBoxColor(playerid, gPTextDrawSpeedo[playerid][3], 11927551);
    PlayerTextDrawSetShadow(playerid, gPTextDrawSpeedo[playerid][3], 77);
    PlayerTextDrawSetOutline(playerid, gPTextDrawSpeedo[playerid][3], 0);
    PlayerTextDrawBackgroundColor(playerid, gPTextDrawSpeedo[playerid][3], 255);
    PlayerTextDrawFont(playerid, gPTextDrawSpeedo[playerid][3], 1);
    PlayerTextDrawSetProportional(playerid, gPTextDrawSpeedo[playerid][3], 1);
    PlayerTextDrawSetShadow(playerid, gPTextDrawSpeedo[playerid][3], 77);

    new Float:health;
    GetVehicleHealth(vehicleid, health);
    new Float:fHealthPercentage = floatdiv(health, 10.0);
    fHealthPercentage *= 0.53;
    fHealthPercentage += 554.873291;
    gPTextDrawSpeedo[playerid][4] = CreatePlayerTextDraw(playerid, 557.499572, 402.000122, "dano");
    PlayerTextDrawLetterSize(playerid, gPTextDrawSpeedo[playerid][4], 0.000333, 0.704111);
    PlayerTextDrawTextSize(playerid, gPTextDrawSpeedo[playerid][4], fHealthPercentage, 0.749999);// 607 max | 554 min | 1% = 1,88679
    PlayerTextDrawAlignment(playerid, gPTextDrawSpeedo[playerid][4], 1);
    PlayerTextDrawColor(playerid, gPTextDrawSpeedo[playerid][4], -1);
    PlayerTextDrawUseBox(playerid, gPTextDrawSpeedo[playerid][4], 1);
    PlayerTextDrawBoxColor(playerid, gPTextDrawSpeedo[playerid][4], -5963616);
    PlayerTextDrawSetShadow(playerid, gPTextDrawSpeedo[playerid][4], 77);
    PlayerTextDrawSetOutline(playerid, gPTextDrawSpeedo[playerid][4], 0);
    PlayerTextDrawBackgroundColor(playerid, gPTextDrawSpeedo[playerid][4], 12648703);
    PlayerTextDrawFont(playerid, gPTextDrawSpeedo[playerid][4], 1);
    PlayerTextDrawSetProportional(playerid, gPTextDrawSpeedo[playerid][4], 1);
    PlayerTextDrawSetShadow(playerid, gPTextDrawSpeedo[playerid][4], 77);

    new sGas[9];
    format(sGas, sizeof(sGas), "%d%%", GetVehicleFuel(vehicleid));
    gPTextDrawSpeedo[playerid][5] = CreatePlayerTextDraw(playerid, 528.000000, 401.000000, sGas);
    PlayerTextDrawLetterSize(playerid, gPTextDrawSpeedo[playerid][5], 0.196333, 0.853333);
    PlayerTextDrawAlignment(playerid, gPTextDrawSpeedo[playerid][5], 2);
    PlayerTextDrawColor(playerid, gPTextDrawSpeedo[playerid][5], -1);
    PlayerTextDrawSetShadow(playerid, gPTextDrawSpeedo[playerid][5], 0);
    PlayerTextDrawSetOutline(playerid, gPTextDrawSpeedo[playerid][5], 0);
    PlayerTextDrawBackgroundColor(playerid, gPTextDrawSpeedo[playerid][5], 255);
    PlayerTextDrawFont(playerid, gPTextDrawSpeedo[playerid][5], 3);
    PlayerTextDrawSetProportional(playerid, gPTextDrawSpeedo[playerid][5], 1);
    PlayerTextDrawSetShadow(playerid, gPTextDrawSpeedo[playerid][5], 0);

    gPTextDrawSpeedo[playerid][6] = CreatePlayerTextDraw(playerid, 546.786193, 343.444488, "LD_POOL:BALL");
    PlayerTextDrawLetterSize(playerid, gPTextDrawSpeedo[playerid][6], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, gPTextDrawSpeedo[playerid][6], 5.333338, 6.622231);
    PlayerTextDrawAlignment(playerid, gPTextDrawSpeedo[playerid][6], 1);
    PlayerTextDrawColor(playerid, gPTextDrawSpeedo[playerid][6], -1);
    PlayerTextDrawSetShadow(playerid, gPTextDrawSpeedo[playerid][6], 0);
    PlayerTextDrawSetOutline(playerid, gPTextDrawSpeedo[playerid][6], 0);
    PlayerTextDrawBackgroundColor(playerid, gPTextDrawSpeedo[playerid][6], 255);
    PlayerTextDrawFont(playerid, gPTextDrawSpeedo[playerid][6], 4);
    PlayerTextDrawSetProportional(playerid, gPTextDrawSpeedo[playerid][6], 0);
    PlayerTextDrawSetShadow(playerid, gPTextDrawSpeedo[playerid][6], 0);

    gPTextDrawSpeedo[playerid][7] = CreatePlayerTextDraw(playerid, 500.000061, 414.400024, "motor");
    PlayerTextDrawLetterSize(playerid, gPTextDrawSpeedo[playerid][7], 0.000000, 0.709665);
    PlayerTextDrawTextSize(playerid, gPTextDrawSpeedo[playerid][7], 525.042175, 0.000000);
    PlayerTextDrawAlignment(playerid, gPTextDrawSpeedo[playerid][7], 1);
    PlayerTextDrawColor(playerid, gPTextDrawSpeedo[playerid][7], -1);
    PlayerTextDrawUseBox(playerid, gPTextDrawSpeedo[playerid][7], 1);
    PlayerTextDrawBoxColor(playerid, gPTextDrawSpeedo[playerid][7], 8388863);
    PlayerTextDrawSetShadow(playerid, gPTextDrawSpeedo[playerid][7], 0);
    PlayerTextDrawSetOutline(playerid, gPTextDrawSpeedo[playerid][7], 0);
    PlayerTextDrawBackgroundColor(playerid, gPTextDrawSpeedo[playerid][7], 255);
    PlayerTextDrawFont(playerid, gPTextDrawSpeedo[playerid][7], 1);
    PlayerTextDrawSetProportional(playerid, gPTextDrawSpeedo[playerid][7], 1);
    PlayerTextDrawSetShadow(playerid, gPTextDrawSpeedo[playerid][7], 0);

    gPTextDrawSpeedo[playerid][8] = CreatePlayerTextDraw(playerid, 528.196838, 414.400024, "janelas");
    PlayerTextDrawLetterSize(playerid, gPTextDrawSpeedo[playerid][8], 0.000000, 0.739665);
    PlayerTextDrawTextSize(playerid, gPTextDrawSpeedo[playerid][8], 553.065124, 0.000000);
    PlayerTextDrawAlignment(playerid, gPTextDrawSpeedo[playerid][8], 1);
    PlayerTextDrawColor(playerid, gPTextDrawSpeedo[playerid][8], -1);
    PlayerTextDrawUseBox(playerid, gPTextDrawSpeedo[playerid][8], 1);
    PlayerTextDrawBoxColor(playerid, gPTextDrawSpeedo[playerid][8], -1523963137);
    PlayerTextDrawSetShadow(playerid, gPTextDrawSpeedo[playerid][8], 0);
    PlayerTextDrawSetOutline(playerid, gPTextDrawSpeedo[playerid][8], 0);
    PlayerTextDrawBackgroundColor(playerid, gPTextDrawSpeedo[playerid][8], 255);
    PlayerTextDrawFont(playerid, gPTextDrawSpeedo[playerid][8], 1);
    PlayerTextDrawSetProportional(playerid, gPTextDrawSpeedo[playerid][8], 1);
    PlayerTextDrawSetShadow(playerid, gPTextDrawSpeedo[playerid][8], 0);

    gPTextDrawSpeedo[playerid][9] = CreatePlayerTextDraw(playerid, 556.090026, 414.400024, "farois");
    PlayerTextDrawLetterSize(playerid, gPTextDrawSpeedo[playerid][9], 0.000000, 0.709665);
    PlayerTextDrawTextSize(playerid, gPTextDrawSpeedo[playerid][9], 580.958312, 0.000000);
    PlayerTextDrawAlignment(playerid, gPTextDrawSpeedo[playerid][9], 1);
    PlayerTextDrawColor(playerid, gPTextDrawSpeedo[playerid][9], -1);
    PlayerTextDrawUseBox(playerid, gPTextDrawSpeedo[playerid][9], 1);
    PlayerTextDrawBoxColor(playerid, gPTextDrawSpeedo[playerid][9], 8388863);
    PlayerTextDrawSetShadow(playerid, gPTextDrawSpeedo[playerid][9], 0);
    PlayerTextDrawSetOutline(playerid, gPTextDrawSpeedo[playerid][9], 0);
    PlayerTextDrawBackgroundColor(playerid, gPTextDrawSpeedo[playerid][9], 255);
    PlayerTextDrawFont(playerid, gPTextDrawSpeedo[playerid][9], 1);
    PlayerTextDrawSetProportional(playerid, gPTextDrawSpeedo[playerid][9], 1);
    PlayerTextDrawSetShadow(playerid, gPTextDrawSpeedo[playerid][9], 0);

    gPTextDrawSpeedo[playerid][10] = CreatePlayerTextDraw(playerid, 583.983215, 414.400024, "portas");
    PlayerTextDrawLetterSize(playerid, gPTextDrawSpeedo[playerid][10], 0.000000, 0.711331);
    PlayerTextDrawTextSize(playerid, gPTextDrawSpeedo[playerid][10], 609.098754, 0.000000);
    PlayerTextDrawAlignment(playerid, gPTextDrawSpeedo[playerid][10], 1);
    PlayerTextDrawColor(playerid, gPTextDrawSpeedo[playerid][10], -1);
    PlayerTextDrawUseBox(playerid, gPTextDrawSpeedo[playerid][10], 1);
    PlayerTextDrawBoxColor(playerid, gPTextDrawSpeedo[playerid][10], -1523963137);
    PlayerTextDrawSetShadow(playerid, gPTextDrawSpeedo[playerid][10], 0);
    PlayerTextDrawSetOutline(playerid, gPTextDrawSpeedo[playerid][10], 0);
    PlayerTextDrawBackgroundColor(playerid, gPTextDrawSpeedo[playerid][10], 255);
    PlayerTextDrawFont(playerid, gPTextDrawSpeedo[playerid][10], 1);
    PlayerTextDrawSetProportional(playerid, gPTextDrawSpeedo[playerid][10], 1);
    PlayerTextDrawSetShadow(playerid, gPTextDrawSpeedo[playerid][10], 0);

    gPTextDrawSpeedo[playerid][11] = CreatePlayerTextDraw(playerid, 548.733215, 406.581542, "LD_POOL:BALL"); // Gas
    PlayerTextDrawLetterSize(playerid, gPTextDrawSpeedo[playerid][11], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, gPTextDrawSpeedo[playerid][11], 2.333338, -2.918508);
    PlayerTextDrawAlignment(playerid, gPTextDrawSpeedo[playerid][11], 1);
    PlayerTextDrawColor(playerid, gPTextDrawSpeedo[playerid][11], 16711935);
    PlayerTextDrawSetShadow(playerid, gPTextDrawSpeedo[playerid][11], 0);
    PlayerTextDrawSetOutline(playerid, gPTextDrawSpeedo[playerid][11], 0);
    PlayerTextDrawBackgroundColor(playerid, gPTextDrawSpeedo[playerid][11], 255);
    PlayerTextDrawFont(playerid, gPTextDrawSpeedo[playerid][11], 4);
    PlayerTextDrawSetProportional(playerid, gPTextDrawSpeedo[playerid][11], 0);
    PlayerTextDrawSetShadow(playerid, gPTextDrawSpeedo[playerid][11], 0);

    new sHealth[9];
    format(sHealth, sizeof(sHealth), "%.0f%%", floatdiv(health, 10.0));
    gPTextDrawSpeedo[playerid][12] = CreatePlayerTextDraw(playerid, 584.000000, 401.000000, sHealth);
    PlayerTextDrawLetterSize(playerid, gPTextDrawSpeedo[playerid][12], 0.196333, 0.853333);
    PlayerTextDrawAlignment(playerid, gPTextDrawSpeedo[playerid][12], 2);
    PlayerTextDrawColor(playerid, gPTextDrawSpeedo[playerid][12], -1);
    PlayerTextDrawSetShadow(playerid, gPTextDrawSpeedo[playerid][12], 0);
    PlayerTextDrawSetOutline(playerid, gPTextDrawSpeedo[playerid][12], 0);
    PlayerTextDrawBackgroundColor(playerid, gPTextDrawSpeedo[playerid][12], 255);
    PlayerTextDrawFont(playerid, gPTextDrawSpeedo[playerid][12], 3);
    PlayerTextDrawSetProportional(playerid, gPTextDrawSpeedo[playerid][12], 1);
    PlayerTextDrawSetShadow(playerid, gPTextDrawSpeedo[playerid][12], 0);

    gPTextDrawSpeedo[playerid][13] = CreatePlayerTextDraw(playerid, 604.453002, 406.581542, "LD_POOL:BALL"); // Health
    PlayerTextDrawLetterSize(playerid, gPTextDrawSpeedo[playerid][13], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, gPTextDrawSpeedo[playerid][13], 2.333338, -2.918508);
    PlayerTextDrawAlignment(playerid, gPTextDrawSpeedo[playerid][13], 1);
    PlayerTextDrawColor(playerid, gPTextDrawSpeedo[playerid][13], 16711935);
    PlayerTextDrawSetShadow(playerid, gPTextDrawSpeedo[playerid][13], 0);
    PlayerTextDrawSetOutline(playerid, gPTextDrawSpeedo[playerid][13], 0);
    PlayerTextDrawBackgroundColor(playerid, gPTextDrawSpeedo[playerid][13], 255);
    PlayerTextDrawFont(playerid, gPTextDrawSpeedo[playerid][13], 4);
    PlayerTextDrawSetProportional(playerid, gPTextDrawSpeedo[playerid][13], 0);
    PlayerTextDrawSetShadow(playerid, gPTextDrawSpeedo[playerid][13], 0);

    for(new i = 0; i < sizeof(gPTextDrawSpeedo[]); i++)
        PlayerTextDrawShow(playerid, gPTextDrawSpeedo[playerid][i]);

    for(new i = 0; i < sizeof(gTextDrawSpeedo); i++)
        TextDrawShowForPlayer(playerid, gTextDrawSpeedo[i]);

    gpIsSpeedoVisible[playerid] = true;
    return 1;
}

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
    gTextDrawSpeedo[0] = TextDrawCreate(612.766174, 341.081695, "box");
    TextDrawLetterSize(gTextDrawSpeedo[0], 0.000000, 9.000012);
    TextDrawTextSize(gTextDrawSpeedo[0], 496.231231, 0.000000);
    TextDrawAlignment(gTextDrawSpeedo[0], 1);
    TextDrawColor(gTextDrawSpeedo[0], -1);
    TextDrawUseBox(gTextDrawSpeedo[0], 1);
    TextDrawBoxColor(gTextDrawSpeedo[0], 40);
    TextDrawSetShadow(gTextDrawSpeedo[0], 0);
    TextDrawSetOutline(gTextDrawSpeedo[0], 0);
    TextDrawBackgroundColor(gTextDrawSpeedo[0], 255);
    TextDrawFont(gTextDrawSpeedo[0], 1);
    TextDrawSetProportional(gTextDrawSpeedo[0], 1);
    TextDrawSetShadow(gTextDrawSpeedo[0], 0);

    gTextDrawSpeedo[1] = TextDrawCreate(499.733489, 342.396545, "box");
    TextDrawLetterSize(gTextDrawSpeedo[1], 0.000000, 7.531681);
    TextDrawTextSize(gTextDrawSpeedo[1], 553.103515, 0.000000);
    TextDrawAlignment(gTextDrawSpeedo[1], 1);
    TextDrawColor(gTextDrawSpeedo[1], -1);
    TextDrawUseBox(gTextDrawSpeedo[1], 1);
    TextDrawBoxColor(gTextDrawSpeedo[1], 40);
    TextDrawSetShadow(gTextDrawSpeedo[1], 0);
    TextDrawSetOutline(gTextDrawSpeedo[1], 0);
    TextDrawBackgroundColor(gTextDrawSpeedo[1], 255);
    TextDrawFont(gTextDrawSpeedo[1], 1);
    TextDrawSetProportional(gTextDrawSpeedo[1], 1);
    TextDrawSetShadow(gTextDrawSpeedo[1], 0);

    gTextDrawSpeedo[2] = TextDrawCreate(556.066284, 342.696533, "box");
    TextDrawLetterSize(gTextDrawSpeedo[2], 0.000000, 7.503683);
    TextDrawTextSize(gTextDrawSpeedo[2], 609.102966, 0.000000);
    TextDrawAlignment(gTextDrawSpeedo[2], 1);
    TextDrawColor(gTextDrawSpeedo[2], -1);
    TextDrawUseBox(gTextDrawSpeedo[2], 1);
    TextDrawBoxColor(gTextDrawSpeedo[2], 40);
    TextDrawSetShadow(gTextDrawSpeedo[2], 0);
    TextDrawSetOutline(gTextDrawSpeedo[2], 0);
    TextDrawBackgroundColor(gTextDrawSpeedo[2], 255);
    TextDrawFont(gTextDrawSpeedo[2], 1);
    TextDrawSetProportional(gTextDrawSpeedo[2], 1);
    TextDrawSetShadow(gTextDrawSpeedo[2], 0);

    gTextDrawSpeedo[3] = TextDrawCreate(556.699768, 400.900054, "box");
    TextDrawLetterSize(gTextDrawSpeedo[3], 0.000000, 0.916666);
    TextDrawTextSize(gTextDrawSpeedo[3], 608.431152, 0.000000);
    TextDrawAlignment(gTextDrawSpeedo[3], 1);
    TextDrawColor(gTextDrawSpeedo[3], -1);
    TextDrawUseBox(gTextDrawSpeedo[3], 1);
    TextDrawBoxColor(gTextDrawSpeedo[3], 67);
    TextDrawSetShadow(gTextDrawSpeedo[3], 77);
    TextDrawSetOutline(gTextDrawSpeedo[3], 0);
    TextDrawBackgroundColor(gTextDrawSpeedo[3], 255);
    TextDrawFont(gTextDrawSpeedo[3], 1);
    TextDrawSetProportional(gTextDrawSpeedo[3], 1);
    TextDrawSetShadow(gTextDrawSpeedo[3], 77);

    gTextDrawSpeedo[4] = TextDrawCreate(554.933471, 380.800201, ".");
    TextDrawLetterSize(gTextDrawSpeedo[4], 5.012997, 0.355555);
    TextDrawAlignment(gTextDrawSpeedo[4], 1);
    TextDrawColor(gTextDrawSpeedo[4], 82);
    TextDrawSetShadow(gTextDrawSpeedo[4], 0);
    TextDrawSetOutline(gTextDrawSpeedo[4], 0);
    TextDrawBackgroundColor(gTextDrawSpeedo[4], 255);
    TextDrawFont(gTextDrawSpeedo[4], 1);
    TextDrawSetProportional(gTextDrawSpeedo[4], 1);
    TextDrawSetShadow(gTextDrawSpeedo[4], 0);

    gTextDrawSpeedo[5] = TextDrawCreate(499.235595, 380.800201, ".");
    TextDrawLetterSize(gTextDrawSpeedo[5], 5.012997, 0.355555);
    TextDrawAlignment(gTextDrawSpeedo[5], 1);
    TextDrawColor(gTextDrawSpeedo[5], 82);
    TextDrawSetShadow(gTextDrawSpeedo[5], 0);
    TextDrawSetOutline(gTextDrawSpeedo[5], 0);
    TextDrawBackgroundColor(gTextDrawSpeedo[5], 255);
    TextDrawFont(gTextDrawSpeedo[5], 1);
    TextDrawSetProportional(gTextDrawSpeedo[5], 1);
    TextDrawSetShadow(gTextDrawSpeedo[5], 0);

    gTextDrawSpeedo[6] = TextDrawCreate(522.699951, 384.648437, "km/h");
    TextDrawLetterSize(gTextDrawSpeedo[6], 0.113333, 0.791111);
    TextDrawAlignment(gTextDrawSpeedo[6], 1);
    TextDrawColor(gTextDrawSpeedo[6], -2139062017);
    TextDrawSetShadow(gTextDrawSpeedo[6], 0);
    TextDrawSetOutline(gTextDrawSpeedo[6], 0);
    TextDrawBackgroundColor(gTextDrawSpeedo[6], 255);
    TextDrawFont(gTextDrawSpeedo[6], 1);
    TextDrawSetProportional(gTextDrawSpeedo[6], 1);
    TextDrawSetShadow(gTextDrawSpeedo[6], 0);

    gTextDrawSpeedo[7] = TextDrawCreate(500.609985, 400.900054, "box");
    TextDrawLetterSize(gTextDrawSpeedo[7], 0.000000, 0.783333);
    TextDrawTextSize(gTextDrawSpeedo[7], 552.432189, 0.000000);
    TextDrawAlignment(gTextDrawSpeedo[7], 1);
    TextDrawColor(gTextDrawSpeedo[7], -1);
    TextDrawUseBox(gTextDrawSpeedo[7], 1);
    TextDrawBoxColor(gTextDrawSpeedo[7], 67);
    TextDrawSetShadow(gTextDrawSpeedo[7], 77);
    TextDrawSetOutline(gTextDrawSpeedo[7], 0);
    TextDrawBackgroundColor(gTextDrawSpeedo[7], 255);
    TextDrawFont(gTextDrawSpeedo[7], 1);
    TextDrawSetProportional(gTextDrawSpeedo[7], 1);
    TextDrawSetShadow(gTextDrawSpeedo[7], 77);

    gTextDrawSpeedo[8] = TextDrawCreate(501.143341, 401.914916, "box");
    TextDrawLetterSize(gTextDrawSpeedo[8], 0.000000, 0.674002);
    TextDrawTextSize(gTextDrawSpeedo[8], 551.870056, 0.000000);
    TextDrawAlignment(gTextDrawSpeedo[8], 1);
    TextDrawColor(gTextDrawSpeedo[8], -114);
    TextDrawUseBox(gTextDrawSpeedo[8], 1);
    TextDrawBoxColor(gTextDrawSpeedo[8], 12386171);
    TextDrawSetShadow(gTextDrawSpeedo[8], 77);
    TextDrawSetOutline(gTextDrawSpeedo[8], 0);
    TextDrawBackgroundColor(gTextDrawSpeedo[8], 255);
    TextDrawFont(gTextDrawSpeedo[8], 1);
    TextDrawSetProportional(gTextDrawSpeedo[8], 1);
    TextDrawSetShadow(gTextDrawSpeedo[8], 77);

    gTextDrawSpeedo[9] = TextDrawCreate(557.499572, 402.000122, "box");
    TextDrawLetterSize(gTextDrawSpeedo[9], 0.000000, 0.740000);
    TextDrawTextSize(gTextDrawSpeedo[9], 607.893310, 0.000000);
    TextDrawAlignment(gTextDrawSpeedo[9], 1);
    TextDrawColor(gTextDrawSpeedo[9], -1);
    TextDrawUseBox(gTextDrawSpeedo[9], 1);
    TextDrawBoxColor(gTextDrawSpeedo[9], -5963670);
    TextDrawSetShadow(gTextDrawSpeedo[9], 77);
    TextDrawSetOutline(gTextDrawSpeedo[9], 0);
    TextDrawBackgroundColor(gTextDrawSpeedo[9], 12648703);
    TextDrawFont(gTextDrawSpeedo[9], 1);
    TextDrawSetProportional(gTextDrawSpeedo[9], 1);
    TextDrawSetShadow(gTextDrawSpeedo[9], 77);

    gTextDrawSpeedo[10] = TextDrawCreate(556.733032, 399.129577, "");
    TextDrawLetterSize(gTextDrawSpeedo[10], 0.000000, 0.000000);
    TextDrawTextSize(gTextDrawSpeedo[10], 8.333339, 11.185173);
    TextDrawAlignment(gTextDrawSpeedo[10], 1);
    TextDrawColor(gTextDrawSpeedo[10], -1);
    TextDrawSetShadow(gTextDrawSpeedo[10], 0);
    TextDrawSetOutline(gTextDrawSpeedo[10], 0);
    TextDrawBackgroundColor(gTextDrawSpeedo[10], 0);
    TextDrawFont(gTextDrawSpeedo[10], 5);
    TextDrawSetProportional(gTextDrawSpeedo[10], 0);
    TextDrawSetShadow(gTextDrawSpeedo[10], 0);
    TextDrawSetPreviewModel(gTextDrawSpeedo[10], 1240);
    TextDrawSetPreviewRot(gTextDrawSpeedo[10], 0.000000, 0.000000, 0.000000, 1.000000);

    gTextDrawSpeedo[11] = TextDrawCreate(498.899658, 400.329772, "");
    TextDrawLetterSize(gTextDrawSpeedo[11], 0.000000, 0.000000);
    TextDrawTextSize(gTextDrawSpeedo[11], 8.999996, 9.525929);
    TextDrawAlignment(gTextDrawSpeedo[11], 1);
    TextDrawColor(gTextDrawSpeedo[11], -1);
    TextDrawSetShadow(gTextDrawSpeedo[11], 0);
    TextDrawSetOutline(gTextDrawSpeedo[11], 0);
    TextDrawBackgroundColor(gTextDrawSpeedo[11], 0);
    TextDrawFont(gTextDrawSpeedo[11], 5);
    TextDrawSetProportional(gTextDrawSpeedo[11], 0);
    TextDrawSetShadow(gTextDrawSpeedo[11], 0);
    TextDrawSetPreviewModel(gTextDrawSpeedo[11], 1676);
    TextDrawSetPreviewRot(gTextDrawSpeedo[11], 0.000000, 0.000000, 0.000000, 1.000000);

    gTextDrawSpeedo[12] = TextDrawCreate(611.716735, 414.400024, "fx stats");
    TextDrawLetterSize(gTextDrawSpeedo[12], 0.000000, 0.110331);
    TextDrawTextSize(gTextDrawSpeedo[12], 497.271514, 0.000000);
    TextDrawAlignment(gTextDrawSpeedo[12], 1);
    TextDrawColor(gTextDrawSpeedo[12], -1);
    TextDrawUseBox(gTextDrawSpeedo[12], 1);
    TextDrawBoxColor(gTextDrawSpeedo[12], -226);
    TextDrawSetShadow(gTextDrawSpeedo[12], 0);
    TextDrawSetOutline(gTextDrawSpeedo[12], 0);
    TextDrawBackgroundColor(gTextDrawSpeedo[12], 255);
    TextDrawFont(gTextDrawSpeedo[12], 1);
    TextDrawSetProportional(gTextDrawSpeedo[12], 1);
    TextDrawSetShadow(gTextDrawSpeedo[12], 0);

    gTextDrawSpeedo[13] = TextDrawCreate(511.867065, 414.400024, "motor");
    TextDrawLetterSize(gTextDrawSpeedo[13], 0.117000, 0.637629);
    TextDrawAlignment(gTextDrawSpeedo[13], 2);
    TextDrawColor(gTextDrawSpeedo[13], -1);
    TextDrawSetShadow(gTextDrawSpeedo[13], 0);
    TextDrawSetOutline(gTextDrawSpeedo[13], 0);
    TextDrawBackgroundColor(gTextDrawSpeedo[13], 255);
    TextDrawFont(gTextDrawSpeedo[13], 2);
    TextDrawSetProportional(gTextDrawSpeedo[13], 1);
    TextDrawSetShadow(gTextDrawSpeedo[13], 0);

    gTextDrawSpeedo[14] = TextDrawCreate(540.460021, 414.400024, "janelas");
    TextDrawLetterSize(gTextDrawSpeedo[14], 0.117000, 0.637629);
    TextDrawAlignment(gTextDrawSpeedo[14], 2);
    TextDrawColor(gTextDrawSpeedo[14], -1);
    TextDrawSetShadow(gTextDrawSpeedo[14], 0);
    TextDrawSetOutline(gTextDrawSpeedo[14], 0);
    TextDrawBackgroundColor(gTextDrawSpeedo[14], 255);
    TextDrawFont(gTextDrawSpeedo[14], 2);
    TextDrawSetProportional(gTextDrawSpeedo[14], 1);
    TextDrawSetShadow(gTextDrawSpeedo[14], 0);

    gTextDrawSpeedo[15] = TextDrawCreate(560.021545, 414.400024, "farois");
    TextDrawLetterSize(gTextDrawSpeedo[15], 0.117000, 0.637629);
    TextDrawAlignment(gTextDrawSpeedo[15], 1);
    TextDrawColor(gTextDrawSpeedo[15], -1);
    TextDrawSetShadow(gTextDrawSpeedo[15], 0);
    TextDrawSetOutline(gTextDrawSpeedo[15], 0);
    TextDrawBackgroundColor(gTextDrawSpeedo[15], 255);
    TextDrawFont(gTextDrawSpeedo[15], 2);
    TextDrawSetProportional(gTextDrawSpeedo[15], 1);
    TextDrawSetShadow(gTextDrawSpeedo[15], 0);

    gTextDrawSpeedo[16] = TextDrawCreate(587.714782, 414.400024, "portas");
    TextDrawLetterSize(gTextDrawSpeedo[16], 0.117000, 0.637629);
    TextDrawAlignment(gTextDrawSpeedo[16], 1);
    TextDrawColor(gTextDrawSpeedo[16], -1);
    TextDrawSetShadow(gTextDrawSpeedo[16], 0);
    TextDrawSetOutline(gTextDrawSpeedo[16], 0);
    TextDrawBackgroundColor(gTextDrawSpeedo[16], 255);
    TextDrawFont(gTextDrawSpeedo[16], 2);
    TextDrawSetProportional(gTextDrawSpeedo[16], 1);
    TextDrawSetShadow(gTextDrawSpeedo[16], 0);
    return 1;
}
