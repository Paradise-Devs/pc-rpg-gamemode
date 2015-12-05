/* *************************************************************************** *
*  Description: Customizable apartment module file.
*
*  Assignment: A script to make apartments available to players buy and customize.
*
*           Copyright Paradise Devs 2015.  All rights reserved.
* *************************************************************************** */

#if defined _MODULE_apartment
	#endinput
#endif
#define _MODULE_apartment

// Textdraws module
#include "../modules/visual/apartment.pwn"
#include <YSI\y_hooks>

//------------------------------------------------------------------------------

#define MAX_APARTMENT_OBJECTS   80
#define MAX_APARTMENTS          25

//------------------------------------------------------------------------------

enum E_APARTMENT_DATA
{
    E_APARTMENT_DATABASE_ID,

	// Names
    E_APARTMENT_OWNER[MAX_PLAYER_NAME],
    E_APARTMENT_LOCATION[MAX_ZONE_NAME],

	// Outside position
	Float:E_APARTMENT_ENTER_X,
    Float:E_APARTMENT_ENTER_Y,
    Float:E_APARTMENT_ENTER_Z,
    Float:E_APARTMENT_ENTER_A,

	// Door position
	E_APARTMENT_DOOR_MODEL,
	Float:E_APARTMENT_DOOR_X,
    Float:E_APARTMENT_DOOR_Y,
    Float:E_APARTMENT_DOOR_Z,
    Float:E_APARTMENT_DOOR_A,

	// Bounds
	Float:E_APARTMENT_MIN_X,
	Float:E_APARTMENT_MIN_Y,
	Float:E_APARTMENT_MIN_Z,
	Float:E_APARTMENT_MAX_X,
	Float:E_APARTMENT_MAX_Y,
	Float:E_APARTMENT_MAX_Z,

	// States
	E_APARTMENT_OWNED,
	E_APARTMENT_LOCKED,

	// Values
	E_APARTMENT_PRICE,
	E_APARTMENT_OBJS,

	// Non-saved
	E_APARTMENT_PICKUP,
	E_APARTMENT_DOOR,
	Text3D:E_APARTMENT_TEXT3D
}
static gApartmentData[MAX_APARTMENTS][E_APARTMENT_DATA];

enum E_APARTMENT_OBJECTS
{
	// IDs
	E_APARTMENT_OBJECT_APARTID,
	E_APARTMENT_OBJECT_ID[MAX_APARTMENT_OBJECTS],
	E_APARTMENT_OBJECT_DBID[MAX_APARTMENT_OBJECTS],
	E_APARTMENT_OBJECT_MODEL[MAX_APARTMENT_OBJECTS],

	// Coordinates
	Float:E_APARTMENT_OBJECT_X[MAX_APARTMENT_OBJECTS],
	Float:E_APARTMENT_OBJECT_Y[MAX_APARTMENT_OBJECTS],
	Float:E_APARTMENT_OBJECT_Z[MAX_APARTMENT_OBJECTS],
	Float:E_APARTMENT_OBJECT_RX[MAX_APARTMENT_OBJECTS],
	Float:E_APARTMENT_OBJECT_RY[MAX_APARTMENT_OBJECTS],
	Float:E_APARTMENT_OBJECT_RZ[MAX_APARTMENT_OBJECTS]
}
static gApartmentObject[MAX_APARTMENTS][E_APARTMENT_OBJECTS];

enum
{
	OBJECT_TYPE_DOOR,
	OBJECT_TYPE_FURNITURE
}

static gPisEditingObject[MAX_PLAYERS];
static gPEditingObjectType[MAX_PLAYERS];

static gCreatedApartments = 0;

static gPlayerKey[MAX_PLAYERS] = { INVALID_APARTMENT_ID, ... }; // Apartment key

//------------------------------------------------------------------------------

forward OnApartmentLoad();
forward OnApartmentLoadObjects(apartmentid);
forward OnInsertApartmentOnDatabase(apartmentid);
forward OnInsertFurnitureOnDatabase(apartmentid, objindex);

//------------------------------------------------------------------------------

public OnApartmentLoad()
{
	new rows, fields;
	cache_get_data(rows, fields, mysql);
	if(rows)
	{
		for(new apartmentid = 0; apartmentid < rows; apartmentid++)
		{
			gApartmentData[apartmentid][E_APARTMENT_DATABASE_ID] = cache_get_field_content_int(apartmentid, "ID");

			cache_get_field_content(apartmentid, "Owner",		gApartmentData[apartmentid][E_APARTMENT_OWNER],		mysql,	MAX_PLAYER_NAME);
			cache_get_field_content(apartmentid, "Location",	gApartmentData[apartmentid][E_APARTMENT_LOCATION],	mysql,	MAX_ZONE_NAME);

			gApartmentData[apartmentid][E_APARTMENT_ENTER_X] = cache_get_field_content_float(apartmentid, "EnterX");
			gApartmentData[apartmentid][E_APARTMENT_ENTER_Y] = cache_get_field_content_float(apartmentid, "EnterY");
			gApartmentData[apartmentid][E_APARTMENT_ENTER_Z] = cache_get_field_content_float(apartmentid, "EnterZ");
			gApartmentData[apartmentid][E_APARTMENT_ENTER_A] = cache_get_field_content_float(apartmentid, "EnterA");

			gApartmentData[apartmentid][E_APARTMENT_DOOR_MODEL] = cache_get_field_content_int(apartmentid, "DoorModel");
			gApartmentData[apartmentid][E_APARTMENT_DOOR_X] = cache_get_field_content_float(apartmentid, "DoorX");
			gApartmentData[apartmentid][E_APARTMENT_DOOR_Y] = cache_get_field_content_float(apartmentid, "DoorY");
			gApartmentData[apartmentid][E_APARTMENT_DOOR_Z] = cache_get_field_content_float(apartmentid, "DoorZ");
			gApartmentData[apartmentid][E_APARTMENT_DOOR_A] = cache_get_field_content_float(apartmentid, "DoorA");

			gApartmentData[apartmentid][E_APARTMENT_MIN_X] = cache_get_field_content_float(apartmentid, "MinX");
			gApartmentData[apartmentid][E_APARTMENT_MIN_Y] = cache_get_field_content_float(apartmentid, "MinY");
			gApartmentData[apartmentid][E_APARTMENT_MIN_Z] = cache_get_field_content_float(apartmentid, "MinZ");
			gApartmentData[apartmentid][E_APARTMENT_MAX_X] = cache_get_field_content_float(apartmentid, "MaxX");
			gApartmentData[apartmentid][E_APARTMENT_MAX_Y] = cache_get_field_content_float(apartmentid, "MaxY");
			gApartmentData[apartmentid][E_APARTMENT_MAX_Z] = cache_get_field_content_float(apartmentid, "MaxZ");

			gApartmentData[apartmentid][E_APARTMENT_OWNED]	= cache_get_field_content_int(apartmentid, "Owned");
			gApartmentData[apartmentid][E_APARTMENT_LOCKED]	= cache_get_field_content_int(apartmentid, "Locked");
			gApartmentData[apartmentid][E_APARTMENT_PRICE]	= cache_get_field_content_int(apartmentid, "Price");
			gApartmentData[apartmentid][E_APARTMENT_OBJS]	= cache_get_field_content_int(apartmentid, "ObjsAmount");

			UpdateApartmentPickup(apartmentid);
			UpdateApartmentText3D(apartmentid);
			UpdateApartmentDoor(apartmentid);
			LoadApartmentObjects(apartmentid);
			gCreatedApartments++;
		}
        printf("Number of apartments loaded: %d", gCreatedApartments);
	}
	return 1;
}

