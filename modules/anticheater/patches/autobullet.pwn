/*******************************************************************************
* FILENAME :        modules/anticheater/main.pwn
*
* DESCRIPTION :
*      	Autobullet protection module
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2016.  All rights reserved.
*
*/

#include <YSI\y_hooks>

hook OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if(!IsPlayerInAnyVehicle(playerid))
	{
		switch(weaponid)
		{
			case 27, 23, 25, 29, 30, 31, 33, 24, 38:
			{
				if(CheckSpeed(playerid))
				{
					if(gettime() - PlayerCheatInfo[playerid][AutoBullet_LastInfractionTime] >= AUTOBULLET_RESET_DELAY) PlayerCheatInfo[playerid][AutoBullet_Infractions] = 1;
					else PlayerCheatInfo[playerid][AutoBullet_Infractions]++;
					PlayerCheatInfo[playerid][AutoBullet_LastInfractionTime] = gettime();

					if(PlayerCheatInfo[playerid][AutoBullet_Infractions] == MAX_AUTOBULLET_INFRACTIONS)
					{
                        PlayerCheatInfo[playerid][AutoBullet_Infractions] = 0;
						CallLocalFunction("OnPlayerCheat", "ii", playerid, CHEAT_AUTOBULLET);
						return 0;
					}
				}
			}
		}
	}
  	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	PlayerCheatInfo[playerid][AutoBullet_Infractions] = 0;
  	return 1;
}

static CheckSpeed(playerid)
{
    new Keys,ud,lr;
    GetPlayerKeys(playerid,Keys,ud,lr);

	if(ud == KEY_UP && lr != KEY_LEFT && lr != KEY_RIGHT)
	{
		new Float:Velocity[3];
		GetPlayerVelocity(playerid, Velocity[0], Velocity[1], Velocity[2]);
	    Velocity[0] = floatsqroot( (Velocity[0]*Velocity[0])+(Velocity[1]*Velocity[1])+(Velocity[2]*Velocity[2]));
		if(Velocity[0] >= 0.11 && Velocity[0] <= 0.13) return 1;
	}
	return 0;
}
