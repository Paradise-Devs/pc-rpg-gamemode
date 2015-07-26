/*******************************************************************************
* FILENAME :        modules/gameplay/hospital.pwn
*
* DESCRIPTION :
*       Sends player to the hospital when he dies.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
* AUTHOR :    Larceny           START DATE :    25 Jul 15
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

enum e_ph_data
{
    e_ph_time
}
static gPHdata[MAX_PLAYERS][e_ph_data];

//------------------------------------------------------------------------------

GetPlayerHospitalTime(playerid)
    return gPHdata[playerid][e_ph_time];

SetPlayerHospitalTime(playerid, value)
    gPHdata[playerid][e_ph_time] = value;

//------------------------------------------------------------------------------

hook OnPlayerConnect(playerid, reason)
{
    gPHdata[playerid][e_ph_time] = 0;
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerDeath(playerid, killerid, reason)
{
    gPHdata[playerid][e_ph_time] = HOSPITAL_TIME;
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerSpawn(playerid)
{
    if(gPHdata[playerid][e_ph_time] > 0)
    {
        SendClientMessage(playerid, COLOR_INFO, "* Você está se recuperando, aguarde...");

        SetPlayerVirtualWorld(playerid, 1);
        new Float:gMedicSpawns[3][3] =
		{
			{348.9868,165.0690,1014.6947},
			{348.8042,162.5563,1014.6947},
			{348.8767,159.9840,1014.6947}
		};

		new rand = random(sizeof(gMedicSpawns));
		SetPlayerPos(playerid, gMedicSpawns[rand][0], gMedicSpawns[rand][1], gMedicSpawns[rand][2]);
		SetPlayerFacingAngle(playerid, 0);
		SetPlayerInterior(playerid, 3);

		ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.1, 1, 0, 0, 1, 0, 1);
		PlayerPlaySound(playerid, 1076, 0.0, 0.0, 0.0);

        defer OnPlayerHospitalUpdate(playerid);
    }
    return -1;
}

//------------------------------------------------------------------------------

timer OnPlayerHospitalUpdate[1000](playerid)
{
    if(!IsPlayerLogged(playerid))
        return 1;

    if(gPHdata[playerid][e_ph_time] == 1)
    {
        SendClientMessage(playerid, COLOR_SUCCESS, "* Você se recuperou e o hospital cobrou pelos serviços.");
        GivePlayerCash(playerid, -HOSPITAL_PRICE);

    	SetCameraBehindPlayer(playerid);
    	SetPlayerPos(playerid, 1177.4866,-1323.9749,14.0731);
    	SetPlayerFacingAngle(playerid, 270.0);
    	SetPlayerInterior(playerid, 0);
    	SetPlayerVirtualWorld(playerid, 0);

    	PlayerPlaySound(playerid, 1077, 0.0, 0.0, 0.0);

        OnDestroyPlayerDeadbody(playerid);
    }
    else if(gPHdata[playerid][e_ph_time] > 0)
    {
        if(GetPlayerAnimationIndex(playerid) != 390)
			ApplyAnimation(playerid, "CRACK", "crckidle2", 4.1, 1, 0, 0, 1, 0);

        new output[134];
        format(output, sizeof(output), "~n~~n~~n~~n~~n~~n~~n~                                           ~r~Em coma...~n~                                          %02d:%02d", gPHdata[playerid][e_ph_time] / 60, gPHdata[playerid][e_ph_time] % 60);
        GameTextForPlayer(playerid, output, 1100, 3);
        gPHdata[playerid][e_ph_time]--;
        defer OnPlayerHospitalUpdate(playerid);
    }
    return 1;
}
