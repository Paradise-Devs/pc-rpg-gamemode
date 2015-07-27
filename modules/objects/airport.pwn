/*******************************************************************************
* FILENAME :        modules/objects/airport.pwn
*
* DESCRIPTION :
*       Create airport dynamic gates.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

static gGate[2];

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
    gGate[0] = CreateDynamicObject(988, 1964.34, -2189.77, 13.54, 0.0, 0.0, 180.0, 0, 0, -1);
	gGate[1] = CreateDynamicObject(988, 1958.85, -2189.77, 13.54, 0.0, 0.0, 180.0, 0, 0, -1);
    return 1;
}

//------------------------------------------------------------------------------

GetAirportGatesState()
{
	new Float:x[2], Float:y[2], Float:z[2];
	GetDynamicObjectPos(gGate[0], x[0], y[0], z[0]);
	GetDynamicObjectPos(gGate[1], x[1], y[1], z[1]);
	if(x[0] != 1964.34 || x[1] != 1958.85)
		return 1;
	return 0;
}

//------------------------------------------------------------------------------

OpenAirportGates()
{
	MoveDynamicObject(gGate[0], 1968.34, -2189.77, 13.54, 1.0);
	MoveDynamicObject(gGate[1], 1954.85, -2189.77, 13.55, 1.0);
}

//------------------------------------------------------------------------------

task AP_OnCheckNearbyPlayer[2500]()
{
    if(!GetAirportGatesState())
        foreach(new i: Player)
            if(IsPlayerInRangeOfPoint(i, 7.5, 1961.67, -2189.69, 13.54))
			         OpenAirportGates();
}

//------------------------------------------------------------------------------

hook OnDynamicObjectMoved(objectid)
{
    if(objectid == gGate[0])
	{
		new Float:x, Float:y, Float:z;
		GetDynamicObjectPos(gGate[0], x, y, z);
		if(x != 1964.34) MoveDynamicObject(gGate[0], 1964.34, -2189.77, 13.54, 0.5);
	}
	else if(objectid == gGate[1])
	{
		new Float:x, Float:y, Float:z;
		GetDynamicObjectPos(gGate[1], x, y, z);
		if(x != 1958.85) MoveDynamicObject(gGate[1], 1958.85, -2189.77, 13.54, 0.5);
	}
}