//------------------------------------------------------------------------------

public OnApartmentLoadObjects(apartmentid)
{
	new rows, fields;
	cache_get_data(rows, fields, mysql);
	if(rows)
	{
		for (new objectid = 0; objectid < rows; objectid++)
		{
			if(objectid == MAX_APARTMENT_OBJECTS)
			{
				printf("[ERROR] gApartmentObject array exceeded limit! (OnApartmentLoadObjects)");
				return 0;
			}

			gApartmentObject[apartmentid][E_APARTMENT_OBJECT_APARTID] = apartmentid;
			gApartmentObject[apartmentid][E_APARTMENT_OBJECT_DBID][objectid]		= cache_get_field_content_int(objectid, "ID");
			gApartmentObject[apartmentid][E_APARTMENT_OBJECT_MODEL][objectid]		= cache_get_field_content_int(objectid, "Model");

			gApartmentObject[apartmentid][E_APARTMENT_OBJECT_X][objectid]	= cache_get_field_content_float(objectid, "X");
			gApartmentObject[apartmentid][E_APARTMENT_OBJECT_Y][objectid]	= cache_get_field_content_float(objectid, "Y");
			gApartmentObject[apartmentid][E_APARTMENT_OBJECT_Z][objectid]	= cache_get_field_content_float(objectid, "Z");
			gApartmentObject[apartmentid][E_APARTMENT_OBJECT_RX][objectid]	= cache_get_field_content_float(objectid, "RX");
			gApartmentObject[apartmentid][E_APARTMENT_OBJECT_RY][objectid]	= cache_get_field_content_float(objectid, "RY");
			gApartmentObject[apartmentid][E_APARTMENT_OBJECT_RZ][objectid]	= cache_get_field_content_float(objectid, "RZ");

			new
				model = gApartmentObject[apartmentid][E_APARTMENT_OBJECT_MODEL][objectid],
				Float:x = gApartmentObject[apartmentid][E_APARTMENT_OBJECT_X][objectid],
				Float:y = gApartmentObject[apartmentid][E_APARTMENT_OBJECT_Y][objectid],
				Float:z = gApartmentObject[apartmentid][E_APARTMENT_OBJECT_Z][objectid],
				Float:rx = gApartmentObject[apartmentid][E_APARTMENT_OBJECT_RX][objectid],
				Float:ry = gApartmentObject[apartmentid][E_APARTMENT_OBJECT_RY][objectid],
				Float:rz = gApartmentObject[apartmentid][E_APARTMENT_OBJECT_RZ][objectid]
			;
			gApartmentObject[apartmentid][E_APARTMENT_OBJECT_ID][objectid] = CreateDynamicObject(model, x, y, z, rx, ry, rz, 0, 0, -1, 30.0);
		}
	}
	return 1;
}

//------------------------------------------------------------------------------

public OnPlayerBuyFurnitureObject(playerid, modelid, price)
{
	SendClientMessage(playerid, 0xffffffff, "* Você comprou um {f66305}objeto{ffffff}! Use /editarmobilia.");
	SendClientMessage(playerid, 0xafafafaf, "* Posicione-o onde quer deixa-lo, ao apertar ESC ele voltará a posição inicial.");

	new apartmentid = gPlayerKey[playerid];
	new objindex = gApartmentData[apartmentid][E_APARTMENT_OBJS];
	gApartmentObject[apartmentid][E_APARTMENT_OBJECT_MODEL][objindex] = modelid;
	GetPlayerPos(playerid, gApartmentObject[apartmentid][E_APARTMENT_OBJECT_X][objindex], gApartmentObject[apartmentid][E_APARTMENT_OBJECT_Y][objindex], gApartmentObject[apartmentid][E_APARTMENT_OBJECT_Z][objindex]);
	gApartmentObject[apartmentid][E_APARTMENT_OBJECT_ID][objindex] = CreateDynamicObject(modelid, gApartmentObject[apartmentid][E_APARTMENT_OBJECT_X][objindex], gApartmentObject[apartmentid][E_APARTMENT_OBJECT_Y][objindex],	gApartmentObject[apartmentid][E_APARTMENT_OBJECT_Z][objindex], 0.0, 0.0, 0.0, 0, 0, -1, 30.0);
	gApartmentObject[apartmentid][E_APARTMENT_OBJECT_APARTID] = apartmentid;

	VSA_HidePlayerSelection(playerid);
	CancelSelectTextDraw(playerid);

	// Insert object to database
	new query[180];
	mysql_format(mysql, query, sizeof(query),
	"INSERT INTO `apartments_objects` (`ApartID`, `Model`, `X`, `Y`, `Z`, `RX`, `RY`, `RZ`) VALUES (%d, %d, %.2f, %.2f, %.2f, 0.0, 0.0, 0.0)",
	apartmentid, modelid, gApartmentObject[apartmentid][E_APARTMENT_OBJECT_X][objindex], gApartmentObject[apartmentid][E_APARTMENT_OBJECT_Y][objindex], gApartmentObject[apartmentid][E_APARTMENT_OBJECT_Z][objindex]);
	mysql_tquery(mysql, query, "OnInsertFurnitureOnDatabase", "ii", apartmentid, objindex);

	gApartmentData[apartmentid][E_APARTMENT_OBJS]++;
	mysql_format(mysql, query, sizeof(query),"UPDATE `apartments` SET `ObjsAmount`=%d WHERE `ID`=%d", gApartmentData[apartmentid][E_APARTMENT_OBJS], gApartmentData[apartmentid][E_APARTMENT_DATABASE_ID]);
	mysql_tquery(mysql, query);
	return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
    gPlayerKey[playerid] = INVALID_APARTMENT_ID;
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerEditDynObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if(gPEditingObjectType[playerid] == OBJECT_TYPE_DOOR)
	{
		new apartmentid = -1;
		for (new i = 0; i < gCreatedApartments; i++)
			if(objectid == gApartmentData[i][E_APARTMENT_DOOR])
				apartmentid = i;

		if(apartmentid == -1 || !IsValidDynamicObject(objectid))
			return 1;

		SetDynamicObjectPos(objectid,
		gApartmentData[apartmentid][E_APARTMENT_DOOR_X],
		gApartmentData[apartmentid][E_APARTMENT_DOOR_Y],
		gApartmentData[apartmentid][E_APARTMENT_DOOR_Z]);
	    SetDynamicObjectRot(objectid, 0.0, 0.0, rz);

		if(response == EDIT_RESPONSE_FINAL)
		{
			gPisEditingObject[playerid] = false;
			SetApartmentDoorPos(apartmentid,
			gApartmentData[apartmentid][E_APARTMENT_DOOR_X],
			gApartmentData[apartmentid][E_APARTMENT_DOOR_Y],
			gApartmentData[apartmentid][E_APARTMENT_DOOR_Z],
			rz);
		}

		else if(response == EDIT_RESPONSE_CANCEL)
		{
			gPisEditingObject[playerid] = false;
			SetDynamicObjectPos(objectid,
				gApartmentData[apartmentid][E_APARTMENT_DOOR_X],
				gApartmentData[apartmentid][E_APARTMENT_DOOR_Y],
				gApartmentData[apartmentid][E_APARTMENT_DOOR_Z]);
			SetDynamicObjectRot(objectid, 0.0, 0.0,
				gApartmentData[apartmentid][E_APARTMENT_DOOR_A]);
		}
	}
	else if(gPEditingObjectType[playerid] == OBJECT_TYPE_FURNITURE)
	{
		new apartmentid = -1;
		new objindex = 0;
		for (new i = 0; i < gCreatedApartments; i++)
			for (new j = 0; j < MAX_APARTMENT_OBJECTS; j++)
				if(objectid == gApartmentObject[i][E_APARTMENT_OBJECT_ID][j])
					apartmentid = i, objindex = j;

		if(apartmentid == -1 || !IsValidDynamicObject(objectid))
			return 1;

		if(response == EDIT_RESPONSE_FINAL)
		{
			gPisEditingObject[playerid] = false;

			// SyNC object to other players
			SetDynamicObjectPos(objectid, x, y, z);
		    SetDynamicObjectRot(objectid, rx, ry, rz);

			// Save object pos and update on database
			SetApartmentFurniturePos(apartmentid, objindex, x, y, z, rx, ry, rz);
		}

		else if(response == EDIT_RESPONSE_CANCEL)
		{
			gPisEditingObject[playerid] = false;

			// Return object to old position
			SetDynamicObjectPos(objectid,
				gApartmentObject[apartmentid][E_APARTMENT_OBJECT_X][objindex],
				gApartmentObject[apartmentid][E_APARTMENT_OBJECT_Y][objindex],
				gApartmentObject[apartmentid][E_APARTMENT_OBJECT_Z][objindex]);
			SetDynamicObjectRot(objectid,
				gApartmentObject[apartmentid][E_APARTMENT_OBJECT_RX][objindex],
				gApartmentObject[apartmentid][E_APARTMENT_OBJECT_RY][objindex],
				gApartmentObject[apartmentid][E_APARTMENT_OBJECT_RZ][objindex]);
		}
	}
	return 1;
}

