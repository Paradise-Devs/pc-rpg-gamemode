/* *************************************************************************** *
*  Description: Houses module file.
*
*  Assignment: A script to make houses available to players buy and rent.
*
*           Copyright Paradise Devs 2015.  All rights reserved.
* *************************************************************************** */

//------------------------------------------------------------------------------
/***
 *    ##     ## ########    ###    ########  ######## ########
 *    ##     ## ##         ## ##   ##     ## ##       ##     ##
 *    ##     ## ##        ##   ##  ##     ## ##       ##     ##
 *    ######### ######   ##     ## ##     ## ######   ########
 *    ##     ## ##       ######### ##     ## ##       ##   ##
 *    ##     ## ##       ##     ## ##     ## ##       ##    ##
 *    ##     ## ######## ##     ## ########  ######## ##     ##
 ***/
//------------------------------------------------------------------------------

#if defined _MODULE_house
	#endinput
#endif
#define _MODULE_house

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

#if !defined MAX_HOUSES
	#define MAX_HOUSES			8
#endif

//------------------------------------------------------------------------------

#if !defined MAX_HOUSE_NAME
    #define MAX_HOUSE_NAME			64
#endif

//------------------------------------------------------------------------------

enum E_HOUSE_DATA
{
	E_HOUSE_DESCR[MAX_HOUSE_NAME],
	E_HOUSE_OWNER[MAX_PLAYER_NAME],
	E_HOUSE_LOCATION[MAX_ZONE_NAME],
	Float:E_HOUSE_ENTERX,
	Float:E_HOUSE_ENTERY,
	Float:E_HOUSE_ENTERZ,
	Float:E_HOUSE_ENTERA,
	Float:E_HOUSE_EXITX,
	Float:E_HOUSE_EXITY,
	Float:E_HOUSE_EXITZ,
	Float:E_HOUSE_EXITA,
	E_HOUSE_ENTERWORLD,
	E_HOUSE_ENTERINT,
	E_HOUSE_EXITINT,
	E_HOUSE_OWNED,
	E_HOUSE_LOCKED,
	E_HOUSE_PRICE,
	E_HOUSE_RENTABLE,
	E_HOUSE_RENTCOST,
	E_HOUSE_BEDS,
	E_HOUSE_ROOMS,
	E_HOUSE_GARAGE,
	E_HOUSE_PICKUP,
	E_HOUSE_PICKUP_EXIT,
	E_HOUSE_MAPICON,
	E_HOUSE_DATABASEID,
	Text3D:E_HOUSE_TEXT3D
}
new	gHouseData[MAX_HOUSES][E_HOUSE_DATA];

//------------------------------------------------------------------------------

static gPlayerKey[MAX_PLAYERS] = {INVALID_HOUSE_ID, ...};

//------------------------------------------------------------------------------

forward LoadDynamicHouse();

//------------------------------------------------------------------------------
/***
 *    ######## ##     ## ##    ##  ######  ######## ####  #######  ##    ##  ######
 *    ##       ##     ## ###   ## ##    ##    ##     ##  ##     ## ###   ## ##    ##
 *    ##       ##     ## ####  ## ##          ##     ##  ##     ## ####  ## ##
 *    ######   ##     ## ## ## ## ##          ##     ##  ##     ## ## ## ##  ######
 *    ##       ##     ## ##  #### ##          ##     ##  ##     ## ##  ####       ##
 *    ##       ##     ## ##   ### ##    ##    ##     ##  ##     ## ##   ### ##    ##
 *    ##        #######  ##    ##  ######     ##    ####  #######  ##    ##  ######
 ***/
//------------------------------------------------------------------------------

/* *************************************************************************** *
*  Assignment: Gets the player's house id
*
*  Params:
* 			playerid: ID of the player
*
*  Returns:
*			The house ID
* *************************************************************************** */
GetPlayerHouseID(playerid)
{
    return gPlayerKey[playerid];
}

/* *************************************************************************** *
*  Assignment: Sets the player's house id
*
*  Params:
* 			playerid: ID of the player
* 			hosueid: ID of the house
*
*  Returns:
*			Nothing
* *************************************************************************** */
SetPlayerHouseID(playerid, hosueid)
{
    gPlayerKey[playerid] = hosueid;
}

/* *************************************************************************** *
*  Assignment: Gets the closest house from the player
*
*  Params:
* 			playerid: ID of the player
*			houseid: ID of the house.
* 			range: Distance to search
*
*  Returns:
*			The house ID
* *************************************************************************** */
stock IsPlayerInRangeOfHouse(playerid, houseid, Float:range = 3.0)
	return (IsPlayerInRangeOfPoint(playerid, range, gHouseData[houseid][E_HOUSE_ENTERX], gHouseData[houseid][E_HOUSE_ENTERY], gHouseData[houseid][E_HOUSE_ENTERZ]) ? true : false);

/* *************************************************************************** *
*  Assignment: Gets the closest house from the player
*
*  Params:
*			playerid: ID of the player.
* 			range: Distance to search
*
*  Returns:
*			The house ID
* *************************************************************************** */
stock GetPlayerClosestHouseID(playerid, Float:range = 3.0)
{
	new houseid = INVALID_HOUSE_ID;
	foreach(new h: House)
	{
		if(IsPlayerInRangeOfPoint(playerid, range, gHouseData[h][E_HOUSE_ENTERX], gHouseData[h][E_HOUSE_ENTERY], gHouseData[h][E_HOUSE_ENTERZ]))
		{
			houseid = h;
			break;
		}
	}
	return houseid;
}


/*
	Gets the closest house from the player
		playerid: ID of the player.
		onlyforsale: true or false
	returns
		The business ID
*/

stock GetClosestHouseFromPlayer(playerid, bool:onlyforsale)
{
	new Float:distance = Float:0x7F800000;
	new houseid = INVALID_HOUSE_ID;
	foreach(new h: House)
	{
		if(GetPlayerDistanceFromPoint(playerid, gHouseData[h][E_HOUSE_ENTERX], gHouseData[h][E_HOUSE_ENTERY], gHouseData[h][E_HOUSE_ENTERZ]) < distance)
		{
			if((onlyforsale) && IsHouseOwned(h))
				continue;

			distance = GetPlayerDistanceFromPoint(playerid, gHouseData[h][E_HOUSE_ENTERX], gHouseData[h][E_HOUSE_ENTERY], gHouseData[h][E_HOUSE_ENTERZ]);
			houseid = h;
		}
	}
	return houseid;
}

/* *************************************************************************** *
*  Assignment: Gets the house entrance position
*
*  Params:
*			playerid: ID of the player.
* 			x: x coords
* 			y: y coords
* 			z: z coords
*
*  Returns:
*			Nothing
* *************************************************************************** */
stock GetHouseEntrance(houseid, &Float:x, &Float:y, &Float:z)
{
	x = gHouseData[houseid][E_HOUSE_ENTERX];
	y = gHouseData[houseid][E_HOUSE_ENTERY];
	z = gHouseData[houseid][E_HOUSE_ENTERZ];
	return 1;
}

/* *************************************************************************** *
*  Assignment: Get the house virtual world
*
*  Params:
*			houseid: ID of the house.
*
*  Returns:
*			The house virtual world
* *************************************************************************** */
stock GetHouseVirtualWorld(houseid)
{
	return gHouseData[houseid][E_HOUSE_ENTERWORLD];
}

stock GetHouseLockState(houseid)
	return gHouseData[houseid][E_HOUSE_LOCKED];

stock GetHouseRooms(houseid)
	return gHouseData[houseid][E_HOUSE_ROOMS];

stock GetHouseBeds(houseid)
	return gHouseData[houseid][E_HOUSE_BEDS];

/* *************************************************************************** *
*  Assignment: Set the house virtual world
*
*  Params:
*			houseid: ID of the house.
*			worldid: ID of the virtual world.
*
*  Returns:
*			Nothing
* *************************************************************************** */
stock SetHouseVirtualWorld(houseid, worldid)
{
	if(worldid < 0) worldid = 0;
	gHouseData[houseid][E_HOUSE_ENTERWORLD] = worldid;

	new query[58];
	mysql_format(mysql, query, sizeof(query), "UPDATE `houses` SET `EnterWorld`=%d WHERE `ID`=%d", \
	gHouseData[houseid][E_HOUSE_ENTERWORLD], gHouseData[houseid][E_HOUSE_DATABASEID]);
	mysql_tquery(mysql, query);
}

