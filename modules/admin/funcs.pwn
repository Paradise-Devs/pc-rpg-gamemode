/*******************************************************************************
* FILENAME :        modules/admin/funcs.pwn
*
* DESCRIPTION :
*       Adds admins functions.
*
* NOTES :
*       This file should only contain admin funcs.
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

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
	if(numargs() > 2) {
		va_format(textBuffer, sizeof(textBuffer), message, va_start<2>);
		format(textBuffer, sizeof(textBuffer), "* %s", textBuffer);

		return SendClientMessage(playerid, COLOR_ADMIN_ACTION, textBuffer);
	} else {
		format(textBuffer, sizeof(textBuffer), "* %s", message);
    }

	SendClientMessage(playerid, COLOR_ADMIN_ACTION, textBuffer);

	return 1;
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

	if(numargs() > 2) {
		va_format(textBuffer, sizeof(textBuffer), message, va_start<2>);
		format(textBuffer, sizeof(textBuffer), "* %s", textBuffer);
		return SendClientMessage(playerid, COLOR_INFO, textBuffer);
	} else {
		format(textBuffer, sizeof(textBuffer), "* %s", message);
    }

	SendClientMessageToAll(COLOR_INFO, textBuffer);

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

	SendClientMessageToAll(COLOR_SUCCESS, textBuffer);

	return 1;
}


//------------------------------------------------------------------------------

SendAdminActionMessage(playerid, const message[], va_args<>)
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