//------------------------------------------------------------------------------

LoadApartments()
{
	mysql_tquery(mysql, "SELECT * FROM `apartments`", "OnApartmentLoad");
}

//------------------------------------------------------------------------------

LoadApartmentObjects(apartmentid)
{
	new query[128];
	mysql_format(mysql, query, sizeof(query), "SELECT * FROM `apartments_objects` WHERE `ApartID` = %d", apartmentid);
	mysql_tquery(mysql, query, "OnApartmentLoadObjects", "i", apartmentid);
}

//------------------------------------------------------------------------------

UpdateApartmentPickup(apartmentid)
{
	if(gApartmentData[apartmentid][E_APARTMENT_PICKUP] != 0)
		DestroyDynamicPickup(gApartmentData[apartmentid][E_APARTMENT_PICKUP]);

	if(gApartmentData[apartmentid][E_APARTMENT_OWNED])
		gApartmentData[apartmentid][E_APARTMENT_PICKUP] = CreateDynamicPickup(19522, 1, gApartmentData[apartmentid][E_APARTMENT_ENTER_X], gApartmentData[apartmentid][E_APARTMENT_ENTER_Y], gApartmentData[apartmentid][E_APARTMENT_ENTER_Z]);
	else
		gApartmentData[apartmentid][E_APARTMENT_PICKUP] = CreateDynamicPickup(1273, 1, gApartmentData[apartmentid][E_APARTMENT_ENTER_X], gApartmentData[apartmentid][E_APARTMENT_ENTER_Y], gApartmentData[apartmentid][E_APARTMENT_ENTER_Z]);
}
//------------------------------------------------------------------------------

UpdateApartmentText3D(apartmentid)
{
	if(gApartmentData[apartmentid][E_APARTMENT_TEXT3D] != Text3D:0)
		DestroyDynamic3DTextLabel(gApartmentData[apartmentid][E_APARTMENT_TEXT3D]);
	gApartmentData[apartmentid][E_APARTMENT_TEXT3D] = CreateDynamic3DTextLabel("PLACE HOLDER", -1, gApartmentData[apartmentid][E_APARTMENT_ENTER_X], gApartmentData[apartmentid][E_APARTMENT_ENTER_Y], gApartmentData[apartmentid][E_APARTMENT_ENTER_Z], MAX_TEXT3D_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 0, 0, -1, 10.0);

	new	sApartment3DText[128];
	if(gApartmentData[apartmentid][E_APARTMENT_OWNED])
		format(sApartment3DText, sizeof(sApartment3DText), "Descrição: {a80000}Apartamento personalizavel\n{FFFFFF}Proprietario: {a80000}%s", gApartmentData[apartmentid][E_APARTMENT_OWNER]);
	else
		format(sApartment3DText, sizeof(sApartment3DText), "Este apartamento está a venda!\n{FFFFFF}Descrição: {14c430}Apartamento personalizavel\n{FFFFFF}Preço: {14c430} $%i", gApartmentData[apartmentid][E_APARTMENT_PRICE]);
	UpdateDynamic3DTextLabelText(gApartmentData[apartmentid][E_APARTMENT_TEXT3D], 0xFFFFFFFF, sApartment3DText);
}

//------------------------------------------------------------------------------

UpdateApartmentDoor(apartmentid)
{
	if(gApartmentData[apartmentid][E_APARTMENT_DOOR_X] == 0.0 && gApartmentData[apartmentid][E_APARTMENT_DOOR_Y] == 0.0)
		return 0;

	if(gApartmentData[apartmentid][E_APARTMENT_DOOR_MODEL] == 0)
		gApartmentData[apartmentid][E_APARTMENT_DOOR_MODEL] = 1504;

	if(gApartmentData[apartmentid][E_APARTMENT_DOOR] == 0)
		gApartmentData[apartmentid][E_APARTMENT_DOOR] = CreateDynamicObject(gApartmentData[apartmentid][E_APARTMENT_DOOR_MODEL], gApartmentData[apartmentid][E_APARTMENT_DOOR_X], gApartmentData[apartmentid][E_APARTMENT_DOOR_Y], gApartmentData[apartmentid][E_APARTMENT_DOOR_Z], 0.00, 0.00, gApartmentData[apartmentid][E_APARTMENT_DOOR_A]);
	else {
		SetDynamicObjectPos(gApartmentData[apartmentid][E_APARTMENT_DOOR], gApartmentData[apartmentid][E_APARTMENT_DOOR_X], gApartmentData[apartmentid][E_APARTMENT_DOOR_Y], gApartmentData[apartmentid][E_APARTMENT_DOOR_Z]);
		SetDynamicObjectRot(gApartmentData[apartmentid][E_APARTMENT_DOOR], 0.0, 0.0, gApartmentData[apartmentid][E_APARTMENT_DOOR_A]);
	}
	return 1;
}

//------------------------------------------------------------------------------

