/*******************************************************************************
* FILENAME :        modules/admin/def.pwn
*
* DESCRIPTION :
*       Adds messages functions.
*
* NOTES :
*       This file should only contain message funcs.
*
* FUNCTION LIST :
*		- PLAYER:
* 			SendPlayerErrorMessage
*			SendPlayerInfoMessage
*			SendPlayerSuccessMessage
*			SendPlayerErrorMessage
*
*		- ADMIN:
*			SendAdminActionMessage
*
*		- SERVER:
*			SendServerMessage
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/


//Ir removendo conforme for usando
#pragma unused SendAdminActionMessageToAll
#pragma unused SendErrorMessageToAll
#pragma unused SendInfoMessageToAll
#pragma unused SendSuccessMessageToAll

//------------------------------------------------------------------------------

/***
 *
 *     #####  #         ##   #     # ###### #####
 *     #    # #        #  #   #   #  #      #    #
 *     #    # #       #    #   # #   #####  #    #
 *     #####  #       ######    #    #      #####
 *     #      #       #    #    #    #      #   #
 *     #      ####### #    #    #    ###### #    #
 *
 */

//------------------------------------------------------------------------------

SendPlayerErrorMessage(playerid, const message[], va_args<>)
{
	new textBuffer[192];

	if(numargs() > 2) {
		va_format(textBuffer, sizeof(textBuffer), message, va_start<2>);
		format(textBuffer, sizeof(textBuffer), "* %s", textBuffer);
	} else {
		format(textBuffer, sizeof(textBuffer), "* %s", message);
    }

	SendClientMessage(playerid, COLOR_ERROR, textBuffer);

	return 1;
}

//------------------------------------------------------------------------------

SendPlayerInfoMessage(playerid, const message[], va_args<>)
{
	new textBuffer[192];

	if(numargs() > 2) {
		va_format(textBuffer, sizeof(textBuffer), message, va_start<2>);
		format(textBuffer, sizeof(textBuffer), "* %s", textBuffer);
		return SendClientMessage(playerid, COLOR_INFO, textBuffer);
	} else {
		format(textBuffer, sizeof(textBuffer), "* %s", message);
    }

	SendClientMessage(playerid, COLOR_INFO, textBuffer);

	return 1;
}


//------------------------------------------------------------------------------

SendPlayerSuccessMessage(playerid, const message[], va_args<>)
{
	new textBuffer[192];
	if(numargs() > 2) {
		va_format(textBuffer, sizeof(textBuffer), message, va_start<2>);
		format(textBuffer, sizeof(textBuffer), "* %s", textBuffer);
		return SendClientMessage(playerid, COLOR_SUCCESS, textBuffer);
	} else {
		format(textBuffer, sizeof(textBuffer), "* %s", message);
    }

	SendClientMessage(playerid, COLOR_SUCCESS, textBuffer);

	return 1;
}


//------------------------------------------------------------------------------

SendAdminActionMessage(playerid, const message[], va_args<>)
{
	new textBuffer[192];
	if(numargs() > 2)
	{
		va_format(textBuffer, sizeof(textBuffer), message, va_start<2>);
		format(textBuffer, sizeof(textBuffer), "* %s", textBuffer);

		return SendClientMessage(playerid, COLOR_ADMIN_ACTION, textBuffer);
	}
	else
	{
		SendClientMessage(playerid, COLOR_ADMIN_ACTION, message);
  }
	return 1;
}

//------------------------------------------------------------------------------

SendActionMessage(playerid, Float:radius, action[])
{
	new	Float:fDist[3];
	GetPlayerPos(playerid, fDist[0], fDist[1], fDist[2]);

	foreach(new i: Player)
	{
		if(!IsPlayerLogged(i))
			continue;

		if(GetPlayerDistanceFromPoint(i, fDist[0], fDist[1], fDist[2]) <= radius && GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid))
		{
			new	message[128];
			format(message, sizeof(message), "* %s (( %s ))", action, GetPlayerNamef(playerid));
			SendClientMessage(i, COLOR_ACTION, message);
		}
	}
}

//------------------------------------------------------------------------------

SendClientLocalMessage(playerid, color, Float:radius, string[])
{
	SetPlayerChatBubble(playerid, string, color, radius, 5000);
	new Float:fDist[3];
	GetPlayerPos(playerid, fDist[0], fDist[1], fDist[2]);
	foreach(new i: Player)
	{
		if(GetPlayerDistanceFromPoint(i, fDist[0], fDist[1], fDist[2]) <= radius)
		{
			SendClientMessage(i, color, string);
		}
	}
}

//------------------------------------------------------------------------------