/* *************************************************************************** *
*  Assignment: Get the house interior of the out-side
*
*  Params:
*			houseid: ID of the house.
*
*  Returns:
*			The house interior
* *************************************************************************** */
stock GetHouseInteriorOut(houseid)
{
	return gHouseData[houseid][E_HOUSE_ENTERINT];
}

/* *************************************************************************** *
*  Assignment: Set the house interior of out-side
*
*  Params:
*			houseid: ID of the house.
* 			intid: Interior ID.
*
*  Returns:
*			Nothing
* *************************************************************************** */
stock SetHouseInteriorOut(houseid, intid)
{
	if(intid < 0) intid = 0;
	gHouseData[houseid][E_HOUSE_ENTERINT] = intid;

	new query[58];
	mysql_format(mysql, query, sizeof(query), "UPDATE `houses` SET `EnterInt`=%d WHERE `ID`=%d", \
	gHouseData[houseid][E_HOUSE_ENTERINT], gHouseData[houseid][E_HOUSE_DATABASEID]);
	mysql_tquery(mysql, query);
}

/* *************************************************************************** *
*  Assignment: Get the house interior if in-side
*
*  Params:
*			houseid: ID of the house.
*
*  Returns:
*			The house interior
* *************************************************************************** */
stock GetHouseInteriorIn(houseid)
{
	return gHouseData[houseid][E_HOUSE_EXITINT];
}

/* *************************************************************************** *
*  Assignment: Set the house interior of in-side
*
*  Params:
*			houseid: ID of the house.
* 			intid: Interior ID.
*
*  Returns:
*			Nothing
* *************************************************************************** */
stock SetHouseInteriorIn(houseid, intid)
{
	if(intid < 0) intid = 0;
	gHouseData[houseid][E_HOUSE_EXITINT] = intid;

	new query[58];
	mysql_format(mysql, query, sizeof(query), "UPDATE `houses` SET `ExitInt`=%d WHERE `ID`=%d", \
	gHouseData[houseid][E_HOUSE_EXITINT], gHouseData[houseid][E_HOUSE_DATABASEID]);
	mysql_tquery(mysql, query);
}

/* *************************************************************************** *
*  Assignment: Get if the house is owned
*
*  Params:
*			houseid: ID of the house.
*
*  Returns:
*			1 if the house is owned
* 			0 if not
* *************************************************************************** */
stock IsHouseOwned(houseid)
{
	return gHouseData[houseid][E_HOUSE_OWNED];
}

/* *************************************************************************** *
*  Assignment: Set if the house is owned
*
*  Params:
*			houseid: ID of the house.
* 			value: 1 for owned, 0 for non-owned
*
*  Returns:
*			Nothing
* *************************************************************************** */
stock SetHouseOwned(houseid, value)
{
	if(value != 1) value = 0;
	gHouseData[houseid][E_HOUSE_OWNED] = value;

	new query[58];
	mysql_format(mysql, query, sizeof(query), "UPDATE `houses` SET `Owned`=%d WHERE `ID`=%d", \
	gHouseData[houseid][E_HOUSE_OWNED], gHouseData[houseid][E_HOUSE_DATABASEID]);
	mysql_tquery(mysql, query);
}

/* *************************************************************************** *
*  Assignment: Get if the house is locked
*
*  Params:
*			houseid: ID of the house.
*
*  Returns:
*			1 if it is locked
* 			0 if not
* *************************************************************************** */
stock IsHouseLocked(houseid)
{
	return gHouseData[houseid][E_HOUSE_LOCKED];
}

/* *************************************************************************** *
*  Assignment: Set the house lock
*
*  Params:
*			houseid: ID of the house.
*
*  Returns:
*			Nothing
* *************************************************************************** */
stock SetHouseLocked(houseid, value)
{
	if(value != 1) value = 0;
	gHouseData[houseid][E_HOUSE_LOCKED] = value;

	new query[58];
	mysql_format(mysql, query, sizeof(query), "UPDATE `houses` SET `Locked`=%d WHERE `ID`=%d", \
	gHouseData[houseid][E_HOUSE_LOCKED], gHouseData[houseid][E_HOUSE_DATABASEID]);
	mysql_tquery(mysql, query);
}

/* *************************************************************************** *
*  Assignment: Get the house price
*
*  Params:
*			houseid: ID of the house.
*
*  Returns:
*			The house price
* *************************************************************************** */
stock GetHousePrice(houseid)
{
	return gHouseData[houseid][E_HOUSE_PRICE];
}

/* *************************************************************************** *
*  Assignment: Set the house price
*
*  Params:
*			houseid: ID of the house.
*
*  Returns:
*			Nothing
* *************************************************************************** */
stock SetHousePrice(houseid, value)
{
	if(value < 0) value = 0;
	gHouseData[houseid][E_HOUSE_PRICE] = value;

	new query[58];
	mysql_format(mysql, query, sizeof(query), "UPDATE `houses` SET `Price`=%d WHERE `ID`=%d", \
	gHouseData[houseid][E_HOUSE_PRICE], gHouseData[houseid][E_HOUSE_DATABASEID]);
	mysql_tquery(mysql, query);
}

/* *************************************************************************** *
*  Assignment: Set the house bed ammount
*
*  Params:
*			houseid: ID of the house.
*
*  Returns:
*			Nothing
* *************************************************************************** */
stock SetHouseBeds(houseid, value)
{
	if(value < 1) value = 1;
	gHouseData[houseid][E_HOUSE_BEDS] = value;

	new query[58];
	mysql_format(mysql, query, sizeof(query), "UPDATE `houses` SET `Beds`=%d WHERE `ID`=%d", \
	gHouseData[houseid][E_HOUSE_BEDS], gHouseData[houseid][E_HOUSE_DATABASEID]);
	mysql_tquery(mysql, query);
}

/* *************************************************************************** *
*  Assignment: Set the house rooms ammount
*
*  Params:
*			houseid: ID of the house.
*
*  Returns:
*			Nothing
* *************************************************************************** */
stock SetHouseRooms(houseid, value)
{
	if(value < 1) value = 1;
	gHouseData[houseid][E_HOUSE_ROOMS] = value;

	new query[58];
	mysql_format(mysql, query, sizeof(query), "UPDATE `houses` SET `Rooms`=%d WHERE `ID`=%d", \
	gHouseData[houseid][E_HOUSE_ROOMS], gHouseData[houseid][E_HOUSE_DATABASEID]);
	mysql_tquery(mysql, query);
}

/* *************************************************************************** *
*  Assignment: Set the house garages ammount
*
*  Params:
*			houseid: ID of the house.
*
*  Returns:
*			Nothing
* *************************************************************************** */
stock SetHouseGarages(houseid, value)
{
	if(value < 1) value = 1;
	gHouseData[houseid][E_HOUSE_GARAGE] = value;

	new query[58];
	mysql_format(mysql, query, sizeof(query), "UPDATE `houses` SET `Garages`=%d WHERE `ID`=%d", \
	gHouseData[houseid][E_HOUSE_GARAGE], gHouseData[houseid][E_HOUSE_DATABASEID]);
	mysql_tquery(mysql, query);
}

/* *************************************************************************** *
*  Assignment: Get if the house is rentable
*
*  Params:
*			houseid: ID of the house.
*
*  Returns:
*			1 if house is rentable
* 			0 if not
* *************************************************************************** */
stock IsHouseRentable(houseid)
{
	return gHouseData[houseid][E_HOUSE_RENTABLE];
}

/* *************************************************************************** *
*  Assignment: Set if the house is rentable
*
*  Params:
*			houseid: ID of the house.
*
*  Returns:
*			Nothing
* *************************************************************************** */
stock SetHouseRentable(houseid, value)
{
	if(value != 1) value = 0;
	gHouseData[houseid][E_HOUSE_RENTABLE] = value;

	new query[58];
	mysql_format(mysql, query, sizeof(query), "UPDATE `houses` SET `Rentable`=%d WHERE `ID`=%d", \
	gHouseData[houseid][E_HOUSE_RENTABLE], gHouseData[houseid][E_HOUSE_DATABASEID]);
	mysql_tquery(mysql, query);
}

