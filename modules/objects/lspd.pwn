/*******************************************************************************
* FILENAME :        modules/objects/lspd.pwn
*
* DESCRIPTION :
*       Create lspd dynamic objects.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

static g_OutsideBar;
static g_OutsideGate;
static g_OutsideDoor;
static g_InsideObjects[6];

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
    // LSPD garage barrier
	g_OutsideBar = CreateDynamicObject(968, 1544.6877, -1630.83972, 13.21490, 0.00000, 90.00000, 90.00000, 0, 0, -1);

	// Fences
	CreateDynamicObject(970, 1544.75903, -1620.53809, 13.06790, 0.00000, 0.00000, 90.00000, 0, 0, -1);
	CreateDynamicObject(970, 1544.33020, -1635.26392, 13.06790, 0.00000, 0.00000, 90.00000, 0, 0, -1);

	// LSPD Garage gate
	g_OutsideGate = CreateDynamicObject(3037, 1589.67029, -1638.29895, 14.25740, 0.00000, 0.00000, 90.00000, 0, 0, -1);

	// LSPD Garage door
	CreateDynamicObject(2949, 1581.97803, -1637.88464, 16.36300, 90.00000, 0.00000, 88.52150, 0, 0, -1);// roof
	g_OutsideDoor = CreateDynamicObject(2949, 1584.1134, -1637.90173, 12.38100, 0.00000, 0.00000, 268.50000, 0, 0, -1);

	// LSPD Interior
	g_InsideObjects[0] = CreateDynamicObject(1495, 228.25, 149.73, 1002.03,   0.00, 0.00, 90.00);// Left
	g_InsideObjects[1] = CreateDynamicObject(1495, 228.23, 152.73, 1002.03,   0.00, 0.00, 270.00);// Right
	CreateDynamicObject(19273, 228.31, 152.66, 1003.48,   0.00, 0.00, 90.00); // Outside pad
	CreateDynamicObject(19273, 228.16, 149.83, 1003.48,   0.00, 0.00, 270.00);// Inside pad

	g_InsideObjects[2] = CreateDynamicObject(1495, 228.26, 159.74, 1002.03,   0.00, 0.00, 90.00); // Left
	g_InsideObjects[3] = CreateDynamicObject(1495, 228.23, 162.75, 1002.03,   0.00, 0.00, 270.00); // Right
	CreateDynamicObject(19273, 228.35, 159.78, 1003.48,   0.00, 0.00, 90.00); // In
	CreateDynamicObject(19273, 228.15, 162.68, 1003.48,   0.00, 0.00, 270.00);// Out

	g_InsideObjects[4] = CreateDynamicObject(1495, 229.99, 169.82, 1002.03,   0.00, 0.00, 000.00); // Left
	g_InsideObjects[5] = CreateDynamicObject(1495, 232.99, 169.85, 1002.03,   0.00, 0.00, 180.00); // Right
	CreateDynamicObject(19273, 230.08, 169.93, 1003.48,   0.00, 0.00, 180.00); // In
	CreateDynamicObject(19273, 232.85, 169.74, 1003.48,   0.00, 0.00, 0.00);// Out
    return 1;
}

//------------------------------------------------------------------------------

hook OnDynamicObjectMoved(objectid)
{
    if(objectid == g_InsideObjects[0])
	{
		new Float:x, Float:y, Float:z;
		GetDynamicObjectPos(g_InsideObjects[0], x, y, z);
		if(y != 149.73) MoveDynamicObject(g_InsideObjects[0], 228.25, 149.73, 1002.03, 0.5);
	}
	else if(objectid == g_InsideObjects[1])
	{
		new Float:x, Float:y, Float:z;
		GetDynamicObjectPos(g_InsideObjects[1], x, y, z);
		if(y != 152.73) MoveDynamicObject(g_InsideObjects[1], 228.23, 152.73, 1002.03, 0.5);
	}
	else if(objectid == g_InsideObjects[2])
	{
		new Float:x, Float:y, Float:z;
		GetDynamicObjectPos(g_InsideObjects[2], x, y, z);
		if(y != 159.74) MoveDynamicObject(g_InsideObjects[2], 228.25, 159.74, 1002.03, 0.5);
	}
	else if(objectid == g_InsideObjects[3])
	{
		new Float:x, Float:y, Float:z;
		GetDynamicObjectPos(g_InsideObjects[3], x, y, z);
		if(y != 162.75) MoveDynamicObject(g_InsideObjects[3], 228.23, 162.75, 1002.03, 0.5);
	}
	else if(objectid == g_InsideObjects[4])
	{
		new Float:x, Float:y, Float:z;
		GetDynamicObjectPos(g_InsideObjects[4], x, y, z);
		if(x != 229.99) MoveDynamicObject(g_InsideObjects[4], 229.99, 169.82, 1002.03, 0.5);
	}
	else if(objectid == g_InsideObjects[5])
	{
		new Float:x, Float:y, Float:z;
		GetDynamicObjectPos(g_InsideObjects[5], x, y, z);
		if(x != 232.99) MoveDynamicObject(g_InsideObjects[5], 232.99, 169.85, 1002.03, 0.5);
	}
	else if(objectid == g_OutsideBar)
	{
		new Float:rx, Float:ry, Float:rz;
		GetDynamicObjectRot(g_OutsideBar, rx, ry, rz);
		if(ry != 90.00)
			if(!IsPlayersNearLSPDBarrier())
				MoveDynamicObject(g_OutsideBar, 1544.6877, -1630.83972, 13.21490, 0.0001, 0.00000, 90.00000, 90.00000);
			else
				defer CloseLSPDBarrierGate();
	}
	else if(objectid == g_OutsideGate)
	{
		new Float:x, Float:y, Float:z;
		GetDynamicObjectPos(g_OutsideGate, x, y, z);
		if(z != 14.25740)
			if(!IsPlayersNearGarageGate())
				MoveDynamicObject(g_OutsideGate, 1589.67029, -1638.29895, 14.25740, 0.5);
			else
				defer ClosePoliceGarageGate();
	}
	else if(objectid == g_OutsideDoor)
	{
		new Float:rx, Float:ry, Float:rz;
		GetDynamicObjectPos(g_OutsideDoor, rx, ry, rz);
		if(rz != 90.00)
			if(!IsPlayersNearGarageDoor())
				MoveDynamicObject(g_OutsideDoor, 1584.1134, -1637.90173, 12.38100, 0.01, 0.00000, 0.00000, 268.50000);
			else
				defer ClosePoliceGarageDoor();
	}
}

//------------------------------------------------------------------------------

timer ClosePoliceGarageDoor[2000]()
{
	if(!GetPoliceGarageDoorState())
		return 0;

	if(IsPlayersNearGarageDoor())
	{
		defer ClosePoliceGarageDoor();
		return 0;
	}

	MoveDynamicObject(g_OutsideDoor, 1584.1134, -1637.90173, 12.38100, 0.01, 0.00000, 0.00000, 268.50000);
	return 1;
}

GetPoliceGarageDoorState()
{
	new Float:rx, Float:ry, Float:rz;
	GetDynamicObjectRot(g_OutsideDoor, rx, ry, rz);
	if(rz != 268.50)
		return 1;
	return 0;
}

OpenPoliceGarageDoor()
{
	MoveDynamicObject(g_OutsideDoor, 1584.1134 + 0.01, -1637.90173 + 0.01, 12.38100 + 0.01, 0.01, 0.00000, 0.00000, 180.50000);
}

IsPlayersNearGarageDoor()
{
	foreach(new i: Player)
	{
		if(IsPlayerInRangeOfPoint(i, 5.0, 1584.1134, -1637.90173, 12.38100) && GetFactionType(GetPlayerFactionID(i)) == FACTION_TYPE_POLICE && !IsPlayerInAnyVehicle(i))
			return true;
	}
	return false;
}

//------------------------------------------------------------------------------

timer ClosePoliceGarageGate[2000]()
{
	if(!GetPoliceGarageGateState())
		return 0;

	if(IsPlayersNearGarageGate())
	{
		defer ClosePoliceGarageGate();
		return 0;
	}

	MoveDynamicObject(g_OutsideGate, 1589.67029, -1638.29895, 14.25740, 0.5);
	return 1;
}

GetPoliceGarageGateState()
{
	new Float:x, Float:y, Float:z;
	GetDynamicObjectPos(g_OutsideGate, x, y, z);
	if(z != 14.25740)
		return 1;
	return 0;
}

OpenPoliceGarageGate()
{
	MoveDynamicObject(g_OutsideGate, 1589.67029, -1638.29895, 10.06540, 0.5);
}

IsPlayersNearGarageGate()
{
	foreach(new i: Player)
	{
		if(IsPlayerInRangeOfPoint(i, 7.5, 1589.67029, -1638.29895, 14.25740) && GetFactionType(GetPlayerFactionID(i)) == FACTION_TYPE_POLICE && IsPlayerInAnyVehicle(i))
			return true;
	}
	return false;
}

//------------------------------------------------------------------------------

timer CloseLSPDBarrierGate[2000]()
{
	if(!GetLSPDBarrierGateState())
		return 0;

	if(IsPlayersNearLSPDBarrier())
	{
		defer CloseLSPDBarrierGate();
		return 0;
	}

	MoveDynamicObject(g_OutsideBar, 1544.6877, -1630.83972, 13.21490, 0.0001, 0.00000, 90.00000, 90.00000);
	return 1;
}

GetLSPDBarrierGateState()
{
	new Float:rx, Float:ry, Float:rz;
	GetDynamicObjectRot(g_OutsideBar, rx, ry, rz);
	if(ry != 90.00)
		return 1;
	return 0;
}

OpenLSPDBarrierGate()
{
	MoveDynamicObject(g_OutsideBar, 1544.6877, -1630.83972, 13.21490 + 0.0001, 0.0001, 0.00000, 0.00000, 90.00000);
}

IsPlayersNearLSPDBarrier()
{
	foreach(new i: Player)
	{
		if(IsPlayerInRangeOfPoint(i, 7.5, 1544.71570, -1630.83972, 13.21490) && GetFactionType(GetPlayerFactionID(i)) == FACTION_TYPE_POLICE && IsPlayerInAnyVehicle(i))
			return true;
	}
	return false;
}

//------------------------------------------------------------------------------

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if((newkeys == KEY_SECONDARY_ATTACK) && IsPlayerInRangeOfPoint(playerid, 0.5, 228.6944, 152.6862, 1003.0234))
	{
		SetPlayerFacingAngle(playerid, 90.0627);
		ApplyAnimation(playerid, "HEIST9", "Use_SwipeCard", 4.1, 0, 0, 0, 0, 0);
		if(GetFactionType(GetPlayerFactionID(playerid)) == FACTION_TYPE_POLICE || GetPlayerHighestRank(playerid) > PLAYER_RANK_BACKUP)
		{
			new Float:X, Float:Y, Float:Z;
			GetPlayerPos(playerid, X, Y, Z);
			foreach(new i: Player)
			{
				if(GetPlayerDistanceFromPlayer(playerid, i) < 50.0)
					PlayerPlaySound(i, 21000, X, Y, Z);
			}
		}
		else
		{
			new Float:X, Float:Y, Float:Z;
			GetPlayerPos(playerid, X, Y, Z);
			foreach(new i: Player)
			{
				if(GetPlayerDistanceFromPlayer(playerid, i) < 50.0)
					PlayerPlaySound(i, 21001, X, Y, Z);
			}
			SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");
			return 1;
		}

		if(!IsDynamicObjectMoving(g_InsideObjects[0]) && !IsDynamicObjectMoving(g_InsideObjects[1]))
		{
			MoveDynamicObject(g_InsideObjects[0], 228.25, 148.73, 1002.03, 0.5);
			MoveDynamicObject(g_InsideObjects[1], 228.23, 153.75, 1002.03, 0.5);
		}
	}
	else if((newkeys == KEY_SECONDARY_ATTACK) && IsPlayerInRangeOfPoint(playerid, 0.5, 227.7984, 149.8394, 1003.0234))
	{
		SetPlayerFacingAngle(playerid, 267.3979);
		ApplyAnimation(playerid, "HEIST9", "Use_SwipeCard", 4.1, 0, 0, 0, 0, 0, 0);

		new Float:X, Float:Y, Float:Z;
		GetPlayerPos(playerid, X, Y, Z);
		foreach(new i: Player)
		{
			if(GetPlayerDistanceFromPlayer(playerid, i) < 50.0)
				PlayerPlaySound(i, 21000, X, Y, Z);
		}

		if(!IsDynamicObjectMoving(g_InsideObjects[0]) && !IsDynamicObjectMoving(g_InsideObjects[1]))
		{
			MoveDynamicObject(g_InsideObjects[0], 228.25, 148.73, 1002.03, 0.5);
			MoveDynamicObject(g_InsideObjects[1], 228.23, 153.75, 1002.03, 0.5);
		}
	}
	else if((newkeys == KEY_SECONDARY_ATTACK) && IsPlayerInRangeOfPoint(playerid, 0.5, 228.6939, 159.7985, 1003.0234))
	{
		SetPlayerFacingAngle(playerid, 90.0627);
		ApplyAnimation(playerid, "HEIST9", "Use_SwipeCard", 4.1, 0, 0, 0, 0, 0);
		if(GetFactionType(GetPlayerFactionID(playerid)) == FACTION_TYPE_POLICE || GetPlayerHighestRank(playerid) > PLAYER_RANK_BACKUP)
		{
			new Float:X, Float:Y, Float:Z;
			GetPlayerPos(playerid, X, Y, Z);
			foreach(new i: Player)
			{
				if(GetPlayerDistanceFromPlayer(playerid, i) < 50.0)
					PlayerPlaySound(i, 21000, X, Y, Z);
			}
		}
		else
		{
			new Float:X, Float:Y, Float:Z;
			GetPlayerPos(playerid, X, Y, Z);
			foreach(new i: Player)
			{
				if(GetPlayerDistanceFromPlayer(playerid, i) < 50.0)
					PlayerPlaySound(i, 21001, X, Y, Z);
			}
			SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");
			return 1;
		}

		if(!IsDynamicObjectMoving(g_InsideObjects[2]) && !IsDynamicObjectMoving(g_InsideObjects[3]))
		{
			MoveDynamicObject(g_InsideObjects[2], 228.25, 158.6982, 1002.03, 0.5);
			MoveDynamicObject(g_InsideObjects[3], 228.23, 163.7490, 1002.03, 0.5);
		}
	}
	else if((newkeys == KEY_SECONDARY_ATTACK) && IsPlayerInRangeOfPoint(playerid, 0.5, 227.7982, 162.6965, 1003.0234))
	{
		SetPlayerFacingAngle(playerid, 267.3979);
		ApplyAnimation(playerid, "HEIST9", "Use_SwipeCard", 4.1, 0, 0, 0, 0, 0, 0);

		new Float:X, Float:Y, Float:Z;
		GetPlayerPos(playerid, X, Y, Z);
		foreach(new i: Player)
		{
			if(GetPlayerDistanceFromPlayer(playerid, i) < 50.0)
				PlayerPlaySound(i, 21000, X, Y, Z);
		}

		if(!IsDynamicObjectMoving(g_InsideObjects[2]) && !IsDynamicObjectMoving(g_InsideObjects[3]))
		{
			MoveDynamicObject(g_InsideObjects[2], 228.25, 158.6982, 1002.03, 0.5);
			MoveDynamicObject(g_InsideObjects[3], 228.23, 163.7490, 1002.03, 0.5);
		}
	}
	else if((newkeys == KEY_SECONDARY_ATTACK) && IsPlayerInRangeOfPoint(playerid, 0.5, 230.0831, 170.0369, 1003.0234))
	{
		SetPlayerFacingAngle(playerid, 180.0);
		ApplyAnimation(playerid, "HEIST9", "Use_SwipeCard", 4.1, 0, 0, 0, 0, 0, 0);

		new Float:X, Float:Y, Float:Z;
		GetPlayerPos(playerid, X, Y, Z);
		foreach(new i: Player)
		{
			if(GetPlayerDistanceFromPlayer(playerid, i) < 50.0)
				PlayerPlaySound(i, 21000, X, Y, Z);
		}

		if(!IsDynamicObjectMoving(g_InsideObjects[4]) && !IsDynamicObjectMoving(g_InsideObjects[5]))
		{
			MoveDynamicObject(g_InsideObjects[4], 228.9555, 169.82, 1002.03, 0.5);
			MoveDynamicObject(g_InsideObjects[5], 233.9849, 169.85, 1002.03, 0.5);
		}
	}
	else if((newkeys == KEY_SECONDARY_ATTACK) && IsPlayerInRangeOfPoint(playerid, 0.5, 232.8594, 169.6253, 1003.0234))
	{
		SetPlayerFacingAngle(playerid, 0.0);
		ApplyAnimation(playerid, "HEIST9", "Use_SwipeCard", 4.1, 0, 0, 0, 0, 0, 0);
		if(GetFactionType(GetPlayerFactionID(playerid)) == FACTION_TYPE_POLICE || GetPlayerHighestRank(playerid) > PLAYER_RANK_BACKUP)
		{
			new Float:X, Float:Y, Float:Z;
			GetPlayerPos(playerid, X, Y, Z);
			foreach(new i: Player)
			{
				if(GetPlayerDistanceFromPlayer(playerid, i) < 50.0)
					PlayerPlaySound(i, 21000, X, Y, Z);
			}
		}
		else
		{
			new Float:X, Float:Y, Float:Z;
			GetPlayerPos(playerid, X, Y, Z);
			foreach(new i: Player)
			{
				if(GetPlayerDistanceFromPlayer(playerid, i) < 50.0)
					PlayerPlaySound(i, 21001, X, Y, Z);
			}
			SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");
			return 1;
		}

		if(!IsDynamicObjectMoving(g_InsideObjects[4]) && !IsDynamicObjectMoving(g_InsideObjects[5]))
		{
			MoveDynamicObject(g_InsideObjects[4], 228.9555, 169.82, 1002.03, 0.5);
			MoveDynamicObject(g_InsideObjects[5], 233.9849, 169.85, 1002.03, 0.5);
		}
	}
	return 1;
}
