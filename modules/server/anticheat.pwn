/*******************************************************************************
* FILENAME :        modules/server/anticheat.pwn
*
* DESCRIPTION :
*       Handle anti-cheat scripts.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

static const g_anticheat_names[][] =
{
    "air-breaking",
    "air-breaking",
    "teleport-hack",
    "teleport-hack",
    "teleport-hack",
    "teleport-hack",
    "teleport-hack",
    "fly-hack",
    "fly-hack",
    "speed hack",
    "speed hack",
    "health hack",
    "health hack",
    "armour hack",
    "money hack",
    "weapon hack",
    "ammo hack",
    "ammo hack",
    "anti anim hack",
    "godmode hack",
    "godmode hack",
    "invisible hack",
    "lagcomp hack",
    "tuning hack",
    "parkour mod",
    "quick turn",
    "rapid fire",
    "fake spawn",
    "fake kill",
    "auto aim",
    "CJ run",
    "carShot",
    "carJack",
    "descongelar hack",
    "AFK Ghost",
    "full aiming",
    "fake NPC",
    "reconnect",
    "ping alto",
    "dialog hack",
    "sandbox protection",
    "invalid version",
    "rcon hack",
    "tuning crasher",
    "assento de veículo inválido",
    "dialog crasher",
    "attached object crasher",
    "weapon crasher",
    "flood",
    "flood",
    "flood",
    "ddos",
    "sobeit NOP"
};

//------------------------------------------------------------------------------

forward OnCheatDetected(playerid, ip_address[], type, code);
public OnCheatDetected(playerid, ip_address[], type, code)
{
    if(!type)
    {
        new count = 0;
        foreach(new i: Player)
        {
            if(GetPlayerRank(i) >= PLAYER_RANK_MODERATOR)
            {
                count++;
            }
        }

        if(count)
            SendAdminMessage(PLAYER_RANK_MODERATOR, 0xf14545ff, "[ANTICHEAT] O jogador %s foi acusado de suspeitas de %s.", GetPlayerNamef(playerid), g_anticheat_names[code]);
        else
        {
            SendClientMessageToAllf(0xf14545ff, "[ANTICHEAT] O jogador %s foi kickado do servidor. Motivo: Suspeitas de %s.", GetPlayerNamef(playerid), g_anticheat_names[code]);
            Kick(playerid);
        }
    }
    return 1;
}

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
    EnableAntiCheat(2, false);
    EnableAntiCheat(3, false);
    EnableAntiCheat(4, false);
    EnableAntiCheat(5, false);
    EnableAntiCheat(6, false);
    EnableAntiCheat(8, false);
    EnableAntiCheat(9, false);
    EnableAntiCheat(10, false);
    EnableAntiCheat(11, false);
    EnableAntiCheat(12, false);
    EnableAntiCheat(14, false);
    EnableAntiCheat(15, false);
    EnableAntiCheat(16, false);
    EnableAntiCheat(17, false);
    EnableAntiCheat(18, false);
    EnableAntiCheat(21, false);
    EnableAntiCheat(24, false);
    EnableAntiCheat(27, false);
    EnableAntiCheat(28, false);
    EnableAntiCheat(32, false);
    EnableAntiCheat(34, false);
    EnableAntiCheat(36, false);
    EnableAntiCheat(37, false);
    EnableAntiCheat(38, false);
    EnableAntiCheat(39, false);
    EnableAntiCheat(40, false);
    EnableAntiCheat(41, false);
    EnableAntiCheat(44, false);
    EnableAntiCheat(47, false);
    EnableAntiCheat(48, false);
    EnableAntiCheat(49, false);
    EnableAntiCheat(50, false);
    EnableAntiCheat(52, false);
    return 1;
}
