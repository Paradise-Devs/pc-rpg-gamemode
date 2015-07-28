/*******************************************************************************
* FILENAME :        modules/admin/commands.pwn
*
* DESCRIPTION :
*       Adds admins commands to the server.
*
* NOTES :
*       This file should only contain admin data.
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

//------------------------------------------------------------------------------

YCMD:acmds(playerid, params[], help)
{
    if(GetPlayerHighestRank(playerid) < PLAYER_RANK_MODERATOR)
 		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Admin Comandos ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	if(GetPlayerHighestRank(playerid) >= PLAYER_RANK_MODERATOR) SendClientMessage(playerid, 0xffffffff, "* /ir - /puxar - /flip - /reparar - /ls - /sf - /lv");
	if(GetPlayerHighestRank(playerid) >= PLAYER_RANK_ADMIN) SendClientMessage(playerid, 0xecececff, "* /criarcar - /setmoney");
	SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Admin Comandos ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	return 1;
}

//------------------------------------------------------------------------------

/***
 *
 *     #    #  ####  #####  ###### #####    ##   #####  ####  #####
 *     ##  ## #    # #    # #      #    #  #  #    #   #    # #    #
 *     # ## # #    # #    # #####  #    # #    #   #   #    # #    #
 *     #    # #    # #    # #      #####  ######   #   #    # #####
 *     #    # #    # #    # #      #   #  #    #   #   #    # #   #
 *     #    #  ####  #####  ###### #    # #    #   #    ####  #    #
 *
 */

 YCMD:ir(playerid, params[], help)
 {
 	if(GetPlayerHighestRank(playerid) < PLAYER_RANK_MODERATOR)
 		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

 	new targetid;
 	if(sscanf(params, "u", targetid))
 		return SendClientMessage(playerid, COLOR_INFO, "* /ir [playerid]");

 	else if(!IsPlayerLogged(targetid))
 		return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");

 	else if(targetid == playerid)
 		return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode ir até você mesmo.");

 	new Float:x, Float:y, Float:z;
    GetPlayerPos(targetid, x, y, z);

    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
        SetPlayerPos(playerid, x, y, z);
    else
        SetVehiclePos(GetPlayerVehicleID(playerid), x, y, z);

    new output[50];
    format(output, sizeof(output), "* %s veio até você.", GetPlayerNamef(playerid));
    SendClientMessage(targetid, COLOR_ADMIN_ACTION, output);
    format(output, sizeof(output), "* Você foi até %s.", GetPlayerNamef(targetid));
    SendClientMessage(playerid, COLOR_ADMIN_ACTION, output);
 	return 1;
 }

//------------------------------------------------------------------------------

 YCMD:puxar(playerid, params[], help)
 {
 	if(GetPlayerHighestRank(playerid) < PLAYER_RANK_MODERATOR)
 		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

 	new targetid;
 	if(sscanf(params, "u", targetid))
 		return SendClientMessage(playerid, COLOR_INFO, "* /puxar [playerid]");

 	else if(!IsPlayerLogged(targetid))
 		return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");

 	else if(targetid == playerid)
 		return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode puxar você mesmo.");

 	new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    if(GetPlayerState(targetid) != PLAYER_STATE_DRIVER)
        SetPlayerPos(targetid, x, y, z);
    else
        SetVehiclePos(GetPlayerVehicleID(targetid), x, y, z);

    new output[50];
    format(output, sizeof(output), "* %s puxou você.", GetPlayerNamef(playerid));
    SendClientMessage(targetid, COLOR_ADMIN_ACTION, output);
    format(output, sizeof(output), "* Você puxou %s.", GetPlayerNamef(targetid));
    SendClientMessage(playerid, COLOR_ADMIN_ACTION, output);
 	return 1;
 }

//------------------------------------------------------------------------------

 YCMD:flip(playerid, params[], help)
 {
 	if(GetPlayerHighestRank(playerid) < PLAYER_RANK_MODERATOR)
 		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

    else if(!IsPlayerInAnyVehicle(playerid))
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não está em um veículo.");

    new Float:a, vehicleid = GetPlayerVehicleID(playerid);
    GetVehicleZAngle(vehicleid, a);
    SetVehicleZAngle(vehicleid, a);
    SendClientMessage(playerid, COLOR_ADMIN_ACTION, "* Você flipou seu veículo.");
 	return 1;
 }

