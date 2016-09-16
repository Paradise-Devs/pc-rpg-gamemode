/*******************************************************************************
* FILENAME :        modules/faction/general.pwn
*
* DESCRIPTION :
*       Commands and functions related to ALL factions.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

YCMD:radio(playerid, params[], help)
{
	if(GetPlayerFactionID(playerid) == FACTION_NONE)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não pertence a uma organização.");

	if(isnull(params))
	  return SendClientMessage(playerid, COLOR_INFO, "* /radio [mensagem]");

	SendPlayerFactionMessage(playerid, params);
	return 1;
}

//------------------------------------------------------------------------------

YCMD:departamento(playerid, params[], help)
{
	if(GetPlayerFactionID(playerid) == FACTION_NONE)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não pertence a uma organização.");

	if(isnull(params))
	  return SendClientMessage(playerid, COLOR_INFO, "* /departamento [mensagem]");

	SendPlayerFactionTypeMessage(playerid, params);
	return 1;
}

//------------------------------------------------------------------------------

YCMD:membros(playerid, params[], help)
{
	if(GetFactionType(GetPlayerFactionID(playerid)) == FACTION_NONE)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não é membro de uma facção.");

	new	string[128];
	SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Membros ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	SendClientMessage(playerid, COLOR_TITLE, "- Membros da organização online:");
	foreach(new i: Player)
	{
		if(GetPlayerFactionID(i) == GetPlayerFactionID(playerid))
		{
			format(string, sizeof string, "[{b4b4b4}%s{ffffff}] {b4b4b4}%s{ffffff} - ID: {b4b4b4}%i", GetFactionRankName(GetPlayerFactionID(i), GetPlayerFactionRankID(i)), GetPlayerNamef(i), i);
			SendClientMessage(playerid, -1, string);
		}
	}
	SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Membros ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	return 1;
}

//------------------------------------------------------------------------------

YCMD:promover(playerid, params[], help)
{
	if(GetFactionType(GetPlayerFactionID(playerid)) == FACTION_NONE || GetPlayerFactionRankID(playerid) != 0)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	new targetid;
	if(sscanf(params, "u", targetid))
	  return SendClientMessage(playerid, COLOR_INFO, "* /promover [playerid]");

	if(!IsPlayerLogged(targetid))
		return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");

	else if(playerid == targetid)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode promover você mesmo.");

	else if(GetPlayerFactionID(targetid) != GetPlayerFactionID(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não é de sua organização.");

	else if((GetPlayerFactionRankID(targetid) - 1) == 0)
		return SendClientMessage(playerid, COLOR_ERROR, "* O jogador já está no cargo máximo.");

	SetPlayerFactionRankID(targetid, GetPlayerFactionRankID(targetid) - 1);
	SendClientMessagef(playerid, 0x00CED1FF, "* Você promoveu %s para %s.", GetPlayerNamef(targetid), GetFactionRankName(GetPlayerFactionID(targetid), GetPlayerFactionRankID(targetid)));
	SendClientMessagef(targetid, 0x00CED1FF, "* Você foi promovido por %s para %s.", GetPlayerNamef(playerid), GetFactionRankName(GetPlayerFactionID(targetid), GetPlayerFactionRankID(targetid)));
	SetPlayerFactionSkin(targetid);
	return 1;
}

//------------------------------------------------------------------------------

YCMD:rebaixar(playerid, params[], help)
{
	if(GetFactionType(GetPlayerFactionID(playerid)) == FACTION_NONE || GetPlayerFactionRankID(playerid) != 0)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	new targetid;
	if(sscanf(params, "u", targetid))
	  return SendClientMessage(playerid, COLOR_INFO, "* /rebaixar [playerid]");

	if(!IsPlayerLogged(targetid))
		return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");

	else if(playerid == targetid)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode rebaixar você mesmo.");

	else if(GetPlayerFactionID(targetid) != GetPlayerFactionID(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não é de sua organização.");

	else if((GetPlayerFactionRankID(targetid) + 1) == GetFactionMaxRanks(GetPlayerFactionID(playerid)))
		return SendClientMessage(playerid, COLOR_ERROR, "* O jogador já está no cargo mínimo.");

	SetPlayerFactionRankID(targetid, GetPlayerFactionRankID(targetid) + 1);
	SendClientMessagef(playerid, 0x00CED1FF, "* Você rebaixou %s para %s.", GetPlayerNamef(targetid), GetFactionRankName(GetPlayerFactionID(targetid), GetPlayerFactionRankID(targetid)));
	SendClientMessagef(targetid, 0x00CED1FF, "* Você foi rebaixado para %s por %s.", GetFactionRankName(GetPlayerFactionID(targetid), GetPlayerFactionRankID(targetid)), GetPlayerNamef(playerid));
	SetPlayerFactionSkin(targetid);
	return 1;
}

//------------------------------------------------------------------------------

YCMD:demitir(playerid, params[], help)
{
	if(GetFactionType(GetPlayerFactionID(playerid)) == FACTION_NONE || GetPlayerFactionRankID(playerid) != 0)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	new targetid;
	if(sscanf(params, "u", targetid))
	  return SendClientMessage(playerid, COLOR_INFO, "* /demitir [playerid]");

	if(!IsPlayerLogged(targetid))
		return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");

	else if(playerid == targetid)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode demitir você mesmo.");

	else if(GetPlayerFactionID(targetid) != GetPlayerFactionID(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não é de sua organização.");

	SendClientMessagef(playerid, 0x00CED1FF, "* Você demitiu %s.", GetPlayerNamef(targetid));
	SendClientMessagef(targetid, 0x00CED1FF, "* Você foi demitido da %s por %s.", GetFactionName(GetPlayerFactionID(targetid)), GetPlayerNamef(playerid));

	SetPlayerFactionID(targetid, 0);
	SetPlayerFactionRankID(targetid, 0);
	SetPlayerSkin(targetid, GetPlayerSavedSkin(targetid));
	return 1;
}

//------------------------------------------------------------------------------

YCMD:convidar(playerid, params[], help)
{
	if(GetFactionType(GetPlayerFactionID(playerid)) == FACTION_NONE || GetPlayerFactionRankID(playerid) != 0)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	new
		targetid,
		factionid = GetPlayerFactionID(playerid)
	;
	if(sscanf(params, "u", targetid))
	  return SendClientMessage(playerid, COLOR_INFO, "* /convidar [playerid]");

	else if(!IsPlayerLogged(targetid))
		return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");

	else if(playerid == targetid)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode convidar você mesmo.");

	else if(GetPlayerFactionID(targetid) != FACTION_NONE)
		return SendClientMessage(playerid, COLOR_ERROR, "* O jogador já é de uma organização.");

	else if(GetPVarInt(targetid, "FactionInviterID") != 0)
		return SendClientMessage(playerid, COLOR_ERROR, "* O jogador já está respondendo uma proposta de facção.");

	SendClientMessagef(playerid, 0x00CED1FF, "* Você convidou %s para ingressar na %s.", GetPlayerNamef(targetid), GetFactionName(factionid));

	new inviteMessage[178];
	format(inviteMessage, sizeof(inviteMessage), "{FFFFFF}Você está sendo convidado para ingressar na organização {0EDBEC}%s{FFFFFF} por {0EDBEC}%s{FFFFFF}.\nVocê aceita?", GetFactionName(factionid), GetPlayerNamef(playerid));
	ShowPlayerDialog(targetid, DIALOG_FACTION_INVITE, DIALOG_STYLE_MSGBOX, "Convite", inviteMessage, "Sim", "Não");

	SetPVarInt(targetid, "FactionInviterID", playerid + 200);
	return 1;
}


//------------------------------------------------------------------------------

YCMD:ajudafaccao(playerid, params[], help)
{
	if(GetPlayerFactionID(playerid) == FACTION_NONE)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não pertence a uma organização.");

    SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Comandos ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	SendClientMessage(playerid, COLOR_SUB_TITLE, "* /(r)adio - /membros - (/d)epartamento");
    if(GetFactionType(GetPlayerFactionID(playerid)) == FACTION_TYPE_NEWS)
        SendClientMessage(playerid, COLOR_SUB_TITLE, "* /(n)oticia");
    else if(GetFactionType(GetPlayerFactionID(playerid)) == FACTION_TYPE_POLICE)
        SendClientMessage(playerid, COLOR_SUB_TITLE, "* /servico - /megafone - /prender - /ajustarpena - /libertar - /algemar - /desalgemar");
	if(GetPlayerFactionRankID(playerid) == 0)
		SendClientMessage(playerid, COLOR_SUB_TITLE, "* /convidar - /promover - /rebaixar - /demitir");
	SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Comandos ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	return 1;
}

//------------------------------------------------------------------------------

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case DIALOG_FACTION_INVITE:
		{
			if(GetPVarInt(playerid, "FactionInviterID") == 0)
				return 1;

			new targetid = GetPVarInt(playerid, "FactionInviterID")-200;
			new factionid = GetPlayerFactionID(targetid);
			if(!response)
			{
				SendClientMessage(playerid, COLOR_INFO, "* Você recusou.");
				SendClientMessage(targetid, COLOR_ERROR, "* O jogador recusou.");
			}
			else
			{
				SetPlayerFactionID(playerid, factionid);
				SetPlayerFactionRankID(playerid, GetFactionMaxRanks(factionid)-1);

				new factionMessage[167];
				format(factionMessage, sizeof(factionMessage), "* {0EDBEC}%s{FFFFFF} ingressou na {0EDBEC}%s{FFFFFF} como {0EDBEC}%s{FFFFFF}.", GetPlayerNamef(playerid), GetFactionName(factionid), GetFactionRankName(GetPlayerFactionID(playerid), GetPlayerFactionRankID(playerid)));
				SendFactionMessage(factionid, 0xFFFFFFFF, factionMessage);
			}
			DeletePVar(playerid, "FactionInviterID");
			return 1;
		}
	}
	return 0;
}
