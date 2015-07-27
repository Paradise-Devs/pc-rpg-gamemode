/*******************************************************************************
* FILENAME :        modules/data/commands.pwn
*
* DESCRIPTION :
*       Adds players general commands to the server.
*
* NOTES :
*       This file should only contain player general commands.
*       Faction, job, admin, etc, commands should be in their respective modules
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
	Command_AddAltNamed("gritar",		"g");
	Command_AddAltNamed("sussurrar",	"s");
	Command_AddAltNamed("comandos",		"cmds");
	return 1;
}

//------------------------------------------------------------------------------

YCMD:do(playerid, params[], help)
{
	if(isnull(params))
		return SendClientMessage(playerid, COLOR_INFO, "* /do [mensagem]");

	SendActionMessage(playerid, 20.0, params);
	return 1;
}

//------------------------------------------------------------------------------

YCMD:eu(playerid, params[], help)
{
	if(isnull(params))
		return SendClientMessage(playerid, COLOR_INFO, "* /eu [mensagem]");

	SendClientActionMessage(playerid, 20.0, params);
	return 1;
}

//------------------------------------------------------------------------------

YCMD:b(playerid, params[], help)
{
	if(isnull(params))
		return SendClientMessage(playerid, COLOR_INFO, "* /b [mensagem]");

    new message[156];
	format(message, sizeof(message), "%s: (( %s ))", GetPlayerNamef(playerid), params);
	SendClientLocalMessage(playerid, 0xe3e3e3ff, 20.0, message);
	return 1;
}

//------------------------------------------------------------------------------

YCMD:id(playerid, params[], help)
{
	new targetid;
	if(sscanf(params, "u", targetid))
		return SendClientMessage(playerid, COLOR_INFO, "* /id [jogador]");

    new output[40];
	format(output, sizeof(output), "* %s(ID: %i)", GetPlayerNamef(targetid), targetid);
	SendClientMessage(playerid, 0xAFAFAFAF, output);
	return 1;
}

//------------------------------------------------------------------------------

YCMD:comandos(playerid, params[], help)
{
	SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Comandos ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	SendClientMessage(playerid, 0xffffffff, "* /(g)ritar - /(s)ussurar - /eu - /do - /b - /admins - /id - /janela - /motor - /farol - /ajuda - /apertarmao - /oferecerboquete");
	SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Comandos ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	return 1;
}

//------------------------------------------------------------------------------

YCMD:admins(playerid, params[], help)
{
	new count = 0, string[64];
	SendClientMessage(playerid, COLOR_TITLE, "- Membros da moderação online -");
	foreach(new i: Player)
	{
		if(GetPlayerHighestRank(i) >= PLAYER_RANK_MODERATOR)
		{
			format(string, sizeof string, "* {FFFFFF}[{%06x}%s{FFFFFF}] %s(ID: %i)", GetPlayerRankColor(i) >>> 8, GetPlayerRankName(i, true), GetPlayerNamef(i), i);
			SendClientMessage(playerid, -1, string);
			count++;
		}
	}

	if(count == 0)
		SendClientMessage(playerid, COLOR_ERROR, "* Nenhum membro da moderação online.");
	return 1;
}

//------------------------------------------------------------------------------

YCMD:ajuda(playerid, params[], help)
{
	SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Ajuda ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	SendClientMessage(playerid, COLOR_WHITE, "* Para uma lista com os comandos disponíveis digite {a5f413}/comandos{ffffff} ou {a5f413}/cmds{ffffff}.");
	SendClientMessage(playerid, COLOR_WHITE, "* Grande parte dos {a5f413}itens{ffffff} a venda se encontram em {a5f413}lojas 24-7{ffffff}.");
	SendClientMessage(playerid, COLOR_WHITE, "* Um {a5f413}GPS{ffffff} irá te ajudar a localizar os locais importantes através do comando {a5f413}/gps{ffffff}.");
	SendClientMessage(playerid, COLOR_WHITE, "* {a5f413}Telefones{ffffff} são vendidos nas operadoras de celular apresentadas por um {a5f413}T{ffffff} em seu radar.");
	SendClientMessage(playerid, COLOR_WHITE, "* {a5f413}Anúncios{ffffff} enviados por empresas de publicidade {a5f413}são 50%% mais baratos{ffffff}.");
	SendClientMessage(playerid, COLOR_WHITE, "* Para mais informações visite nosso site e fórum em {a5f413}www.pc-rpg.com.br{ffffff}.");
	SendClientMessage(playerid, COLOR_WHITE, "* Caso ainda tenha dúvidas chame um {a5f413}administrador{ffffff} com {a5f413}/relatorio{ffffff}.");
	SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Ajuda ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	return 1;
}

//------------------------------------------------------------------------------

YCMD:sussurrar(playerid, params[], help)
{
	new targetid, message[128];
	if(sscanf(params, "us[128]", targetid, message))
		return SendClientMessage(playerid, COLOR_INFO, "* /(s)ussurrar [playerid] [mensagem]");

	if(!IsPlayerLogged(targetid))
		return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");

	if(targetid == playerid)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode sussurar para você mesmo.");

	new Float:fDist[3];
	GetPlayerPos(playerid, fDist[0], fDist[1], fDist[2]);
	if(GetPlayerDistanceFromPoint(targetid, fDist[0], fDist[1], fDist[2]) < 3.0 && GetPlayerVirtualWorld(targetid) == GetPlayerVirtualWorld(playerid))
	{
        new output[148];
        format(output, sizeof(output), "* Você sussurou para {FFD700}%s{FFFF00}: %s", GetPlayerNamef(targetid), message);
		SendClientMessage(playerid, COLOR_YELLOW, output);
        format(output, sizeof(output), "* {FFD700}%s{FFFF00} sussurou: %s", GetPlayerNamef(playerid), message);
		SendClientMessage(targetid, COLOR_YELLOW, output);
        format(output, sizeof(output), "sussurou algo para %s.", GetPlayerNamef(targetid));
        SendClientActionMessage(playerid, 15.0, output);
	}
	else SendClientMessage(playerid, COLOR_ERROR, "* Você não está próximo do jogador.");
	return 1;
}

//------------------------------------------------------------------------------

YCMD:gritar(playerid, params[], help)
{
	if(isnull(params))
		return SendClientMessage(playerid, COLOR_INFO, "* /(g)ritar [mensagem]");

	for(new i, l = strlen( params ); i != l; i++)
	{
		if(params[i] >= 'a' && params[i] <= 'z')
		{
			params[i] = toupper(params[i]);
		}
	}

	new message[156];
	format(message, sizeof(message), "%s grita: %s!!", GetPlayerNamef(playerid), params);
	SendClientLocalMessage(playerid, COLOR_WHITE, 40.0, message);
	return 1;
}

//------------------------------------------------------------------------------

/*
        Error & Return type

    COMMAND_ZERO_RET      = 0 , // The command returned 0.
    COMMAND_OK            = 1 , // Called corectly.
    COMMAND_UNDEFINED     = 2 , // Command doesn't exist.
    COMMAND_DENIED        = 3 , // Can't use the command.
    COMMAND_HIDDEN        = 4 , // Can't use the command don't let them know it exists.
    COMMAND_NO_PLAYER     = 6 , // Used by a player who shouldn't exist.
    COMMAND_DISABLED      = 7 , // All commands are disabled for this player.
    COMMAND_BAD_PREFIX    = 8 , // Used "/" instead of "#", or something similar.
    COMMAND_INVALID_INPUT = 10, // Didn't type "/something".
*/

public e_COMMAND_ERRORS:OnPlayerCommandReceived(playerid, cmdtext[], e_COMMAND_ERRORS:success)
{
	if(!IsPlayerLogged(playerid))
	{
		SendClientMessage(playerid, COLOR_ERROR, "* Você precisa estar logado para usar algum comando.");
		return COMMAND_DENIED;
	}
	else if(GetPlayerHospitalTime(playerid) > 0)
	{
		SendClientMessage(playerid, COLOR_ERROR, "* Você está em coma.");
		return COMMAND_DENIED;
	}
	else if(success != COMMAND_OK)
		SendClientMessage(playerid, COLOR_ERROR, "* Este comando não existe. Utilize /cmds ou /comandos para uma lista com todos os comandos.");
    return COMMAND_OK;
}
