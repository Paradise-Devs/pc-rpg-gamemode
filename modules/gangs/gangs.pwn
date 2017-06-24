
#include <YSI\y_hooks>

forward OnGangMenuResponse(playerid, gangname[], gangid, gangmembers[], bool:response);
forward ExpireGangInvite(senderid, receiverid, slot);

/*
▒█▀▀█ █▀▀█ █░░ █░░ █▀▀▄ █▀▀█ █▀▀ █░█ █▀▀
▒█░░░ █▄▄█ █░░ █░░ █▀▀▄ █▄▄█ █░░ █▀▄ ▀▀█
▒█▄▄█ ▀░░▀ ▀▀▀ ▀▀▀ ▀▀▀░ ▀░░▀ ▀▀▀ ▀░▀ ▀▀▀
*/

hook OnGameModeInit()
{
    LoadGangs();
    return 1;
}

hook OnGameModeExit()
{
    SaveGangs();
    return 1;
}

hook OnPlayerConnect(playerid)
{
    ResetPlayerGangData(playerid);
    ResetPlayerGangMenuData(playerid);
    ResetGangInvitationData(playerid);
    LoadPlayerGangData(playerid);

    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    SavePlayerGangData(playerid);
    ResetPlayerGangData(playerid);
    ResetPlayerGangMenuData(playerid);

    new senderid = PlayerGangInvitationInfo[playerid][sender_id];

    if(senderid != INVALID)
    {
        for(new x; x < 3; x++)
        {
            if(PlayerGangInvitationInfo[senderid][receiver_id][x] == playerid)
            {
                CancelGangInvite(senderid, playerid, x);
                RemovePlayerFromGangMenuLabel(senderid, playerid, x);
                UnlockInviteSlot(senderid, x);
            }
        }
    }

    for(new x; x < 3; x++)
    {
        new receiverid = PlayerGangInvitationInfo[playerid][receiver_id][x];
        if(receiverid != INVALID)
        {
            ResetPlayerGangInvitationData(playerid, receiverid, x);
            SendClientMessage(receiverid, COLOR_ERROR, "* Processo de criação de gangue cancelado pois o criador se desconectou!");
        }
    }
    return 1;
}




public OnGangMenuResponse(playerid, gangname[], gangid, gangmembers[], bool:response)
{
    if(!response)
    {
        ResetPlayerGangMenuData(playerid);
        for(new x; x < 3; x++)
        {
            foreach(new p : Player)
            {
                if(PlayerGangInvitationInfo[playerid][receiver_id][x] == p)
                {
                    new str[128], sname[24];
                    GetPlayerName(playerid, sname, 24);
                    format(str, sizeof(str), "* O usuário {FF0000}%s{FFFFFF} cancelou o processo de criação da gangue!", sname);
                    SendClientMessage(p, -1, str);
                    SendClientMessage(playerid, -1, "{FFCC00}* Você cancelou o processo de criação da gangue!");
                }
                PlayerTextDrawSetString(playerid, GangMenuPlayerText[playerid][11 + x], "Clique para adicionar um usuario...");
                PlayerTextDrawSetSelectable(playerid, GangMenuPlayerText[playerid][11 + x], true);
                ResetPlayerGangInvitationData(playerid, p, x);
                PlayerTextDrawSetString(playerid, GangMenuPlayerText[playerid][0], "Insira um nome para a gangue...");
            }
        }
        return HidePlayerGangMenu(playerid);
    }
    return 1;
}




hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_CHOOSE_GANGNAME)
    {
        if(response)
        {
            if(!CheckGangName(inputtext) || strlen(inputtext) < 6 ||  strlen(inputtext) > 18) return ShowPlayerDialog(playerid, DIALOG_CHOOSE_GANGNAME, DIALOG_STYLE_INPUT, "{FFCC00}Qual será o nome de sua gangue?", "Insira um nome válido para sua gangue.\n\nCaracteres Permitidos:\n\n{FF0000}*Alfanumericos: A-Z, a-z e 0-9\n\n*Minimo de 6 caracteres\n\n *Máximo de 18 caracteres", "Pronto", "Voltar");

            SetPlayerGangMenuName(playerid, inputtext);
        }
    }
    else if(dialogid == DIALOG_CHOOSE_GANGMEMBER_1)
    {
        if(!response) return 0;
        new receiverid = PlayerGangInvitationInfo[playerid][users_list][listitem];
        if(IsPlayerConnected(receiverid))
        {
            if(GetPlayerGang(receiverid) == INVALID)
            {
                SendGangInvite(playerid, receiverid, 0);
            }
            else
            {
                SendClientMessage(playerid, 0xFF0000FF, "* Este player já está em uma gangue!");
            }
        }
        else
        {
            SendClientMessage(playerid, 0xFF0000FF, "* Este player não está conectado!");
        }

    }
    else if(dialogid == DIALOG_CHOOSE_GANGMEMBER_2)
    {
        if(!response) return 0;
        new receiverid = PlayerGangInvitationInfo[playerid][users_list][listitem];
        if(IsPlayerConnected(receiverid))
        {
            if(GetPlayerGang(receiverid) == INVALID)
            {
                SendGangInvite(playerid, receiverid, 1);
            }
            else
            {
                SendClientMessage(playerid, 0xFF0000FF, "* Este player já está em uma gangue!");

            }
        }
        else
        {
            SendClientMessage(playerid, 0xFF0000FF, "* Este player não está conectado!");
        }
    }
    else if(dialogid == DIALOG_CHOOSE_GANGMEMBER_3)
    {
        if(!response) return 0;
        new receiverid = PlayerGangInvitationInfo[playerid][users_list][listitem];
        if(IsPlayerConnected(receiverid))
        {
            if(GetPlayerGang(receiverid) == INVALID)
            {
                SendGangInvite(playerid, receiverid, 2);
            }
            else
            {
                SendClientMessage(playerid, 0xFF0000FF, "* Este player já está em uma gangue!");
            }
        }
        else
        {
            SendClientMessage(playerid, 0xFF0000FF, "* Este player não está conectado!");
        }
    }
    else if(dialogid == DIALOG_GANG_INVITE)
    {
        new slot = PlayerGangInvitationInfo[playerid][menu_slot];
        new senderid = PlayerGangInvitationInfo[playerid][sender_id];

        if(!response) DeclineGangInvite(senderid, playerid, slot);
        else AcceptGangInvite(senderid, playerid, slot);
    }
    return 1;
}



public ExpireGangInvite(senderid, receiverid, slot)
{
    PlayerGangInvitationInfo[senderid][accepted][slot] = false;
    new strinvite[128];
    format(strinvite, sizeof(strinvite), "* O usuário não respondeu ao convite dentro do periodo estabelecido (slot %d), o convite foi recusado automaticamente!", slot);
    SendClientMessage(senderid, -1, strinvite);

    SendClientMessage(receiverid, -1, "* Você não respondeu ao convite em 1 minuto, portanto ele expirou!");

    ResetPlayerGangInvitationData(senderid, receiverid, slot);

    if(slot != -1) UnlockInviteSlot(senderid, slot);
    return 1;
}




/*
▒█▀▀▀ █░░█ █▀▀▄ █▀▀ ▀▀█▀▀ ░▀░ █▀▀█ █▀▀▄ █▀▀
▒█▀▀▀ █░░█ █░░█ █░░ ░░█░░ ▀█▀ █░░█ █░░█ ▀▀█
▒█░░░ ░▀▀▀ ▀░░▀ ▀▀▀ ░░▀░░ ▀▀▀ ▀▀▀▀ ▀░░▀ ▀▀▀
*/


CheckGangName(const string[])
{
	new z = 0;
    new c = 0;
	for(new x, y = strlen(string); x != y; x++)
	{
	    if((string[x] >= 48 && string[x] <= 57) || (string[x] >= 65 && string[x] <= 90) || (string[x] >= 97 && string[x] <= 122) || (string[x] == 95))
	    {
			z++;
            if(string[x] == 95) c++;

		}
	}
	if(z == strlen(string) && c <= 2) return true;
	else return false;
}


