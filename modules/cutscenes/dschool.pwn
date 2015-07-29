/*******************************************************************************
* FILENAME :        modules/cutscenes/dschool.pwn
*
* DESCRIPTION :
*       Handle driving school cutscenes.
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

static gPlayerSoundPart[MAX_PLAYERS];

//------------------------------------------------------------------------------

StartDrivingSchoolCutscene(playerid)
{
    SetPlayerInterior(playerid, 3);
    SetPlayerVirtualWorld(playerid, 0);

    SetPlayerPos(playerid, -2032.7184, -118.3477, 1035.1719);
    SetPlayerFacingAngle(playerid, 90.6432);

    SetPlayerCameraPos(playerid, -2033.0891, -117.6420, 1035.3528);
    SetPlayerCameraLookAt(playerid, -2034.0880, -117.6433, 1035.2723);

    TogglePlayerControllable(playerid, false);

    gPlayerSoundPart[playerid] = 0;
    defer PlayDrivingSchoolSound(playerid);
    return 1;
}

//------------------------------------------------------------------------------

timer PlayDrivingSchoolSound[4000](playerid)
{
    switch(gPlayerSoundPart[playerid])
    {
        case 0:
        {
            PlayerPlaySound(playerid, 26002, 0.0, 0.0, 0.0);
            CreatePlayerSubtitle(playerid, ConvertToGameText("Bem-vindo ao teste de direção avançada."));
            defer PlayDrivingSchoolSound(playerid);
        }
        case 1:
        {
            PlayerPlaySound(playerid, 26003, 0.0, 0.0, 0.0);
            SetPlayerSubtitle(playerid, ConvertToGameText("Para passar você precisa obter BRONZE ou superior em todos os testes."));
            defer PlayDrivingSchoolSound(playerid);
        }
        case 2:
        {
            PlayerPlaySound(playerid, 26004, 0.0, 0.0, 0.0);
            SetPlayerSubtitle(playerid, ConvertToGameText("Para visualizar cada teste, por favor, use a TV alí."));
            defer PlayDrivingSchoolSound(playerid);
        }
        case 3:
        {
            PlayerPlaySound(playerid, 26005, 0.0, 0.0, 0.0);
            SetPlayerSubtitle(playerid, ConvertToGameText("Passar em um teste irá desbloquear o próximo teste no programa."));
            defer PlayDrivingSchoolSound(playerid);
        }
        case 4:
        {
            PlayerPlaySound(playerid, 26006, 0.0, 0.0, 0.0);
            SetPlayerSubtitle(playerid, ConvertToGameText("Você pode voltar e checar suas pontuações ou fazer novos testes a qualquer momento."));
            defer PlayDrivingSchoolSound(playerid);
        }
        default:
        {
            TogglePlayerControllable(playerid, true);
            SetCameraBehindPlayer(playerid);
            DestroyPlayerSubtitle(playerid);
            SetPlayerFirstTime(playerid, FIRST_TIME_DRIVING_SCHOOL, true);
        }
    }
    gPlayerSoundPart[playerid]++;
}

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
    gPlayerSoundPart[playerid] = 0;
    return 1;
}
