
#include <YSI\y_hooks>

forward OnGangMenuResponse(playerid, gangname[], gangid, gangmembers[], bool:response);

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
    LoadPlayerGangData(playerid);
    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    SavePlayerGangData(playerid);
    ResetPlayerGangData(playerid);
    ResetPlayerGangMenuData(playerid);
    return 1;
}

public OnGangMenuResponse(playerid, gangname[], gangid, gangmembers[], bool:response)
{
    if(!response) return HidePlayerGangMenu(playerid);
    return 1;
}


hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_CHOOSE_GANGNAME)
    {
        if(response)
        {
            if(!CheckGangName(inputtext)) return ShowPlayerDialog(playerid, DIALOG_CHOOSE_GANGNAME, DIALOG_STYLE_INPUT, "{FFCC00}Qual será o nome de sua gangue?", "Insira um nome válido para sua gangue.\nCaracteres Permitidos:\n {FF0000}*Alfanumericos: A-Z, a-z e 0-9\n *Minimo de 6 caracteres\n  *Máximo de 18 caracteres\n *No máximo 2 underlines", "Pronto", "Voltar");
            SetPlayerGangMenuName(playerid, inputtext);
        }
    }
    else if(dialogid == DIALOG_CHOOSE_GANGMEMBER_1)
    {
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
    return 1;
}

stock CheckGangName(const string[])
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




/////// functions


stock SendGangInvite(senderid, receiverid, slot)
{
    new sendername[24], invitemsg[256];
    GetPlayerName(senderid, sendername, 24);

    format(invitemsg, sizeof(invitemsg), "{ffcc00}[Convite]\n\n\nO usuário {FF0000}%s{FFFFFF} convidou você para participar da gangue {FF0000}%s!\n\n\nVocê aceita o convite? \
    (Este convite expira em 1 minuto)", sendername, PlayerGangMenuInfo[senderid][g_name]);
    //setup receiver vars
    PlayerGangInvitationInfo[receiverid][sender_id] = senderid;
    ShowPlayerDialog(receiverid, DIALOG_GANG_INVITE, DIALOG_STYLE_LIST, "Convite para juntar-se à gangue!", invitemsg, "Aceitar", "Recusar");

    //setup sender vars
    PlayerGangInvitationInfo[senderid][receiver_id][slot] = receiverid;
    PlayerGangInvitationInfo[senderid][active_token][slot] = true;
    PlayerGangInvitationInfo[senderid][invite_timer][slot] = SetTimerEx("ExpireGangInvite", 60000, false, "iii", senderid, receiverid, slot);
    return 1;
}

stock ExpireGangInvite(senderid, receiverid, slot)
{
    new strinvite[128];
    format(strinvite, sizeof(strinvite), "* O usuário não respondeu ao convite dentro do periodo estabelecido (slot %d), portanto o convite foi recusado automaticamente!", slot);
    SendClientMessage(senderid, 0xFF0000FF, strinvite);
    SendClientMessage(receiverid, 0xFF0000FF, "* Você não respondeu ao convite em 1 minuto, portanto ele expirou!");

    ResetPlayerGangInvitationData(senderid, receiverid, slot);
    return 1;
}