SendClientActionMessage(playerid, Float:radius, action[])
{
	new	Float:fDist[3];
	GetPlayerPos(playerid, fDist[0], fDist[1], fDist[2]);

	foreach(new i: Player)
	{
		if(!IsPlayerLogged(i))
			continue;

		if(GetPlayerDistanceFromPoint(i, fDist[0], fDist[1], fDist[2]) <= radius && GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid))
		{
			new	message[128];
			format(message, sizeof(message), "* %s %s", GetPlayerNamef(playerid), action);
			SendClientMessage(i, COLOR_ACTION, message);
		}
	}
}

//------------------------------------------------------------------------------

/***
 *
 *       ##   #      #
 *      #  #  #      #
 *     #    # #      #
 *     ###### #      #
 *     #    # #      #
 *     #    # ###### ######
 *
 */

SendErrorMessageToAll(const message[], va_args<>)
{
	new textBuffer[192];

	if(numargs() > 1) {
		va_format(textBuffer, sizeof(textBuffer), message, va_start<1>);
		format(textBuffer, sizeof(textBuffer), "* %s", textBuffer);
	} else {
		format(textBuffer, sizeof(textBuffer), "* %s", message);
    }

	SendClientMessageToAll(COLOR_ERROR, textBuffer);

	return 1;
}

//------------------------------------------------------------------------------

SendInfoMessageToAll(const message[], va_args<>)
{
	new textBuffer[192];

	if(numargs() > 1) {
		va_format(textBuffer, sizeof(textBuffer), message, va_start<1>);
		format(textBuffer, sizeof(textBuffer), "* %s", textBuffer);
	} else {
		format(textBuffer, sizeof(textBuffer), "* %s", message);
    }

	SendClientMessageToAll(COLOR_INFO, textBuffer);

	return 1;
}


//------------------------------------------------------------------------------

SendSuccessMessageToAll(playerid, const message[], va_args<>)
{
	new textBuffer[192];
	if(numargs() > 2) {
		va_format(textBuffer, sizeof(textBuffer), message, va_start<2>);
		format(textBuffer, sizeof(textBuffer), "* %s", textBuffer);
		return SendClientMessage(playerid, COLOR_SUCCESS, textBuffer);
	} else {
		format(textBuffer, sizeof(textBuffer), "* %s", message);
    }

	SendClientMessageToAll(COLOR_SUCCESS, textBuffer);

	return 1;
}

//------------------------------------------------------------------------------

SendAdminActionMessageToAll(playerid, const message[], va_args<>)
{
	new textBuffer[192];
	if(numargs() > 2) {
		va_format(textBuffer, sizeof(textBuffer), message, va_start<2>);
		format(textBuffer, sizeof(textBuffer), "* %s", textBuffer);

		return SendClientMessage(playerid, COLOR_ADMIN_ACTION, textBuffer);
	} else {
		format(textBuffer, sizeof(textBuffer), "* %s", message);
    }

	SendClientMessageToAll(COLOR_ADMIN_ACTION, textBuffer);

	return 1;
}

//------------------------------------------------------------------------------

/***
 *
 *       ##   #####  #    # # #    #
 *      #  #  #    # ##  ## # ##   #
 *     #    # #    # # ## # # # #  #
 *     ###### #    # #    # # #  # #
 *     #    # #    # #    # # #   ##
 *     #    # #####  #    # # #    #
 *
 ***/

SendAdminMessage(PLAYER_RANK:rank, color, const message[], va_args<>)
{
	new out[228];

	// Large array because of possible embedding colours
	va_format(out, sizeof(out), message, va_start<3>);
	format(out, sizeof(out), "* %s", out);

	foreach(new i: Player)
	{
        if(GetPlayerHighestRank(i) < rank)
            continue;

        if(IsPlayerLogged(i))
            SendClientMessage(i, color, out);
	}

    return 1;
}


//------------------------------------------------------------------------------

/***
 *
 *      ####  ###### #####  #    # ###### #####
 *     #      #      #    # #    # #      #    #
 *      ####  #####  #    # #    # #####  #    #
 *          # #      #####  #    # #      #####
 *     #    # #      #   #   #  #  #      #   #
 *      ####  ###### #    #   ##   ###### #    #
 *
 ***/

SendServerMessage(const message[], va_args<>)
{
   new textBuffer[192];
   if(numargs() > 2) {
       va_format(textBuffer, sizeof(textBuffer), message, va_start<1>);
       format(textBuffer, sizeof(textBuffer), "* %s", textBuffer);

       foreach(new i: Player)
           if(IsPlayerLogged(i))
               SendClientMessage(i, COLOR_SERVER, textBuffer);
   } else {
       format(textBuffer, sizeof(textBuffer), "* %s", message);

       foreach(new i: Player)
           if(IsPlayerLogged(i))
               SendClientMessage(i, COLOR_SERVER, message);
   }

   return 1;
}
