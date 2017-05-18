/*******************************************************************************
* FILENAME :        modules/job/commands.pwn
*
* DESCRIPTION :
*       Global jobs commands
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/
#include <YSI\y_hooks>

YCMD:sairdoemprego(playerid, params[], help)
{
    if(GetPlayerJobID(playerid) != INVALID_JOB_ID)
    {
        ShowPlayerDialog(playerid, DIALOG_LEAVE_JOB, DIALOG_STYLE_MSGBOX, "Sair do emprego {FF0000}(Aviso)","Atenção!\n\n\nEsta é uma atitude sem volta, caso você abandone o emprego atual perderá todo o EXP e Níveis já conquistados nesta profissão.\nCaso retorne à profissão novamente o nível de emprego voltará a 1\n\nTem certeza de que deseja abandonar o emprego atual?", "Sim", "Não");
    }
    else
    {
        SendClientMessage(playerid, COLOR_ERROR, "* Você não tem emprego.");
    }
    return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_LEAVE_JOB)
    {
        if(response)
        {
            SetPlayerJobID(playerid, INVALID_JOB_ID);
            SendClientMessage(playerid, COLOR_SUCCESS, "* Você abandonou seu emprego.");
        }
        else
        {
            SendClientMessage(playerid, COLOR_SUCCESS, "* Você optou por não abandonar seu emprego.");
        }
    }
    return 1;
}