DeclineGangInvite(senderid, receiverid, slot)
{
    new rname[24], strmsg[128];
    GetPlayerName(receiverid, rname, 24);

    format(strmsg, sizeof(strmsg), "* O usuário {FF0000}%s{FFFFFF} recusou seu pedido para juntar-se à gangue.", rname);
    SendClientMessage(senderid, -1, strmsg);

    SendClientMessage(receiverid, -1, "* Você recusou o convite.");

    ResetPlayerGangInvitationData(senderid, receiverid, slot);
    if(slot != 3) UnlockInviteSlot(senderid, slot);
    return 1;
}

CancelGangInvite(senderid, receiverid, slot)
{
    new rname[24], strmsg[128];
    GetPlayerName(receiverid, rname, 24);

    format(strmsg, sizeof(strmsg), "* O usuário {FF0000}%s{FFFFFF} desconectou-se e foi removido do seu processo de criação da gangue.", rname);
    SendClientMessage(senderid, -1, strmsg);

    ResetPlayerGangInvitationData(senderid, receiverid, slot);
    if(slot != 3) UnlockInviteSlot(senderid, slot);
    return 1;
}

AcceptGangInvite(senderid, receiverid, slot)
{
    new rname[24], strmsg[128];
    GetPlayerName(receiverid, rname, 24);

    format(strmsg, sizeof(strmsg), "* O usuário {FF0000}%s{FFFFFF} aceitou seu pedido para juntar-se à gangue.", rname);
    SendClientMessage(senderid, -1, strmsg);

    SendClientMessage(receiverid, -1, "* Você aceitou o convite para juntar-se à gangue.");

    SetPlayerInGangMenu(senderid, receiverid, slot);
    SetPlayerInGangMenuLabel(senderid, receiverid, slot);

    KillTimer(PlayerGangInvitationInfo[senderid][invite_timer][slot]);
    return 1;
}

SendGangInvite(senderid, receiverid, slot)
{
    new sendername[24], invitemsg[256], invitedmsg[256], receivername[24];
    GetPlayerName(senderid, sendername, 24);
    GetPlayerName(receiverid, receivername, 24);
    PlayerGangInvitationInfo[receiverid][menu_slot] = slot;


    format(invitemsg, sizeof(invitemsg), "* Você enviou um convite para o usuário {FF0000}%s{FFFFFF} juntar-se ao processo de criação de sua gangue!\n \
    (aguarde até 1 minuto para receber a resposta)");
    SendClientMessage(senderid, -1, invitemsg);

    PlayerGangInvitationInfo[senderid][accepted][slot] = false;
    if(slot != 3)
    {
        LockInviteSlot(senderid, slot);
        format(invitedmsg, sizeof(invitedmsg), "{FFCC00}[Convite]\n\n\nO usuário {FF0000}%s{FFFFFF} convidou você para participar do processo de criação da gangue {FF0000}%s!\n\n\nVocê aceita o convite? \
        (Este convite expira em 1 minuto)\n{FF0000}IMPORTANTE: Esta gangue ainda está em criação, aceitar o convite não garante que ela será criada!", sendername, PlayerGangMenuInfo[senderid][g_name]);
    }
    else
    {
        format(invitedmsg, sizeof(invitedmsg), "{FFCC00}[Convite]\n\n\nO usuário {FF0000}%s{FFFFFF} convidou você para participar da gangue {FF0000}%s!\n\n\nVocê aceita o convite? \
        (Este convite expira em 1 minuto)", sendername, PlayerGangMenuInfo[senderid][g_name]);
    }
    //setup receiver vars
    PlayerGangInvitationInfo[receiverid][sender_id] = senderid;
    ShowPlayerDialog(receiverid, DIALOG_GANG_INVITE, DIALOG_STYLE_MSGBOX, "Convite para juntar-se à gangue!", invitedmsg, "Aceitar", "Recusar");

    //setup sender vars
    PlayerGangInvitationInfo[senderid][receiver_id][slot] = receiverid;
    PlayerGangInvitationInfo[senderid][active_token][slot] = true;
    PlayerGangInvitationInfo[senderid][invite_timer][slot] = SetTimerEx("ExpireGangInvite", 60000, false, "iii", senderid, receiverid, slot);
    return 1;
}
