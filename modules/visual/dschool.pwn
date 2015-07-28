/*******************************************************************************
* FILENAME :        modules/visual/dschool.pwn
*
* DESCRIPTION :
*       Create/Destroy and Show driving school GUI functions.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

static PlayerText:gpTextDrawSub[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...};
static PlayerText:gplTextDrawCerti[MAX_PLAYERS][16];
static bool:gplIsCertificationVisible[MAX_PLAYERS];
static Text:gDrivingSchoolTV[21];
static bool:gplIsTelevisionVisible[MAX_PLAYERS];
static gplSelection[MAX_PLAYERS];

//------------------------------------------------------------------------------

CreatePlayerSubtitle(playerid, text[])
{
    if(gpTextDrawSub[playerid] != PlayerText:INVALID_TEXT_DRAW)
        return 1;

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
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(!gplIsTelevisionVisible[playerid])
        return 1;

    if(newkeys == KEY_SECONDARY_ATTACK)
    {
        HidePlayerSchoolTV(playerid);
        SetPlayerPos(playerid, -2029.8218, -119.1891, 1035.1719);
        SetPlayerFacingAngle(playerid, 0.0);
        SetPlayerInterior(playerid, 3);
        SetPlayerVirtualWorld(playerid, 0);
        SetCameraBehindPlayer(playerid);
        DestroyAutoSchoolObject(playerid);
    }
    else if(newkeys == KEY_SPRINT)
    {
        OnPlayerSelectSchoolTest(playerid, gplSelection[playerid]);
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
    gpTextDrawSub[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gplIsTelevisionVisible[playerid] = false;
    return 1;
}

//------------------------------------------------------------------------------

HidePlayerSchoolTV(playerid)
{
    if(!gplIsTelevisionVisible[playerid])
        return 1;

    gplIsTelevisionVisible[playerid] = false;
    TogglePlayerSpectating(playerid, false);
    PlayerPlaySound(playerid, 1188, 0.0, 0.0, 0.0);

    ShowPlayerClock(playerid);
    for(new i = 0; i < sizeof(gDrivingSchoolTV); i++)
        TextDrawHideForPlayer(playerid, gDrivingSchoolTV[i]);
    return 1;
}

//------------------------------------------------------------------------------

HidePlayerCertification(playerid)
{
    if(!gplIsCertificationVisible[playerid])
        return 1;

    gplIsCertificationVisible[playerid] = false;

    for(new i = 0; i < sizeof(gplTextDrawCerti[]); i++)
        PlayerTextDrawDestroy(playerid, gplTextDrawCerti[playerid][i]);
    return 1;
}

//------------------------------------------------------------------------------

ShowPlayerCertification(playerid)
{
    if(gplIsCertificationVisible[playerid])
        return 1;

    gplIsCertificationVisible[playerid] = true;
    gplTextDrawCerti[playerid][0] = CreatePlayerTextDraw(playerid, 189.999969, 171.748153, "box");
    PlayerTextDrawLetterSize(playerid, gplTextDrawCerti[playerid][0], 0.000000, 19.200000);
    PlayerTextDrawTextSize(playerid, gplTextDrawCerti[playerid][0], 446.999938, 0.000000);
    PlayerTextDrawAlignment(playerid, gplTextDrawCerti[playerid][0], 1);
    PlayerTextDrawColor(playerid, gplTextDrawCerti[playerid][0], -1);
    PlayerTextDrawUseBox(playerid, gplTextDrawCerti[playerid][0], 1);
    PlayerTextDrawBoxColor(playerid, gplTextDrawCerti[playerid][0], 76);
    PlayerTextDrawSetShadow(playerid, gplTextDrawCerti[playerid][0], 0);
    PlayerTextDrawSetOutline(playerid, gplTextDrawCerti[playerid][0], 0);
    PlayerTextDrawBackgroundColor(playerid, gplTextDrawCerti[playerid][0], 255);
    PlayerTextDrawFont(playerid, gplTextDrawCerti[playerid][0], 2);
    PlayerTextDrawSetProportional(playerid, gplTextDrawCerti[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid, gplTextDrawCerti[playerid][0], 0);

    gplTextDrawCerti[playerid][1] = CreatePlayerTextDraw(playerid, 165.533096, 75.096305, "OBTEVE NOVO CERTIFICADO");
    PlayerTextDrawLetterSize(playerid, gplTextDrawCerti[playerid][1], 0.705333, 2.404740);
    PlayerTextDrawAlignment(playerid, gplTextDrawCerti[playerid][1], 1);
    PlayerTextDrawColor(playerid, gplTextDrawCerti[playerid][1], -1653005057);
    PlayerTextDrawSetShadow(playerid, gplTextDrawCerti[playerid][1], 1);
    PlayerTextDrawSetOutline(playerid, gplTextDrawCerti[playerid][1], 1);
    PlayerTextDrawBackgroundColor(playerid, gplTextDrawCerti[playerid][1], 255);
    PlayerTextDrawFont(playerid, gplTextDrawCerti[playerid][1], 3);
    PlayerTextDrawSetProportional(playerid, gplTextDrawCerti[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid, gplTextDrawCerti[playerid][1], 1);

    gplTextDrawCerti[playerid][2] = CreatePlayerTextDraw(playerid, 318.000030, 105.792610, "NOVO RECORDE");
    PlayerTextDrawLetterSize(playerid, gplTextDrawCerti[playerid][2], 0.705333, 2.404740);
    PlayerTextDrawAlignment(playerid, gplTextDrawCerti[playerid][2], 2);
    PlayerTextDrawColor(playerid, gplTextDrawCerti[playerid][2], -1);
    PlayerTextDrawSetShadow(playerid, gplTextDrawCerti[playerid][2], 1);
    PlayerTextDrawSetOutline(playerid, gplTextDrawCerti[playerid][2], 1);
    PlayerTextDrawBackgroundColor(playerid, gplTextDrawCerti[playerid][2], 255);
    PlayerTextDrawFont(playerid, gplTextDrawCerti[playerid][2], 3);
    PlayerTextDrawSetProportional(playerid, gplTextDrawCerti[playerid][2], 1);
    PlayerTextDrawSetShadow(playerid, gplTextDrawCerti[playerid][2], 1);

    gplTextDrawCerti[playerid][3] = CreatePlayerTextDraw(playerid, 328.333374, 147.692550, "LD_DRV:ribb");
    PlayerTextDrawLetterSize(playerid, gplTextDrawCerti[playerid][3], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, gplTextDrawCerti[playerid][3], 64.999984, 45.614830);
    PlayerTextDrawAlignment(playerid, gplTextDrawCerti[playerid][3], 1);
    PlayerTextDrawColor(playerid, gplTextDrawCerti[playerid][3], -1);
    PlayerTextDrawSetShadow(playerid, gplTextDrawCerti[playerid][3], 0);
    PlayerTextDrawSetOutline(playerid, gplTextDrawCerti[playerid][3], 0);
    PlayerTextDrawBackgroundColor(playerid, gplTextDrawCerti[playerid][3], 255);
    PlayerTextDrawFont(playerid, gplTextDrawCerti[playerid][3], 4);
    PlayerTextDrawSetProportional(playerid, gplTextDrawCerti[playerid][3], 0);
    PlayerTextDrawSetShadow(playerid, gplTextDrawCerti[playerid][3], 0);

    gplTextDrawCerti[playerid][4] = CreatePlayerTextDraw(playerid, 328.333374, 147.592544, "LD_DRV:ribb");
    PlayerTextDrawLetterSize(playerid, gplTextDrawCerti[playerid][4], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, gplTextDrawCerti[playerid][4], -84.666671, 45.614822);
    PlayerTextDrawAlignment(playerid, gplTextDrawCerti[playerid][4], 1);
    PlayerTextDrawColor(playerid, gplTextDrawCerti[playerid][4], -1);
    PlayerTextDrawSetShadow(playerid, gplTextDrawCerti[playerid][4], 0);
    PlayerTextDrawSetOutline(playerid, gplTextDrawCerti[playerid][4], 0);
    PlayerTextDrawBackgroundColor(playerid, gplTextDrawCerti[playerid][4], 255);
    PlayerTextDrawFont(playerid, gplTextDrawCerti[playerid][4], 4);
    PlayerTextDrawSetProportional(playerid, gplTextDrawCerti[playerid][4], 0);
    PlayerTextDrawSetShadow(playerid, gplTextDrawCerti[playerid][4], 0);

    gplTextDrawCerti[playerid][5] = CreatePlayerTextDraw(playerid, 283.333343, 134.674102, "ld_drv:gold");
    PlayerTextDrawLetterSize(playerid, gplTextDrawCerti[playerid][5], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, gplTextDrawCerti[playerid][5], 71.666671, 75.896278);
    PlayerTextDrawAlignment(playerid, gplTextDrawCerti[playerid][5], 1);
    PlayerTextDrawColor(playerid, gplTextDrawCerti[playerid][5], -1);
    PlayerTextDrawSetShadow(playerid, gplTextDrawCerti[playerid][5], 0);
    PlayerTextDrawSetOutline(playerid, gplTextDrawCerti[playerid][5], 0);
    PlayerTextDrawBackgroundColor(playerid, gplTextDrawCerti[playerid][5], 255);
    PlayerTextDrawFont(playerid, gplTextDrawCerti[playerid][5], 4);
    PlayerTextDrawSetProportional(playerid, gplTextDrawCerti[playerid][5], 0);
    PlayerTextDrawSetShadow(playerid, gplTextDrawCerti[playerid][5], 0);

    gplTextDrawCerti[playerid][6] = CreatePlayerTextDraw(playerid, 203.333312, 216.548126, "RESULTADO FINAL:");
    PlayerTextDrawLetterSize(playerid, gplTextDrawCerti[playerid][6], 0.337000, 1.210072);
    PlayerTextDrawAlignment(playerid, gplTextDrawCerti[playerid][6], 1);
    PlayerTextDrawColor(playerid, gplTextDrawCerti[playerid][6], -1026561537);
    PlayerTextDrawSetShadow(playerid, gplTextDrawCerti[playerid][6], 1);
    PlayerTextDrawSetOutline(playerid, gplTextDrawCerti[playerid][6], 0);
    PlayerTextDrawBackgroundColor(playerid, gplTextDrawCerti[playerid][6], 255);
    PlayerTextDrawFont(playerid, gplTextDrawCerti[playerid][6], 2);
    PlayerTextDrawSetProportional(playerid, gplTextDrawCerti[playerid][6], 1);
    PlayerTextDrawSetShadow(playerid, gplTextDrawCerti[playerid][6], 1);

    gplTextDrawCerti[playerid][7] = CreatePlayerTextDraw(playerid, 203.333312, 232.649108, "POSICAO FINAL:");
    PlayerTextDrawLetterSize(playerid, gplTextDrawCerti[playerid][7], 0.337000, 1.210072);
    PlayerTextDrawAlignment(playerid, gplTextDrawCerti[playerid][7], 1);
    PlayerTextDrawColor(playerid, gplTextDrawCerti[playerid][7], -1026561537);
    PlayerTextDrawSetShadow(playerid, gplTextDrawCerti[playerid][7], 1);
    PlayerTextDrawSetOutline(playerid, gplTextDrawCerti[playerid][7], 0);
    PlayerTextDrawBackgroundColor(playerid, gplTextDrawCerti[playerid][7], 255);
    PlayerTextDrawFont(playerid, gplTextDrawCerti[playerid][7], 2);
    PlayerTextDrawSetProportional(playerid, gplTextDrawCerti[playerid][7], 1);
    PlayerTextDrawSetShadow(playerid, gplTextDrawCerti[playerid][7], 1);

    gplTextDrawCerti[playerid][8] = CreatePlayerTextDraw(playerid, 203.333312, 248.650085, "PENALIDADE POR DANO:");
    PlayerTextDrawLetterSize(playerid, gplTextDrawCerti[playerid][8], 0.337000, 1.210072);
    PlayerTextDrawAlignment(playerid, gplTextDrawCerti[playerid][8], 1);
    PlayerTextDrawColor(playerid, gplTextDrawCerti[playerid][8], -1026561537);
    PlayerTextDrawSetShadow(playerid, gplTextDrawCerti[playerid][8], 1);
    PlayerTextDrawSetOutline(playerid, gplTextDrawCerti[playerid][8], 0);
    PlayerTextDrawBackgroundColor(playerid, gplTextDrawCerti[playerid][8], 255);
    PlayerTextDrawFont(playerid, gplTextDrawCerti[playerid][8], 2);
    PlayerTextDrawSetProportional(playerid, gplTextDrawCerti[playerid][8], 1);
    PlayerTextDrawSetShadow(playerid, gplTextDrawCerti[playerid][8], 1);

    gplTextDrawCerti[playerid][9] = CreatePlayerTextDraw(playerid, 203.333312, 264.551055, "PONTUACAO MEDIA:");
    PlayerTextDrawLetterSize(playerid, gplTextDrawCerti[playerid][9], 0.337000, 1.210072);
    PlayerTextDrawAlignment(playerid, gplTextDrawCerti[playerid][9], 1);
    PlayerTextDrawColor(playerid, gplTextDrawCerti[playerid][9], -1026561537);
    PlayerTextDrawSetShadow(playerid, gplTextDrawCerti[playerid][9], 1);
    PlayerTextDrawSetOutline(playerid, gplTextDrawCerti[playerid][9], 0);
    PlayerTextDrawBackgroundColor(playerid, gplTextDrawCerti[playerid][9], 255);
    PlayerTextDrawFont(playerid, gplTextDrawCerti[playerid][9], 2);
    PlayerTextDrawSetProportional(playerid, gplTextDrawCerti[playerid][9], 1);
    PlayerTextDrawSetShadow(playerid, gplTextDrawCerti[playerid][9], 1);

    gplTextDrawCerti[playerid][10] = CreatePlayerTextDraw(playerid, 427.399658, 216.748138, "100%");
    PlayerTextDrawLetterSize(playerid, gplTextDrawCerti[playerid][10], 0.388666, 1.147852);
    PlayerTextDrawAlignment(playerid, gplTextDrawCerti[playerid][10], 3);
    PlayerTextDrawColor(playerid, gplTextDrawCerti[playerid][10], -1);
    PlayerTextDrawSetShadow(playerid, gplTextDrawCerti[playerid][10], 1);
    PlayerTextDrawSetOutline(playerid, gplTextDrawCerti[playerid][10], 0);
    PlayerTextDrawBackgroundColor(playerid, gplTextDrawCerti[playerid][10], 255);
    PlayerTextDrawFont(playerid, gplTextDrawCerti[playerid][10], 2);
    PlayerTextDrawSetProportional(playerid, gplTextDrawCerti[playerid][10], 1);
    PlayerTextDrawSetShadow(playerid, gplTextDrawCerti[playerid][10], 1);

    gplTextDrawCerti[playerid][11] = CreatePlayerTextDraw(playerid, 427.565856, 232.784988, "100%");
    PlayerTextDrawLetterSize(playerid, gplTextDrawCerti[playerid][11], 0.388666, 1.147852);
    PlayerTextDrawAlignment(playerid, gplTextDrawCerti[playerid][11], 3);
    PlayerTextDrawColor(playerid, gplTextDrawCerti[playerid][11], -1);
    PlayerTextDrawSetShadow(playerid, gplTextDrawCerti[playerid][11], 1);
    PlayerTextDrawSetOutline(playerid, gplTextDrawCerti[playerid][11], 0);
    PlayerTextDrawBackgroundColor(playerid, gplTextDrawCerti[playerid][11], 255);
    PlayerTextDrawFont(playerid, gplTextDrawCerti[playerid][11], 2);
    PlayerTextDrawSetProportional(playerid, gplTextDrawCerti[playerid][11], 1);
    PlayerTextDrawSetShadow(playerid, gplTextDrawCerti[playerid][11], 1);

    gplTextDrawCerti[playerid][12] = CreatePlayerTextDraw(playerid, 427.900085, 264.751831, "100%");
    PlayerTextDrawLetterSize(playerid, gplTextDrawCerti[playerid][12], 0.388666, 1.147852);
    PlayerTextDrawAlignment(playerid, gplTextDrawCerti[playerid][12], 3);
    PlayerTextDrawColor(playerid, gplTextDrawCerti[playerid][12], -1);
    PlayerTextDrawSetShadow(playerid, gplTextDrawCerti[playerid][12], 1);
    PlayerTextDrawSetOutline(playerid, gplTextDrawCerti[playerid][12], 0);
    PlayerTextDrawBackgroundColor(playerid, gplTextDrawCerti[playerid][12], 255);
    PlayerTextDrawFont(playerid, gplTextDrawCerti[playerid][12], 2);
    PlayerTextDrawSetProportional(playerid, gplTextDrawCerti[playerid][12], 1);
    PlayerTextDrawSetShadow(playerid, gplTextDrawCerti[playerid][12], 1);

    gplTextDrawCerti[playerid][13] = CreatePlayerTextDraw(playerid, 427.400390, 248.629669, "-0%");
    PlayerTextDrawLetterSize(playerid, gplTextDrawCerti[playerid][13], 0.388666, 1.147852);
    PlayerTextDrawAlignment(playerid, gplTextDrawCerti[playerid][13], 3);
    PlayerTextDrawColor(playerid, gplTextDrawCerti[playerid][13], -1221180417);
    PlayerTextDrawSetShadow(playerid, gplTextDrawCerti[playerid][13], 1);
    PlayerTextDrawSetOutline(playerid, gplTextDrawCerti[playerid][13], 0);
    PlayerTextDrawBackgroundColor(playerid, gplTextDrawCerti[playerid][13], 255);
    PlayerTextDrawFont(playerid, gplTextDrawCerti[playerid][13], 2);
    PlayerTextDrawSetProportional(playerid, gplTextDrawCerti[playerid][13], 1);
    PlayerTextDrawSetShadow(playerid, gplTextDrawCerti[playerid][13], 1);

    gplTextDrawCerti[playerid][14] = CreatePlayerTextDraw(playerid, 203.999969, 307.392761, "NOVO TESTE DISPONIVEL");
    PlayerTextDrawLetterSize(playerid, gplTextDrawCerti[playerid][14], 0.339333, 1.210073);
    PlayerTextDrawAlignment(playerid, gplTextDrawCerti[playerid][14], 1);
    PlayerTextDrawColor(playerid, gplTextDrawCerti[playerid][14], -1);
    PlayerTextDrawSetShadow(playerid, gplTextDrawCerti[playerid][14], 1);
    PlayerTextDrawSetOutline(playerid, gplTextDrawCerti[playerid][14], 0);
    PlayerTextDrawBackgroundColor(playerid, gplTextDrawCerti[playerid][14], 255);
    PlayerTextDrawFont(playerid, gplTextDrawCerti[playerid][14], 2);
    PlayerTextDrawSetProportional(playerid, gplTextDrawCerti[playerid][14], 1);
    PlayerTextDrawSetShadow(playerid, gplTextDrawCerti[playerid][14], 1);

    gplTextDrawCerti[playerid][15] = CreatePlayerTextDraw(playerid, 204.000000, 324.400207, "CONTINUAR          ~k~~VEHICLE_HANDBRAKE~");
    PlayerTextDrawLetterSize(playerid, gplTextDrawCerti[playerid][15], 0.339333, 1.210073);
    PlayerTextDrawAlignment(playerid, gplTextDrawCerti[playerid][15], 1);
    PlayerTextDrawColor(playerid, gplTextDrawCerti[playerid][15], -1484576001);
    PlayerTextDrawSetShadow(playerid, gplTextDrawCerti[playerid][15], 1);
    PlayerTextDrawSetOutline(playerid, gplTextDrawCerti[playerid][15], 0);
    PlayerTextDrawBackgroundColor(playerid, gplTextDrawCerti[playerid][15], 255);
    PlayerTextDrawFont(playerid, gplTextDrawCerti[playerid][15], 2);
    PlayerTextDrawSetProportional(playerid, gplTextDrawCerti[playerid][15], 1);
    PlayerTextDrawSetShadow(playerid, gplTextDrawCerti[playerid][15], 1);

    for(new i = 0; i < sizeof(gplTextDrawCerti[]); i++)
        PlayerTextDrawShow(playerid, gplTextDrawCerti[playerid][i]);
    return 1;
}

//------------------------------------------------------------------------------

ShowPlayerSchoolTV(playerid)
{
    if(gplIsTelevisionVisible[playerid])
        return 1;

    gplIsTelevisionVisible[playerid] = true;
    TogglePlayerSpectating(playerid, true);
    PlayerPlaySound(playerid, 1187, 0.0, 0.0, 0.0);
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, (playerid + 1));
    HidePlayerClock(playerid);
    ClearPlayerScreen(playerid);
    gplSelection[playerid] = 0;
    CreateAutoSchoolObject(playerid, 0);
    for(new i = 0; i < sizeof(gDrivingSchoolTV); i++)
        TextDrawShowForPlayer(playerid, gDrivingSchoolTV[i]);
    InterpolateCameraPos(playerid, -2023.7064, -97.8283, 54.4462, -2020.9050, -290.2478, 53.7949, 20000, CAMERA_MOVE);
    InterpolateCameraLookAt(playerid, -2024.3069, -98.6351, 53.8811, -2021.2629, -289.3084, 53.4247, 20000, CAMERA_MOVE);
    return 1;
}

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
    gDrivingSchoolTV[0] = TextDrawCreate(15.000000, 17.000000, "box");
    TextDrawLetterSize(gDrivingSchoolTV[0], 0.000000, 10.433334);
    TextDrawTextSize(gDrivingSchoolTV[0], 620.999938, 0.000000);
    TextDrawAlignment(gDrivingSchoolTV[0], 1);
    TextDrawColor(gDrivingSchoolTV[0], -1);
    TextDrawUseBox(gDrivingSchoolTV[0], 1);
    TextDrawBoxColor(gDrivingSchoolTV[0], 255);
    TextDrawSetShadow(gDrivingSchoolTV[0], 0);
    TextDrawSetOutline(gDrivingSchoolTV[0], 0);
    TextDrawBackgroundColor(gDrivingSchoolTV[0], 255);
    TextDrawFont(gDrivingSchoolTV[0], 2);
    TextDrawSetProportional(gDrivingSchoolTV[0], 1);
    TextDrawSetShadow(gDrivingSchoolTV[0], 0);

    gDrivingSchoolTV[1] = TextDrawCreate(19.000000, 332.000000, "box");
    TextDrawLetterSize(gDrivingSchoolTV[1], 0.000000, 10.433334);
    TextDrawTextSize(gDrivingSchoolTV[1], 621.666809, 0.000000);
    TextDrawAlignment(gDrivingSchoolTV[1], 1);
    TextDrawColor(gDrivingSchoolTV[1], -1);
    TextDrawUseBox(gDrivingSchoolTV[1], 1);
    TextDrawBoxColor(gDrivingSchoolTV[1], 509);
    TextDrawSetShadow(gDrivingSchoolTV[1], 0);
    TextDrawSetOutline(gDrivingSchoolTV[1], 0);
    TextDrawBackgroundColor(gDrivingSchoolTV[1], 255);
    TextDrawFont(gDrivingSchoolTV[1], 2);
    TextDrawSetProportional(gDrivingSchoolTV[1], 1);
    TextDrawSetShadow(gDrivingSchoolTV[1], 0);
    TextDrawSetSelectable(gDrivingSchoolTV[1], true);

    gDrivingSchoolTV[2] = TextDrawCreate(-1.000000, 444.000000, "LD_DRV:TVCORN");
    TextDrawLetterSize(gDrivingSchoolTV[2], 0.000000, 0.000000);
    TextDrawTextSize(gDrivingSchoolTV[2], 326.000488, -219.037338);
    TextDrawAlignment(gDrivingSchoolTV[2], 1);
    TextDrawColor(gDrivingSchoolTV[2], -1);
    TextDrawSetShadow(gDrivingSchoolTV[2], 0);
    TextDrawSetOutline(gDrivingSchoolTV[2], 0);
    TextDrawBackgroundColor(gDrivingSchoolTV[2], 255);
    TextDrawFont(gDrivingSchoolTV[2], 4);
    TextDrawSetProportional(gDrivingSchoolTV[2], 0);
    TextDrawSetShadow(gDrivingSchoolTV[2], 0);

    gDrivingSchoolTV[3] = TextDrawCreate(647.000000, 440.000000, "LD_DRV:TVCORN");
    TextDrawLetterSize(gDrivingSchoolTV[3], 0.000000, 0.000000);
    TextDrawTextSize(gDrivingSchoolTV[3], -416.666015, -180.459472);
    TextDrawAlignment(gDrivingSchoolTV[3], 1);
    TextDrawColor(gDrivingSchoolTV[3], -1);
    TextDrawSetShadow(gDrivingSchoolTV[3], 0);
    TextDrawSetOutline(gDrivingSchoolTV[3], 0);
    TextDrawBackgroundColor(gDrivingSchoolTV[3], 255);
    TextDrawFont(gDrivingSchoolTV[3], 4);
    TextDrawSetProportional(gDrivingSchoolTV[3], 0);
    TextDrawSetShadow(gDrivingSchoolTV[3], 0);

    gDrivingSchoolTV[4] = TextDrawCreate(633.000000, -1.000000, "ld_drv:tvbase");
    TextDrawLetterSize(gDrivingSchoolTV[4], 0.000000, 0.000000);
    TextDrawTextSize(gDrivingSchoolTV[4], -634.666381, 17.822071);
    TextDrawAlignment(gDrivingSchoolTV[4], 1);
    TextDrawColor(gDrivingSchoolTV[4], -1);
    TextDrawSetShadow(gDrivingSchoolTV[4], 0);
    TextDrawSetOutline(gDrivingSchoolTV[4], 0);
    TextDrawBackgroundColor(gDrivingSchoolTV[4], 255);
    TextDrawFont(gDrivingSchoolTV[4], 4);
    TextDrawSetProportional(gDrivingSchoolTV[4], 0);
    TextDrawSetShadow(gDrivingSchoolTV[4], 0);

    gDrivingSchoolTV[5] = TextDrawCreate(649.666076, 427.748809, "ld_drv:tvbase");
    TextDrawLetterSize(gDrivingSchoolTV[5], 0.000000, 0.000000);
    TextDrawTextSize(gDrivingSchoolTV[5], -670.333007, 210.710906);
    TextDrawAlignment(gDrivingSchoolTV[5], 1);
    TextDrawColor(gDrivingSchoolTV[5], -1);
    TextDrawSetShadow(gDrivingSchoolTV[5], 0);
    TextDrawSetOutline(gDrivingSchoolTV[5], 0);
    TextDrawBackgroundColor(gDrivingSchoolTV[5], 255);
    TextDrawFont(gDrivingSchoolTV[5], 4);
    TextDrawSetProportional(gDrivingSchoolTV[5], 0);
    TextDrawSetShadow(gDrivingSchoolTV[5], 0);

    gDrivingSchoolTV[6] = TextDrawCreate(-1.000000, 0.000000, "LD_DRV:TVCORN");
    TextDrawLetterSize(gDrivingSchoolTV[6], 0.000000, 0.000000);
    TextDrawTextSize(gDrivingSchoolTV[6], 333.666656, 238.503555);
    TextDrawAlignment(gDrivingSchoolTV[6], 1);
    TextDrawColor(gDrivingSchoolTV[6], -1);
    TextDrawSetShadow(gDrivingSchoolTV[6], 0);
    TextDrawSetOutline(gDrivingSchoolTV[6], 0);
    TextDrawBackgroundColor(gDrivingSchoolTV[6], 255);
    TextDrawFont(gDrivingSchoolTV[6], 4);
    TextDrawSetProportional(gDrivingSchoolTV[6], 0);
    TextDrawSetShadow(gDrivingSchoolTV[6], 0);

    gDrivingSchoolTV[7] = TextDrawCreate(640.000000, -1.000000, "LD_DRV:TVCORN");
    TextDrawLetterSize(gDrivingSchoolTV[7], 0.000000, 0.000000);
    TextDrawTextSize(gDrivingSchoolTV[7], -307.333099, 260.903564);
    TextDrawAlignment(gDrivingSchoolTV[7], 1);
    TextDrawColor(gDrivingSchoolTV[7], -1);
    TextDrawSetShadow(gDrivingSchoolTV[7], 0);
    TextDrawSetOutline(gDrivingSchoolTV[7], 0);
    TextDrawBackgroundColor(gDrivingSchoolTV[7], 255);
    TextDrawFont(gDrivingSchoolTV[7], 4);
    TextDrawSetProportional(gDrivingSchoolTV[7], 0);
    TextDrawSetShadow(gDrivingSchoolTV[7], 0);

    gDrivingSchoolTV[8] = TextDrawCreate(348.000000, 310.000000, "ld_drv:ribbw");
    TextDrawLetterSize(gDrivingSchoolTV[8], 0.000000, 0.000000);
    TextDrawTextSize(gDrivingSchoolTV[8], 44.666683, 42.296291);
    TextDrawAlignment(gDrivingSchoolTV[8], 1);
    TextDrawColor(gDrivingSchoolTV[8], -1);
    TextDrawSetShadow(gDrivingSchoolTV[8], 0);
    TextDrawSetOutline(gDrivingSchoolTV[8], 0);
    TextDrawBackgroundColor(gDrivingSchoolTV[8], 255);
    TextDrawFont(gDrivingSchoolTV[8], 4);
    TextDrawSetProportional(gDrivingSchoolTV[8], 0);
    TextDrawSetShadow(gDrivingSchoolTV[8], 0);

    gDrivingSchoolTV[9] = TextDrawCreate(300.900054, 309.299774, "ld_drv:ribbw");
    TextDrawLetterSize(gDrivingSchoolTV[9], 0.000000, 0.000000);
    TextDrawTextSize(gDrivingSchoolTV[9], -55.999992, 42.711112);
    TextDrawAlignment(gDrivingSchoolTV[9], 1);
    TextDrawColor(gDrivingSchoolTV[9], -1);
    TextDrawSetShadow(gDrivingSchoolTV[9], 0);
    TextDrawSetOutline(gDrivingSchoolTV[9], 0);
    TextDrawBackgroundColor(gDrivingSchoolTV[9], 255);
    TextDrawFont(gDrivingSchoolTV[9], 4);
    TextDrawSetProportional(gDrivingSchoolTV[9], 0);
    TextDrawSetShadow(gDrivingSchoolTV[9], 0);

    gDrivingSchoolTV[10] = TextDrawCreate(68.333320, 359.659423, "INICIAR");
    TextDrawLetterSize(gDrivingSchoolTV[10], 0.322000, 1.446518);
    TextDrawAlignment(gDrivingSchoolTV[10], 1);
    TextDrawColor(gDrivingSchoolTV[10], -1669449729);
    TextDrawSetShadow(gDrivingSchoolTV[10], 0);
    TextDrawSetOutline(gDrivingSchoolTV[10], 0);
    TextDrawBackgroundColor(gDrivingSchoolTV[10], 255);
    TextDrawFont(gDrivingSchoolTV[10], 2);
    TextDrawSetProportional(gDrivingSchoolTV[10], 1);
    TextDrawSetShadow(gDrivingSchoolTV[10], 0);

    gDrivingSchoolTV[11] = TextDrawCreate(285.000000, 293.000000, "ld_drv:naward");
    TextDrawLetterSize(gDrivingSchoolTV[11], 0.000000, 0.000000);
    TextDrawTextSize(gDrivingSchoolTV[11], 70.333343, 74.237022);
    TextDrawAlignment(gDrivingSchoolTV[11], 1);
    TextDrawColor(gDrivingSchoolTV[11], -1);
    TextDrawSetShadow(gDrivingSchoolTV[11], 0);
    TextDrawSetOutline(gDrivingSchoolTV[11], 0);
    TextDrawBackgroundColor(gDrivingSchoolTV[11], 255);
    TextDrawFont(gDrivingSchoolTV[11], 4);
    TextDrawSetProportional(gDrivingSchoolTV[11], 0);
    TextDrawSetShadow(gDrivingSchoolTV[11], 0);

    gDrivingSchoolTV[12] = TextDrawCreate(67.999984, 380.815002, "SAIR");
    TextDrawLetterSize(gDrivingSchoolTV[12], 0.322000, 1.446518);
    TextDrawAlignment(gDrivingSchoolTV[12], 1);
    TextDrawColor(gDrivingSchoolTV[12], -1669449729);
    TextDrawSetShadow(gDrivingSchoolTV[12], 0);
    TextDrawSetOutline(gDrivingSchoolTV[12], 0);
    TextDrawBackgroundColor(gDrivingSchoolTV[12], 255);
    TextDrawFont(gDrivingSchoolTV[12], 2);
    TextDrawSetProportional(gDrivingSchoolTV[12], 1);
    TextDrawSetShadow(gDrivingSchoolTV[12], 0);

    gDrivingSchoolTV[13] = TextDrawCreate(157.699874, 380.755920, "~k~~VEHICLE_ENTER_EXIT~");
    TextDrawLetterSize(gDrivingSchoolTV[13], 0.322000, 1.446518);
    TextDrawAlignment(gDrivingSchoolTV[13], 1);
    TextDrawColor(gDrivingSchoolTV[13], -1);
    TextDrawSetShadow(gDrivingSchoolTV[13], 0);
    TextDrawSetOutline(gDrivingSchoolTV[13], 0);
    TextDrawBackgroundColor(gDrivingSchoolTV[13], 255);
    TextDrawFont(gDrivingSchoolTV[13], 2);
    TextDrawSetProportional(gDrivingSchoolTV[13], 1);
    TextDrawSetShadow(gDrivingSchoolTV[13], 0);

    gDrivingSchoolTV[14] = TextDrawCreate(157.699890, 359.326324, "~k~~PED_SPRINT~");
    TextDrawLetterSize(gDrivingSchoolTV[14], 0.322000, 1.446518);
    TextDrawAlignment(gDrivingSchoolTV[14], 1);
    TextDrawColor(gDrivingSchoolTV[14], -1);
    TextDrawSetShadow(gDrivingSchoolTV[14], 0);
    TextDrawSetOutline(gDrivingSchoolTV[14], 0);
    TextDrawBackgroundColor(gDrivingSchoolTV[14], 255);
    TextDrawFont(gDrivingSchoolTV[14], 2);
    TextDrawSetProportional(gDrivingSchoolTV[14], 1);
    TextDrawSetShadow(gDrivingSchoolTV[14], 0);

    gDrivingSchoolTV[15] = TextDrawCreate(323.333282, 377.911102, "SEM RECOMPENSA");
    TextDrawLetterSize(gDrivingSchoolTV[15], 0.268333, 1.745184);
    TextDrawAlignment(gDrivingSchoolTV[15], 2);
    TextDrawColor(gDrivingSchoolTV[15], -1061109505);
    TextDrawSetShadow(gDrivingSchoolTV[15], 0);
    TextDrawSetOutline(gDrivingSchoolTV[15], 0);
    TextDrawBackgroundColor(gDrivingSchoolTV[15], 255);
    TextDrawFont(gDrivingSchoolTV[15], 2);
    TextDrawSetProportional(gDrivingSchoolTV[15], 1);
    TextDrawSetShadow(gDrivingSchoolTV[15], 0);

    gDrivingSchoolTV[16] = TextDrawCreate(467.333312, 357.585388, "navegar");
    TextDrawLetterSize(gDrivingSchoolTV[16], 0.273666, 1.106370);
    TextDrawAlignment(gDrivingSchoolTV[16], 1);
    TextDrawColor(gDrivingSchoolTV[16], -1061109505);
    TextDrawSetShadow(gDrivingSchoolTV[16], 0);
    TextDrawSetOutline(gDrivingSchoolTV[16], 0);
    TextDrawBackgroundColor(gDrivingSchoolTV[16], 255);
    TextDrawFont(gDrivingSchoolTV[16], 2);
    TextDrawSetProportional(gDrivingSchoolTV[16], 1);
    TextDrawSetShadow(gDrivingSchoolTV[16], 0);

    gDrivingSchoolTV[17] = TextDrawCreate(541.666931, 358.674133, "ld_beat:right");
    TextDrawLetterSize(gDrivingSchoolTV[17], 0.000000, 0.000000);
    TextDrawTextSize(gDrivingSchoolTV[17], 7.666674, 9.940734);
    TextDrawAlignment(gDrivingSchoolTV[17], 1);
    TextDrawColor(gDrivingSchoolTV[17], -1);
    TextDrawSetShadow(gDrivingSchoolTV[17], 0);
    TextDrawSetOutline(gDrivingSchoolTV[17], 0);
    TextDrawBackgroundColor(gDrivingSchoolTV[17], 255);
    TextDrawFont(gDrivingSchoolTV[17], 4);
    TextDrawSetProportional(gDrivingSchoolTV[17], 0);
    TextDrawSetShadow(gDrivingSchoolTV[17], 0);

    gDrivingSchoolTV[18] = TextDrawCreate(532.269226, 358.674133, "ld_beat:left");
    TextDrawLetterSize(gDrivingSchoolTV[18], 0.000000, 0.000000);
    TextDrawTextSize(gDrivingSchoolTV[18], 7.666674, 9.940734);
    TextDrawAlignment(gDrivingSchoolTV[18], 1);
    TextDrawColor(gDrivingSchoolTV[18], -1);
    TextDrawSetShadow(gDrivingSchoolTV[18], 0);
    TextDrawSetOutline(gDrivingSchoolTV[18], 0);
    TextDrawBackgroundColor(gDrivingSchoolTV[18], 255);
    TextDrawFont(gDrivingSchoolTV[18], 4);
    TextDrawSetProportional(gDrivingSchoolTV[18], 0);
    TextDrawSetShadow(gDrivingSchoolTV[18], 0);

    gDrivingSchoolTV[19] = TextDrawCreate(316.000000, 35.000000, "O 360");
    TextDrawLetterSize(gDrivingSchoolTV[19], 1.012332, 3.748741);
    TextDrawAlignment(gDrivingSchoolTV[19], 2);
    TextDrawColor(gDrivingSchoolTV[19], -1);
    TextDrawSetShadow(gDrivingSchoolTV[19], 0);
    TextDrawSetOutline(gDrivingSchoolTV[19], 0);
    TextDrawBackgroundColor(gDrivingSchoolTV[19], 255);
    TextDrawFont(gDrivingSchoolTV[19], 3);
    TextDrawSetProportional(gDrivingSchoolTV[19], 0);
    TextDrawSetShadow(gDrivingSchoolTV[19], 0);

    gDrivingSchoolTV[20] = TextDrawCreate(452.000000, 82.000000, "OBTENHA 70% ou mais para passar");
    TextDrawLetterSize(gDrivingSchoolTV[20], 0.444666, 1.981628);
    TextDrawAlignment(gDrivingSchoolTV[20], 3);
    TextDrawColor(gDrivingSchoolTV[20], -1061109505);
    TextDrawSetShadow(gDrivingSchoolTV[20], 0);
    TextDrawSetOutline(gDrivingSchoolTV[20], 0);
    TextDrawBackgroundColor(gDrivingSchoolTV[20], 255);
    TextDrawFont(gDrivingSchoolTV[20], 2);
    TextDrawSetProportional(gDrivingSchoolTV[20], 0);
    TextDrawSetShadow(gDrivingSchoolTV[20], 0);
    return 1;
}