/* *************************************************************************** *
*  Assignment: Sets and save house owner name
*
*  Params:
*			houseid: ID of the house.
*
*  Returns:
*			Nothing
* *************************************************************************** */
stock SetHouseOwnerName(houseid, name[])
{
	format(gHouseData[houseid][E_HOUSE_OWNER], MAX_PLAYER_NAME, "%s", name);

	new query[50 + MAX_PLAYER_NAME];
	mysql_format(mysql, query, sizeof(query), "UPDATE `houses` SET `Owner`='%s' WHERE `ID`=%d", \
	gHouseData[houseid][E_HOUSE_OWNER], gHouseData[houseid][E_HOUSE_DATABASEID]);
	mysql_tquery(mysql, query);
}

/* *************************************************************************** *
*  Assignment: Sets and save house description
*
*  Params:
*			houseid: ID of the house.
*
*  Returns:
*			Nothing
* *************************************************************************** */
stock SetHouseDescription(houseid, name[])
{
	format(gHouseData[houseid][E_HOUSE_DESCR], MAX_HOUSE_NAME, "%s", name);

	new query[50 + MAX_HOUSE_NAME];
	mysql_format(mysql, query, sizeof(query), "UPDATE `houses` SET `Description`='%s' WHERE `ID`=%d", \
	gHouseData[houseid][E_HOUSE_DESCR], gHouseData[houseid][E_HOUSE_DATABASEID]);
	mysql_tquery(mysql, query);
}

/* *************************************************************************** *
*  Assignment: Get the house owner
*
*  Params:
*			houseid: ID of the house.
*
*  Returns:
*			The house owner
* *************************************************************************** */
stock GetHouseOwner(houseid)
{
	new ownerName[MAX_PLAYER_NAME];
	format(ownerName, sizeof(ownerName), "%s", gHouseData[houseid][E_HOUSE_OWNER]);
	return ownerName;
}

/* *************************************************************************** *
*  Assignment: Get the house description
*
*  Params:
*			houseid: ID of the house.
*
*  Returns:
*			The house description
* *************************************************************************** */
stock GetHouseDescription(houseid)
{
	new houseName[MAX_HOUSE_NAME];
	format(houseName, sizeof(houseName), "%s", gHouseData[houseid][E_HOUSE_DESCR]);
	return houseName;
}

stock GetHouseDatabaseID(houseid)
	return gHouseData[houseid][E_HOUSE_DATABASEID];

/* *************************************************************************** *
*  Assignment: Get the house rent cost
*
*  Params:
*			houseid: ID of the house.
*
*  Returns:
*			The house rent cost
* *************************************************************************** */
stock GetHouseRentCost(houseid)
{
	return gHouseData[houseid][E_HOUSE_RENTCOST];
}

/* *************************************************************************** *
*  Assignment: Set the house rent cost
*
*  Params:
*			houseid: ID of the house.
*
*  Returns:
*			Nothing
* *************************************************************************** */
stock SetHouseRentCost(houseid, value)
{
	if(value < 0) value = 0;
	gHouseData[houseid][E_HOUSE_RENTCOST] = value;

	new query[58];
	mysql_format(mysql, query, sizeof(query), "UPDATE `houses` SET `RentCost`=%d WHERE `ID`=%d", \
	gHouseData[houseid][E_HOUSE_RENTCOST], gHouseData[houseid][E_HOUSE_DATABASEID]);
	mysql_tquery(mysql, query);
}

/* *************************************************************************** *
*  Assignment: Updates the house 3d text
*
*  Params:
*			houseid: ID of the house.
*
*  Returns:
*			Nothing
* *************************************************************************** */
stock UpdateHouseText3D(houseid)
{
	if(!IsValidDynamic3DTextLabel(gHouseData[houseid][E_HOUSE_TEXT3D])) return 1;

	if(IsHouseOwned(houseid))
	{
		if(!IsHouseRentable(houseid))
		{
			new
				sHouse3DText[256];
			format(sHouse3DText, sizeof(sHouse3DText), "{FFFFFF}Descrição: {a80000}%s\n{FFFFFF}Proprietario: {a80000}%s", gHouseData[houseid][E_HOUSE_DESCR], gHouseData[houseid][E_HOUSE_OWNER]);
			UpdateDynamic3DTextLabelText(gHouseData[houseid][E_HOUSE_TEXT3D], 0xffef00ff, sHouse3DText);
		}

		else
		{
			new
				sHouse3DText[256];
			format(sHouse3DText, sizeof(sHouse3DText), "{FFFFFF}Descrição: {a80000}%s\n{FFFFFF}Proprietario: {a80000}%s\n{FFFFFF}Aluguel: {a80000}$%i", gHouseData[houseid][E_HOUSE_DESCR], gHouseData[houseid][E_HOUSE_OWNER], gHouseData[houseid][E_HOUSE_RENTCOST]);
			UpdateDynamic3DTextLabelText(gHouseData[houseid][E_HOUSE_TEXT3D], 0xffef00ff, sHouse3DText);
		}
	}

	else
	{
		if(!gHouseData[houseid][E_HOUSE_PRICE])
		{
			UpdateDynamic3DTextLabelText(gHouseData[houseid][E_HOUSE_TEXT3D], 0x14c430ff, "Esta casa {FF0000}NÃO{14c430} está a venda!");
		}

		else
		{
			new
				sHouse3DText[256];
			format(sHouse3DText, sizeof(sHouse3DText), "Esta casa está a venda!\n{FFFFFF}Descrição:{14c430} %s\n{FFFFFF}Preço:{14c430} $%i", gHouseData[houseid][E_HOUSE_DESCR], gHouseData[houseid][E_HOUSE_PRICE]);
			UpdateDynamic3DTextLabelText(gHouseData[houseid][E_HOUSE_TEXT3D], 0x14c430ff, sHouse3DText);
		}
	}
	return 1;
}

