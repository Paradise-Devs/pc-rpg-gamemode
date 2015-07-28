/*******************************************************************************
* FILENAME :        modules/job/pilot.pwn
*
* DESCRIPTION :
*       Adds pilot job to the server.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

// Checkpointid
static STREAMER_TAG_CP gCheckpointid;

//------------------------------------------------------------------------------

static gPilotServices[][][] = {
    {1000, "Testar aviões de pequeno porte"},
    {2000, "Levar mercadorias"},
    {3000, "Piloto de passeio"},
    {5000, "Piloto privado"},
    {10000, "Piloto comercial"}
};

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
    print("Loading pilot job.");
	CreateDynamicPickup(1210, 1, 1954.4822, -2177.7603, 13.5469, 0, 0, -1, MAX_PICKUP_RANGE);
	CreateDynamic3DTextLabel("Piloto\nPressione ENTER", 0xFFFFFFFF, 1954.4822, -2177.7603, 13.5469, MAX_TEXT3D_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
    gCheckpointid = CreateDynamicCP(1957.1, -2181.5964, 13.5469, 1.0, 0, 0);
	return 1;
}

//------------------------------------------------------------------------------

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
    {
        case DIALOG_PILOT_JOB:
        {
            if(!response)
                PlayCancelSound(playerid);
            else
            {
                if(GetPlayerJobID(playerid) != INVALID_JOB_ID)
                {
                    PlayErrorSound(playerid);
                    SendClientMessage(playerid, COLOR_ERROR, "* Você já possui um emprego.");
                }
                else
                {
                    SetPlayerJobID(playerid, PILOT_JOB_ID);
                    SendClientMessage(playerid, COLOR_SPECIAL, "* Agora você é um piloto!");
                    SendClientMessage(playerid, COLOR_SUB_TITLE, "* Vá até a cabine da entrada do aeroporto procurar por serviços.");
                    PlayConfirmSound(playerid);
                }
            }
            return -2;
        }
        case DIALOG_PILOT_SERVICES:
        {
            if(!response)
                PlayCancelSound(playerid);
            else if(GetPlayerJobLV(playerid) < listitem+1)
            {
                PlayErrorSound(playerid);
                SendClientMessage(playerid, COLOR_ERROR, "* Você não tem nível de emprego suficiente para este serviço.");
                SetCameraBehindPlayer(playerid);
            }
            return -2;
        }
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerEnterDynamicCP(playerid, STREAMER_TAG_CP checkpointid)
{
    if(checkpointid == gCheckpointid)
    {
        if(GetPlayerJobID(playerid) != PILOT_JOB_ID)
        {
            PlayErrorSound(playerid);
            SendClientMessage(playerid, COLOR_ERROR, "* Você não é um piloto.");
        }
        else
        {
            PlaySelectSound(playerid);
            new info[300], buffer[60];
            strcat(info, "Serviço\tPagamento\tNível");
            for(new i = 0; i < sizeof(gPilotServices); i++)
            {
                format(buffer, sizeof(buffer), "\n%s\t$%s\t%i", gPilotServices[i][1], formatnumber(gPilotServices[i][0][0]), i+1);
                strcat(info, buffer);
            }
            ShowPlayerDialog(playerid, DIALOG_PILOT_SERVICES,  DIALOG_STYLE_TABLIST_HEADERS, "Piloto -> Serviços", info, "Aceitar", "Recusar");
        }
        return -2;
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if((newkeys == KEY_SECONDARY_ATTACK) && IsPlayerInRangeOfPoint(playerid, 3.0, 1954.4822, -2177.7603, 13.5469))
	{
		new sDialogText[900];
		strcat(sDialogText, "{FFEE00}Informação:\n");
		strcat(sDialogText, "{ADBEE6}Este emprego é usado para transportar pessoas e mercadorias de um local a outro.\n");
		strcat(sDialogText, "{ADBEE6}Este emprego requer nível 8 de jogo para adquiri-lo.\n");
		strcat(sDialogText, "{ADBEE6}Este emprego é legal e você não será preso por trabalhar nele.\n\n");

		strcat(sDialogText, "{FFEE00}Comandos:\n");
		strcat(sDialogText, "{ADBEE6}Nenhum - Pergunte na portaria por mais serviços.\n\n");

		strcat(sDialogText, "{FFEE00}Localização do emprego:\n");
		strcat(sDialogText, "{ADBEE6}Este emprego pode ser obtido em Los Santos International, no ícone de maleta.\n\n");

		strcat(sDialogText, "{FF1A1A}Anotações Importante(s):\n");
		strcat(sDialogText, "{ADBEE6}Conforme você vai cumprindo serviços você irá subindo de cargo, liberando novos aviões e mais recompensa pelos serviços.\n");
		strcat(sDialogText, "{ADBEE6}Para trabalhar neste emprego você precisa possuir habilitação para aviões.\n\n");

		strcat(sDialogText, "{FF1A1A}Contrato:\n");
		if(IsPlayerDonator(playerid)) strcat(sDialogText, "{ADBEE6}Você terá de cumprir um contrato de 10 minutos antes de poder sair do emprego.");
		else strcat(sDialogText, "{ADBEE6}Você terá de cumprir um contrato de 1 hora antes de poder sair do emprego.");
        ShowPlayerDialog(playerid, DIALOG_PILOT_JOB, DIALOG_STYLE_MSGBOX, "Emprego: Piloto", sDialogText, "Aceitar", "Recusar");
		return 1;
	}
	return 1;
}
