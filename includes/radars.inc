//------------------------------------------------------------------------------

/*
	SA-MP Radars include

	Description:
		This include provide code to create vehicle radars in SA-MP.

	License:
		The MIT License (MIT)
		Copyright (c) 2014 Larceny
		Permission is hereby granted, free of charge, to any person obtaining a copy
		of this software and associated documentation files (the "Software"), to deal
		in the Software without restriction, including without limitation the rights
		to use, copy, modiY, merge, publish, distribute, sublicense, and/or sell
		copies of the Software, and to permit persons to whom the Software is
		furnished to do so, subject to the following conditions:
		The above copyright notice and this permission notice shall be included in all
		copies or substantial portions of the Software.
		THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
		IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
		FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
		AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
		LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
		OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
		SOFTWARE.

	Author:
		Larceny

	Contributors:
		Y_Less - ALS Hooking method
		Gamer_Z - Player speed calculation
		MP2 - Player speed calculation

	Version:
		0.6
*/

//------------------------------------------------------------------------------

#include <a_samp>

#if defined inc_radars_included
	#endinput
#endif
#define inc_radars_included

//------------------------------------------------------------------------------

/*
native CreateRadar(Float:X, Float:Y, Float:Z, Float:rX, Float:rY, Float:rZ, Float:DrawDistance = 200.0, Float:MaxSpeed = 0, Float:Radius = 15.0, bool:isActive = true);
native SetRadarPosition(radarid, Float:Y, Float:Z, Float:rX, Float:rY, Float:rZ, Float:DrawDistance = 200.0);
native GetRadarPosition(radarid, &Float:Y, &Float:Z, &Float:rX, &Float:rY, &Float:rZ);
native SetRadarActivated(radarid, bool:activated);
native SetRadarRadius(radarid, Float:radius);
native SetRadarMaxSpeed(radarid, maxspeed);
native IsPlayerInRadar(playerid, radarid)
native IsPlayerInAnyRadar(playerid)
native IsRadarActivated(radarid)
native GetRadarMaxSpeed(radarid);
native GetRadarObjectID(radarid);
native GetRadarRadius(radarid);
native IsValidRadar(radarid);
native DestroyRadar(radarid);
*/

//------------------------------------------------------------------------------

#if !defined MAX_RADARS
	#define MAX_RADARS 32
#endif

#if !defined RADAR_MODEL_ID
	#define RADAR_MODEL_ID 18880
#endif

#define INVALID_RADAR_ID -1

//------------------------------------------------------------------------------

enum E_RADAR_DATA
{
	Float:E_RADAR_POS[3],
	Float:E_RADAR_ROT[3],
	Float:E_RADAR_DRAWDIST,
	Float:E_RADAR_RADIUS,
	Float:E_RADAR_MAXSPEED,
	bool:E_RADAR_ISACTIVE,
	E_RADAR_OBJECTID
}
static g_eRadarData[MAX_RADARS][E_RADAR_DATA];

//------------------------------------------------------------------------------

forward OnPlayerEnterRadar(playerid, radarid, Float:speed);

//------------------------------------------------------------------------------

stock CreateRadar(Float:X, Float:Y, Float:Z, Float:rX, Float:rY, Float:rZ, Float:DrawDistance = 200.0, Float:MaxSpeed = 0.0, Float:Radius = 15.0, bool:isActive = true)
{
	new radarid = GetFreeRadarID();

	if(radarid == INVALID_RADAR_ID)
	{
		print("ERROR: Limit of radars exceeded! Increase the limit or reduce the created radars.");
		return 0;
	}

	g_eRadarData[radarid][E_RADAR_POS][0]		= X;
	g_eRadarData[radarid][E_RADAR_POS][1]		= Y;
	g_eRadarData[radarid][E_RADAR_POS][2]		= Z;

	g_eRadarData[radarid][E_RADAR_ROT][0]		= rX;
	g_eRadarData[radarid][E_RADAR_ROT][1]		= rY;
	g_eRadarData[radarid][E_RADAR_ROT][2]		= rZ;

	g_eRadarData[radarid][E_RADAR_DRAWDIST]		= DrawDistance;
	g_eRadarData[radarid][E_RADAR_MAXSPEED]		= MaxSpeed;

	g_eRadarData[radarid][E_RADAR_RADIUS] 		= Radius;
	g_eRadarData[radarid][E_RADAR_ISACTIVE] 	= isActive;

	g_eRadarData[radarid][E_RADAR_OBJECTID]		= CreateObject(RADAR_MODEL_ID, X, Y, Z, rX, rY, rZ, DrawDistance);

	return radarid;
}

