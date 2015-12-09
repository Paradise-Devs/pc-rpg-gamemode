/*******************************************************************************
* FILENAME :        modules/gameplay/gym.pwn
*
* DESCRIPTION :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

//------------------------------------------------------------------------------

#include <YSI\y_hooks>

#define BENCH_PRESS_INDEX (9)

//------------------------------------------------------------------------------

// Running machine
static Float:run_machine_pos[][] =
{
    { 773.4922, -2.6016,   1000.7209,  180.00000 }, // Los Santos
    { 759.6328, -48.1250 , 1000.7209,  180.00000}, // San Fierro
    { 758.3828, -65.5078,  1000.7209,  180.00000} // Las Venturas
};

// Bike
static Float:bike_pos[][] =
{
    {772.172,  9.41406,    1000.0, 90.0}, // Los Santos
    {769.242,  -47.8984,   1000.0, 90.0}, // San Fierro
    {774.625,  -68.6406,   1000.0, 90.0} // Las Venturas
};

// Bench
static Float:bench_pos[][] =
{
    { 773.0491,    1.4285,     1000.7209, 269.2024 }, // Los Santos
    { 766.3170,    -47.3574,   1000.5859, 179.2983 }, // San Fierro
    { 764.9001,    -60.5580,   1000.6563, 1.9500 } // Las Venturas
};

// BarBell
static Float:barbell_pos[][] =
{
    { 774.42907715,    1.88309872,     1000.48834229,  0.00000000, 270.00000000,   87.99966431 }, // Los Santos
    { 765.85528564,    -48.86857224,   1000.64093018,  0.00000000, 89.49993896,    0.00000000 }, // San Fierro
    { 765.34039307,    -59.18271637,   1000.63793945,  0.00000000, 89.49993896,    181.25012207 } // Las Venturas
};

// Dumb
static Float:dumb_pos[][] =
{
    {772.992,  5.38281,    999.727,    270.0}, // Los Santos
    {756.406,  -47.9219,   999.727,    90.0}, // San Fierro
    {759.18,   -60.0625,   999.727,    90.0} // Las Venturas
};

static Float:dumb_bell_right_pos[][] =
{
    {772.992,  5.18281,    999.927,    0.0,    90.0,   90.0} // Los Santos
};

static Float:dumb_bell_left_pos[][] =
{
    {772.992,  5.62738,    999.927,    0.0,    90.0,   90.0} // Los Santos
};

//------------------------------------------------------------------------------

// Tream
static g_plCurrentTread[MAX_PLAYERS];
static bool:g_isPlayerInTream[MAX_PLAYERS];
static bool:g_isTreamInUse[sizeof run_machine_pos];

// Bike
static g_plCurrentBike[MAX_PLAYERS];
static bool:g_isPlayerInBike[MAX_PLAYERS];
static bool:g_isBikeInUse[sizeof bike_pos];

// Bench
static g_plCurrentBench[MAX_PLAYERS];
static bool:g_isPlayerInBench[MAX_PLAYERS];
static bool:g_isBenchInUse[sizeof bench_pos];

// Dumb Bell
static g_plCurrentDumb[MAX_PLAYERS];
static bool:g_isPlayerInDumb[MAX_PLAYERS];
static bool:g_isDumbInUse[sizeof bench_pos];

// Gobale
static bool:g_plBarCanBeUsed[MAX_PLAYERS];
static barbell_objects[sizeof barbell_pos];
static dumbell_right_objects[sizeof dumb_bell_right_pos];
static dumbell_left_objects[sizeof dumb_bell_left_pos];

//------------------------------------------------------------------------------

// TextDraws
static PlayerText:gym_des[MAX_PLAYERS];
static PlayerText:gym_power[MAX_PLAYERS];
static PlayerText:gym_deslabel[MAX_PLAYERS];
static PlayerText:gym_repslabel[MAX_PLAYERS];
static PlayerBar:player_gym_progress[MAX_PLAYERS];

//------------------------------------------------------------------------------

// Timers
static g_plTreadTimer[MAX_PLAYERS];
static g_plBikeTimer[MAX_PLAYERS];
static g_plBenchTimer[MAX_PLAYERS];
static g_plDumbTimer[MAX_PLAYERS];

//------------------------------------------------------------------------------

// Player Counts
static g_plDumbCount[MAX_PLAYERS];
static g_plBenchCount[MAX_PLAYERS];
static g_plBikeDistCount[MAX_PLAYERS];
static g_plTreamDistCount[MAX_PLAYERS];

//------------------------------------------------------------------------------

hook OnPlayerConnect(playerid)
{
    if(IsPlayerNPC(playerid))
        return 1;

    player_gym_progress[playerid] = CreatePlayerProgressBar(playerid, 550.000000, 166.000000, 55.5, 3.2, COLOR_INFO);

    gym_power[playerid] = CreatePlayerTextDraw(playerid, 426.000000, 158.000000, ConvertToGameText("FORÇA:"));
    PlayerTextDrawBackgroundColor(playerid, gym_power[playerid], 255);
    PlayerTextDrawFont(playerid, gym_power[playerid], 2);
    PlayerTextDrawLetterSize(playerid, gym_power[playerid], 0.400000, 1.800000);
    PlayerTextDrawColor(playerid, gym_power[playerid], COLOR_INFO);
    PlayerTextDrawSetOutline(playerid, gym_power[playerid], 0);
    PlayerTextDrawSetProportional(playerid, gym_power[playerid], 1);
    PlayerTextDrawSetShadow(playerid, gym_power[playerid], 1);

    gym_des[playerid] = CreatePlayerTextDraw(playerid, 426.000000, 203.000000, ConvertToGameText("DISTÂNCIA:"));
    PlayerTextDrawBackgroundColor(playerid, gym_des[playerid], 255);
    PlayerTextDrawFont(playerid, gym_des[playerid], 2);
    PlayerTextDrawLetterSize(playerid, gym_des[playerid], 0.509999, 1.800000);
    PlayerTextDrawColor(playerid, gym_des[playerid], COLOR_INFO);
    PlayerTextDrawSetOutline(playerid, gym_des[playerid], 0);
    PlayerTextDrawSetProportional(playerid, gym_des[playerid], 1);
    PlayerTextDrawSetShadow(playerid, gym_des[playerid], 1);

    gym_repslabel[playerid] = CreatePlayerTextDraw(playerid, 426.000000, 203.000000, "REPS:");
    PlayerTextDrawBackgroundColor(playerid, gym_repslabel[playerid], 255);
    PlayerTextDrawFont(playerid, gym_repslabel[playerid], 2);
    PlayerTextDrawLetterSize(playerid, gym_repslabel[playerid], 0.509999, 1.800000);
    PlayerTextDrawColor(playerid, gym_repslabel[playerid], COLOR_INFO);
    PlayerTextDrawSetOutline(playerid, gym_repslabel[playerid], 0);
    PlayerTextDrawSetProportional(playerid, gym_repslabel[playerid], 1);
    PlayerTextDrawSetShadow(playerid, gym_repslabel[playerid], 1);

    gym_deslabel[playerid] = CreatePlayerTextDraw(playerid, 557.000000, 203.000000, "0");
    PlayerTextDrawBackgroundColor(playerid, gym_deslabel[playerid], 255);
    PlayerTextDrawFont(playerid, gym_deslabel[playerid], 2);
    PlayerTextDrawLetterSize(playerid, gym_deslabel[playerid], 0.509999, 1.800000);
    PlayerTextDrawColor(playerid, gym_deslabel[playerid], COLOR_INFO);
    PlayerTextDrawSetOutline(playerid, gym_deslabel[playerid], 0);
    PlayerTextDrawSetProportional(playerid, gym_deslabel[playerid], 1);
    PlayerTextDrawSetShadow(playerid, gym_deslabel[playerid], 1);
    return 1;
}

hook OnGameModeInit()
{
    for(new i, j = sizeof(barbell_pos); i < j; i++)
        barbell_objects[i] = CreateDynamicObject(2913, barbell_pos[i][0], barbell_pos[i][1], barbell_pos[i][2], barbell_pos[i][3], barbell_pos[i][4], barbell_pos[i][5]);
    for(new i, j = sizeof(dumb_bell_left_pos); i < j; i++)
        dumbell_left_objects[i]    = CreateDynamicObject(3072,dumb_bell_left_pos[i][0],dumb_bell_left_pos[i][1],dumb_bell_left_pos[i][2],dumb_bell_left_pos[i][3],dumb_bell_left_pos[i][4],dumb_bell_left_pos[i][5]);
    for(new i, j = sizeof(dumb_bell_right_pos); i < j; i++)
        dumbell_right_objects[i]   = CreateDynamicObject(3071,dumb_bell_right_pos[i][0],dumb_bell_right_pos[i][1],dumb_bell_right_pos[i][2],dumb_bell_right_pos[i][3],dumb_bell_right_pos[i][4],dumb_bell_right_pos[i][5]);
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if((newkeys & KEY_SECONDARY_ATTACK) && !(oldkeys & KEY_SECONDARY_ATTACK))
    {
        if(g_isPlayerInTream[playerid] && g_plBarCanBeUsed[playerid])
        {
            KillTimer(g_plTreadTimer[playerid]);
            GetOffTread(playerid);
        }
        else if(g_isPlayerInBike[playerid] && g_plBarCanBeUsed[playerid])
        {
            KillTimer(g_plBikeTimer[playerid]);
            GetOffBIKE(playerid);
        }
        else if(g_isPlayerInBench[playerid] && g_plBarCanBeUsed[playerid])
        {
            KillTimer(g_plBenchTimer[playerid]);
            GetOffBENCH(playerid);
        }
        else if(g_isPlayerInDumb[playerid] && g_plBarCanBeUsed[playerid])
        {
            KillTimer(g_plDumbTimer[playerid]);
            PutDownDUMB(playerid);
        }
        else
        {
            for(new o, j = sizeof run_machine_pos; o < j; o++)
            {
                if(IsPlayerInRangeOfPoint(playerid, 2.0, run_machine_pos[o][0], run_machine_pos[o][1], run_machine_pos[o][2]))
                {
                    if(!g_isTreamInUse[o] && !g_isPlayerInTream[playerid])
                    {
                        g_isTreamInUse[o] = true;
                        g_plCurrentTread[playerid] = o;
                        g_plTreamDistCount[playerid] = 0;
                        g_isPlayerInTream[playerid] = true;

                        TogglePlayerControllable(playerid, 0);
                        SetPlayerPos(playerid, run_machine_pos[o][0], run_machine_pos[o][1]+1.3, run_machine_pos[o][2]);
                        SetPlayerFacingAngle(playerid, run_machine_pos[o][3]);
                        ApplyAnimation(playerid, "GYMNASIUM", "gym_tread_geton", 1, 0, 0, 0, 1, 0, 1);
                        SetTimerEx("TREAM_START", 2000, false, "ii", playerid);

                        SetPlayerCameraPos(playerid, run_machine_pos[o][0] +2, run_machine_pos[o][1] -2, run_machine_pos[o][2] + 0.5);
                        SetPlayerCameraLookAt(playerid, run_machine_pos[o][0], run_machine_pos[o][1], run_machine_pos[o][2]);
                    }
                    else
                    {
                        GameTextForPlayer(playerid, "Maquina em uso", 5000, 4);
                    }
                }
            }

            for(new b, j = sizeof bike_pos; b < j; b++)
            {
                if(IsPlayerInRangeOfPoint(playerid, 2.0, bike_pos[b][0], bike_pos[b][1], bike_pos[b][2]))
                {
                    if(!g_isBikeInUse[b] && !g_isPlayerInBike[playerid])
                    {
                        g_isBikeInUse[b] = true;
                        g_plCurrentBike[playerid] = b;
                        g_plBikeDistCount[playerid] = 0;
                        g_isPlayerInBike[playerid] = true;

                        TogglePlayerControllable(playerid, 0);
                        SetPlayerPos(playerid, bike_pos[b][0]+0.5, bike_pos[b][1]-0.5, bike_pos[b][2]);
                        SetPlayerFacingAngle(playerid, bike_pos[b][3]);
                        ApplyAnimation(playerid, "GYMNASIUM", "gym_bike_geton", 1, 0, 0, 0, 1, 0, 1);

                        SetTimerEx("BIKE_START", 2000, false, "i", playerid);
                        SetPlayerCameraPos(playerid, bike_pos[b][0] +2, bike_pos[b][1] -2, bike_pos[b][2] + 0.5);
                        SetPlayerCameraLookAt(playerid, bike_pos[b][0], bike_pos[b][1], bike_pos[b][2]+0.5);
                    }
                    else
                    {
                        GameTextForPlayer(playerid, "Maquina em uso", 5000, 4);
                    }
                }
            }

            for(new g, j = sizeof bench_pos; g < j; g++)
            {
                if(IsPlayerInRangeOfPoint(playerid, 2.0, bench_pos[g][0], bench_pos[g][1], bench_pos[g][2]))
                {
                    if(!g_isBenchInUse[g] && !g_isPlayerInBench[playerid])
                    {
                        g_isBenchInUse[g] = true;
                        g_plBenchCount[playerid] = 0;
                        g_plCurrentBench[playerid] = g;
                        g_isPlayerInBench[playerid] = true;

                        TogglePlayerControllable(playerid, 0);
                        SetPlayerPos(playerid, bench_pos[g][0], bench_pos[g][1], bench_pos[g][2]);
                        SetPlayerFacingAngle(playerid, bench_pos[g][3]);
                        ApplyAnimation(playerid, "benchpress", "gym_bp_geton", 1, 0, 0, 0, 1, 0, 1);

                        SetTimerEx("BENCH_START", 3800, 0, "ii", playerid,g);
                        SetPlayerCameraPos(playerid, bench_pos[g][0]-1.5, bench_pos[g][1]+1.5, bench_pos[g][2] + 0.5);
                        SetPlayerCameraLookAt(playerid, bench_pos[g][0], bench_pos[g][1], bench_pos[g][2]);
                    }
                    else
                    {
                        GameTextForPlayer(playerid, "Maquina em uso", 5000, 4);
                    }
                }
            }

            for(new d, j = sizeof dumb_pos; d < j; d++)
            {
                if(IsPlayerInRangeOfPoint(playerid, 2.0, dumb_pos[d][0], dumb_pos[d][1], dumb_pos[d][2]))
                {
                    if(!g_isDumbInUse[d] && !g_isPlayerInDumb[playerid])
                    {
                        g_isDumbInUse[d] = true;
                        g_plDumbCount[playerid] = 0;
                        g_plCurrentDumb[playerid] = d;
                        g_isPlayerInDumb[playerid] = true;

                        TogglePlayerControllable(playerid, 0);
                        SetPlayerPos(playerid, dumb_pos[d][0]-1, dumb_pos[d][1], dumb_pos[d][2] +1);
                        SetPlayerFacingAngle(playerid, dumb_pos[d][3]);
                        ApplyAnimation(playerid, "Freeweights", "gym_free_pickup", 1, 0, 0, 0, 1, 0, 1);

                        SetTimerEx("DUMB_START", 2500, 0, "ii", playerid);
                        SetPlayerCameraPos(playerid, dumb_pos[d][0]+2.3, dumb_pos[d][1], dumb_pos[d][2]+0.3);
                        SetPlayerCameraLookAt(playerid, dumb_pos[d][0], dumb_pos[d][1], dumb_pos[d][2]+0.5);
                    }
                    else
                    {
                        GameTextForPlayer(playerid, "Maquina em uso", 5000, 4);
                    }
                }
            }
        }
    }
    else if((newkeys & KEY_SPRINT) && !(oldkeys & KEY_SPRINT))
    {
        if(g_isPlayerInTream[playerid] && g_plBarCanBeUsed[playerid])
        {
            new LocalLabel[10];
            g_plTreamDistCount[playerid]++;
            format(LocalLabel,sizeof(LocalLabel),"%d",g_plTreamDistCount[playerid]);
            PlayerTextDrawSetString(playerid, gym_deslabel[playerid], LocalLabel);
            SetPlayerProgressBarValue(playerid, player_gym_progress[playerid], (GetPlayerProgressBarValue(playerid,  player_gym_progress[playerid]) + 5.0));
        }
        else if(g_isPlayerInBike[playerid] && g_plBarCanBeUsed[playerid])
        {
            new LocalLabel[10];
            g_plBikeDistCount[playerid]++;
            format(LocalLabel,sizeof(LocalLabel),"%d",g_plBikeDistCount[playerid]);
            PlayerTextDrawSetString(playerid, gym_deslabel[playerid], LocalLabel);
            SetPlayerProgressBarValue(playerid, player_gym_progress[playerid], (GetPlayerProgressBarValue(playerid, player_gym_progress[playerid]) + 5.0));
        }
        else if(g_isPlayerInBench[playerid] && g_plBarCanBeUsed[playerid])
        {
            SetPlayerProgressBarValue(playerid, player_gym_progress[playerid], (GetPlayerProgressBarValue(playerid, player_gym_progress[playerid]) + 5.0));
        }
        else if(g_isPlayerInDumb[playerid] && g_plBarCanBeUsed[playerid])
        {
            SetPlayerProgressBarValue(playerid, player_gym_progress[playerid], (GetPlayerProgressBarValue(playerid, player_gym_progress[playerid]) + 5.0));
        }
    }
    return 1;
}

forward DUMB_START(playerid);
public DUMB_START(playerid)
{
    g_plBarCanBeUsed[playerid]=true;

    SetPlayerAttachedObject(playerid,1, 3072, 5);//left hand
    SetPlayerAttachedObject(playerid,2, 3071, 6);//right hand

    DestroyDynamicObject(dumbell_right_objects[g_plCurrentDumb[playerid]]);
    DestroyDynamicObject(dumbell_left_objects[g_plCurrentDumb[playerid]]);

    SetPlayerProgressBarValue(playerid, player_gym_progress[playerid], 0.0);
    ShowPlayerProgressBar(playerid, player_gym_progress[playerid]);
    PlayerTextDrawShow(playerid, gym_power[playerid]);
    PlayerTextDrawShow(playerid, gym_repslabel[playerid]);
    PlayerTextDrawShow(playerid, gym_deslabel[playerid]);
    g_plDumbTimer[playerid]=SetTimerEx("GYM_CHECK", 500,true,"i", playerid);
}

forward BIKE_START(playerid);
public BIKE_START(playerid)
{
    g_plBarCanBeUsed[playerid]=true;
    ApplyAnimation(playerid, "GYMNASIUM", "bike_start", 1, 1, 0, 0, 1, 0, 1);

    SetPlayerProgressBarValue(playerid, player_gym_progress[playerid], 0.0);
    ShowPlayerProgressBar(playerid, player_gym_progress[playerid]);
    PlayerTextDrawShow(playerid, gym_power[playerid]);
    PlayerTextDrawShow(playerid, gym_des[playerid]);
    PlayerTextDrawShow(playerid, gym_deslabel[playerid]);

    g_plBikeTimer[playerid] = SetTimerEx("GYM_CHECK", 500, 1, "i", playerid);
}

forward TREAM_START(playerid);
public TREAM_START(playerid)
{
    g_plBarCanBeUsed[playerid]=true;
    ApplyAnimation(playerid, "GYMNASIUM", "gym_tread_sprint", 1, 1, 0, 0, 1, 0, 1);

    SetPlayerProgressBarValue(playerid, player_gym_progress[playerid], 0.0);
    ShowPlayerProgressBar(playerid, player_gym_progress[playerid]);
    PlayerTextDrawShow(playerid, gym_power[playerid]);
    PlayerTextDrawShow(playerid, gym_des[playerid]);
    PlayerTextDrawShow(playerid, gym_deslabel[playerid]);

    g_plTreadTimer[playerid] = SetTimerEx("GYM_CHECK", 500, 1, "i", playerid);
}

forward BENCH_START(playerid,OBJ_INDEX);
public BENCH_START(playerid,OBJ_INDEX)
{
    g_plBarCanBeUsed[playerid]=true;

    SetPlayerAttachedObject(playerid, BENCH_PRESS_INDEX, 2913, 6);
    DestroyDynamicObject(barbell_objects[OBJ_INDEX]);

    SetPlayerProgressBarValue(playerid, player_gym_progress[playerid], 0.0);
    ShowPlayerProgressBar(playerid, player_gym_progress[playerid]);
    PlayerTextDrawShow(playerid, gym_power[playerid]);
    PlayerTextDrawShow(playerid, gym_repslabel[playerid]);
    PlayerTextDrawShow(playerid, gym_deslabel[playerid]);
    g_plBenchTimer[playerid]=SetTimerEx("GYM_CHECK", 500,true,"i", playerid);
}

forward GYM_CHECK(playerid);
public GYM_CHECK(playerid)
{
    if(g_isPlayerInTream[playerid])
    {
        TREAM_CHECK(playerid);
    }
    else if(g_isPlayerInBike[playerid])
    {
        BIKE_CHECK(playerid);
    }
    else if(g_isPlayerInBench[playerid])
    {
        BENCH_CHECK(playerid);
    }
    else if(g_isPlayerInDumb[playerid])
    {
        DUMB_CHECK(playerid);
    }
}

DUMB_CHECK(playerid)
{
    SetPlayerProgressBarValue(playerid, player_gym_progress[playerid], (GetPlayerProgressBarValue(playerid,  player_gym_progress[playerid]) - 2.0));

    if(GetPlayerProgressBarValue(playerid,  player_gym_progress[playerid]) >= 90)
    {
        switch(random(2))
        {
            case 0: ApplyAnimation(playerid, "freeweights", "gym_free_A", 1, 0, 0, 0, 1, 0, 1);
            case 1: ApplyAnimation(playerid, "freeweights", "gym_free_B", 1, 0, 0, 0, 1, 0, 1);
        }

        new LocalLabel[10];
        g_plDumbCount[playerid]++;
        format(LocalLabel,sizeof(LocalLabel),"%d",g_plDumbCount[playerid]);
        PlayerTextDrawSetString(playerid, gym_deslabel[playerid],LocalLabel);

        SetPlayerProgressBarValue(playerid, player_gym_progress[playerid], 0.0);
        SetTimerEx("DUMB_SET_AIMSTOP",2000, false, "i", playerid);
    }
}

BENCH_CHECK(playerid)
{
    SetPlayerProgressBarValue(playerid, player_gym_progress[playerid], (GetPlayerProgressBarValue(playerid,  player_gym_progress[playerid]) - 2.0));

    if(GetPlayerProgressBarValue(playerid,  player_gym_progress[playerid]) >= 90)
    {
        switch(random(2))
        {
            case 0: ApplyAnimation(playerid, "benchpress", "gym_bp_up_A", 1, 0, 0, 0, 1, 0, 1);
            case 1: ApplyAnimation(playerid, "benchpress", "gym_bp_up_B", 1, 0, 0, 0, 1, 0, 1);
        }

        new LocalLabel[10];
        g_plBenchCount[playerid]++;
        format(LocalLabel,sizeof(LocalLabel),"%d",g_plBenchCount[playerid]);
        PlayerTextDrawSetString(playerid, gym_deslabel[playerid],LocalLabel);

        SetPlayerProgressBarValue(playerid, player_gym_progress[playerid], 0.0);
        SetTimerEx("BENCH_SET_AIMSTOP",2000, false, "i", playerid);
    }
}

forward DUMB_SET_AIMSTOP(playerid);
public DUMB_SET_AIMSTOP(playerid)
{
    ApplyAnimation(playerid, "freeweights", "gym_free_down", 1, 0, 0, 0, 1, 0, 1);
}

forward BENCH_SET_AIMSTOP(playerid);
public BENCH_SET_AIMSTOP(playerid)
{
    ApplyAnimation(playerid, "benchpress", "gym_bp_down", 1, 0, 0, 0, 1, 0, 1);
}

BIKE_CHECK(playerid)
{
    SetPlayerProgressBarValue(playerid, player_gym_progress[playerid], (GetPlayerProgressBarValue(playerid,  player_gym_progress[playerid]) - 8.0));
    if(GetPlayerProgressBarValue(playerid,  player_gym_progress[playerid]) <= 0)
    {
        ApplyAnimation(playerid, "GYMNASIUM", "gym_bike_still", 1, 1, 0, 0, 1, 0, 1);
    }
    else
    {
        ApplyAnimation(playerid, "GYMNASIUM", "gym_bike_fast", 1, 1, 0, 0, 1, 0, 1);
    }
}

TREAM_CHECK(playerid)
{
    SetPlayerProgressBarValue(playerid, player_gym_progress[playerid], (GetPlayerProgressBarValue(playerid,  player_gym_progress[playerid]) - 8.0));
    if(GetPlayerProgressBarValue(playerid,  player_gym_progress[playerid]) <= 0)
    {
        KillTimer(g_plTreadTimer[playerid]);
        FallOffTread(playerid);
    }
}

FallOffTread(playerid)
{
    g_plBarCanBeUsed[playerid] = false;
    ApplyAnimation(playerid, "GYMNASIUM", "gym_tread_falloff", 1, 0, 0, 0, 1, 0, 1);

    HidePlayerProgressBar(playerid, player_gym_progress[playerid]);
    PlayerTextDrawHide(playerid, gym_power[playerid]);
    PlayerTextDrawHide(playerid, gym_des[playerid]);
    PlayerTextDrawHide(playerid, gym_deslabel[playerid]);
    SetTimerEx("REST_PLAYER", 2000, false, "i", playerid);
}

GetOffTread(playerid)
{
    g_plBarCanBeUsed[playerid] = false;
    ApplyAnimation(playerid, "GYMNASIUM", "gym_tread_getoff", 1, 0, 0, 0, 1, 0, 1);
    HidePlayerProgressBar(playerid, player_gym_progress[playerid]);
    PlayerTextDrawHide(playerid, gym_power[playerid]);
    PlayerTextDrawHide(playerid, gym_des[playerid]);
    PlayerTextDrawHide(playerid, gym_deslabel[playerid]);

    SetTimerEx("REST_PLAYER", 3500, false, "i", playerid);
}

GetOffBENCH(playerid)
{
    g_plBarCanBeUsed[playerid] = false;
    ApplyAnimation(playerid, "benchpress", "gym_bp_getoff", 1, 0, 0, 0, 1, 0, 1);
    HidePlayerProgressBar(playerid, player_gym_progress[playerid]);

    PlayerTextDrawHide(playerid, gym_power[playerid]);
    PlayerTextDrawHide(playerid, gym_repslabel[playerid]);
    PlayerTextDrawHide(playerid, gym_deslabel[playerid]);
    SetTimerEx("REST_PLAYER", 5000, false, "i", playerid);
}

PutDownDUMB(playerid)
{
    g_plBarCanBeUsed[playerid] = false;
    ApplyAnimation(playerid, "freeweights", "gym_free_putdown", 1, 0, 0, 0, 1, 0, 1);
    HidePlayerProgressBar(playerid, player_gym_progress[playerid]);

    PlayerTextDrawHide(playerid, gym_power[playerid]);
    PlayerTextDrawHide(playerid, gym_repslabel[playerid]);
    PlayerTextDrawHide(playerid, gym_deslabel[playerid]);
    SetTimerEx("REST_PLAYER",3000, false, "i", playerid);
}

GetOffBIKE(playerid)
{
    g_plBarCanBeUsed[playerid] = false;
    ApplyAnimation(playerid, "GYMNASIUM", "gym_bike_getoff", 1, 0, 0, 0, 1, 0, 1);
    HidePlayerProgressBar(playerid, player_gym_progress[playerid]);
    PlayerTextDrawHide(playerid, gym_power[playerid]);
    PlayerTextDrawHide(playerid, gym_des[playerid]);
    PlayerTextDrawHide(playerid, gym_deslabel[playerid]);
    SetTimerEx("REST_PLAYER", 2000, false, "i", playerid);
}

forward REST_PLAYER(playerid);
public REST_PLAYER(playerid)
{
    g_plBarCanBeUsed[playerid] = false;

    ClearAnimations(playerid, 1);
    SetCameraBehindPlayer(playerid);
    TogglePlayerControllable(playerid, 1);

    if(g_isPlayerInTream[playerid])
    {
        g_isPlayerInTream[playerid] = false;
        g_isTreamInUse[g_plCurrentTread[playerid]] = false;
    }
    else if(g_isPlayerInBike[playerid])
    {
        g_isPlayerInBike[playerid] = false;
        g_isBikeInUse[g_plCurrentBike[playerid]] = false;
    }
    else if(g_isPlayerInBench[playerid])
    {
        g_isPlayerInBench[playerid] = false;
        g_isBenchInUse[g_plCurrentBench[playerid]] = false;
        barbell_objects[g_plCurrentBench[playerid]] = CreateDynamicObject(2913, barbell_pos[g_plCurrentBench[playerid]][0], barbell_pos[g_plCurrentBench[playerid]][1], barbell_pos[g_plCurrentBench[playerid]][2], barbell_pos[g_plCurrentBench[playerid]][3], barbell_pos[g_plCurrentBench[playerid]][4], barbell_pos[g_plCurrentBench[playerid]][5]);
        RemovePlayerAttachedObject(playerid, BENCH_PRESS_INDEX);
    }
    else if(g_isPlayerInDumb[playerid])
    {
        g_isPlayerInDumb[playerid] = false;
        g_isDumbInUse[g_plCurrentDumb[playerid]] = false;
        dumbell_right_objects[g_plCurrentDumb[playerid]] = CreateDynamicObject(3071,dumb_bell_right_pos[g_plCurrentDumb[playerid]][0],dumb_bell_right_pos[g_plCurrentDumb[playerid]][1],dumb_bell_right_pos[g_plCurrentDumb[playerid]][2],dumb_bell_right_pos[g_plCurrentDumb[playerid]][3],dumb_bell_right_pos[g_plCurrentDumb[playerid]][4],dumb_bell_right_pos[g_plCurrentDumb[playerid]][5]);
        dumbell_left_objects[g_plCurrentDumb[playerid]] = CreateDynamicObject(3072,dumb_bell_left_pos[g_plCurrentDumb[playerid]][0],dumb_bell_left_pos[g_plCurrentDumb[playerid]][1],dumb_bell_left_pos[g_plCurrentDumb[playerid]][2],dumb_bell_left_pos[g_plCurrentDumb[playerid]][3],dumb_bell_left_pos[g_plCurrentDumb[playerid]][4],dumb_bell_left_pos[g_plCurrentDumb[playerid]][5]);
        RemovePlayerAttachedObject(playerid, 1);
        RemovePlayerAttachedObject(playerid, 2);
    }
}

hook OnPlayerDisconnect(playerid, reason)
{
    if(IsPlayerNPC(playerid))
        return 1;

    REST_PLAYER(playerid);
    DestroyPlayerProgressBar(playerid, player_gym_progress[playerid]);
    return 1;
}
