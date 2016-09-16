/*******************************************************************************
* FILENAME :        modules/player/needs.pwn
*
* DESCRIPTION :
*       A script that allows players to have pets.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

#define MAX_PET_NAME    			20
#define PET_MODEL       			19079
#define PET_FOOD_PRICE  			80
#define PET_PRICE					10000
#define PET_MESSAGE_INTERVAL		25000

static gPlayerWarningMessagePet[MAX_PLAYERS];

//------------------------------------------------------------------------------

forward OnPlayerLoadPets(playerid);
forward OnPlayerPetUpdate(playerid);
forward OnInsertPetOnDatabase(playerid);

enum E_PET_DATA
{
    E_PET_DATABASE_INDEX,
    E_PET_ATTACHMENT_INDEX,
    E_PET_NAME[MAX_PET_NAME],
    E_PET_MODEL,
    E_PET_SIZE,
    Float:E_PET_HUNGER,
    Float:E_PET_NEXT_GROWTH,
	E_PET_LAST_MESSAGE,
    E_PET_DBID_PLAYER,
    E_PET_FOOD_PLAYER
}
static gPPetData[MAX_PLAYERS][E_PET_DATA];

// Coordinates to place the pet on player's shoulder
static Float:gPetOffset[][] =
{
    { 0.328340, -0.019586, -0.157024, 0.000000, 0.000000, 0.000000, 0.391784, 0.423681, 0.528653 },
    { 0.328340, -0.019586, -0.157024, 0.000000, 0.000000, 0.000000, 0.509503, 0.486798, 0.625176 },
    { 0.328340, -0.051058, -0.147006, 0.000000, 0.000000, 0.000000, 0.584640, 0.560368, 0.655995 },
    { 0.328340, -0.082576, -0.147006, 0.000000, 0.000000, 0.000000, 0.648338, 0.671368, 0.725697 },
    { 0.328340, -0.082576, -0.147006, 0.000000, 0.000000, 0.000000, 0.949556, 1.045981, 1.021382 }
};

//------------------------------------------------------------------------------

reverse(const string[], dest[], len = sizeof (dest))
{
	new
		i = strlen(string),
		j = 0;
	if (i >= len)
	{
		i = len - 1;
	}
	while (i--)
	{
		dest[j++] = string[i];
	}
	dest[j] = '\0';
	return 1;
}

//------------------------------------------------------------------------------

SavePlayerPetData(playerid)
{
	if(!gPPetData[playerid][E_PET_DBID_PLAYER])
		return 1;

	new query[118];
	mysql_format(mysql, query, sizeof(query), "UPDATE `pets` SET `Size`=%d, `Hunger`=%f, `NextGrowth`=%f, `Food`=%d WHERE `OwnerID`=%d",
	gPPetData[playerid][E_PET_SIZE], gPPetData[playerid][E_PET_HUNGER], gPPetData[playerid][E_PET_NEXT_GROWTH], gPPetData[playerid][E_PET_FOOD_PLAYER],GetPlayerDatabaseID(playerid));
	mysql_tquery(mysql, query);
	return 1;
}

//------------------------------------------------------------------------------

DestroyPlayerPet(playerid)
{
	if(!gPPetData[playerid][E_PET_DBID_PLAYER])
		return 1;

	if(IsPlayerAttachedObjectSlotUsed(playerid, gPPetData[playerid][E_PET_ATTACHMENT_INDEX]))
		RemovePlayerAttachedObject(playerid, gPPetData[playerid][E_PET_ATTACHMENT_INDEX]);

	new query[50];
	mysql_format(mysql, query, sizeof(query), "DELETE FROM `pets` WHERE `OwnerID` = %d", GetPlayerDatabaseID(playerid));
	mysql_tquery(mysql, query);

	ResetPlayerPetData(playerid);
	return 1;
}

//------------------------------------------------------------------------------

// Resets pets variables
ResetPlayerPetData(playerid)
{
    gPPetData[playerid][E_PET_DBID_PLAYER] = 0;
    gPPetData[playerid][E_PET_DATABASE_INDEX] = 0;
    gPPetData[playerid][E_PET_HUNGER] = 0;
}

//------------------------------------------------------------------------------

Float:GetPlayerPetHunger(playerid)
	return gPPetData[playerid][E_PET_HUNGER];

//------------------------------------------------------------------------------

SendPetLocalMessage(playerid, message[])
{
	if(!gPPetData[playerid][E_PET_DBID_PLAYER] || gPPetData[playerid][E_PET_LAST_MESSAGE] > GetTickCount())
		return 1;

	new rev_message[128];
	reverse(message, rev_message);
	strdel(rev_message, strfind(rev_message, " "), strlen(rev_message));

	new pet_sentence[64];
	reverse(rev_message, pet_sentence);
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	new output[64];
	format(output, sizeof(output), "(Pet) %s diz: %s", gPPetData[playerid][E_PET_NAME], pet_sentence);
	foreach(new i: Player)
		if(GetPlayerDistanceFromPoint(i, x, y, z) < 10.0)
			SendClientMessage(i, 0xB6B6B6FF, output);
	gPPetData[playerid][E_PET_LAST_MESSAGE] = GetTickCount() + PET_MESSAGE_INTERVAL;
	return 1;
}

//------------------------------------------------------------------------------

LoadPlayerPets(playerid)
{
	new query[54];
	mysql_format(mysql, query, sizeof(query), "SELECT * FROM `pets` WHERE `OwnerID` = %i",GetPlayerDatabaseID(playerid));
	mysql_tquery(mysql, query, "OnPlayerLoadPets", "i", playerid);
}

//------------------------------------------------------------------------------

public OnPlayerLoadPets(playerid)
{
	new rows, fields;
	cache_get_data(rows, fields, mysql);
	if(rows)
	{
		cache_get_field_content(0, "Name", gPPetData[playerid][E_PET_NAME],	mysql, MAX_PET_NAME);
	    gPPetData[playerid][E_PET_DBID_PLAYER]  = cache_get_field_content_int(0, "ID");
	    gPPetData[playerid][E_PET_MODEL]        = cache_get_field_content_int(0, "Model");
	    gPPetData[playerid][E_PET_SIZE]         = cache_get_field_content_int(0, "Size");
	    gPPetData[playerid][E_PET_HUNGER]       = cache_get_field_content_float(0, "Hunger");
	    gPPetData[playerid][E_PET_NEXT_GROWTH]  = cache_get_field_content_float(0, "NextGrowth");
	    gPPetData[playerid][E_PET_FOOD_PLAYER]  = cache_get_field_content_int(0, "Food");
	}
}

//------------------------------------------------------------------------------

public OnInsertPetOnDatabase(playerid)
{
	new database_id = cache_insert_id();
	gPPetData[playerid][E_PET_DATABASE_INDEX] = database_id;
	gPPetData[playerid][E_PET_DBID_PLAYER] = database_id;
}

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
    CreateDynamicPickup(1239, 1, 1370.2031, -1746.1957, 13.5494, 0, 0, -1, MAX_PICKUP_RANGE);
	CreateDynamic3DTextLabel("Pet Shop\nDigite {1add69}/ajudapet", 0xFFFFFFFF, 1370.2031, -1746.1957, 13.5494, MAX_TEXT3D_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerSpawn(playerid)
{
    if(IsPlayerNPC(playerid))
        return 1;

	if(gPPetData[playerid][E_PET_DBID_PLAYER] != 0)
	{
		// Put the pet on player's shoulder
	    for(new i=7; i<MAX_PLAYER_ATTACHED_OBJECTS; i++)
		{
	        if(!IsPlayerAttachedObjectSlotUsed(playerid, i))
			{
				new size = gPPetData[playerid][E_PET_SIZE];
	            SetPlayerAttachedObject(playerid, i, PET_MODEL, 1, gPetOffset[size][0], gPetOffset[size][1], gPetOffset[size][2], gPetOffset[size][3], gPetOffset[size][4], gPetOffset[size][5], gPetOffset[size][6], gPetOffset[size][7], gPetOffset[size][8]);
				gPPetData[playerid][E_PET_ATTACHMENT_INDEX] = i;
				break;
			}
		}
	}
	return 1;
}

//------------------------------------------------------------------------------

// Called every second to update pet data
public OnPlayerPetUpdate(playerid)
{
	// If the player hasn't pet, ignore it
	if(!gPPetData[playerid][E_PET_DBID_PLAYER])
		return 1;

    // Update pet's hunger
    if(gPPetData[playerid][E_PET_HUNGER] > 0.0)
        gPPetData[playerid][E_PET_HUNGER] -= 0.012;
    else if(gPPetData[playerid][E_PET_HUNGER] < 0.0)
        gPPetData[playerid][E_PET_HUNGER] = 0.0;

    // Update pet's size
    if(gPPetData[playerid][E_PET_SIZE] == 4)
        goto skip_pet_growth;
    if(gPPetData[playerid][E_PET_NEXT_GROWTH] > 100.0)
    {
        SendClientMessage(playerid, 0xffffffff, "* Seu pet {18dbb2}cresceu{ffffff}!");
        gPPetData[playerid][E_PET_NEXT_GROWTH] = 0.0;
        gPPetData[playerid][E_PET_SIZE]++;
    }
    gPPetData[playerid][E_PET_NEXT_GROWTH] += 0.006;
    skip_pet_growth:

    // Send pet warning messages
	if(gPlayerWarningMessagePet[playerid] < GetTickCount() && gPPetData[playerid][E_PET_HUNGER] < 10.0)
	{
		if(gPPetData[playerid][E_PET_HUNGER] <= 0.0)
		{
			SendClientMessage(playerid, 0xffffffff, "* Seu pet {18dbb2}morreu{ffffff} de fome!");
			new	Float:fDist[3];
			GetPlayerPos(playerid, fDist[0], fDist[1], fDist[2]);

			foreach(new i: Player)
			{
				if(!IsPlayerLogged(i))
					continue;

				if(GetPlayerDistanceFromPoint(i, fDist[0], fDist[1], fDist[2]) <= 15.0 && GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid))
				{
					new	message[128];
					format(message, sizeof(message), "* %s caiu do ombro de %s.", gPPetData[playerid][E_PET_NAME], GetPlayerNamef(playerid));
					SendClientMessage(i, 0xDA70D6FF, message);
				}
			}
			DestroyPlayerPet(playerid);
		}
		else if(gPPetData[playerid][E_PET_HUNGER] < 2.5)
        {
            new string[38];
            format(string, sizeof(string), "Estômago roncando. (( %s ))", gPPetData[playerid][E_PET_NAME]);
            SendCustomActionMessage(playerid, 15.0, string);
            SendClientMessage(playerid, 0xFF4040FF, "* Seu pet está faminto!");
        }
		else if(gPPetData[playerid][E_PET_HUNGER] < 5.0)
        {
            new string[38];
            format(string, sizeof(string), "Estômago roncando. (( %s ))", gPPetData[playerid][E_PET_NAME]);
            SendCustomActionMessage(playerid, 15.0, string);
            SendClientMessage(playerid, 0xFF4040FF, "* Seu pet está com fome!");
        }
		else
        {
            new string[38];
            format(string, sizeof(string), "Estômago roncando. (( %s ))", gPPetData[playerid][E_PET_NAME]);
            SendCustomActionMessage(playerid, 15.0, string);
            SendClientMessage(playerid, 0xFF4040FF, "* Seu pet está ficando com fome!");
        }
		gPlayerWarningMessagePet[playerid] = GetTickCount() + 120000;
	}
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
    // When player leaves delete pets data
	SavePlayerPetData(playerid);
    ResetPlayerPetData(playerid);
    return 1;
}

//------------------------------------------------------------------------------

YCMD:ajudapet(playerid, params[], help)
{
	SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~ Comandos Pet ~~~~~~~~~~~~~~~~~~~~");
	SendClientMessage(playerid, COLOR_SUB_TITLE, "* /comprarpet - /alimentarpet - /compraralimentopet - /abandonarpet");
	SendClientMessagef(playerid, COLOR_SUB_TITLE, "* Pet: $%s - Ração: $%s", formatnumber(PET_PRICE), formatnumber(PET_FOOD_PRICE));
	SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~ Comandos Pet ~~~~~~~~~~~~~~~~~~~~");
	return 1;
}

//------------------------------------------------------------------------------

YCMD:comprarpet(playerid, params[], help)
{
    if(!IsPlayerInRangeOfPoint(playerid, 7.5, 1370.2031, -1746.1957, 13.5494))
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não está no petshop.");

    else if(gPPetData[playerid][E_PET_DBID_PLAYER])
        return SendClientMessage(playerid, COLOR_ERROR, "* Você já tem um pet.");

	else if(GetPlayerCash(playerid) < PET_PRICE)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente.");

    new petName[MAX_PET_NAME];
    if(sscanf(params, "s[20]", petName))
    	return SendClientMessage(playerid, COLOR_INFO, "* /comprarpet [nome do pet]");

    new output[75 + MAX_PET_NAME];
    format(output, sizeof(output), "* Você comprou um pet e deu o nome dele de {18dbb2}%s{ffffff}. (/ajudapet)", petName);
    SendClientMessage(playerid, 0xffffffff, output);
	GivePlayerCash(playerid, -PET_PRICE);

    // Assign pet values
    format(gPPetData[playerid][E_PET_NAME], MAX_PET_NAME, "%s", petName);
    gPPetData[playerid][E_PET_MODEL]        = PET_MODEL;
    gPPetData[playerid][E_PET_SIZE]         = 0;
    gPPetData[playerid][E_PET_HUNGER]       = 100.0;
    gPPetData[playerid][E_PET_NEXT_GROWTH]  = 0.0;
    gPPetData[playerid][E_PET_FOOD_PLAYER]  = 0;

    // Put the pet on player's shoulder
    for(new i=7; i<MAX_PLAYER_ATTACHED_OBJECTS; i++)
	{
        if(!IsPlayerAttachedObjectSlotUsed(playerid, i))
		{
            SetPlayerAttachedObject(playerid, i, PET_MODEL, 1, gPetOffset[0][0], gPetOffset[0][1], gPetOffset[0][2], gPetOffset[0][3], gPetOffset[0][4], gPetOffset[0][5], gPetOffset[0][6], gPetOffset[0][7], gPetOffset[0][8]);
            gPPetData[playerid][E_PET_ATTACHMENT_INDEX] = i;
			break;
		}
	}

    // Insert pet on database
    new query[170];
    mysql_format(mysql, query, sizeof(query), "INSERT INTO `pets` (`Name`, `OwnerID`, `Model`, `Size`, `Hunger`, `NextGrowth`, `Food`) VALUES ('%e', %d, %d, 0, 100.0, 0.0, 0)", petName,GetPlayerDatabaseID(playerid), PET_MODEL);
	mysql_tquery(mysql, query, "OnInsertPetOnDatabase", "i", playerid);
    return 1;
}

//------------------------------------------------------------------------------

YCMD:alimentarpet(playerid, params[], help)
{
    if(!gPPetData[playerid][E_PET_DBID_PLAYER])
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem um pet.");

	else if(!gPPetData[playerid][E_PET_FOOD_PLAYER])
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem ração para seu pet.");

	else if(gPPetData[playerid][E_PET_HUNGER] > 25.0)
	{
		SendClientActionMessage(playerid, 15.0, "tenta alimentar seu pet mas ele recusa.");
		return 1;
	}

	new output[36 + MAX_PET_NAME];
	format(output, sizeof(output), "* Você alimentou {18dbb2}%s{ffffff}.", gPPetData[playerid][E_PET_NAME]);
	SendClientMessage(playerid, 0xffffffff, output);
	SendClientActionMessage(playerid, 15.0, "alimenta seu pet.");
	gPPetData[playerid][E_PET_HUNGER] = 100.0;
	gPPetData[playerid][E_PET_FOOD_PLAYER]--;
	return 1;
}

//------------------------------------------------------------------------------

YCMD:compraralimentopet(playerid, params[], help)
{
    if(!IsPlayerInRangeOfPoint(playerid, 7.5, 1370.2031, -1746.1957, 13.5494))
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não está no petshop.");

    else if(!gPPetData[playerid][E_PET_DBID_PLAYER])
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem um pet.");

	else if(gPPetData[playerid][E_PET_FOOD_PLAYER] > 2)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode carregar mais ração.");

	else if(GetPlayerCash(playerid) < PET_FOOD_PRICE)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente.");

	SendClientMessage(playerid, 0xffffffff, "* Você comprou ração para pets.");
	GivePlayerCash(playerid, -PET_FOOD_PRICE);
	gPPetData[playerid][E_PET_FOOD_PLAYER]++;
	return 1;
}

//------------------------------------------------------------------------------

YCMD:abandonarpet(playerid, params[], help)
{
	if(!gPPetData[playerid][E_PET_DBID_PLAYER])
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem um pet.");

	new output[57];
	format(output, sizeof(output), "* Você abandonou {18dbb2}%s{ffffff}.", gPPetData[playerid][E_PET_NAME]);
	SendClientMessage(playerid, 0xffffffff, output);
	SendClientActionMessage(playerid, 15.0, "abandona seu pet.");
	DestroyPlayerPet(playerid);
	return 1;
}