//------------------------------------------------------------------------------

stock GetRadarObjectID(radarid)
	return g_eRadarData[radarid][E_RADAR_OBJECTID];

//------------------------------------------------------------------------------

stock IsValidRadar(radarid)
	return !(g_eRadarData[radarid][E_RADAR_POS][0] == 0.0 && g_eRadarData[radarid][E_RADAR_POS][1] == 0.0 && g_eRadarData[radarid][E_RADAR_POS][2] == 0.0);

//------------------------------------------------------------------------------

stock DestroyRadar(radarid)
{
	if(IsValidRadar(radarid))
		DestroyObject(g_eRadarData[radarid][E_RADAR_OBJECTID]);

	g_eRadarData[radarid][E_RADAR_OBJECTID] = INVALID_OBJECT_ID;

	g_eRadarData[radarid][E_RADAR_POS][0]		= 0.0;
	g_eRadarData[radarid][E_RADAR_POS][1]		= 0.0;
	g_eRadarData[radarid][E_RADAR_POS][2]		= 0.0;

	g_eRadarData[radarid][E_RADAR_ROT][0]		= 0.0;
	g_eRadarData[radarid][E_RADAR_ROT][1]		= 0.0;
	g_eRadarData[radarid][E_RADAR_ROT][2]		= 0.0;

	g_eRadarData[radarid][E_RADAR_DRAWDIST]		= 0.0;
	g_eRadarData[radarid][E_RADAR_MAXSPEED]		= 0.0;

	g_eRadarData[radarid][E_RADAR_RADIUS] 		= 0.0;
	g_eRadarData[radarid][E_RADAR_ISACTIVE]		= false;
	return 1;
}

// -----------------------------------------------------------------------------

stock SetRadarPosition(radarid, Float:X, Float:Y, Float:Z, Float:rX, Float:rY, Float:rZ, Float:DrawDistance = 200.0)
{
	g_eRadarData[radarid][E_RADAR_POS][0] = X;
	g_eRadarData[radarid][E_RADAR_POS][1] = Y;
	g_eRadarData[radarid][E_RADAR_POS][2] = Z;

	g_eRadarData[radarid][E_RADAR_ROT][0] = rX;
	g_eRadarData[radarid][E_RADAR_ROT][1] = rY;
	g_eRadarData[radarid][E_RADAR_ROT][2] = rZ;

	if(IsValidRadar(radarid))
		DestroyObject(g_eRadarData[radarid][E_RADAR_OBJECTID]);

	g_eRadarData[radarid][E_RADAR_OBJECTID] = CreateObject(RADAR_MODEL_ID, X, Y, Z, rX, rY, rZ, DrawDistance);
	return 1;
}

// -----------------------------------------------------------------------------

stock GetRadarPosition(radarid, &Float:X, &Float:Y, &Float:Z, &Float:rX, &Float:rY, &Float:rZ)
{
	X = g_eRadarData[radarid][E_RADAR_POS][0];
	Y = g_eRadarData[radarid][E_RADAR_POS][1];
	Z = g_eRadarData[radarid][E_RADAR_POS][2];

	rX = g_eRadarData[radarid][E_RADAR_ROT][0];
	rY = g_eRadarData[radarid][E_RADAR_ROT][1];
	rZ = g_eRadarData[radarid][E_RADAR_ROT][2];
	return 1;
}

// -----------------------------------------------------------------------------

stock SetRadarRadius(radarid, Float:radius)
	return g_eRadarData[radarid][E_RADAR_RADIUS] = radius;

// -----------------------------------------------------------------------------

stock Float:GetRadarRadius(radarid)
	return g_eRadarData[radarid][E_RADAR_RADIUS];

// -----------------------------------------------------------------------------

stock SetRadarMaxSpeed(radarid, Float:maxspeed)
	return g_eRadarData[radarid][E_RADAR_MAXSPEED] = maxspeed;