SetApartmentEntrance(apartmentid, Float:x, Float:y, Float:z, Float:a)
{
	gApartmentData[apartmentid][E_APARTMENT_ENTER_X] = x;
	gApartmentData[apartmentid][E_APARTMENT_ENTER_Y] = y;
	gApartmentData[apartmentid][E_APARTMENT_ENTER_Z] = z;
	gApartmentData[apartmentid][E_APARTMENT_ENTER_A] = a;

	UpdateApartmentPickup(apartmentid);
	UpdateApartmentText3D(apartmentid);

	new query[128];
	mysql_format(mysql, query, sizeof(query),
	"UPDATE `apartments` SET `EnterX`=%.2f, `EnterY`=%.2f, `EnterZ`=%.2f, `EnterA`=%.2f WHERE `ID`=%d",
	gApartmentData[apartmentid][E_APARTMENT_ENTER_X], gApartmentData[apartmentid][E_APARTMENT_ENTER_Y],
	gApartmentData[apartmentid][E_APARTMENT_ENTER_Z], gApartmentData[apartmentid][E_APARTMENT_ENTER_A],
	gApartmentData[apartmentid][E_APARTMENT_DATABASE_ID]);
	mysql_tquery(mysql, query);
}

//------------------------------------------------------------------------------

GetApartmentEntrance(apartmentid, &Float:x, &Float:y, &Float:z, &Float:a)
{
	x = gApartmentData[apartmentid][E_APARTMENT_ENTER_X];
	y = gApartmentData[apartmentid][E_APARTMENT_ENTER_Y];
	z = gApartmentData[apartmentid][E_APARTMENT_ENTER_Z];
	a = gApartmentData[apartmentid][E_APARTMENT_ENTER_A];
}

//------------------------------------------------------------------------------

SetApartmentDoorPos(apartmentid, Float:x, Float:y, Float:z, Float:a)
{
	gApartmentData[apartmentid][E_APARTMENT_DOOR_X] = x;
	gApartmentData[apartmentid][E_APARTMENT_DOOR_Y] = y;
	gApartmentData[apartmentid][E_APARTMENT_DOOR_Z] = z;
	gApartmentData[apartmentid][E_APARTMENT_DOOR_A] = a;

	UpdateApartmentDoor(apartmentid);

	new query[188];
	mysql_format(mysql, query, sizeof(query),
	"UPDATE `apartments` SET `DoorModel`=%d, `DoorX`=%.2f, `DoorY`=%.2f, `DoorZ`=%.2f, `DoorA`=%.2f WHERE `ID`=%d",
	gApartmentData[apartmentid][E_APARTMENT_DOOR_MODEL],
	gApartmentData[apartmentid][E_APARTMENT_DOOR_X], gApartmentData[apartmentid][E_APARTMENT_DOOR_Y],
	gApartmentData[apartmentid][E_APARTMENT_DOOR_Z], gApartmentData[apartmentid][E_APARTMENT_DOOR_A],
	gApartmentData[apartmentid][E_APARTMENT_DATABASE_ID]);
	mysql_tquery(mysql, query);
}

//------------------------------------------------------------------------------

SetApartmentFurniturePos(apartmentid, objindex, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	gApartmentObject[apartmentid][E_APARTMENT_OBJECT_X][objindex] = x;
	gApartmentObject[apartmentid][E_APARTMENT_OBJECT_Y][objindex] = y;
	gApartmentObject[apartmentid][E_APARTMENT_OBJECT_Z][objindex] = z;

	gApartmentObject[apartmentid][E_APARTMENT_OBJECT_RX][objindex] = rx;
	gApartmentObject[apartmentid][E_APARTMENT_OBJECT_RY][objindex] = ry;
	gApartmentObject[apartmentid][E_APARTMENT_OBJECT_RZ][objindex] = rz;

	new query[130];
	mysql_format(mysql, query, sizeof(query),
	"UPDATE `apartments_objects` SET `X`=%.2f, `Y`=%.2f, `Z`=%.2f, `RX`=%.2f, `RY`=%.2f, `RZ`=%.2f WHERE `ID`=%d",
	x, y, z, rx, ry, rz, gApartmentObject[apartmentid][E_APARTMENT_OBJECT_DBID][objindex]);
	mysql_tquery(mysql, query);
}

//------------------------------------------------------------------------------

SetApartmentPrice(apartmentid, value)
{
	gApartmentData[apartmentid][E_APARTMENT_PRICE] = value;
	UpdateApartmentText3D(apartmentid);

	new query[76];
	mysql_format(mysql, query, sizeof(query),
	"UPDATE `apartments` SET `Price`=%d WHERE `ID`=%d",
	value, gApartmentData[apartmentid][E_APARTMENT_DATABASE_ID]);
	mysql_tquery(mysql, query);
}

//------------------------------------------------------------------------------

SetApartmentLockState(apartmentid, stat)
{
	gApartmentData[apartmentid][E_APARTMENT_LOCKED] = stat;

	new query[76];
	mysql_format(mysql, query, sizeof(query),
	"UPDATE `apartments` SET `Locked`=%d WHERE `ID`=%d",
	stat, gApartmentData[apartmentid][E_APARTMENT_DATABASE_ID]);
	mysql_tquery(mysql, query);
}

//------------------------------------------------------------------------------

SellApartament(apartmentid)
{
	new query[80];
	mysql_format(mysql, query, sizeof(query), "DELETE FROM `apartments_objects` WHERE `ApartID` = %d", apartmentid);
	mysql_tquery(mysql, query);

	for (new i = 0; i < gApartmentData[apartmentid][E_APARTMENT_OBJS]; i++) {
		DestroyDynamicObject(gApartmentObject[apartmentid][E_APARTMENT_OBJECT_ID][i]);
	}

	gApartmentData[apartmentid][E_APARTMENT_OWNED]	= 0;
	gApartmentData[apartmentid][E_APARTMENT_LOCKED]	= 1;
	gApartmentData[apartmentid][E_APARTMENT_OBJS]	= 0;

	UpdateApartmentPickup(apartmentid);
	UpdateApartmentText3D(apartmentid);

	mysql_format(mysql, query, sizeof(query),
	"UPDATE `apartments` SET `Owned`=0, `ObjsAmount`=0, `Locked`=1 WHERE `ID`=%d",
	gApartmentData[apartmentid][E_APARTMENT_DATABASE_ID]);
	mysql_tquery(mysql, query);
}

//------------------------------------------------------------------------------

SaveApartmentBounds(apartmentid)
{
	new query[190];
	mysql_format(mysql, query, sizeof(query), "UPDATE `apartments` SET `MinX`=%.2f, `MinY`=%.2f, `MinZ`=%.2f,`MaxX`=%.2f, `MaxY`=%.2f, `MaxZ`=%.2f WHERE `ID`=%d",
	gApartmentData[apartmentid][E_APARTMENT_MIN_X], gApartmentData[apartmentid][E_APARTMENT_MIN_Y], gApartmentData[apartmentid][E_APARTMENT_MIN_Z],
	gApartmentData[apartmentid][E_APARTMENT_MAX_X], gApartmentData[apartmentid][E_APARTMENT_MAX_Y], gApartmentData[apartmentid][E_APARTMENT_MAX_Z],
	gApartmentData[apartmentid][E_APARTMENT_DATABASE_ID]);
	mysql_tquery(mysql, query);
}

