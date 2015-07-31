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

// Amount of XP multipled by job level to level up.
static const REQUIRED_XP = 125;

// Amount of XP multipled by job level the player will recieve for deliver.
static const XP_SCALE = 10;

//------------------------------------------------------------------------------

static gPilotServices[][][] =
{
    {1000, "Testar aviões de pequeno porte"},
    {2000, "Levar mercadorias"},
    {3000, "Piloto de passeio"},
    {5000, "Piloto privado"},
    {10000, "Piloto comercial"}
};

static Float:gPilotCheckpoints[][][] =
{
    {
        {2054.1265,	-2493.8489,	13.8452,	91.4724},
        {1475.4282,	-2493.5117,	66.9498,	86.1570},
        {1128.7266,	-2343.5603,	98.4655,	60.3041},
        {909.6150,	-2069.9292,	99.1051,	47.6028},
        {616.5660,	-1872.7959,	112.3478,	43.2559},
        {461.0778,	-1615.1846,	112.2309,	21.5616},
        {444.7950,	-1384.2529,	138.0470,	354.8569},
        {509.0371,	-1229.9012,	153.3936,	330.0956},
        {827.1981,	-916.9576,	169.7193,	296.9095},
        {1111.1775,	-828.5963,	182.3320,	277.0523},
        {1358.8469,	-863.9774,	179.5065,	255.6490},
        {1611.3414,	-992.2854,	175.8651,	233.4423},
        {1830.9020,	-1168.2623,	155.9554,	226.8032},
        {2006.6550,	-1397.7028,	127.5173,	224.0789},
        {2193.9187,	-1637.4517,	132.7093,	217.3337},
        {2268.8188,	-1823.7314,	136.7986,	194.7329},
        {2285.9221,	-2200.0549,	115.9421,	168.3723},
        {1461.9639,	-2592.5193,	13.8291,	88.9984}
    },
    {
        {2054.12650,    -2493.8489,	14.3000,    91.4724},
        {-1651.0690,    -158.9726,  15.4803,    315.1306},
        {1478.41200,    -2592.8333, 14.8861,    90.3482},
        {0.0,           0.0,        0.0,        0.0},
        {0.0,           0.0,        0.0,        0.0},
        {0.0,           0.0,        0.0,        0.0},
        {0.0,           0.0,        0.0,        0.0},
        {0.0,           0.0,        0.0,        0.0},
        {0.0,           0.0,        0.0,        0.0},
        {0.0,           0.0,        0.0,        0.0},
        {0.0,           0.0,        0.0,        0.0},
        {0.0,           0.0,        0.0,        0.0},
        {0.0,           0.0,        0.0,        0.0},
        {0.0,           0.0,        0.0,        0.0},
        {0.0,           0.0,        0.0,        0.0},
        {0.0,           0.0,        0.0,        0.0},
        {0.0,           0.0,        0.0,        0.0},
        {0.0,           0.0,        0.0,        0.0}
    },
    {
        {2063.6990,	-2493.7148,	14.9224,	89.9396},
        {1416.9952,	-2489.2361,	46.6593,	89.5995},
        {859.3854,	-2122.5513,	97.8134,	72.8206},
        {355.3760,	-1939.3934,	128.9462,	61.6242},
        {30.5819,	-1587.6959,	154.8984,	34.1496},
        {-55.2750,	-1158.4691,	177.8976,	358.6408},
        {268.4062,	-602.8958,	223.9518,	308.2401},
        {916.6452,	-382.1201,	262.4483,	288.8401},
        {1775.7074,	-423.6345,	235.5766,	243.6390},
        {2228.6494,	-739.9728,	258.4167,	234.6330},
        {2875.3406,	-1200.5775,	241.2403,	219.6273},
        {2892.8047,	-1850.0393,	169.0984,	165.2068},
        {2849.3892,	-2165.0720,	184.3733,	162.6351},
        {2616.8169,	-2474.3325,	177.1170,	128.0519},
        {2114.0466,	-2587.2759,	89.8623,	92.7849},
        {1477.0249,	-2593.0061,	14.9218,	88.3415},
        {0.0,           0.0,        0.0,        0.0},
        {0.0,           0.0,        0.0,        0.0}
    },
    {
        {2066.3196,     -2493.5767,	14.4661,    90.1220},
        {-1651.3975,	-158.3260,	15.0760,    314.4883},
        {1477.3772,     1695.2845,	11.7344,    179.6740},
        {1477.5199,     -2593.3848,	14.4685,    90.7639},
        {0.0,           0.0,        0.0,        0.0},
        {0.0,           0.0,        0.0,        0.0},
        {0.0,           0.0,        0.0,        0.0},
        {0.0,           0.0,        0.0,        0.0},
        {0.0,           0.0,        0.0,        0.0},
        {0.0,           0.0,        0.0,        0.0},
        {0.0,           0.0,        0.0,        0.0},
        {0.0,           0.0,        0.0,        0.0},
        {0.0,           0.0,        0.0,        0.0},
        {0.0,           0.0,        0.0,        0.0},
        {0.0,           0.0,        0.0,        0.0},
        {0.0,           0.0,        0.0,        0.0},
        {0.0,           0.0,        0.0,        0.0},
        {0.0,           0.0,        0.0,        0.0}
    },
    {
        {2032.3551,     -2493.7759, 13.4586,  89.1950},
        {-1627.5024,    -134.0422,  14.0604,  314.4283},
        {1477.5643,     1661.2117,  10.7384,  179.6288},
        {1481.4575,     -2595.4895, 13.3776,  89.0782},
        {0.0,           0.0,        0.0,        0.0},
        {0.0,           0.0,        0.0,        0.0},
        {0.0,           0.0,        0.0,        0.0},
        {0.0,           0.0,        0.0,        0.0},
        {0.0,           0.0,        0.0,        0.0},
        {0.0,           0.0,        0.0,        0.0},
        {0.0,           0.0,        0.0,        0.0},
        {0.0,           0.0,        0.0,        0.0},
        {0.0,           0.0,        0.0,        0.0},
        {0.0,           0.0,        0.0,        0.0},
        {0.0,           0.0,        0.0,        0.0},
        {0.0,           0.0,        0.0,        0.0},
        {0.0,           0.0,        0.0,        0.0},
        {0.0,           0.0,        0.0,        0.0}
    }
};