/* *************************************************************************** *
*  Assignment: Updates the house pickup, 3d text and mapicon
*
*  Params:
*			houseid: ID of the house.
*
*  Returns:
*			Nothing
* *************************************************************************** */
stock UpdateHousePickup(houseid)
{
	if(IsValidDynamicPickup(gHouseData[houseid][E_HOUSE_PICKUP])) DestroyDynamicPickup(gHouseData[houseid][E_HOUSE_PICKUP]);
	if(IsValidDynamic3DTextLabel(gHouseData[houseid][E_HOUSE_TEXT3D])) DestroyDynamic3DTextLabel(gHouseData[houseid][E_HOUSE_TEXT3D]);
	if(IsValidDynamicPickup(gHouseData[houseid][E_HOUSE_PICKUP_EXIT])) DestroyDynamicPickup(gHouseData[houseid][E_HOUSE_PICKUP_EXIT]);
	if(IsValidDynamicMapIcon(gHouseData[houseid][E_HOUSE_MAPICON])) DestroyDynamicMapIcon(gHouseData[houseid][E_HOUSE_MAPICON]);

	gHouseData[houseid][E_HOUSE_MAPICON] = CreateDynamicMapIcon(gHouseData[houseid][E_HOUSE_ENTERX], gHouseData[houseid][E_HOUSE_ENTERY], gHouseData[houseid][E_HOUSE_ENTERZ], (IsHouseOwned(houseid)) ? 32 : 31, 0x0000FFFF, -1, -1, -1, MAX_HOUSE_MAPICON_RANGE);
	gHouseData[houseid][E_HOUSE_PICKUP_EXIT] = CreateDynamicPickup(1318, 1, gHouseData[houseid][E_HOUSE_EXITX], gHouseData[houseid][E_HOUSE_EXITY], gHouseData[houseid][E_HOUSE_EXITZ], houseid);

	if(IsHouseOwned(houseid))
	{
		gHouseData[houseid][E_HOUSE_PICKUP] = CreateDynamicPickup(19522, 1, gHouseData[houseid][E_HOUSE_ENTERX], gHouseData[houseid][E_HOUSE_ENTERY], gHouseData[houseid][E_HOUSE_ENTERZ], gHouseData[houseid][E_HOUSE_ENTERWORLD]);

		if(!IsHouseRentable(houseid))
		{
			new
				sHouse3DText[256];
			format(sHouse3DText, sizeof(sHouse3DText), "{FFFFFF}Descrição: {a80000}%s\n{FFFFFF}Proprietario: {a80000}%s", gHouseData[houseid][E_HOUSE_DESCR], gHouseData[houseid][E_HOUSE_OWNER]);
			gHouseData[houseid][E_HOUSE_TEXT3D] = CreateDynamic3DTextLabel(sHouse3DText, 0xffef00ff, gHouseData[houseid][E_HOUSE_ENTERX], gHouseData[houseid][E_HOUSE_ENTERY], gHouseData[houseid][E_HOUSE_ENTERZ], MAX_TEXT3D_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
		}

		else
		{
			new
				sHouse3DText[256];
			format(sHouse3DText, sizeof(sHouse3DText), "{FFFFFF}Descrição: {a80000}%s\n{FFFFFF}Proprietario: {a80000}%s\n{FFFFFF}Aluguel: {a80000}$%d", gHouseData[houseid][E_HOUSE_DESCR], gHouseData[houseid][E_HOUSE_OWNER], GetHouseRentCost(houseid));
			gHouseData[houseid][E_HOUSE_TEXT3D] = CreateDynamic3DTextLabel(sHouse3DText, 0xffef00ff, gHouseData[houseid][E_HOUSE_ENTERX], gHouseData[houseid][E_HOUSE_ENTERY], gHouseData[houseid][E_HOUSE_ENTERZ], MAX_TEXT3D_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
		}
	}

	else
	{
		gHouseData[houseid][E_HOUSE_PICKUP] = CreateDynamicPickup(1273, 1, gHouseData[houseid][E_HOUSE_ENTERX], gHouseData[houseid][E_HOUSE_ENTERY], gHouseData[houseid][E_HOUSE_ENTERZ], gHouseData[houseid][E_HOUSE_ENTERWORLD]);

		if(!GetHousePrice(houseid))
		{
			gHouseData[houseid][E_HOUSE_TEXT3D] = CreateDynamic3DTextLabel("Esta casa {FF0000}NÃO{14c430} está a venda!", 0x14c430ff, gHouseData[houseid][E_HOUSE_ENTERX], gHouseData[houseid][E_HOUSE_ENTERY], gHouseData[houseid][E_HOUSE_ENTERZ], MAX_TEXT3D_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
		}

		else
		{
			new
				sHouse3DText[256];
			format(sHouse3DText, sizeof(sHouse3DText), "Esta casa está a venda!\n{FFFFFF}Descrição:{14c430} %s\n{FFFFFF}Preço:{14c430} $%d", gHouseData[houseid][E_HOUSE_DESCR], GetHousePrice(houseid));
			gHouseData[houseid][E_HOUSE_TEXT3D] = CreateDynamic3DTextLabel(sHouse3DText, 0x14c430ff, gHouseData[houseid][E_HOUSE_ENTERX], gHouseData[houseid][E_HOUSE_ENTERY], gHouseData[houseid][E_HOUSE_ENTERZ], MAX_TEXT3D_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
		}
	}
}

/* *************************************************************************** *
*  Assignment: Load a house data.
*
*  Params:
*			houseid: ID of the house to be loaded.
*
*  Returns:
*			1 if loaded successful.
*			0 if house doesn't exist.
* *************************************************************************** */
public LoadDynamicHouse()
{
	new rows, fields;
	cache_get_data(rows, fields, mysql);
	if(rows)
	{
		for(new houseid = 0; houseid < rows; houseid++)
		{
			cache_get_field_content(houseid, "Description", gHouseData[houseid][E_HOUSE_DESCR], mysql, MAX_HOUSE_NAME);
			cache_get_field_content(houseid, "Owner", gHouseData[houseid][E_HOUSE_OWNER], mysql, MAX_PLAYER_NAME);
			cache_get_field_content(houseid, "Location", gHouseData[houseid][E_HOUSE_LOCATION], mysql, MAX_ZONE_NAME);

			gHouseData[houseid][E_HOUSE_DATABASEID]	= cache_get_field_content_int(houseid, "ID");

			gHouseData[houseid][E_HOUSE_ENTERX]		= cache_get_field_content_float(houseid, "EnterX");
			gHouseData[houseid][E_HOUSE_ENTERY]		= cache_get_field_content_float(houseid, "EnterY");
			gHouseData[houseid][E_HOUSE_ENTERZ]		= cache_get_field_content_float(houseid, "EnterZ");
			gHouseData[houseid][E_HOUSE_ENTERA]		= cache_get_field_content_float(houseid, "EnterA");

			gHouseData[houseid][E_HOUSE_EXITX]		= cache_get_field_content_float(houseid, "ExitX");
			gHouseData[houseid][E_HOUSE_EXITY]		= cache_get_field_content_float(houseid, "ExitY");
			gHouseData[houseid][E_HOUSE_EXITZ]		= cache_get_field_content_float(houseid, "ExitZ");
			gHouseData[houseid][E_HOUSE_EXITA]		= cache_get_field_content_float(houseid, "ExitA");

			gHouseData[houseid][E_HOUSE_ENTERWORLD]	= cache_get_field_content_int(houseid, "EnterWorld");
			gHouseData[houseid][E_HOUSE_ENTERINT]	= cache_get_field_content_int(houseid, "EnterInt");
			gHouseData[houseid][E_HOUSE_EXITINT]	= cache_get_field_content_int(houseid, "ExitInt");
			gHouseData[houseid][E_HOUSE_OWNED]		= cache_get_field_content_int(houseid, "Owned");
			gHouseData[houseid][E_HOUSE_LOCKED]		= cache_get_field_content_int(houseid, "Locked");
			gHouseData[houseid][E_HOUSE_PRICE]		= cache_get_field_content_int(houseid, "Price");
			gHouseData[houseid][E_HOUSE_RENTABLE]	= cache_get_field_content_int(houseid, "Rentable");
			gHouseData[houseid][E_HOUSE_RENTCOST]	= cache_get_field_content_int(houseid, "RentCost");

			gHouseData[houseid][E_HOUSE_BEDS]	= cache_get_field_content_int(houseid, "Beds");
			gHouseData[houseid][E_HOUSE_ROOMS]	= cache_get_field_content_int(houseid, "Rooms");
			gHouseData[houseid][E_HOUSE_GARAGE]	= cache_get_field_content_int(houseid, "Garages");

			if(gHouseData[houseid][E_HOUSE_ENTERX] != 0.0 && gHouseData[houseid][E_HOUSE_ENTERY] != 0.0)
			{
				UpdateHousePickup(houseid);
				Iter_Add(House, houseid);
			}
		}
		printf("Number of houses loaded: %d", rows);
	}
	else
	{
		new query[350];
		mysql_format(mysql, query, sizeof(query), "INSERT INTO `houses` (`ID`, `Description`, `Owner`, `EnterX`, `EnterY`, `EnterZ` ,`EnterA`, `ExitX`, `ExitY`, `ExitZ`, `ExitA`, `EnterWorld`, `EnterInt`, `ExitInt`, `Owned`, `Locked`, `Price`, `Rentable`, `RentCost`, `Location`) VALUES (%d, 'Nenhum', 'Ninguem', 0, 0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 'San Andreas')", cache_insert_id());
		mysql_tquery(mysql, query);
		print("Number of houses loaded: 0");
		return 0;
	}
	return 1;
}

//------------------------------------------------------------------------------

/* *************************************************************************** *
*  Assignment: Saves house entrance position.
*
*  Params:
*			houseid: ID of the house to be saved.
*
*  Returns:
*			 -
* *************************************************************************** */
stock SaveHouseEntrancePos(houseid)
{
	Get2DZoneName(gHouseData[houseid][E_HOUSE_LOCATION], gHouseData[houseid][E_HOUSE_ENTERX], gHouseData[houseid][E_HOUSE_ENTERY]);

	new query[164];
	mysql_format(mysql, query, sizeof(query), "UPDATE `houses` SET `EnterX`=%.2f, `EnterY`=%.2f, `EnterZ`=%.2f, `EnterA`=%.2f, `EnterWorld`=%d, `EnterInt`=%d, `Location`='%s' WHERE `ID`=%d", \
	gHouseData[houseid][E_HOUSE_ENTERX], gHouseData[houseid][E_HOUSE_ENTERY], gHouseData[houseid][E_HOUSE_ENTERZ], gHouseData[houseid][E_HOUSE_ENTERA], gHouseData[houseid][E_HOUSE_ENTERWORLD], gHouseData[houseid][E_HOUSE_ENTERINT], gHouseData[houseid][E_HOUSE_LOCATION], gHouseData[houseid][E_HOUSE_DATABASEID]);
	mysql_tquery(mysql, query);
	return 1;
}

/* *************************************************************************** *
*  Assignment: Saves house exit position.
*
*  Params:
*			houseid: ID of the house to be saved.
*
*  Returns:
*			 -
* *************************************************************************** */
stock SaveHouseExitPos(houseid)
{

	new query[164];
	mysql_format(mysql, query, sizeof(query), "UPDATE `houses` SET `ExitX`=%.2f, `ExitY`=%.2f, `ExitZ`=%.2f, `ExitA`=%.2f, `ExitInt`=%d WHERE `ID`=%d", \
	gHouseData[houseid][E_HOUSE_EXITX], gHouseData[houseid][E_HOUSE_EXITY], gHouseData[houseid][E_HOUSE_EXITZ], gHouseData[houseid][E_HOUSE_EXITA], gHouseData[houseid][E_HOUSE_EXITINT], gHouseData[houseid][E_HOUSE_DATABASEID]);
	mysql_tquery(mysql, query);
	return 1;
}

//------------------------------------------------------------------------------
/***
 *     ######     ###    ##       ##       ########     ###     ######  ##    ##
 *    ##    ##   ## ##   ##       ##       ##     ##   ## ##   ##    ## ##   ##
 *    ##        ##   ##  ##       ##       ##     ##  ##   ##  ##       ##  ##
 *    ##       ##     ## ##       ##       ########  ##     ## ##       #####
 *    ##       ######### ##       ##       ##     ## ######### ##       ##  ##
 *    ##    ## ##     ## ##       ##       ##     ## ##     ## ##    ## ##   ##
 *     ######  ##     ## ######## ######## ########  ##     ##  ######  ##    ##
 ***/
//------------------------------------------------------------------------------

/* *************************************************************************** *
*  Assignment: Called when the script initiates.
*
*  Params:
*			-
*
*  Returns:
*			-
* *************************************************************************** */
hook OnGameModeInit()
{
	mysql_tquery(mysql, "CREATE TABLE IF NOT EXISTS `houses` (`ID` int(11) NOT NULL AUTO_INCREMENT, `Description` VARCHAR(64), `Owner` VARCHAR(25), `EnterX` FLOAT(10), `EnterY` FLOAT(10),\
	`EnterZ` FLOAT(10), `EnterA` FLOAT(10), `ExitX` FLOAT(10), `ExitY` FLOAT(10), `ExitZ` FLOAT(10), `ExitA` FLOAT(10), `EnterWorld` INT(4), `EnterInt` INT(4), `ExitInt` INT(4), `Owned` INT(1),\
	`Locked` INT(1), `Price` INT(10), `Beds` INT(10), `Rooms` INT(10), `Garages` INT(10), `Rentable` INT(1), `RentCost` INT(10), `Location` VARCHAR(28), PRIMARY KEY (ID), KEY (ID)) ENGINE = InnoDB DEFAULT CHARSET = latin1 AUTO_INCREMENT = 1;");

	mysql_tquery(mysql, "SELECT * FROM `houses`", "LoadDynamicHouse");
	return 1;
}

hook OnPlayerPickUpDynPickup(playerid, pickupid)
{
	if(GetPVarInt(playerid, "PickupDelay") > 0)
        return 1;

	foreach(new i: House)
	{
		if(pickupid == gHouseData[i][E_HOUSE_PICKUP])
		{
			if(GetPlayerVirtualWorld(playerid) == gHouseData[i][E_HOUSE_ENTERWORLD] && GetPVarInt(playerid, "gptIsVisible") == 0)
			{
				ShowPlayerHouseTD(playerid, i);
				SetPVarInt(playerid, "gptIsVisible", 1);
				return 1;
			}
		}
		else if(pickupid == gHouseData[i][E_HOUSE_PICKUP_EXIT])
		{
			if(GetPlayerVirtualWorld(playerid) == i)
			{
				SetPlayerPos(playerid, gHouseData[i][E_HOUSE_ENTERX], gHouseData[i][E_HOUSE_ENTERY], gHouseData[i][E_HOUSE_ENTERZ]);
				SetPlayerFacingAngle(playerid, gHouseData[i][E_HOUSE_ENTERA]);
				SetPlayerInterior(playerid, gHouseData[i][E_HOUSE_ENTERINT]);
				SetPlayerVirtualWorld(playerid, gHouseData[i][E_HOUSE_ENTERWORLD]);
				SetPVarInt(playerid, "PickupDelay", PICKUP_DELAY);

				SetCameraBehindPlayer(playerid);
				return 1;
			}
		}
	}
	return 1;
}

/***
 *     ######   #######  ##     ## ##     ##    ###    ##    ## ########   ######
 *    ##    ## ##     ## ###   ### ###   ###   ## ##   ###   ## ##     ## ##    ##
 *    ##       ##     ## #### #### #### ####  ##   ##  ####  ## ##     ## ##
 *    ##       ##     ## ## ### ## ## ### ## ##     ## ## ## ## ##     ##  ######
 *    ##       ##     ## ##     ## ##     ## ######### ##  #### ##     ##       ##
 *    ##    ## ##     ## ##     ## ##     ## ##     ## ##   ### ##     ## ##    ##
 *     ######   #######  ##     ## ##     ## ##     ## ##    ## ########   ######
 ***/

/***
 *
 *     #####  #        ##   #   # ###### #####
 *     #    # #       #  #   # #  #      #    #
 *     #    # #      #    #   #   #####  #    #
 *     #####  #      ######   #   #      #####
 *     #      #      #    #   #   #      #   #
 *     #      ###### #    #   #   ###### #    #
 *
 */

//------------------------------------------------------------------------------

/* *************************************************************************** *
*  Assignment: Shows house player commands.
*
*  Params:
*			playerid: ID of the playerid.
* 			params[]: Params passed when used the command.
*
*  Returns:
*			Nothing
* *************************************************************************** */
YCMD:ajudacasa(playerid, params[], help)
{
	SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~ Comandos Casa ~~~~~~~~~~~~~~~~~~~~");
	SendClientMessage(playerid, COLOR_SUB_TITLE, "* /comprarcasa - /vendercasa - /infocasa");
	SendClientMessage(playerid, COLOR_SUB_TITLE, "* /trancarcasa - /aluguelcasa - /alugavelcasa");
	SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~ Comandos Casa ~~~~~~~~~~~~~~~~~~~~");
	return 1;
}

//------------------------------------------------------------------------------

/* *************************************************************************** *
*  Assignment: Buys a house.
*
*  Params:
*			playerid: ID of the playerid.
* 			params[]: Params passed when used the command.
*
*  Returns:
*			Nothing
* *************************************************************************** */
YCMD:comprarcasa(playerid, params[], help)
{
	if(GetPlayerHouseID(playerid) != INVALID_HOUSE_ID)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você já possui uma casa.");

	if(GetPlayerApartmentKey(playerid) != INVALID_APARTMENT_ID)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você já possui um apartamento.");

	new	index = GetPlayerClosestHouseID(playerid);

	if(index != INVALID_HOUSE_ID)
	{
		if(gHouseData[index][E_HOUSE_OWNED])
		{
			SendClientMessage(playerid, COLOR_ERROR, "* Esta casa já tem dono.");
		}

		else if(gHouseData[index][E_HOUSE_PRICE] < 1)
		{
			SendClientMessage(playerid, COLOR_ERROR, "* Esta casa não está a venda.");
		}

		else if(GetPlayerCash(playerid) < GetHousePrice(index))
		{
			SendClientMessagef(playerid, COLOR_ERROR, "* Você não possui dinheiro suficiente. [$%i]", gHouseData[index][E_HOUSE_PRICE]);
		}

		else
		{
			SendClientMessage(playerid, COLOR_SUCCESS, "* Você comprou a casa.");
			SendClientMessage(playerid, 0xffffffff, "* Agora você pode dar spawn aqui ao se contectar com {f66305}/trocarspawn{ffffff}!");
			SendClientActionMessage(playerid, 15.0, "assina os papeis e recebe a chave da casa.");
			GivePlayerCash(playerid, -gHouseData[index][E_HOUSE_PRICE]);

			new playerName[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playerName, MAX_PLAYER_NAME);

			SetPlayerHouseID(playerid, index);

			SetHouseLocked(index,	0);
			SetHouseRentable(index, 0);
			SetHouseRentCost(index, 0);
			SetHouseOwned(index,	1);
			SetHouseOwnerName(index, playerName);

			UpdateHousePickup(index);
		}
	}
	else
	{
		SendClientMessage(playerid, COLOR_ERROR, "* Você não está no í­cone de uma casa.");
	}
	return 1;
}

//------------------------------------------------------------------------------

/* *************************************************************************** *
*  Assignment: Sells a house.
*
*  Params:
*			playerid: ID of the playerid.
* 			params[]: Params passed when used the command.
*
*  Returns:
*			Nothing
* *************************************************************************** */
YCMD:vendercasa(playerid, params[], help)
{
	new
		playerName[MAX_PLAYER_NAME],
		houseid = GetPlayerHouseID(playerid);

	GetPlayerName(playerid, playerName, sizeof(playerName));
	if(GetPlayerHouseID(playerid) != INVALID_HOUSE_ID && strcmp(playerName, gHouseData[houseid][E_HOUSE_OWNER], true) == 0)
	{
		if(IsPlayerInRangeOfHouse(playerid, houseid))
		{
			SendClientMessage(playerid, COLOR_SUCCESS, "* Você vendeu sua casa.");
			SendClientActionMessage(playerid, 15, "rasga os papeis e joga a chave da casa fora.");
			GivePlayerCash(playerid, gHouseData[houseid][E_HOUSE_PRICE] / 2);

			SetPlayerHouseID(playerid, INVALID_HOUSE_ID);

			SetHouseLocked(houseid,		1);
			SetHouseRentable(houseid,	0);
			SetHouseRentCost(houseid,	0);
			SetHouseOwned(houseid,		0);
			SetHouseOwnerName(houseid,	"Ninguem");

            SetPlayerSpawnPosition(playerid, LAST_POSITION);

			UpdateHousePickup(houseid);
		}
		else
		{
			SendClientMessage(playerid, COLOR_ERROR, "* Você não está na entrada de sua casa.");
		}
	}
	else
	{
		SendClientMessage(playerid, COLOR_ERROR, "* Você não possui uma casa.");
	}
	return 1;
}

//------------------------------------------------------------------------------

/* *************************************************************************** *
*  Assignment: Shows info of the house.
*
*  Params:
*			playerid: ID of the playerid.
* 			params[]: Params passed when used the command.
*
*  Returns:
*			Nothing
* *************************************************************************** */
YCMD:infocasa(playerid, params[], help)
{
	new
		playerName[MAX_PLAYER_NAME],
		houseid = GetPlayerHouseID(playerid);
	GetPlayerName(playerid, playerName, sizeof(playerName));

	if(GetPlayerHouseID(playerid) != INVALID_HOUSE_ID && strcmp(playerName, gHouseData[houseid][E_HOUSE_OWNER], true) == 0)
	{
		if(IsPlayerInRangeOfHouse(playerid, houseid))
		{
			new
				lockedText[4],
				rentableText[4];

			switch(gHouseData[houseid][E_HOUSE_LOCKED])
			{
				case 0: lockedText = "Não";
				case 1: lockedText = "Sim";
				default: lockedText = "???";
			}

			switch(gHouseData[houseid][E_HOUSE_RENTABLE])
			{
				case 0: rentableText = "Não";
				case 1: rentableText = "Sim";
				default: rentableText = "???";
			}

			SendClientMessage(playerid, 0xFAD669FF, "~~~~~~~~~~~~~~~~~~~~ Estatísticas Casa ~~~~~~~~~~~~~~~~~~~~");
			SendClientMessagef(playerid, -1, "* Descrição: %s - Alugável: %s ($%i).", gHouseData[houseid][E_HOUSE_DESCR], rentableText, gHouseData[houseid][E_HOUSE_RENTCOST]);
			SendClientMessagef(playerid, -1, "* Trancada: %s.", lockedText);
			SendClientMessage(playerid, 0xFAD669FF, "~~~~~~~~~~~~~~~~~~~~ Estatísticas Casa ~~~~~~~~~~~~~~~~~~~~");
			SendClientActionMessage(playerid, 15, "confere as estatísticas da casa.");
		}
		else
		{
			SendClientMessage(playerid, COLOR_ERROR, "* Você não está na entrada de sua casa.");
		}
	}
	else
	{
		SendClientMessage(playerid, COLOR_ERROR, "* Você não possui uma casa.");
	}
	return 1;
}

//------------------------------------------------------------------------------

/* *************************************************************************** *
*  Assignment: Locks a house.
*
*  Params:
*			playerid: ID of the playerid.
* 			params[]: Params passed when used the command.
*
*  Returns:
*			Nothing
* *************************************************************************** */
YCMD:trancarcasa(playerid, params[], help)
{
	new
		playerName[MAX_PLAYER_NAME],
		houseid = GetPlayerHouseID(playerid);
	GetPlayerName(playerid, playerName, sizeof(playerName));
	if(GetPlayerHouseID(playerid) != INVALID_HOUSE_ID && strcmp(playerName, gHouseData[houseid][E_HOUSE_OWNER], true) == 0)
	{
		if(IsPlayerInRangeOfHouse(playerid, houseid))
		{
			switch(gHouseData[houseid][E_HOUSE_LOCKED])
			{
				case 0: {
					SendClientMessage(playerid, COLOR_SUCCESS, "* Você trancou sua casa.");
					SendClientActionMessage(playerid, 15, "gira a chave e tranca a casa.");
					SetHouseLocked(houseid, 1);
				}
				default:
				{
					SendClientMessage(playerid, COLOR_SUCCESS, "* Você destrancou sua casa.");
					SendClientActionMessage(playerid, 15, "gira a chave e destranca a casa.");
					SetHouseLocked(houseid, 0);
				}
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_ERROR, "* Você não está na entrada da sua casa.");
		}
	}
	else
	{
		SendClientMessage(playerid, COLOR_ERROR, "* Você não possui uma casa.");
	}
	return 1;
}

//------------------------------------------------------------------------------

/* *************************************************************************** *
*  Assignment: Toggle house rentable.
*
*  Params:
*			playerid: ID of the playerid.
* 			params[]: Params passed when used the command.
*
*  Returns:
*			Nothing
* *************************************************************************** */
YCMD:alugavelcasa(playerid, params[], help)
{
	new
		playerName[MAX_PLAYER_NAME],
		houseid = GetPlayerHouseID(playerid);
	GetPlayerName(playerid, playerName, sizeof(playerName));
	if(GetPlayerHouseID(playerid) != INVALID_HOUSE_ID && strcmp(playerName, gHouseData[houseid][E_HOUSE_OWNER], true) == 0)
	{
		if(IsPlayerInRangeOfHouse(playerid, houseid))
		{
			switch(gHouseData[houseid][E_HOUSE_RENTABLE])
			{
				case 0:
				{
					SendClientMessage(playerid, COLOR_SUCCESS, "* Sua casa agora está disponivel para aluguel.");
					SetHouseRentable(houseid, 1);
				}
				default:
				{
					SendClientMessage(playerid, COLOR_SUCCESS, "* Sua casa não está mais disponivel para aluguel.");
					SetHouseRentable(houseid, 0);
				}
			}
			UpdateHouseText3D(houseid);
		}
		else
		{
			SendClientMessage(playerid, COLOR_ERROR, "* Você não está na entrada da sua casa.");
		}
	}
	else
	{
		SendClientMessage(playerid, COLOR_ERROR, "* Você não possui uma casa.");
	}
	return 1;
}

//------------------------------------------------------------------------------

/* *************************************************************************** *
*  Assignment: Sets house rent price.
*
*  Params:
*			playerid: ID of the playerid.
* 			params[]: Params passed when used the command.
*
*  Returns:
*			Nothing
* *************************************************************************** */
YCMD:aluguelcasa(playerid, params[], help)
{
	new
		playerName[MAX_PLAYER_NAME],
		houseid = GetPlayerHouseID(playerid);
	GetPlayerName(playerid, playerName, sizeof(playerName));
	if(GetPlayerHouseID(playerid) != INVALID_HOUSE_ID && strcmp(playerName, gHouseData[houseid][E_HOUSE_OWNER], true) == 0)
	{
		if(IsPlayerInRangeOfHouse(playerid, houseid))
		{
			new
				price;

			if(sscanf(params, "i", price))
			{
				SendClientMessage(playerid, COLOR_INFO, "* /aluguelcasa [preço]");
			}

			else if(price < 0 || price > 9999)
			{
				SendClientMessage(playerid, COLOR_ERROR, "* Apenas valores entre $0 e $9,999.");
			}

			else if(!gHouseData[houseid][E_HOUSE_RENTABLE])
			{
				SendClientMessage(playerid, COLOR_ERROR, "* Sua casa não está disponivel para aluguel. (/alugavelcasa)");
			}

			else
			{
				SendClientMessagef(playerid, COLOR_SUCCESS, "* Você colocou o valor do aluguel da sua casa em $%i.", price);
				SetHouseRentCost(houseid, price);
				UpdateHouseText3D(houseid);
			}
		}
		else {
			SendClientMessage(playerid, COLOR_ERROR, "* Você não está na entrada da sua casa.");
		}
	}
	else {
		SendClientMessage(playerid, COLOR_ERROR, "* Você não possui uma casa.");
	}
	return 1;
}

//------------------------------------------------------------------------------

/***
 *     ######  ####### #     # ####### #       ####### ######  ####### ######
 *     #     # #       #     # #       #       #     # #     # #       #     #
 *     #     # #       #     # #       #       #     # #     # #       #     #
 *     #     # #####   #     # #####   #       #     # ######  #####   ######
 *     #     # #        #   #  #       #       #     # #       #       #   #
 *     #     # #         # #   #       #       #     # #       #       #    #
 *     ######  #######    #    ####### ####### ####### #       ####### #     #
 *
 */

//------------------------------------------------------------------------------

/* *************************************************************************** *
*  Assignment: Shows developer house commands.
*
*  Params:
*			playerid: ID of the playerid.
* 			params[]: Params passed when used the command.
*
*  Returns:
*			Nothing
* *************************************************************************** */
YCMD:ahousecmds(playerid, params[], help)
{
	if(!IsPlayerAdmin(playerid))
		SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");
	else
	{
		SendClientMessage(playerid, 0xFAD669FF, "~~~~~~~~~~~~~~~~~~~~ Comandos ~~~~~~~~~~~~~~~~~~~~");
		SendClientMessage(playerid, -1, "* /ahouseentrance - /ahouseexit - /ahouseprice - /ahouselock - /ahouseowner");
		SendClientMessage(playerid, -1, "* /ahousesell - /ahousedescription - /ahouseid - /ahousegarages - /ahousebeds - /ahouserooms");
		SendClientMessage(playerid, 0xFAD669FF, "~~~~~~~~~~~~~~~~~~~~ Comandos ~~~~~~~~~~~~~~~~~~~~");
	}
	return 1;
}

//------------------------------------------------------------------------------

/* *************************************************************************** *
*  Assignment: Shows id of the current house.
*
*  Params:
*			playerid: ID of the playerid.
* 			params[]: Params passed when used the command.
*
*  Returns:
*			Nothing
* *************************************************************************** */
YCMD:ahouseid(playerid, params[], help)
{
	if(!IsPlayerAdmin(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	foreach(new i: House)
	{
		if(IsPlayerInRangeOfHouse(playerid, i))
		{
			SendClientMessagef(playerid, COLOR_INFO, "* House ID: %i", i);
			return 1;
		}
	}
	SendClientMessage(playerid, COLOR_ERROR, "* Você não está no icone de alguma casa.");
	return 1;
}

//------------------------------------------------------------------------------

/* *************************************************************************** *
*  Assignment: Sets house entrance position.
*
*  Params:
*			playerid: ID of the playerid.
* 			params[]: Params passed when used the command.
*
*  Returns:
*			Nothing
* *************************************************************************** */
YCMD:ahouseentrance(playerid, params[], help)
{
	if(!IsPlayerAdmin(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	new
		houseid;
	if(sscanf(params, "d", houseid))
	{
		SendClientMessage(playerid, COLOR_INFO, "* /ahouseentrance [casaid]");
	}

	else if(houseid < 1 || houseid > (MAX_HOUSES - 1))
	{
		SendClientMessagef(playerid, COLOR_ERROR, "* Casa inválida. [Apenas valores entre 1 e %i]", (MAX_HOUSES - 1));
	}

	else
	{

		if(gHouseData[houseid][E_HOUSE_ENTERX] == 0.0 && gHouseData[houseid][E_HOUSE_ENTERY] == 0.0)
		{
			Iter_Add(House, houseid);
		}

		SendClientMessagef(playerid, COLOR_SUCCESS, "* Você alterou a posição da entrada da casa %i.", houseid);

		GetPlayerPos(playerid, gHouseData[houseid][E_HOUSE_ENTERX], gHouseData[houseid][E_HOUSE_ENTERY], gHouseData[houseid][E_HOUSE_ENTERZ]);
		GetPlayerFacingAngle(playerid, gHouseData[houseid][E_HOUSE_ENTERA]);
		gHouseData[houseid][E_HOUSE_ENTERINT] = GetPlayerInterior(playerid);
		gHouseData[houseid][E_HOUSE_ENTERWORLD] = GetPlayerVirtualWorld(playerid);

		SaveHouseEntrancePos(houseid);

		UpdateHousePickup(houseid);
	}
	return 1;
}

//------------------------------------------------------------------------------

/* *************************************************************************** *
*  Assignment: Sets house exit position.
*
*  Params:
*			playerid: ID of the playerid.
* 			params[]: Params passed when used the command.
*
*  Returns:
*			Nothing
* *************************************************************************** */
YCMD:ahouseexit(playerid, params[], help)
{
	if(!IsPlayerAdmin(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	new
		houseid;

	if(sscanf(params, "d", houseid))
	{
		SendClientMessage(playerid, COLOR_INFO, "* /ahouseexit [casaid]");
	}

	else if(houseid < 1 || houseid > (MAX_HOUSES - 1))
	{
		SendClientMessagef(playerid, COLOR_ERROR, "* Casa inválida. [Apenas valores entre 1 e %i]", (MAX_HOUSES - 1));
	}

	else
	{
		SendClientMessagef(playerid, COLOR_SUCCESS, "* Você alterou a posição de saí­da da casa %i.", houseid);

		GetPlayerPos(playerid, gHouseData[houseid][E_HOUSE_EXITX], gHouseData[houseid][E_HOUSE_EXITY], gHouseData[houseid][E_HOUSE_EXITZ]);
		GetPlayerFacingAngle(playerid, gHouseData[houseid][E_HOUSE_EXITA]);
		gHouseData[houseid][E_HOUSE_EXITINT] = GetPlayerInterior(playerid);

		SaveHouseExitPos(houseid);
	}
	return 1;
}

//------------------------------------------------------------------------------

/* *************************************************************************** *
*  Assignment: Sets house price.
*
*  Params:
*			playerid: ID of the playerid.
* 			params[]: Params passed when used the command.
*
*  Returns:
*			Nothing
* *************************************************************************** */
YCMD:ahouseprice(playerid, params[], help)
{
	if(!IsPlayerAdmin(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	new
		houseid,
		price;

	if(sscanf(params, "ii", houseid, price))
	{
		SendClientMessage(playerid, COLOR_INFO, "* /ahouseprice [casaid] [preço]");
	}

	else if(houseid < 1 || houseid > (MAX_HOUSES - 1))
	{
		SendClientMessagef(playerid, COLOR_ERROR, "* Casa inválida. [Apenas valores entre 1 e %i]", (MAX_HOUSES - 1));
	}

	else if(price < 0)
	{
		SendClientMessage(playerid, COLOR_ERROR, "* Use apenas valores positivos");
	}

	else
	{
		SendClientMessagef(playerid, COLOR_SUCCESS, "* Você alterou o preço da casa %i para $%i.", houseid, price);
		SetHousePrice(houseid, price);
		UpdateHouseText3D(houseid);
	}
	return 1;
}

/* *************************************************************************** *
*  Assignment: Sets house beds.
*
*  Params:
*			playerid: ID of the playerid.
* 			params[]: Params passed when used the command.
*
*  Returns:
*			Nothing
* *************************************************************************** */
YCMD:ahousebeds(playerid, params[], help)
{
	if(!IsPlayerAdmin(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	new
		houseid,
		value;

	if(sscanf(params, "ii", houseid, value))
	{
		SendClientMessage(playerid, COLOR_INFO, "* /ahousebeds [casaid] [quantia]");
	}

	else if(houseid < 1 || houseid > (MAX_HOUSES - 1))
	{
		SendClientMessagef(playerid, COLOR_ERROR, "* Casa inválida. [Apenas valores entre 1 e %i]", (MAX_HOUSES - 1));
	}

	else if(value < 1)
	{
		SendClientMessage(playerid, COLOR_ERROR, "* Use apenas valores acima de 1.");
	}

	else
	{
		SendClientMessagef(playerid, COLOR_SUCCESS, "* Você alterou a qtd. de camas da casa %i para %i.", houseid, value);
		SetHouseBeds(houseid, value);
	}
	return 1;
}

/* *************************************************************************** *
*  Assignment: Sets house rooms.
*
*  Params:
*			playerid: ID of the playerid.
* 			params[]: Params passed when used the command.
*
*  Returns:
*			Nothing
* *************************************************************************** */
YCMD:ahouserooms(playerid, params[], help)
{
	if(!IsPlayerAdmin(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	new
		houseid,
		value;

	if(sscanf(params, "ii", houseid, value))
	{
		SendClientMessage(playerid, COLOR_INFO, "* /ahouserooms [casaid] [quantia]");
	}

	else if(houseid < 1 || houseid > (MAX_HOUSES - 1))
	{
		SendClientMessagef(playerid, COLOR_ERROR, "* Casa inválida. [Apenas valores entre 1 e %i]", (MAX_HOUSES - 1));
	}

	else if(value < 1)
	{
		SendClientMessage(playerid, COLOR_ERROR, "* Use apenas valores acima de 1.");
	}

	else
	{
		SendClientMessagef(playerid, COLOR_SUCCESS, "* Você alterou a qtd. de comodos da casa %i para %i.", houseid, value);
		SetHouseRooms(houseid, value);
	}
	return 1;
}

/* *************************************************************************** *
*  Assignment: Sets house garage.
*
*  Params:
*			playerid: ID of the playerid.
* 			params[]: Params passed when used the command.
*
*  Returns:
*			Nothing
* *************************************************************************** */
YCMD:ahousegarages(playerid, params[], help)
{
	if(!IsPlayerAdmin(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	new
		houseid,
		value;

	if(sscanf(params, "ii", houseid, value))
	{
		SendClientMessage(playerid, COLOR_INFO, "* /ahousegarages [casaid] [quantia]");
	}

	else if(houseid < 1 || houseid > (MAX_HOUSES - 1))
	{
		SendClientMessagef(playerid, COLOR_ERROR, "* Casa inválida. [Apenas valores entre 1 e %i]", (MAX_HOUSES - 1));
	}

	else if(value < 0)
	{
		SendClientMessage(playerid, COLOR_ERROR, "* Use apenas valores acima de 0.");
	}

	else
	{
		SendClientMessagef(playerid, COLOR_SUCCESS, "* Você alterou a qtd. de garagem da casa %i para %i.", houseid, value);
		SetHouseGarages(houseid, value);
	}
	return 1;
}

//------------------------------------------------------------------------------

/* *************************************************************************** *
*  Assignment: Toggle house locked state.
*
*  Params:
*			playerid: ID of the playerid.
* 			params[]: Params passed when used the command.
*
*  Returns:
*			Nothing
* *************************************************************************** */
YCMD:ahouselock(playerid, params[], help)
{
	if(!IsPlayerAdmin(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	new
		houseid;

	if(sscanf(params, "i", houseid))
	{
		SendClientMessage(playerid, COLOR_INFO, "* /ahouselock [casaid]");
	}

	else if(houseid < 1 || houseid > (MAX_HOUSES - 1))
	{
		SendClientMessagef(playerid, COLOR_ERROR, "* Casa inválida. [Apenas valores entre 1 e %i]", (MAX_HOUSES - 1));
	}

	else
	{
		switch(gHouseData[houseid][E_HOUSE_LOCKED])
		{
			case 0:
			{
				SendClientMessagef(playerid, COLOR_SUCCESS, "* Você trancou a casa %i.", houseid);
				SetHouseLocked(houseid, 1);
			}
			default:
			{
				SendClientMessagef(playerid, COLOR_SUCCESS, "* Você destrancou a casa %i.", houseid);
				SetHouseLocked(houseid, 0);
			}
		}
	}
	return 1;
}

//------------------------------------------------------------------------------

/* *************************************************************************** *
*  Assignment: Sets house owner name.
*
*  Params:
*			playerid: ID of the playerid.
* 			params[]: Params passed when used the command.
*
*  Returns:
*			Nothing
* *************************************************************************** */
YCMD:ahouseowner(playerid, params[], help)
{
	if(!IsPlayerAdmin(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	new
		houseid,
		owner[MAX_PLAYER_NAME];

	if(sscanf(params, "is[25]", houseid, owner))
	{
		SendClientMessage(playerid, COLOR_INFO, "* /ahouseowner [casaid] [nome]");
	}

	else if(houseid < 1 || houseid > (MAX_HOUSES - 1))
	{
		SendClientMessagef(playerid, COLOR_ERROR, "* Casa inválida. [Apenas valores entre 1 e %i]", (MAX_HOUSES - 1));
	}

	else
	{
		SendClientMessagef(playerid, COLOR_SUCCESS, "* Você alterou o nome do proprietário da casa %i para %s.", houseid, owner);
		SetHouseOwnerName(houseid, owner);
		UpdateHouseText3D(houseid);
	}
	return 1;
}

//------------------------------------------------------------------------------

/* *************************************************************************** *
*  Assignment: Sets house description.
*
*  Params:
*			playerid: ID of the playerid.
* 			params[]: Params passed when used the command.
*
*  Returns:
*			Nothing
* *************************************************************************** */
YCMD:ahousedescription(playerid, params[], help)
{
	if(!IsPlayerAdmin(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	new
		houseid,
		description[64];

	if(sscanf(params, "is[64]", houseid, description))
	{
		SendClientMessage(playerid, COLOR_INFO, "* /ahousedescription [casaid] [descrição]");
	}

	else if(houseid < 1 || houseid > (MAX_HOUSES - 1))
	{
		SendClientMessagef(playerid, COLOR_ERROR, "* Casa inválida. [Apenas valores entre 1 e %i]", (MAX_HOUSES - 1));
	}

	else
	{
		SendClientMessagef(playerid, COLOR_SUCCESS, "* Você alterou a descrição da casa %i para %s.", houseid, description);
		SetHouseDescription(houseid, description);
		UpdateHouseText3D(houseid);
	}
	return 1;
}

//------------------------------------------------------------------------------

/* *************************************************************************** *
*  Assignment: Sells a house.
*
*  Params:
*			playerid: ID of the playerid.
* 			params[]: Params passed when used the command.
*
*  Returns:
*			Nothing
* *************************************************************************** */
YCMD:ahousesell(playerid, params[], help)
{
	if(!IsPlayerAdmin(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	new
		houseid;

	if(sscanf(params, "i", houseid))
	{
		SendClientMessage(playerid, COLOR_INFO, "* /ahousesell [casaid]");
	}

	else if(houseid < 1 || houseid > (MAX_HOUSES - 1))
	{
		SendClientMessagef(playerid, COLOR_ERROR, "* Casa inválida. [Apenas valores entre 1 e %i]", (MAX_HOUSES - 1));
	}

	else
	{
		SendClientMessagef(playerid, COLOR_SUCCESS, "* Você vendeu a casa %i.", houseid);

		SetHouseLocked(houseid,		1);
		SetHouseRentable(houseid,	0);
		SetHouseRentCost(houseid,	0);
		SetHouseOwned(houseid,		0);
		SetHouseOwnerName(houseid,	"Ninguem");

		UpdateHousePickup(houseid);
	}
	return 1;
}

// Textdraws module
#include "../modules/visual/house.pwn"
