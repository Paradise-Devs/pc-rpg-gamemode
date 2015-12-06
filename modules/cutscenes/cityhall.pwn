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
static bool:gIsPlayerTalkin[MAX_PLAYERS];
static g_pCheckpoint[MAX_PLAYERS];

//------------------------------------------------------------------------------

new Float:gCityHallBooksPos[][] =
{
	{368.0253, 211.9999, 1008.3828},
	{368.0286, 212.8032, 1008.3828},
	{368.0285, 213.7967, 1008.3828},
	{368.0284, 214.6061, 1008.3828},
    {368.0286, 216.4410, 1008.3828},
    {367.3542, 216.6298, 1008.3828},
	{365.5838, 216.7317, 1008.3828},
	{363.7329, 216.7314, 1008.3828},
	{351.3337, 216.4646, 1008.3828},
	{351.3228, 214.6218, 1008.3828},
	{351.3309, 212.9557, 1008.3828},
	{351.3307, 211.1214, 1008.3828},
	{351.3311, 201.5438, 1008.3828},
	{351.3308, 200.6499, 1008.3828},
	{351.3318, 199.7634, 1008.3828},
	{351.3308, 198.9792, 1008.3828},
	{351.3312, 197.8826, 1008.3828},
	{351.3312, 197.1710, 1008.3828}
};

//------------------------------------------------------------------------------

StartCityHallSchoolCutscene(playerid)
{
    SetPlayerInterior(playerid, 3);
    SetPlayerVirtualWorld(playerid, 0);

    SetPlayerPos(playerid, 361.7102,172.6248,1008.3828);
    SetPlayerFacingAngle(playerid, 83.2779);

    SetPlayerCameraPos(playerid, 361.2575, 172.7412, 1008.6669);
    SetPlayerCameraLookAt(playerid, 360.3167, 173.0762, 1008.5674);

    ShowPlayerGPS(playerid, true);
    TogglePlayerControllable(playerid, false);

    foreach(new i: Player)
    {
        if(gIsPlayerTalkin[i] == true)
            break;

        ApplyActorAnimation(gActorData[ACTOR_CITYHALL][E_ID], "MISC", "Seat_talk_01", 4.0, 1, 0, 0, 0, 0);
        break;
    }

    gPlayerSoundPart[playerid] = 0;
    gIsPlayerTalkin[playerid] = true;
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
            CreatePlayerSubtitle(playerid, ConvertToGameText("Olá, Bem-vindo a prefeitura, você apareceu bem na hora!"), true);
            ClearPlayerScreen(playerid, 20);
            defer PlayCityHallSound(playerid);
        }
        case 1:
        {
            PlayAudioStreamForPlayer(playerid, "https://dl.dropboxusercontent.com/u/88802402/cityhall_02.mp3");
            SetPlayerSubtitle(playerid, ConvertToGameText("Estou precisando de ajuda, para organizar alguns livros."));
            ClearPlayerScreen(playerid, 20);
            defer PlayCityHallSound(playerid);
        }
        case 2:
        {
            PlayAudioStreamForPlayer(playerid, "https://dl.dropboxusercontent.com/u/88802402/cityhall_03.mp3");
            SetPlayerSubtitle(playerid, ConvertToGameText("Vá até a sala a direita, irei paga-lo ao terminar."));
            ClearPlayerScreen(playerid, 20);
            defer PlayCityHallSound(playerid);
        }
        default:
        {
            gIsPlayerTalkin[playerid] = false;
            foreach(new i: Player)
            {
                if(gIsPlayerTalkin[i] == true)
                    break;

                ApplyActorAnimation(gActorData[ACTOR_CITYHALL][E_ID], "PED", "SEAT_IDLE", 4.0, 1, 0, 0, 0, 0);
                break;
            }

            StopAudioStreamForPlayer(playerid);
            TogglePlayerControllable(playerid, true);
            if(GetPlayerGPS(playerid) > gettime()) ShowPlayerGPS(playerid); else HidePlayerGPS(playerid);

            SetCameraBehindPlayer(playerid);
            DestroyPlayerSubtitle(playerid);

            SetPlayerCPID(playerid, CHECKPOINT_CITYHALL);
            SetPlayerRaceCheckpoint(playerid, 0, gCityHallBooksPos[0][0], gCityHallBooksPos[0][1], gCityHallBooksPos[0][2], gCityHallBooksPos[1][0], gCityHallBooksPos[1][1], gCityHallBooksPos[1][2], 1.0);
            // SetPlayerFirstTime(playerid, FIRST_TIME_CITY_HALL, true);
        }
    }
    gPlayerSoundPart[playerid]++;
}

//------------------------------------------------------------------------------

hook OnPlayerEnterRaceCPT(playerid)
{
    switch(GetPlayerCPID(playerid))
    {
        case CHECKPOINT_CITYHALL:
        {
            if(g_pCheckpoint[playerid] < sizeof(gCityHallBooksPos)-1 && g_pCheckpoint[playerid] >= 0)
			{
				g_pCheckpoint[playerid]++;
				new cpid = g_pCheckpoint[playerid];
				SetPlayerRaceCheckpoint(playerid, 0, gCityHallBooksPos[cpid][0], gCityHallBooksPos[cpid][1], gCityHallBooksPos[cpid][2], gCityHallBooksPos[cpid+1][0], gCityHallBooksPos[cpid+1][1], gCityHallBooksPos[cpid+1][2], 1.0);
				ApplyAnimation(playerid, "INT_SHOP", "SHOP_LOOP", 4.1, 0, 1, 1, 0, 0, 1);
				GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~w~Va para a prox. ~g~~h~prateleira", 1500, 3);
			}
            else if(g_pCheckpoint[playerid] == -1)
			{
				g_pCheckpoint[playerid] = 0;
                SetPlayerCPID(playerid, CHECKPOINT_NONE);
				DisablePlayerRaceCheckpoint(playerid);
                SetPlayerFirstTime(playerid, FIRST_TIME_CITY_HALL, true);

				GivePlayerCash(playerid, 800);
				foreach(new i: Player)
				{
					if(IsPlayerInRangeOfPoint(i, 8.0, 361.8299, 173.5555, 1008.3828))
					{
						new message[54 + MAX_PLAYER_NAME];
						format(message, sizeof(message), "* Secretaria entrega uma quantia de dinheiro para %s.", GetPlayerNamef(playerid));
						SendClientMessage(i, 0xDA70D6FF, message);
					}
				}
			}
            else
			{
				g_pCheckpoint[playerid] = -1;
				ApplyAnimation(playerid, "INT_SHOP", "SHOP_LOOP", 4.1, 0, 1, 1, 0, 0, 1);
                SetPlayerRaceCheckpoint(playerid, 1, 361.8299, 173.5555, 1008.3828, 0.0, 0.0, 0.0, 1.0);
				SendClientMessage(playerid, 0xFFFFFFFF, "* Volte para o {D1E28E}balcão{FFFFFF} para falar com a secretaria.");
			}
        }
    }
}

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
    gPlayerSoundPart[playerid] = 0;
    gIsPlayerTalkin[playerid] = false;
    g_pCheckpoint[playerid] = 0;
    return 1;
}