static gPilotPlanes[] =
{
    512, 553, 511, 519, 577
};

static gPlayerPlane[MAX_PLAYERS] = {INVALID_VEHICLE_ID, ...};
static gPlayerCP[MAX_PLAYERS];
static gPlayerCF[MAX_PLAYERS];

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
    print("Loading pilot job.");
	CreateDynamicPickup(1210, 1, 1954.4822, -2177.7603, 13.5469, 0, 0, -1, MAX_PICKUP_RANGE);
	CreateDynamic3DTextLabel("Piloto\nPressione {1add69}Y", 0xFFFFFFFF, 1954.4822, -2177.7603, 13.5469, MAX_TEXT3D_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
    gCheckpointid = CreateDynamicCP(1957.1, -2181.5964, 13.5469, 1.0, 0, 0);
	return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
    if(gPlayerPlane[playerid] != INVALID_VEHICLE_ID)
    {
        SetPlayerPos(playerid, 1956.7430, -2183.7312, 13.5469);
        SetPlayerFacingAngle(playerid, 274.3091);

        DestroyVehicle(gPlayerPlane[playerid]);
        gPlayerPlane[playerid] = INVALID_VEHICLE_ID;
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
    switch(newstate)
    {
        case PLAYER_STATE_ONFOOT:
        {
            if(gPlayerPlane[playerid] != INVALID_VEHICLE_ID)
            {
                SendClientMessage(playerid, COLOR_ERROR, "* Você abandonou o avião.");

                SetPlayerPos(playerid, 1956.7430, -2183.7312, 13.5469);
                SetPlayerFacingAngle(playerid, 274.3091);
                SetCameraBehindPlayer(playerid);

                DisablePlayerRaceCheckpoint(playerid);

                DestroyVehicle(gPlayerPlane[playerid]);
                gPlayerPlane[playerid] = INVALID_VEHICLE_ID;

                SetPlayerCPID(playerid, CHECKPOINT_NONE);
            }
        }
        case PLAYER_STATE_WASTED:
        {
            if(gPlayerPlane[playerid] != INVALID_VEHICLE_ID)
            {
                new f = gPlayerCF[playerid];
                SendClientMessage(playerid, COLOR_ERROR, "* Você detonou o avião.");
                new output[50];
                format(output, sizeof(output), "* Foram descontados $%s pelos reparos.", formatnumber(gPilotServices[f][0][0] * 2));
                SendClientMessage(playerid, COLOR_SUB_TITLE, output);
                GivePlayerCash(playerid, -(gPilotServices[f][0][0] * 2));

                DisablePlayerRaceCheckpoint(playerid);

                DestroyVehicle(gPlayerPlane[playerid]);
                gPlayerPlane[playerid] = INVALID_VEHICLE_ID;

                SetPlayerCPID(playerid, CHECKPOINT_NONE);
            }
        }
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerEnterRaceCPT(playerid)
{
    if(GetPlayerCPID(playerid) == CHECKPOINT_PILOT)
    {
        new i = ++gPlayerCP[playerid];
        new f = gPlayerCF[playerid];
        PlaySelectSound(playerid);
        if(i == sizeof(gPilotCheckpoints[]))
        {
            SendClientMessage(playerid, COLOR_SPECIAL, "* Você terminou o serviço!");

            new output[50];
            format(output, sizeof(output), "* Você recebeu seu pagamento: $%s.", formatnumber(gPilotServices[f][0][0]));
            SendClientMessage(playerid, COLOR_SUB_TITLE, output);
            GivePlayerCash(playerid, gPilotServices[f][0][0]);

            SetPlayerPos(playerid, 1956.7430, -2183.7312, 13.5469);
            SetPlayerFacingAngle(playerid, 274.3091);
            SetCameraBehindPlayer(playerid);

            DisablePlayerRaceCheckpoint(playerid);

            DestroyVehicle(gPlayerPlane[playerid]);
            gPlayerPlane[playerid] = INVALID_VEHICLE_ID;

            SetPlayerCPID(playerid, CHECKPOINT_NONE);
            SetPlayerJobXP(playerid, GetPlayerJobXP(playerid) + (GetPlayerJobLV(playerid) * XP_SCALE));
            if(GetPlayerJobXP(playerid) > (GetPlayerJobLV(playerid) * REQUIRED_XP))
            {
                SendClientMessage(playerid, COLOR_SPECIAL, " ");
                SendClientMessage(playerid, COLOR_SPECIAL, "* Você subiu de nível no emprego!");
                if(GetPlayerJobLV(playerid) <= sizeof(gPilotServices))
                    SendClientMessage(playerid, COLOR_SUB_TITLE, "* Você liberou um novo serviço.");
                SetPlayerJobXP(playerid, 0);
                SetPlayerJobLV(playerid, GetPlayerJobLV(playerid) + 1);
                PlayConfirmSound(playerid);
            }
        }
        else if(gPilotCheckpoints[f][i][0] == 0.0 && gPilotCheckpoints[f][i][1] == 0.0)
        {
            SendClientMessage(playerid, COLOR_SPECIAL, "* Você terminou o serviço!");

            new output[50];
            format(output, sizeof(output), "* Você recebeu seu pagamento: $%s.", formatnumber(gPilotServices[f][0][0]));
            SendClientMessage(playerid, COLOR_SUB_TITLE, output);
            GivePlayerCash(playerid, gPilotServices[f][0][0]);

            SetPlayerPos(playerid, 1956.7430, -2183.7312, 13.5469);
            SetPlayerFacingAngle(playerid, 274.3091);
            SetCameraBehindPlayer(playerid);

            DisablePlayerRaceCheckpoint(playerid);

            DestroyVehicle(gPlayerPlane[playerid]);
            gPlayerPlane[playerid] = INVALID_VEHICLE_ID;

            SetPlayerCPID(playerid, CHECKPOINT_NONE);
            SetPlayerJobXP(playerid, GetPlayerJobXP(playerid) + (GetPlayerJobLV(playerid) * XP_SCALE));
            if(GetPlayerJobXP(playerid) > (GetPlayerJobLV(playerid) * REQUIRED_XP))
            {
                SendClientMessage(playerid, COLOR_SPECIAL, " ");
                SendClientMessage(playerid, COLOR_SPECIAL, "* Você subiu de nível no emprego!");
                if(GetPlayerJobLV(playerid) <= sizeof(gPilotServices))
                    SendClientMessage(playerid, COLOR_SUB_TITLE, "* Você liberou um novo serviço.");
                SetPlayerJobXP(playerid, 0);
                SetPlayerJobLV(playerid, GetPlayerJobLV(playerid) + 1);
                PlayConfirmSound(playerid);
            }
        }
        else if(i == sizeof(gPilotCheckpoints[])-1)
            SetPlayerRaceCheckpoint(playerid, 4, gPilotCheckpoints[f][i][0], gPilotCheckpoints[f][i][1], gPilotCheckpoints[f][i][2], 0.0, 0.0, 0.0, 10.0);
        else
            SetPlayerRaceCheckpoint(playerid, 3, gPilotCheckpoints[f][i][0], gPilotCheckpoints[f][i][1], gPilotCheckpoints[f][i][2], gPilotCheckpoints[f][i+1][0], gPilotCheckpoints[f][i+1][1], gPilotCheckpoints[f][i+1][2], 10.0);
        return -2;
    }
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
            else
            {
                SendClientMessage(playerid, COLOR_SPECIAL, "* Siga os checkpoints para completar o serviço.");
                SendClientMessage(playerid, COLOR_SUB_TITLE, "* Caso você destrua o avião será descontado de seu dinheiro.");
                gPlayerPlane[playerid] = CreateVehicle(gPilotPlanes[listitem], gPilotCheckpoints[listitem][0][0], gPilotCheckpoints[listitem][0][1], gPilotCheckpoints[listitem][0][2], gPilotCheckpoints[listitem][0][3], -1, -1, -1);
                PutPlayerInVehicle(playerid, gPlayerPlane[playerid], 0);
                SetVehicleFuel(gPlayerPlane[playerid], 100.0);
                gPlayerCP[playerid] = 1;
                gPlayerCF[playerid] = listitem;

                SetPlayerRaceCheckpoint(playerid, 3, gPilotCheckpoints[listitem][1][0], gPilotCheckpoints[listitem][1][1], gPilotCheckpoints[listitem][1][2], gPilotCheckpoints[listitem][2][0], gPilotCheckpoints[listitem][2][1], gPilotCheckpoints[listitem][2][2], 5.0);
                SetPlayerCPID(playerid, CHECKPOINT_PILOT);
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
	if((newkeys == KEY_YES) && IsPlayerInRangeOfPoint(playerid, 3.0, 1954.4822, -2177.7603, 13.5469))
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
