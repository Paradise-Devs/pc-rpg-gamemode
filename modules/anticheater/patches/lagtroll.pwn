/*******************************************************************************
* FILENAME :        modules/anticheater/patches/lagtroll.pwn
*
* DESCRIPTION :
*      	Lagtroll protection module
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2016.  All rights reserved.
*
*/


hook OnPlayerUpdate(playerid)
{
	new vid = GetPlayerVehicleID(playerid);
	if(vid > 0)
	{
	    if(vid != PlayerCheatInfo[playerid][LagTroll_LastVehicleID])
	    {
			if(GetTickCount() - PlayerCheatInfo[playerid][LagTroll_VehicleIDChangeTime] < 5000)
			{
	        	PlayerCheatInfo[playerid][LagTroll_VehicleIDChanges]++;
	            if(PlayerCheatInfo[playerid][LagTroll_VehicleIDChanges] > MAX_VEHICLE_ID_CHANGES)
	            {
                    CallLocalFunction("OnPlayerCheat", "ii", playerid, CHEAT_LAGTROLL);
					return 0;
	            }
			}
			else PlayerCheatInfo[playerid][LagTroll_VehicleIDChanges] = 1;
	    }
	    PlayerCheatInfo[playerid][LagTroll_LastVehicleID] = vid;
        PlayerCheatInfo[playerid][LagTroll_VehicleIDChangeTime] = GetTickCount();
    }
    return 1;
}
