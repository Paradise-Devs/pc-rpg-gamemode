/*******************************************************************************
* FILENAME :        modules/properties/house.pwn
*
* DESCRIPTION :
*       Make houses available to players buy & sell.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

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

forward LoadDynamicHouse();

//------------------------------------------------------------------------------

IsPlayerInRangeOfHouse(playerid, houseid, Float:range = 3.0) {
	return (IsPlayerInRangeOfPoint(playerid, range, gHouseData[houseid][E_HOUSE_ENTERX], gHouseData[houseid][E_HOUSE_ENTERY], gHouseData[houseid][E_HOUSE_ENTERZ]) ? true : false);
}

GetPlayerClosestHouseID(playerid, Float:range = 3.0)
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

GetClosestHouseFromPlayer(playerid, bool:onlyforsale)
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

//------------------------------------------------------------------------------

GetHouseEntrance(houseid, &Float:x, &Float:y, &Float:z)
{
	x = gHouseData[houseid][E_HOUSE_ENTERX];
	y = gHouseData[houseid][E_HOUSE_ENTERY];
	z = gHouseData[houseid][E_HOUSE_ENTERZ];
	return 1;
}

//------------------------------------------------------------------------------

GetHouseVirtualWorld(houseid)
{
	return gHouseData[houseid][E_HOUSE_ENTERWORLD];
}

//------------------------------------------------------------------------------

GetHouseLockState(houseid)
{
	return gHouseData[houseid][E_HOUSE_LOCKED];
}

GetHouseRooms(houseid)
{
	return gHouseData[houseid][E_HOUSE_ROOMS];
}

GetHouseBeds(houseid)
{
	return gHouseData[houseid][E_HOUSE_BEDS];
}

//------------------------------------------------------------------------------

SetHouseVirtualWorld(houseid, worldid)
{
	if(worldid < 0) worldid = 0;
	gHouseData[houseid][E_HOUSE_ENTERWORLD] = worldid;

	new query[58];
	mysql_format(mysql, query, sizeof(query), "UPDATE `houses` SET `EnterWorld`=%d WHERE `ID`=%d", \
	gHouseData[houseid][E_HOUSE_ENTERWORLD], gHouseData[houseid][E_HOUSE_DATABASEID]);
	mysql_tquery(mysql, query);
}

//------------------------------------------------------------------------------

GetHouseInteriorOut(houseid)
{
	return gHouseData[houseid][E_HOUSE_ENTERINT];
}

SetHouseInteriorOut(houseid, intid)
{
	if(intid < 0) intid = 0;
	gHouseData[houseid][E_HOUSE_ENTERINT] = intid;

	new query[58];
	mysql_format(mysql, query, sizeof(query), "UPDATE `houses` SET `EnterInt`=%d WHERE `ID`=%d", \
	gHouseData[houseid][E_HOUSE_ENTERINT], gHouseData[houseid][E_HOUSE_DATABASEID]);
	mysql_tquery(mysql, query);
}

//------------------------------------------------------------------------------

GetHouseInteriorIn(houseid)
{
	return gHouseData[houseid][E_HOUSE_EXITINT];
}

SetHouseInteriorIn(houseid, intid)
{
	if(intid < 0) intid = 0;
	gHouseData[houseid][E_HOUSE_EXITINT] = intid;

	new query[58];
	mysql_format(mysql, query, sizeof(query), "UPDATE `houses` SET `ExitInt`=%d WHERE `ID`=%d", \
	gHouseData[houseid][E_HOUSE_EXITINT], gHouseData[houseid][E_HOUSE_DATABASEID]);
	mysql_tquery(mysql, query);
}

//------------------------------------------------------------------------------

IsHouseOwned(houseid)
{
	return gHouseData[houseid][E_HOUSE_OWNED];
}

SetHouseOwned(houseid, value)
{
	if(value != 1) value = 0;
	gHouseData[houseid][E_HOUSE_OWNED] = value;

	new query[58];
	mysql_format(mysql, query, sizeof(query), "UPDATE `houses` SET `Owned`=%d WHERE `ID`=%d", \
	gHouseData[houseid][E_HOUSE_OWNED], gHouseData[houseid][E_HOUSE_DATABASEID]);
	mysql_tquery(mysql, query);
}

//------------------------------------------------------------------------------

IsHouseLocked(houseid)
{
	return gHouseData[houseid][E_HOUSE_LOCKED];
}

SetHouseLocked(houseid, value)
{
	if(value != 1) value = 0;
	gHouseData[houseid][E_HOUSE_LOCKED] = value;

	new query[58];
	mysql_format(mysql, query, sizeof(query), "UPDATE `houses` SET `Locked`=%d WHERE `ID`=%d", \
	gHouseData[houseid][E_HOUSE_LOCKED], gHouseData[houseid][E_HOUSE_DATABASEID]);
	mysql_tquery(mysql, query);
}

//------------------------------------------------------------------------------

GetHousePrice(houseid)
{
	return gHouseData[houseid][E_HOUSE_PRICE];
}

SetHousePrice(houseid, value)
{
	if(value < 0) value = 0;
	gHouseData[houseid][E_HOUSE_PRICE] = value;

	new query[58];
	mysql_format(mysql, query, sizeof(query), "UPDATE `houses` SET `Price`=%d WHERE `ID`=%d", \
	gHouseData[houseid][E_HOUSE_PRICE], gHouseData[houseid][E_HOUSE_DATABASEID]);
	mysql_tquery(mysql, query);
}

//------------------------------------------------------------------------------

SetHouseBeds(houseid, value)
{
	if(value < 1) value = 1;
	gHouseData[houseid][E_HOUSE_BEDS] = value;

	new query[58];
	mysql_format(mysql, query, sizeof(query), "UPDATE `houses` SET `Beds`=%d WHERE `ID`=%d", \
	gHouseData[houseid][E_HOUSE_BEDS], gHouseData[houseid][E_HOUSE_DATABASEID]);
	mysql_tquery(mysql, query);
}

SetHouseRooms(houseid, value)
{
	if(value < 1) value = 1;
	gHouseData[houseid][E_HOUSE_ROOMS] = value;

	new query[58];
	mysql_format(mysql, query, sizeof(query), "UPDATE `houses` SET `Rooms`=%d WHERE `ID`=%d", \
	gHouseData[houseid][E_HOUSE_ROOMS], gHouseData[houseid][E_HOUSE_DATABASEID]);
	mysql_tquery(mysql, query);
}

SetHouseGarages(houseid, value)
{
	if(value < 1) value = 1;
	gHouseData[houseid][E_HOUSE_GARAGE] = value;

	new query[58];
	mysql_format(mysql, query, sizeof(query), "UPDATE `houses` SET `Garages`=%d WHERE `ID`=%d", \
	gHouseData[houseid][E_HOUSE_GARAGE], gHouseData[houseid][E_HOUSE_DATABASEID]);
	mysql_tquery(mysql, query);
}

//------------------------------------------------------------------------------

IsHouseRentable(houseid)
{
	return gHouseData[houseid][E_HOUSE_RENTABLE];
}

SetHouseRentable(houseid, value)
{
	if(value != 1) value = 0;
	gHouseData[houseid][E_HOUSE_RENTABLE] = value;

	new query[58];
	mysql_format(mysql, query, sizeof(query), "UPDATE `houses` SET `Rentable`=%d WHERE `ID`=%d", \
	gHouseData[houseid][E_HOUSE_RENTABLE], gHouseData[houseid][E_HOUSE_DATABASEID]);
	mysql_tquery(mysql, query);
}

//------------------------------------------------------------------------------

SetHouseOwnerName(houseid, name[])
{
	format(gHouseData[houseid][E_HOUSE_OWNER], MAX_PLAYER_NAME, "%s", name);

	new query[50 + MAX_PLAYER_NAME];
	mysql_format(mysql, query, sizeof(query), "UPDATE `houses` SET `Owner`='%s' WHERE `ID`=%d", \
	gHouseData[houseid][E_HOUSE_OWNER], gHouseData[houseid][E_HOUSE_DATABASEID]);
	mysql_tquery(mysql, query);
}

SetHouseDescription(houseid, name[])
{
	format(gHouseData[houseid][E_HOUSE_DESCR], MAX_HOUSE_NAME, "%s", name);

	new query[50 + MAX_HOUSE_NAME];
	mysql_format(mysql, query, sizeof(query), "UPDATE `houses` SET `Description`='%s' WHERE `ID`=%d", \
	gHouseData[houseid][E_HOUSE_DESCR], gHouseData[houseid][E_HOUSE_DATABASEID]);
	mysql_tquery(mysql, query);
}

GetHouseDescription(houseid)
{
	new houseName[MAX_HOUSE_NAME];
	format(houseName, sizeof(houseName), "%s", gHouseData[houseid][E_HOUSE_DESCR]);
	return houseName;
}

//------------------------------------------------------------------------------

GetHouseOwner(houseid)
{
	new ownerName[MAX_PLAYER_NAME];
	format(ownerName, sizeof(ownerName), "%s", gHouseData[houseid][E_HOUSE_OWNER]);
	return ownerName;
}

//------------------------------------------------------------------------------

GetHouseDatabaseID(houseid)
{
	return gHouseData[houseid][E_HOUSE_DATABASEID];
}

//------------------------------------------------------------------------------

GetHouseRentCost(houseid)
{
	return gHouseData[houseid][E_HOUSE_RENTCOST];
}

SetHouseRentCost(houseid, value)
{
	if(value < 0) value = 0;
	gHouseData[houseid][E_HOUSE_RENTCOST] = value;

	new query[58];
	mysql_format(mysql, query, sizeof(query), "UPDATE `houses` SET `RentCost`=%d WHERE `ID`=%d", \
	gHouseData[houseid][E_HOUSE_RENTCOST], gHouseData[houseid][E_HOUSE_DATABASEID]);
	mysql_tquery(mysql, query);
}

//------------------------------------------------------------------------------

UpdateHouseText3D(houseid)
{
	if(!IsValidDynamic3DTextLabel(gHouseData[houseid][E_HOUSE_TEXT3D])) return 1;

	if(IsHouseOwned(houseid))
	{
		if(!IsHouseRentable(houseid))
		{
			new
				sHouse3DText[256];
			format(sHouse3DText, sizeof(sHouse3DText), "{FFFFFF}Descrição: {a80000}%s\n{FFFFFF}Proprietário: {a80000}%s", gHouseData[houseid][E_HOUSE_DESCR], gHouseData[houseid][E_HOUSE_OWNER]);
			UpdateDynamic3DTextLabelText(gHouseData[houseid][E_HOUSE_TEXT3D], 0xffef00ff, sHouse3DText);
		}

		else
		{
			new
				sHouse3DText[256];
			format(sHouse3DText, sizeof(sHouse3DText), "{FFFFFF}Descrição: {a80000}%s\n{FFFFFF}Proprietário: {a80000}%s\n{FFFFFF}Aluguel: {a80000}$%i", gHouseData[houseid][E_HOUSE_DESCR], gHouseData[houseid][E_HOUSE_OWNER], gHouseData[houseid][E_HOUSE_RENTCOST]);
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

//------------------------------------------------------------------------------

UpdateHousePickup(houseid)
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
			format(sHouse3DText, sizeof(sHouse3DText), "{FFFFFF}Descrição: {a80000}%s\n{FFFFFF}Proprietário: {a80000}%s", gHouseData[houseid][E_HOUSE_DESCR], gHouseData[houseid][E_HOUSE_OWNER]);
			gHouseData[houseid][E_HOUSE_TEXT3D] = CreateDynamic3DTextLabel(sHouse3DText, 0xffef00ff, gHouseData[houseid][E_HOUSE_ENTERX], gHouseData[houseid][E_HOUSE_ENTERY], gHouseData[houseid][E_HOUSE_ENTERZ], MAX_TEXT3D_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
		}

		else
		{
			new
				sHouse3DText[256];
			format(sHouse3DText, sizeof(sHouse3DText), "{FFFFFF}Descrição: {a80000}%s\n{FFFFFF}Proprietário: {a80000}%s\n{FFFFFF}Aluguel: {a80000}$%d", gHouseData[houseid][E_HOUSE_DESCR], gHouseData[houseid][E_HOUSE_OWNER], GetHouseRentCost(houseid));
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

LoadDynamicHouse()
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
	}
	else
	{
		new query[350];
		mysql_format(mysql, query, sizeof(query), "INSERT INTO `houses` (`ID`, `Description`, `Owner`, `EnterX`, `EnterY`, `EnterZ` ,`EnterA`, `ExitX`, `ExitY`, `ExitZ`, `ExitA`, `EnterWorld`, `EnterInt`, `ExitInt`, `Owned`, `Locked`, `Price`, `Rentable`, `RentCost`, `Location`) VALUES (%d, 'Nenhum', 'Ninguem', 0, 0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 'San Andreas')", cache_insert_id());
		mysql_tquery(mysql, query);
		return 0;
	}
	return 1;
}

//------------------------------------------------------------------------------

SaveHouseEntrancePos(houseid)
{
	Get2DZoneName(gHouseData[houseid][E_HOUSE_LOCATION], gHouseData[houseid][E_HOUSE_ENTERX], gHouseData[houseid][E_HOUSE_ENTERY]);

	new query[164];
	mysql_format(mysql, query, sizeof(query), "UPDATE `houses` SET `EnterX`=%.2f, `EnterY`=%.2f, `EnterZ`=%.2f, `EnterA`=%.2f, `EnterWorld`=%d, `EnterInt`=%d, `Location`='%s' WHERE `ID`=%d", \
	gHouseData[houseid][E_HOUSE_ENTERX], gHouseData[houseid][E_HOUSE_ENTERY], gHouseData[houseid][E_HOUSE_ENTERZ], gHouseData[houseid][E_HOUSE_ENTERA], gHouseData[houseid][E_HOUSE_ENTERWORLD], gHouseData[houseid][E_HOUSE_ENTERINT], gHouseData[houseid][E_HOUSE_LOCATION], gHouseData[houseid][E_HOUSE_DATABASEID]);
	mysql_tquery(mysql, query);
	return 1;
}

SaveHouseExitPos(houseid)
{

	new query[164];
	mysql_format(mysql, query, sizeof(query), "UPDATE `houses` SET `ExitX`=%.2f, `ExitY`=%.2f, `ExitZ`=%.2f, `ExitA`=%.2f, `ExitInt`=%d WHERE `ID`=%d", \
	gHouseData[houseid][E_HOUSE_EXITX], gHouseData[houseid][E_HOUSE_EXITY], gHouseData[houseid][E_HOUSE_EXITZ], gHouseData[houseid][E_HOUSE_EXITA], gHouseData[houseid][E_HOUSE_EXITINT], gHouseData[houseid][E_HOUSE_DATABASEID]);
	mysql_tquery(mysql, query);
	return 1;
}

//------------------------------------------------------------------------------

OnGameModeInit()
{
	mysql_tquery(mysql, "CREATE TABLE IF NOT EXISTS `houses` (`ID` int(11) NOT NULL AUTO_INCREMENT, `Description` VARCHAR(64), `Owner` VARCHAR(25), `EnterX` FLOAT(10), `EnterY` FLOAT(10),\
	`EnterZ` FLOAT(10), `EnterA` FLOAT(10), `ExitX` FLOAT(10), `ExitY` FLOAT(10), `ExitZ` FLOAT(10), `ExitA` FLOAT(10), `EnterWorld` INT(4), `EnterInt` INT(4), `ExitInt` INT(4), `Owned` INT(1),\
	`Locked` INT(1), `Price` INT(10), `Beds` INT(10), `Rooms` INT(10), `Garages` INT(10), `Rentable` INT(1), `RentCost` INT(10), `Location` VARCHAR(28), PRIMARY KEY (ID), KEY (ID)) ENGINE = InnoDB DEFAULT CHARSET = latin1 AUTO_INCREMENT = 1;");

	mysql_tquery(mysql, "SELECT * FROM `houses`", "LoadDynamicHouse");
	return 1;
}