//------------------------------------------------------------------------------

GetPlayerApartmentKey(playerid) {
    return gPlayerKey[playerid];
}

//------------------------------------------------------------------------------

SetPlayerApartmentKey(playerid, key) {
    gPlayerKey[playerid] = key;
}

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
	// Create apartment table
	mysql_tquery(mysql,
	"CREATE TABLE IF NOT EXISTS `apartments` (`ID` int(11) NOT NULL AUTO_INCREMENT,\
	`Owner` VARCHAR(25), `Location` VARCHAR(32),\
	`EnterX` FLOAT(10), `EnterY` FLOAT(10), `EnterZ` FLOAT(10), `EnterA` FLOAT(10),\
	`DoorModel` INT(11),\
	`DoorX` FLOAT(10), `DoorY` FLOAT(10), `DoorZ` FLOAT(10), `DoorA` FLOAT(10),\
	`MinX` FLOAT, `MinY` FLOAT, `MinZ` FLOAT, `MaxX` FLOAT, `MaxY` FLOAT, `MaxZ` FLOAT,\
	`Owned` TINYINT(1), `Locked` TINYINT(1), `Price` INT(11), `ObjsAmount` INT(11),\
	PRIMARY KEY (ID), KEY (ID)) ENGINE = InnoDB DEFAULT CHARSET = latin1 AUTO_INCREMENT = 1;");

	// Create apartment objects table
	mysql_tquery(mysql,
	"CREATE TABLE IF NOT EXISTS `apartments_objects` (`ID` int(11) NOT NULL AUTO_INCREMENT,\
	`ApartID` INT(11), `Model` INT(11),\
	`X` FLOAT(10), `Y` FLOAT(10), `Z` FLOAT(10),\
	`RX` FLOAT(10), `RY` FLOAT(10), `RZ` FLOAT(10),\
	PRIMARY KEY (ID), KEY (ID)) ENGINE = InnoDB DEFAULT CHARSET = latin1 AUTO_INCREMENT = 1;");

	// Reset apartment data
	for (new i = 0; i < MAX_APARTMENTS; i++)
		gApartmentData[i][E_APARTMENT_DATABASE_ID] = INVALID_APARTMENT_ID;

	// Load created apartments
	LoadApartments();
	return 1;
}

//------------------------------------------------------------------------------

public OnInsertApartmentOnDatabase(apartmentid)
{
	gApartmentData[apartmentid][E_APARTMENT_DATABASE_ID] = cache_insert_id();
}

//------------------------------------------------------------------------------

public OnInsertFurnitureOnDatabase(apartmentid, objindex)
{
	gApartmentObject[apartmentid][E_APARTMENT_OBJECT_DBID][objindex] = cache_insert_id();
}

//------------------------------------------------------------------------------