//------------------------------------------------------------------------------

 YCMD:ls(playerid, params[], help)
 {
 	if(GetPlayerHighestRank(playerid) < PLAYER_RANK_MODERATOR)
 		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
        SetPlayerPos(playerid, 1540.3774, -1675.6068, 13.5505);
    else
        SetVehiclePos(GetPlayerVehicleID(playerid), 1540.3774, -1675.6068, 13.5505);
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
 	return 1;
 }

//------------------------------------------------------------------------------

 YCMD:sf(playerid, params[], help)
 {
 	if(GetPlayerHighestRank(playerid) < PLAYER_RANK_MODERATOR)
 		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
        SetPlayerPos(playerid, -1816.0549, 590.1733, 35.1641);
    else
        SetVehiclePos(GetPlayerVehicleID(playerid), -1816.0549, 590.1733, 35.1641);
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
 	return 1;
 }

//------------------------------------------------------------------------------

 YCMD:lv(playerid, params[], help)
 {
 	if(GetPlayerHighestRank(playerid) < PLAYER_RANK_MODERATOR)
 		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
        SetPlayerPos(playerid, 2023.5212, 1341.9235, 10.82035);
    else
        SetVehiclePos(GetPlayerVehicleID(playerid), 2023.5212, 1341.9235, 10.8203);
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
 	return 1;
 }

//------------------------------------------------------------------------------

/***
 *
 *       ##   #####  #    # # #    # #  ####  ##### #####    ##   #####  ####  #####
 *      #  #  #    # ##  ## # ##   # # #        #   #    #  #  #    #   #    # #    #
 *     #    # #    # # ## # # # #  # #  ####    #   #    # #    #   #   #    # #    #
 *     ###### #    # #    # # #  # # #      #   #   #####  ######   #   #    # #####
 *     #    # #    # #    # # #   ## # #    #   #   #   #  #    #   #   #    # #   #
 *     #    # #####  #    # # #    # #  ####    #   #    # #    #   #    ####  #    #
 *
 ***/

YCMD:criarcar(playerid, params[], help)
{
    if(GetPlayerHighestRank(playerid) < PLAYER_RANK_ADMIN)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

    new
		idx,
		iString[ 128 ];

	if ( params[ 0 ] == '\0' )
		return SendClientMessage( playerid, COLOR_INFO, "* /criarcar [modeloid/nome]" );

	idx = GetVehicleModelIDFromName( params );

	if( idx == -1 )
	{
		idx = strval(iString);

		if ( idx < 400 || idx > 611 )
			return SendClientMessage(playerid, COLOR_ERROR, "* Veículo inválido.");
	}

	new	Float:x, Float:y, Float:z, Float:a;
	GetPlayerPos(playerid, x, y, z);
	GetXYInFrontOfPlayer(playerid, x, y, 5.0);
	GetPlayerFacingAngle(playerid, a);

	new vehicleid = CreateVehicle(idx, x, y, z + 2.0, a + 90.0, -1, -1, 5000);
	LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid));
    SetVehicleFuel(vehicleid, 100.0);

    format(iString, 128, "* Você criou um \"%s\" (ModeloID: %d, VeículoID: %d)", aVehicleNames[idx - 400], idx, vehicleid);
	SendClientMessage(playerid, COLOR_SUCCESS, iString);
    return 1;
}

//------------------------------------------------------------------------------

YCMD:setmoney(playerid, params[], help)
{
   if(GetPlayerHighestRank(playerid) < PLAYER_RANK_ADMIN)
       return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

   new targetid, value;
   if(sscanf(params, "ui", targetid, value))
       return SendClientMessage(playerid, COLOR_INFO, "* /setmoney [playerid] [dinheiro]");

   else if(!IsPlayerLogged(targetid))
       return SendClientMessage(playerid, COLOR_ERROR, "* O jogador não está conectado.");

   SetPlayerCash(playerid, value);

   new output[80];
   if(playerid != targetid) {
       format(output, sizeof(output), "* %s alterou seu dinheiro para $%s.", GetPlayerNamef(playerid), formatnumber(value));
       SendClientMessage(targetid, COLOR_ADMIN_ACTION, output);
   }
   format(output, sizeof(output), "* Você alterou o dinheiro de %s para $%s.", GetPlayerNamef(targetid), formatnumber(value));
   SendClientMessage(playerid, COLOR_ADMIN_ACTION, output);
   return 1;
}

