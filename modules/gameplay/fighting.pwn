/*******************************************************************************
* FILENAME :        modules/gameplay/fighting.pwn
*
* DESCRIPTION :
*       Make players able to learn fighting styles.
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

//------------------------------------------------------------------------------

#include <YSI\y_hooks>

// Checkpointid
static STREAMER_TAG_CP gCheckpointid;

// Available fstyles
static g_fightingStyles[][][] =
{
    {500,    FIGHT_STYLE_NORMAL,     "Briga de rua"},
    {2500,   FIGHT_STYLE_BOXING,     "Boxe"},
    {5000,   FIGHT_STYLE_GRABKICK,   "GrabKick"},
    {7500,   FIGHT_STYLE_ELBOW,      "Elbow"},
    {10000,  FIGHT_STYLE_KNEEHEAD,   "KneeHead"},
    {15000,  FIGHT_STYLE_KUNGFU,     "Kungfu"}
};

hook OnGameModeInit()
{
    gCheckpointid = CreateDynamicCP(768.7508, 13.2563, 1000.7009, 1.0, 0, 5);
    return 1;
}

hook OnPlayerEnterDynamicCP(playerid, STREAMER_TAG_CP checkpointid)
{
    if(checkpointid == gCheckpointid)
    {
        new info[128], buffer[60];
        strcat(info, "Luta\tPreço");
        for(new i = 0; i < sizeof(g_fightingStyles); i++)
        {
            format(buffer, sizeof(buffer), "\n%s\t$%s", g_fightingStyles[i][2], formatnumber(g_fightingStyles[i][0][0]));
            strcat(info, buffer);
        }
        ShowPlayerDialog(playerid, DIALOG_FSTYLE, DIALOG_STYLE_TABLIST_HEADERS, "Estilos de Luta", info, "Aprender", "Cancelar");
    }
    return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
    {
        case DIALOG_FSTYLE:
        {
            if(!response)
                PlayCancelSound(playerid);
            else
            {
                if(GetPlayerCash(playerid) < g_fightingStyles[listitem][0][0])
                {
                    SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente.");
                    PlayErrorSound(playerid);
                    return 1;
                }

                else if(GetPlayerFightingStyle(playerid) == g_fightingStyles[listitem][1][0])
                {
                    SendClientMessage(playerid, COLOR_ERROR, "* Você já aprendeu este estilo de luta.");
                    PlayErrorSound(playerid);
                    return 1;
                }

                SendClientMessagef(playerid, 0x9df420ff, "* Você aprendeu a lutar %s.", g_fightingStyles[listitem][2]);
                GivePlayerCash(playerid, -g_fightingStyles[listitem][0][0]);
                SetPlayerFightingStyle(playerid, g_fightingStyles[listitem][1][0]);
            }
        }
    }
    return 1;
}
