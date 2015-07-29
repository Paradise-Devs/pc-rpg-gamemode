/*******************************************************************************
* FILENAME :        modules/cutscenes/cityhall.pwn
*
* DESCRIPTION :
*       Handle cityhall cutscenes.
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

StartCityHallSchoolCutscene(playerid)
{
    SetPlayerInterior(playerid, 3);
    SetPlayerVirtualWorld(playerid, 0);

    SetPlayerPos(playerid, 361.7102,172.6248,1008.3828);
    SetPlayerFacingAngle(playerid, 83.2779);

    SetPlayerCameraPos(playerid, 361.2575, 172.7412, 1008.6669);
    SetPlayerCameraLookAt(playerid, 360.3167, 173.0762, 1008.5674);

    TogglePlayerControllable(playerid, false);

    gPlayerSoundPart[playerid] = 0;
    PlayCityHallSound(playerid);
    return 1;
}

//------------------------------------------------------------------------------

timer PlayCityHallSound[6500](playerid)
{
    switch(gPlayerSoundPart[playerid])
    {
        case 0:
        {
            PlayAudioStreamForPlayer(playerid, "https://dl.dropboxusercontent.com/u/88802402/cityhall_01.mp3");
            ClearPlayerScreen(playerid);
            CreatePlayerSubtitle(playerid, ConvertToGameText("Bem-vindo a prefeitura, aqui você fará muitas coisas."), true);
            defer PlayCityHallSound(playerid);
        }
        case 1:
        {
            PlayAudioStreamForPlayer(playerid, "https://dl.dropboxusercontent.com/u/88802402/cityhall_02.mp3");
            ClearPlayerScreen(playerid);
            SetPlayerSubtitle(playerid, ConvertToGameText("Você poderá votar em prefeitos, fazer quests e muito mais."));
            defer PlayCityHallSound(playerid);
        }
        case 2:
        {
            PlayAudioStreamForPlayer(playerid, "https://dl.dropboxusercontent.com/u/88802402/cityhall_03.mp3");
            ClearPlayerScreen(playerid);
            SetPlayerSubtitle(playerid, ConvertToGameText("Vá até o checkpoint no balcão e experimente."));
            defer PlayCityHallSound(playerid);
        }
        default:
        {
            StopAudioStreamForPlayer(playerid);
            TogglePlayerControllable(playerid, true);
            SetCameraBehindPlayer(playerid);
            DestroyPlayerSubtitle(playerid);
            SetPlayerFirstTime(playerid, FIRST_TIME_CITY_HALL, true);
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