//------------------------------------------------------------------------------

/***
 *
 *     #####  ###### #    # ###### #       ####  #####  ###### #####
 *     #    # #      #    # #      #      #    # #    # #      #    #
 *     #    # #####  #    # #####  #      #    # #    # #####  #    #
 *     #    # #      #    # #      #      #    # #####  #      #####
 *     #    # #       #  #  #      #      #    # #      #      #   #
 *     #####  ######   ##   ###### ######  ####  #      ###### #    #
 *
 */

YCMD:setrank(playerid, params[], help)
{
	if(IsPlayerAdmin(playerid) || GetPlayerHighestRank(playerid) == PLAYER_RANK_DEVELOPER)
	{
		new	targetid, rankName[9], option[8];
		if(sscanf(params, "us[9]s[8]", targetid, rankName, option))
        {
			SendClientMessage(playerid, COLOR_INFO, "* /setrank [playerid] [nome do rank] [add / remover]");
			SendClientMessage(playerid, COLOR_WHITE, "* Ranks: donator, designer, beta, mod, super, admin, dev");
        }
        else
        {
            if(!strcmp(rankName, "donator", true))
            {
                if(!strcmp(option, "add", true))
                {
                    new output[40 + MAX_PLAYER_NAME];
                    format(output, sizeof(output), "* Você adicinou %s ao cargo donator.", GetPlayerNamef(targetid));
                    SendClientMessage(playerid, COLOR_SUCCESS, output);
                    SetPlayerRank(PLAYER_RANK_DONATOR, targetid, true);
                }
                else if(!strcmp(option, "remover", true))
                {
                    new output[40 + MAX_PLAYER_NAME];
                    format(output, sizeof(output), "* Você removeu %s do cargo donator.", GetPlayerNamef(targetid));
                    SendClientMessage(playerid, COLOR_SUCCESS, output);
                    SetPlayerRank(PLAYER_RANK_DONATOR, targetid, false);
                }
                else SendClientMessage(playerid, COLOR_ERROR, "* Opção inválida.");
            }
            else if(!strcmp(rankName, "designer", true))
            {
                if(!strcmp(option, "add", true))
                {
                    new output[40 + MAX_PLAYER_NAME];
                    format(output, sizeof(output), "* Você adicinou %s ao cargo designer.", GetPlayerNamef(targetid));
                    SendClientMessage(playerid, COLOR_SUCCESS, output);
                    SetPlayerRank(PLAYER_RANK_DESIGNER, targetid, true);
                }
                else if(!strcmp(option, "remover", true))
                {
                    new output[40 + MAX_PLAYER_NAME];
                    format(output, sizeof(output), "* Você removeu %s do cargo designer.", GetPlayerNamef(targetid));
                    SendClientMessage(playerid, COLOR_SUCCESS, output);
                    SetPlayerRank(PLAYER_RANK_DESIGNER, targetid, false);
                }
                else SendClientMessage(playerid, COLOR_ERROR, "* Opção inválida.");
            }
            else if(!strcmp(rankName, "beta", true))
            {
                if(!strcmp(option, "add", true))
                {
                    new output[40 + MAX_PLAYER_NAME];
                    format(output, sizeof(output), "* Você adicinou %s ao cargo beta.", GetPlayerNamef(targetid));
                    SendClientMessage(playerid, COLOR_SUCCESS, output);
                    SetPlayerRank(PLAYER_RANK_BETATESTER, targetid, true);
                }
                else if(!strcmp(option, "remover", true))
                {
                    new output[40 + MAX_PLAYER_NAME];
                    format(output, sizeof(output), "* Você removeu %s do cargo beta.", GetPlayerNamef(targetid));
                    SendClientMessage(playerid, COLOR_SUCCESS, output);
                    SetPlayerRank(PLAYER_RANK_BETATESTER, targetid, false);
                }
                else SendClientMessage(playerid, COLOR_ERROR, "* Opção inválida.");
            }
            else if(!strcmp(rankName, "mod", true))
            {
                if(!strcmp(option, "add", true))
                {
                    new output[40 + MAX_PLAYER_NAME];
                    format(output, sizeof(output), "* Você adicinou %s ao cargo moderador.", GetPlayerNamef(targetid));
                    SendClientMessage(playerid, COLOR_SUCCESS, output);
                    SetPlayerRank(PLAYER_RANK_MODERATOR, targetid, true);
                }
                else if(!strcmp(option, "remover", true))
                {
                    new output[40 + MAX_PLAYER_NAME];
                    format(output, sizeof(output), "* Você removeu %s do cargo moderador.", GetPlayerNamef(targetid));
                    SendClientMessage(playerid, COLOR_SUCCESS, output);
                    SetPlayerRank(PLAYER_RANK_MODERATOR, targetid, false);
                }
                else SendClientMessage(playerid, COLOR_ERROR, "* Opção inválida.");
            }
            else if(!strcmp(rankName, "super", true))
            {
                if(!strcmp(option, "add", true))
                {
                    new output[40 + MAX_PLAYER_NAME];
                    format(output, sizeof(output), "* Você adicinou %s ao cargo supervisor.", GetPlayerNamef(targetid));
                    SendClientMessage(playerid, COLOR_SUCCESS, output);
                    SetPlayerRank(PLAYER_RANK_SUPERVISOR, targetid, true);
                }
                else if(!strcmp(option, "remover", true))
                {
                    new output[40 + MAX_PLAYER_NAME];
                    format(output, sizeof(output), "* Você removeu %s do cargo supervisor.", GetPlayerNamef(targetid));
                    SendClientMessage(playerid, COLOR_SUCCESS, output);
                    SetPlayerRank(PLAYER_RANK_SUPERVISOR, targetid, false);
                }
                else SendClientMessage(playerid, COLOR_ERROR, "* Opção inválida.");
            }
            else if(!strcmp(rankName, "admin", true))
            {
                if(!strcmp(option, "add", true))
                {
                    new output[40 + MAX_PLAYER_NAME];
                    format(output, sizeof(output), "* Você adicinou %s ao cargo admin.", GetPlayerNamef(targetid));
                    SendClientMessage(playerid, COLOR_SUCCESS, output);
                    SetPlayerRank(PLAYER_RANK_ADMIN, targetid, true);
                }
                else if(!strcmp(option, "remover", true))
                {
                    new output[40 + MAX_PLAYER_NAME];
                    format(output, sizeof(output), "* Você removeu %s do cargo admin.", GetPlayerNamef(targetid));
                    SendClientMessage(playerid, COLOR_SUCCESS, output);
                    SetPlayerRank(PLAYER_RANK_ADMIN, targetid, false);
                }
                else SendClientMessage(playerid, COLOR_ERROR, "* Opção inválida.");
            }
            else if(!strcmp(rankName, "dev", true))
            {
                if(!strcmp(option, "add", true))
                {
                    new output[40 + MAX_PLAYER_NAME];
                    format(output, sizeof(output), "* Você adicinou %s ao cargo dev.", GetPlayerNamef(targetid));
                    SendClientMessage(playerid, COLOR_SUCCESS, output);
                    SetPlayerRank(PLAYER_RANK_DEVELOPER, targetid, true);
                }
                else if(!strcmp(option, "remover", true))
                {
                    new output[40 + MAX_PLAYER_NAME];
                    format(output, sizeof(output), "* Você removeu %s do cargo dev.", GetPlayerNamef(targetid));
                    SendClientMessage(playerid, COLOR_SUCCESS, output);
                    SetPlayerRank(PLAYER_RANK_DEVELOPER, targetid, false);
                }
                else SendClientMessage(playerid, COLOR_ERROR, "* Opção inválida.");
            }
        }
    }
	else SendClientMessage(playerid, COLOR_ERROR, "Você não tem permissão.");
	return 1;
}
