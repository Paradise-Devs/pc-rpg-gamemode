#include <YSI\y_hooks>

static PlayerNames[MAX_PLAYERS][MAX_PLAYER_NAME];

// Store players name
hook OnPlayerConnect(playerid)
{
	if(IsPlayerNPC(playerid)) return 1;
	GetPlayerName(playerid, PlayerNames[playerid], MAX_PLAYER_NAME);
 	return 1;
}

// Search for players name
SSCANF:u(name[])
{
	// No name specified
	if(isnull(name)) return INVALID_PLAYER_ID;

	new id;

	// Was a part of name provided?
	if(sscanf(name, "i", id))
	{
        new matches;

		// Find a player return the id
		foreach(new i : Player)
		{
			// Search for part of the players name
		    if(strfind(PlayerNames[i], name, true) != -1)
			{
				matches++;
				id = i;
				if(matches > 1) return INVALID_PLAYER_ID;
			}
		}
		// Found a match
		if(matches) return id;

		// No player found return invalid player id
		return INVALID_PLAYER_ID;
	}

	// Player supplied a id

	// Make sure the id is greater than 0
	if(id < 0) return INVALID_PLAYER_ID;

	// Make sure the id is connected
	if(!IsPlayerConnected(id)) return INVALID_PLAYER_ID;

	// Return the id
	return id;
}