// -----------------------------------------------------------------------------

stock Float:GetRadarMaxSpeed(radarid)
	return g_eRadarData[radarid][E_RADAR_MAXSPEED];

// -----------------------------------------------------------------------------

stock SetRadarActivated(radarid, bool:activated)
	return g_eRadarData[radarid][E_RADAR_ISACTIVE] = activated;

// -----------------------------------------------------------------------------

stock IsRadarActivated(radarid)
	return g_eRadarData[radarid][E_RADAR_ISACTIVE];

// -----------------------------------------------------------------------------

stock GetFreeRadarID()
{
	for(new i; i < MAX_RADARS; i++)
		if(!IsValidRadar(i))
			return i;

	return INVALID_RADAR_ID;
}

// -----------------------------------------------------------------------------

stock IsPlayerInAnyRadar(playerid)
{
	for(new i; i < MAX_RADARS; i++)
	{
		if(!IsValidRadar(i) || !IsRadarActivated(i))
			continue;

		if(IsPlayerInRangeOfPoint(playerid, g_eRadarData[i][E_RADAR_RADIUS], g_eRadarData[i][E_RADAR_POS][0], g_eRadarData[i][E_RADAR_POS][1], g_eRadarData[i][E_RADAR_POS][2]))
			return 1;
	}
	return 0;
}

// -----------------------------------------------------------------------------

stock IsPlayerInRadar(playerid, radarid)
{
	if(!IsValidRadar(radarid) || !IsRadarActivated(radarid))
		return 0;

	if(IsPlayerInRangeOfPoint(playerid, g_eRadarData[radarid][E_RADAR_RADIUS], g_eRadarData[radarid][E_RADAR_POS][0], g_eRadarData[radarid][E_RADAR_POS][1], g_eRadarData[radarid][E_RADAR_POS][2]))
		return 1;
	return 0;
}

// -----------------------------------------------------------------------------

stock Float:_getPlayerSpeed(playerid)
{// Using Gamer_Z and MP2 calculations (https://github.com/grasmanek94/GPB/blob/master/Speeds/AccurateGTASpeed.inc)
	new Float:VelocityX, Float:VelocityY, Float:VelocityZ;
	if(IsPlayerInAnyVehicle(playerid))
		GetVehicleVelocity(GetPlayerVehicleID(playerid), VelocityX, VelocityY, VelocityZ);
	else
		GetPlayerVelocity(playerid, VelocityX, VelocityY, VelocityZ);

	#if !defined USE_MPH
		return (VelocityX*VelocityX+VelocityY*VelocityY+VelocityZ*VelocityZ)*(427833329/2935682);
	#else
		return (VelocityX*VelocityX+VelocityY*VelocityY+VelocityZ*VelocityZ)*(427833329/9449044);
	#endif
}

// -----------------------------------------------------------------------------

public OnPlayerUpdate(playerid)
{
	if(GetPVarInt(playerid, "radarTick") < GetTickCount())
	{
		SetPVarInt(playerid, "radarTick", GetTickCount() + 250);
		if(GetPVarInt(playerid, "enteredRadar") && !IsPlayerInAnyRadar(playerid))
		{
			DeletePVar(playerid, "enteredRadar");
		}
		else if(!GetPVarInt(playerid, "enteredRadar") && IsPlayerInAnyRadar(playerid))
		{
			for(new r; r < MAX_RADARS; r++)
			{
				if(!IsPlayerInRadar(playerid, r))
					continue;

				if(_getPlayerSpeed(playerid) < g_eRadarData[r][E_RADAR_MAXSPEED])
					continue;

				SetPVarInt(playerid, "enteredRadar", 1);
				OnPlayerEnterRadar(playerid, r, _getPlayerSpeed(playerid));
				break;
			}
		}
	}
	#if defined inc_Radar_OnPlayerUpdate
		return inc_Radar_OnPlayerUpdate(playerid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerUpdate
	#undef OnPlayerUpdate
#else
	#define _ALS_OnPlayerUpdate
#endif

#define OnPlayerUpdate inc_Radar_OnPlayerUpdate
#if defined inc_Radar_OnPlayerUpdate
	forward inc_Radar_OnPlayerUpdate(playerid);
#endif

// -----------------------------------------------------------------------------