YCMD:apartcmds(playerid, params[], help)
{
	if(!IsPlayerAdmin(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~ Comandos (Dev) Apartamento ~~~~~~~~~~~~~~~~~~~~");
	SendClientMessage(playerid, COLOR_SUB_TITLE, "* /apartcriar - /apartpos - /apartpreco - /aparttrancar - /apartvender - /apartporta");
	SendClientMessage(playerid, COLOR_SUB_TITLE, "* /apartid - /apartgoto - /apartbounds");
	SendClientMessage(playerid, COLOR_SUB_TITLE, "* Obs: /apartcriar cria um apartamento em sua posição atual.");
	SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~ Comandos (Dev) Apartamento ~~~~~~~~~~~~~~~~~~~~");
	return 1;
}

//------------------------------------------------------------------------------

YCMD:ajudaapartamento(playerid, params[], help)
{
	SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~ Comandos Apartamento ~~~~~~~~~~~~~~~~~~~~");
	SendClientMessage(playerid, COLOR_SUB_TITLE, "* /comprarapartamento - /venderapartamento - /porta - /trancaporta");
	SendClientMessage(playerid, COLOR_SUB_TITLE, "* /comprarmobilia - /trocarspawn - /editarmobilia");
	SendClientMessage(playerid, COLOR_TITLE, "~~~~~~~~~~~~~~~~~~~~ Comandos Apartamento ~~~~~~~~~~~~~~~~~~~~");
	return 1;
}

//------------------------------------------------------------------------------

YCMD:apartcriar(playerid, params[], help)
{
	if(!IsPlayerAdmin(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	if(gCreatedApartments == MAX_APARTMENTS)
		return SendClientMessage(playerid, COLOR_ERROR, "* O limite de apartamentos criados foi atingido.");

	new apartmentid = gCreatedApartments;
	SendClientMessagef(playerid, COLOR_SUCCESS, "* Você criou o apartamento id %d.", apartmentid);

	GetPlayerPos(playerid, gApartmentData[apartmentid][E_APARTMENT_ENTER_X], gApartmentData[apartmentid][E_APARTMENT_ENTER_Y], gApartmentData[apartmentid][E_APARTMENT_ENTER_Z]);
	GetPlayerFacingAngle(playerid, gApartmentData[apartmentid][E_APARTMENT_ENTER_A]);
	Get2DZoneName(gApartmentData[apartmentid][E_APARTMENT_LOCATION], gApartmentData[apartmentid][E_APARTMENT_ENTER_X], gApartmentData[apartmentid][E_APARTMENT_ENTER_Y]);
	gApartmentData[apartmentid][E_APARTMENT_LOCKED] = 1;
	UpdateApartmentPickup(apartmentid);
	UpdateApartmentText3D(apartmentid);
	gCreatedApartments++;

	new query[480];
	mysql_format(mysql, query, sizeof(query),
	"INSERT INTO `apartments` (`Owner`, `Location`, `EnterX`, `EnterY`, `EnterZ`, `EnterA`, `DoorModel`, `DoorX`, `DoorY`, `DoorZ`, `DoorA`, `Owned`, `Locked`, `Price`, `ObjsAmount`) VALUES ('Ninguem', '%e', %.2f, %.2f, %.2f, %.2f, 0, 0.0, 0.0, 0.0, 0.0, 0, 1, 0, 0)",
	gApartmentData[apartmentid][E_APARTMENT_LOCATION], gApartmentData[apartmentid][E_APARTMENT_ENTER_X],
	gApartmentData[apartmentid][E_APARTMENT_ENTER_Y], gApartmentData[apartmentid][E_APARTMENT_ENTER_Z],
	gApartmentData[apartmentid][E_APARTMENT_ENTER_A]);
	mysql_tquery(mysql, query, "OnInsertApartmentOnDatabase", "i", apartmentid);
	return 1;
}

//------------------------------------------------------------------------------

YCMD:apartpos(playerid, params[], help)
{
	if(!IsPlayerAdmin(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	new apartmentid;
	if(sscanf(params, "i", apartmentid))
		return SendClientMessage(playerid, COLOR_INFO, "* /apartpos [apartamento id]");

	if(apartmentid > (MAX_APARTMENTS-1) || apartmentid < 0)
		return SendClientMessage(playerid, COLOR_ERROR, "* Não existe um apartamento com este ID.");

	if(gApartmentData[apartmentid][E_APARTMENT_DATABASE_ID] == INVALID_APARTMENT_ID)
		return SendClientMessage(playerid, COLOR_ERROR, "* Não existe um apartamento com este ID criado.");

	SendClientMessagef(playerid, COLOR_SUCCESS, "* Você alterou a entrada do apartamento %i.", apartmentid);
	new Float:x, Float:y, Float:z, Float:a;
	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, a);
	SetApartmentEntrance(apartmentid, x, y, z, a);
	return 1;
}

//------------------------------------------------------------------------------

YCMD:apartpreco(playerid, params[], help)
{
	if(!IsPlayerAdmin(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	new apartmentid, value;
	if(sscanf(params, "ii", apartmentid, value))
		return SendClientMessage(playerid, COLOR_INFO, "* /apartpreco [apartamento id] [valor]");

	if(apartmentid > (MAX_APARTMENTS-1) || apartmentid < 0)
		return SendClientMessage(playerid, COLOR_ERROR, "* Não existe um apartamento com este ID.");

	if(gApartmentData[apartmentid][E_APARTMENT_DATABASE_ID] == INVALID_APARTMENT_ID)
		return SendClientMessage(playerid, COLOR_ERROR, "* Não existe um apartamento com este ID criado.");

	if(value < 0 || value > 2147483647)
		return SendClientMessage(playerid, COLOR_ERROR, "* Preço inválido.");

	SendClientMessagef(playerid, COLOR_SUCCESS, "* Você alterou o preço do apartamento %i para $%i.", apartmentid, value);
	SetApartmentPrice(apartmentid, value);
	return 1;
}

//------------------------------------------------------------------------------

YCMD:aparttrancar(playerid, params[], help)
{
	if(!IsPlayerAdmin(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	new apartmentid;
	if(sscanf(params, "i", apartmentid))
		return SendClientMessage(playerid, COLOR_INFO, "* /aparttrancar [apartamento id]");

	if(apartmentid > (MAX_APARTMENTS-1) || apartmentid < 0)
		return SendClientMessage(playerid, COLOR_ERROR, "* Não existe um apartamento com este ID.");

	if(gApartmentData[apartmentid][E_APARTMENT_DATABASE_ID] == INVALID_APARTMENT_ID)
		return SendClientMessage(playerid, COLOR_ERROR, "* Não existe um apartamento com este ID criado.");

	new islocked = gApartmentData[apartmentid][E_APARTMENT_LOCKED];
	new sLock[] = "destrancou";
	if(!islocked) sLock = "trancou";
	SendClientMessagef(playerid, COLOR_SUCCESS, "* Você %s o apartamento %i.", sLock, apartmentid);
	SetApartmentLockState(apartmentid, (islocked) ? 0 : 1);
	return 1;
}

//------------------------------------------------------------------------------

YCMD:apartvender(playerid, params[], help)
{
	if(!IsPlayerAdmin(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	new apartmentid;
	if(sscanf(params, "i", apartmentid))
		return SendClientMessage(playerid, COLOR_INFO, "* /apartvender [apartamento id]");

	if(apartmentid > (MAX_APARTMENTS-1) || apartmentid < 0)
		return SendClientMessage(playerid, COLOR_ERROR, "* Não existe um apartamento com este ID.");

	if(gApartmentData[apartmentid][E_APARTMENT_DATABASE_ID] == INVALID_APARTMENT_ID)
		return SendClientMessage(playerid, COLOR_ERROR, "* Não existe um apartamento com este ID criado.");

	if(gApartmentData[apartmentid][E_APARTMENT_OWNED] == 0)
		return SendClientMessage(playerid, COLOR_ERROR, "* Este apartamento já está a venda.");

	SendClientMessagef(playerid, COLOR_SUCCESS, "* Você vendeu o apartamento %i.", apartmentid);
	SellApartament(apartmentid);
	return 1;
}

//------------------------------------------------------------------------------

YCMD:apartporta(playerid, params[], help)
{
	if(!IsPlayerAdmin(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	new apartmentid, modelid, Float:x, Float:y, Float:z, Float:a;
	if(sscanf(params, "iiffff", apartmentid, modelid, x, y, z, a))
		return SendClientMessage(playerid, COLOR_INFO, "* /apartporta [apartamento id] [modelo] [float x] [float y] [float z] [float a]");

	if(apartmentid > (MAX_APARTMENTS-1) || apartmentid < 0)
		return SendClientMessage(playerid, COLOR_ERROR, "* Não existe um apartamento com este ID.");

	if(gApartmentData[apartmentid][E_APARTMENT_DATABASE_ID] == INVALID_APARTMENT_ID)
		return SendClientMessage(playerid, COLOR_ERROR, "* Não existe um apartamento com este ID criado.");

	SendClientMessagef(playerid, COLOR_SUCCESS, "* Você alterou a posição da porta do apartamento %i.", apartmentid);
	gApartmentData[apartmentid][E_APARTMENT_DOOR_MODEL] = modelid;
	SetApartmentDoorPos(apartmentid, x, y, z, a);
	return 1;
}

//------------------------------------------------------------------------------

YCMD:apartid(playerid, params[], help)
{
	new apartmentid = -1;
	for (new i = 0; i < gCreatedApartments; i++)
		if(IsPlayerInRangeOfPoint(playerid, 2.0, gApartmentData[i][E_APARTMENT_ENTER_X], gApartmentData[i][E_APARTMENT_ENTER_Y], gApartmentData[i][E_APARTMENT_ENTER_Z]))
			apartmentid = i;

	if(apartmentid == -1)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não está no ícone de um apartamento.");

	SendClientMessagef(playerid, 0xffffffff, "* ID do apartamento: {f66305}%i{ffffff}.", apartmentid);
	return 1;
}

//------------------------------------------------------------------------------

YCMD:apartgoto(playerid, params[], help)
{
	new apartmentid;
	if(sscanf(params, "i", apartmentid))
		return SendClientMessage(playerid, COLOR_INFO, "* /apartgoto [apartamento id]");

	if(apartmentid > (MAX_APARTMENTS-1) || apartmentid < 0)
		return SendClientMessage(playerid, COLOR_ERROR, "* Não existe um apartamento com este ID.");

	if(gApartmentData[apartmentid][E_APARTMENT_DATABASE_ID] == INVALID_APARTMENT_ID)
		return SendClientMessage(playerid, COLOR_ERROR, "* Não existe um apartamento com este ID criado.");

	SetPlayerPos(playerid, gApartmentData[apartmentid][E_APARTMENT_ENTER_X], gApartmentData[apartmentid][E_APARTMENT_ENTER_Y], gApartmentData[apartmentid][E_APARTMENT_ENTER_Z]);
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);
	return 1;
}

//------------------------------------------------------------------------------

YCMD:apartbounds(playerid, params[], help)
{
	if(!IsPlayerAdmin(playerid))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	new apartmentid;
	if(sscanf(params, "i", apartmentid))
		return SendClientMessage(playerid, COLOR_INFO, "* /apartvender [apartamento id]");

	if(apartmentid > (MAX_APARTMENTS-1) || apartmentid < 0)
		return SendClientMessage(playerid, COLOR_ERROR, "* Não existe um apartamento com este ID.");

	if(gApartmentData[apartmentid][E_APARTMENT_DATABASE_ID] == INVALID_APARTMENT_ID)
		return SendClientMessage(playerid, COLOR_ERROR, "* Não existe um apartamento com este ID criado.");

	if((gApartmentData[apartmentid][E_APARTMENT_MAX_X] == 0.0 && gApartmentData[apartmentid][E_APARTMENT_MAX_Y] == 0.0 &&
		gApartmentData[apartmentid][E_APARTMENT_MIN_X] == 0.0 && gApartmentData[apartmentid][E_APARTMENT_MIN_Y] == 0.0) ||
		(gApartmentData[apartmentid][E_APARTMENT_MAX_X] != 0.0 && gApartmentData[apartmentid][E_APARTMENT_MAX_Y] != 0.0 &&
		gApartmentData[apartmentid][E_APARTMENT_MIN_X] != 0.0 && gApartmentData[apartmentid][E_APARTMENT_MIN_Y] != 0.0))
	{
		SendClientMessagef(playerid, COLOR_SUCCESS, "* Você definiu o MinX, MinY e MinZ do apartamento %i.", apartmentid);
		SendClientMessage(playerid, 0xffffffff, "* Vá para a outra extremidade e marque novamente.");

		gApartmentData[apartmentid][E_APARTMENT_MAX_X] = 0.0;
		gApartmentData[apartmentid][E_APARTMENT_MAX_Y] = 0.0;
		gApartmentData[apartmentid][E_APARTMENT_MAX_Z] = 0.0;

		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		gApartmentData[apartmentid][E_APARTMENT_MIN_X] = x;
		gApartmentData[apartmentid][E_APARTMENT_MIN_Y] = y;
		gApartmentData[apartmentid][E_APARTMENT_MIN_Z] = z;
	}
	else if(gApartmentData[apartmentid][E_APARTMENT_MAX_X] == 0.0 && gApartmentData[apartmentid][E_APARTMENT_MAX_Y] == 0.0 &&
		gApartmentData[apartmentid][E_APARTMENT_MIN_X] != 0.0 && gApartmentData[apartmentid][E_APARTMENT_MIN_Y] != 0.0)
	{
		SendClientMessagef(playerid, COLOR_SUCCESS, "* Você definiu o MaxX, MaxY e MaxZ do apartamento %i.", apartmentid);

		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		gApartmentData[apartmentid][E_APARTMENT_MAX_X] = x;
		gApartmentData[apartmentid][E_APARTMENT_MAX_Y] = y;
		gApartmentData[apartmentid][E_APARTMENT_MAX_Z] = z;

		if(gApartmentData[apartmentid][E_APARTMENT_MIN_X] > gApartmentData[apartmentid][E_APARTMENT_MAX_X])
			swap(gApartmentData[apartmentid][E_APARTMENT_MIN_X], gApartmentData[apartmentid][E_APARTMENT_MAX_X]);
		if(gApartmentData[apartmentid][E_APARTMENT_MIN_Y] > gApartmentData[apartmentid][E_APARTMENT_MAX_Y])
			swap(gApartmentData[apartmentid][E_APARTMENT_MIN_Y], gApartmentData[apartmentid][E_APARTMENT_MAX_Y]);
		if(gApartmentData[apartmentid][E_APARTMENT_MIN_Z] > gApartmentData[apartmentid][E_APARTMENT_MAX_Z])
			swap(gApartmentData[apartmentid][E_APARTMENT_MIN_Z], gApartmentData[apartmentid][E_APARTMENT_MAX_Z]);
	}
	SaveApartmentBounds(apartmentid);
	return 1;
}

//------------------------------------------------------------------------------

YCMD:comprarapartamento(playerid, params[], help)
{
	if(GetPlayerHouseID(playerid) != INVALID_HOUSE_ID)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você já possui uma casa.");

	if(gPlayerKey[playerid] != INVALID_APARTMENT_ID)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você já possui um apartamento.");

	new apartmentid = -1;
	for (new i = 0; i < gCreatedApartments; i++)
		if(IsPlayerInRangeOfPoint(playerid, 2.0, gApartmentData[i][E_APARTMENT_ENTER_X], gApartmentData[i][E_APARTMENT_ENTER_Y], gApartmentData[i][E_APARTMENT_ENTER_Z]))
			apartmentid = i;

	if(apartmentid == -1)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não está no ícone de um apartamento.");

	if(gApartmentData[apartmentid][E_APARTMENT_OWNED])
		return SendClientMessage(playerid, COLOR_ERROR, "* Este apartamento já possui dono.");

	if(GetPlayerCash(playerid) < gApartmentData[apartmentid][E_APARTMENT_PRICE])
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não possui dinheiro suficiente.");

	SendClientMessage(playerid, 0xffffffff, "* Você comprou um {f66305}apartamento{ffffff}! (/ajudaapartamento)");
	SendClientMessage(playerid, 0xffffffff, "* Agora você pode dar spawn aqui ao se contectar com {f66305}/trocarspawn{ffffff}!");
	SendClientActionMessage(playerid, 15.0, "assina uns papeis e recebe a chave do apartamento.");

	// Data
	GivePlayerCash(playerid, -gApartmentData[apartmentid][E_APARTMENT_PRICE]);
	GetPlayerName(playerid, gApartmentData[apartmentid][E_APARTMENT_OWNER], MAX_PLAYER_NAME);
	gApartmentData[apartmentid][E_APARTMENT_OWNED] = 1;
	gPlayerKey[playerid] = apartmentid;
	UpdateApartmentText3D(apartmentid);
	UpdateApartmentPickup(apartmentid);

	// Mysql
	new query[104];
	mysql_format(mysql, query, sizeof(query),
	"UPDATE `apartments` SET `Owner`='%e', `Owned`=%d WHERE `ID`=%d",
	gApartmentData[apartmentid][E_APARTMENT_OWNER], gApartmentData[apartmentid][E_APARTMENT_OWNED], gApartmentData[apartmentid][E_APARTMENT_DATABASE_ID]);
	mysql_tquery(mysql, query);
	return 1;
}

//------------------------------------------------------------------------------

YCMD:venderapartamento(playerid, params[], help)
{
	if(gPlayerKey[playerid] == INVALID_APARTMENT_ID)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não possui um apartamento.");

	new apartmentid = gPlayerKey[playerid];
	if(!IsPlayerInRangeOfPoint(playerid, 2.0, gApartmentData[apartmentid][E_APARTMENT_ENTER_X], gApartmentData[apartmentid][E_APARTMENT_ENTER_Y], gApartmentData[apartmentid][E_APARTMENT_ENTER_Z]))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não está no ícone de seu apartamento.");

	SendClientMessage(playerid, 0xffffffff, "* Você vendeu seu {f66305}apartamento{ffffff}!");
	SendClientActionMessage(playerid, 15.0, "devolve a chave do apartamento.");

	// Data
	GivePlayerCash(playerid, (gApartmentData[apartmentid][E_APARTMENT_PRICE] / 2));
	format(gApartmentData[apartmentid][E_APARTMENT_OWNER], MAX_PLAYER_NAME, "Ninguém");
	gApartmentData[apartmentid][E_APARTMENT_OWNED] = 0;
	gApartmentData[apartmentid][E_APARTMENT_LOCKED] = 1;
	gPlayerKey[playerid] = INVALID_APARTMENT_ID;
	UpdateApartmentText3D(apartmentid);
	UpdateApartmentPickup(apartmentid);
	SetApartmentDoorPos(apartmentid,
	gApartmentData[apartmentid][E_APARTMENT_DOOR_X],
	gApartmentData[apartmentid][E_APARTMENT_DOOR_Y],
	gApartmentData[apartmentid][E_APARTMENT_DOOR_Z],
	80.0);

    SetPlayerSpawnPosition(playerid, LAST_POSITION);

	// Mysql
	new query[116];
	mysql_format(mysql, query, sizeof(query),
	"UPDATE `apartments` SET `Owner`='%e', `Owned`=%d, `Locked`=1 WHERE `ID`=%d",
	gApartmentData[apartmentid][E_APARTMENT_OWNER], gApartmentData[apartmentid][E_APARTMENT_OWNED], gApartmentData[apartmentid][E_APARTMENT_DATABASE_ID]);
	mysql_tquery(mysql, query);
	return 1;
}

//------------------------------------------------------------------------------

YCMD:porta(playerid, params[], help)
{
	if(gPisEditingObject[playerid])
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode fazer isso enquanto edita um objeto.");

	new apartmentid = -1;
	for (new i = 0; i < gCreatedApartments; i++)
		if(IsPlayerInRangeOfPoint(playerid, 2.0, gApartmentData[i][E_APARTMENT_DOOR_X], gApartmentData[i][E_APARTMENT_DOOR_Y], gApartmentData[i][E_APARTMENT_DOOR_Z]))
			apartmentid = i;

	if(apartmentid == -1)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não está na porta de algum apartamento.");

	if(gApartmentData[apartmentid][E_APARTMENT_LOCKED])
		return SendClientMessage(playerid, COLOR_ERROR, "* A porta está trancada.");

	SendClientMessage(playerid, 0xffffffff, "* Você apenas pode alterar a {f66305}rotação Z{ffffff} da porta.");
	EditDynamicObject(playerid, gApartmentData[apartmentid][E_APARTMENT_DOOR]);
	gPisEditingObject[playerid] = true;
	gPEditingObjectType[playerid] = OBJECT_TYPE_DOOR;
	return 1;
}

//------------------------------------------------------------------------------

YCMD:trancaporta(playerid, params[], help)
{
	if(gPlayerKey[playerid] == INVALID_APARTMENT_ID)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não possui um apartamento.");

	new apartmentid = gPlayerKey[playerid];
	if(!IsPlayerInRangeOfPoint(playerid, 2.5, gApartmentData[apartmentid][E_APARTMENT_DOOR_X], gApartmentData[apartmentid][E_APARTMENT_DOOR_Y], gApartmentData[apartmentid][E_APARTMENT_DOOR_Z]))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não está próximo da porta de seu apartamento.");

	if(gApartmentData[apartmentid][E_APARTMENT_LOCKED]) {
		SendClientMessage(playerid, 0xffffffff, "* Você {f66305}destrancou{ffffff} a porta.");
		SendClientActionMessage(playerid, 15.0, "destrancou a porta do apartamento.");
		SetApartmentLockState(apartmentid, 0);
	} else {
		SendClientMessage(playerid, 0xffffffff, "* Você {f66305}trancou{ffffff} a porta.");
		SendClientActionMessage(playerid, 15.0, "trancou a porta do apartamento.");
		SetApartmentLockState(apartmentid, 1);
	}
	return 1;
}

//------------------------------------------------------------------------------

YCMD:comprarmobilia(playerid, params[], help)
{
	if(gPisEditingObject[playerid])
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode fazer isso enquanto edita um objeto.");

	if(gPlayerKey[playerid] == INVALID_APARTMENT_ID)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não possui um apartamento.");

	new apartmentid = gPlayerKey[playerid];
	if(!IsPlayerInCube(playerid, gApartmentData[apartmentid][E_APARTMENT_MIN_X], gApartmentData[apartmentid][E_APARTMENT_MIN_Y], gApartmentData[apartmentid][E_APARTMENT_MIN_Z], gApartmentData[apartmentid][E_APARTMENT_MAX_X], gApartmentData[apartmentid][E_APARTMENT_MAX_Y], gApartmentData[apartmentid][E_APARTMENT_MAX_Z]))
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não está próximo dentro de seu apartamento.");

	if(gApartmentData[apartmentid][E_APARTMENT_OBJS] >= MAX_APARTMENT_OBJECTS)
		return SendClientMessage(playerid, COLOR_ERROR, "* Seu apartamento já possui o limite de objetos.");

	VSA_ShowPlayerCategory(playerid, 0);
	return 1;
}

//------------------------------------------------------------------------------

YCMD:trocarspawn(playerid, params[], help)
{
	if(gPlayerKey[playerid] == INVALID_APARTMENT_ID && GetPlayerHouseID(playerid) == INVALID_HOUSE_ID)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não possui uma moradia.");

    if(GetPlayerSpawnPosition(playerid) == LAST_POSITION)
	{
        SetPlayerSpawnPosition(playerid, HOUSE_POSITION);
		SendClientMessage(playerid, 0xffffffff, "* Agora você irá dar spawn em sua {f66305}moradia{ffffff}!");
		SendClientMessage(playerid, 0xafafafaf, "* Apenas se não estiver sendo procurado pela policia.");
	}
	else if(GetPlayerSpawnPosition(playerid) == HOUSE_POSITION)
	{
        SetPlayerSpawnPosition(playerid, LAST_POSITION);
		SendClientMessage(playerid, 0xffffffff, "* Agora você irá dar spawn {f66305}onde você deslogou{ffffff}.");
	}
	return 1;
}

//------------------------------------------------------------------------------

YCMD:editarmobilia(playerid, params[], help)
{
	if(gPisEditingObject[playerid])
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não pode fazer isso enquanto edita um objeto.");

	if(gPlayerKey[playerid] == INVALID_APARTMENT_ID)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não possui um apartamento.");

	new apartmentid = gPlayerKey[playerid];
	new objindex = -1;
	new Float:dist = 10.0;
	for (new i = 0; i < MAX_APARTMENT_OBJECTS; i++)
	{
		if(GetPlayerDistanceFromPoint(playerid, gApartmentObject[apartmentid][E_APARTMENT_OBJECT_X][i], gApartmentObject[apartmentid][E_APARTMENT_OBJECT_Y][i], gApartmentObject[apartmentid][E_APARTMENT_OBJECT_Z][i]) < dist)
		{
			objindex = i;
			dist = GetPlayerDistanceFromPoint(playerid, gApartmentObject[apartmentid][E_APARTMENT_OBJECT_X][i], gApartmentObject[apartmentid][E_APARTMENT_OBJECT_Y][i], gApartmentObject[apartmentid][E_APARTMENT_OBJECT_Z][i]);
		}
	}

	if(objindex == -1)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não está próximo de um objeto de seu apartamento.");

	gPisEditingObject[playerid] = true;
	gPEditingObjectType[playerid] = OBJECT_TYPE_FURNITURE;
	EditDynamicObject(playerid, gApartmentObject[apartmentid][E_APARTMENT_OBJECT_ID][objindex]);
	return 1;
}
