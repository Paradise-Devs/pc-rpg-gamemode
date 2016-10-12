#if defined OnPlayerSkinChange
	forward OnPlayerSkinChange(playerid, newskin, oldskin);
#endif
#if defined OnPlayerNameChange
	forward OnPlayerNameChange(playerid, newname[], oldname[]);
#endif
#if defined OnPlayerMoneyChange
	forward OnPlayerMoneyChange(playerid, newmoney, oldmoney);
#endif
#if defined OnPlayerWantedLevelChange
	forward OnPlayerWantedLevelChange(playerid, newlevel, oldlevel);
#endif
#if defined OnPlayerScoreChange
	forward OnPlayerScoreChange(playerid, newscore, oldscore);
#endif
#if defined OnPlayerWeaponSlotChange
	forward OnPlayerWeaponSlotChange(playerid, slotid, new_weapon, oldweapon);
#endif
#if defined OnPlayerAmmoChange
	forward OnPlayerAmmoChange(playerid, weaponid, newammo, oldammo);
#endif
#if defined OnPlayerCurrentWeaponChange
	forward OnPlayerCurrentWeaponChange(playerid, new_weapon, oldweapon);
#endif
#if defined OnPlayerVehicleChange
	forward OnPlayerVehicleChange(playerid, new_vehicle, oldvehicle);
#endif
#if defined OnPlayerVehicleSeatChange
	forward OnPlayerVehicleSeatChange(playerid, newseat, oldseat);
#endif
#if defined OnPlayerHealthChange
	forward OnPlayerHealthChange(playerid, Float:newhealth, Float:oldhealth);
#endif
#if defined OnPlayerArmourChange
	forward OnPlayerArmourChange(playerid, Float:newarmour, Float:oldarmour);
#endif
#if defined OnPlayerVirtualWorldChange
	forward OnPlayerVirtualWorldChange(playerid, new_world, oldworld);
#endif
#if defined OnPlayerPingChange
	forward OnPlayerPingChange(playerid, newping, oldping);
#endif
#if defined OnPlayerFPSChange
	forward OnPlayerFPSChange(playerid, newfps, oldfps);
#endif
#if defined OnPlayerDrunkLevelChange
	forward OnPlayerDrunkLevelChange(playerid, newlevel, oldlevel);
#endif
#if defined OnPlayerFreezeStateChange
	forward OnPlayerFreezeStateChange(playerid, newstate, oldstate);
#endif
#if defined OnPlayerTeamChange
	forward OnPlayerTeamChange(playerid, newteam, oldteam);
#endif
#if defined OnPlayerGenderChange
	forward OnPlayerGenderChange(playerid, newgender, oldgender);
#endif
#if defined OnPlayerAimStateChange
	forward OnPlayerAimStateChange(playerid, weaponid, mode);
#endif
#if !defined strcpy
	#define strcpy(%0,%1) strcat((%0[0] = '\0', %0), %1)
#endif
#if !defined isnull
    #define isnull(%1) ((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))
#endif


#if !defined PRESSED
	#define PRESSED(%0) \
		(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#endif
#if !defined RELEASED
	#define RELEASED(%0) \
		(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))
#endif

#define KEY_AIM KEY_HANDBRAKE

#define SKIN_GENDER_NONE 0
#define SKIN_GENDER_FEMALE 1
#define SKIN_GENDER_MALE 2

#define AIM_MODE_RELEASE	 0
#define AIM_MODE_HOLD	 1


enum UpdateData
{
	iB_Skin,
	iB_Gender,
	iB_Name[MAX_PLAYER_NAME],
	iB_Money,
	iB_WantedLevel,
	iB_Score,
	iB_Weapon[13],
	iB_Ammo[13],
	iB_CurrentWeapon,
	iB_Vehicle,
	iB_Seat,
	Float:iB_Health,
	Float:iB_Armour,
	iB_World,
	iB_Ping,
	iB_FPS,
	iB_DrunkLevel,
	bool:iB_Freezed,
	iB_Team,
	bool:iB_IsAiming
}
new PlayerUpdateInfo[MAX_PLAYERS][UpdateData];

enum FPSData
{
	iB_PlayerFPS,
	iB_LastPlayerDrunkLevel,
	iB_NewPlayerDrunkLevel
}
new PlayerFPSInfo[MAX_PLAYERS][FPSData];

CleanPlayerUpdateInfo(playerid)
{
	PlayerUpdateInfo[playerid][iB_Skin] = 0;
	PlayerUpdateInfo[playerid][iB_Gender] = SKIN_GENDER_NONE;
	format(PlayerUpdateInfo[playerid][iB_Name], MAX_PLAYER_NAME, "");
	PlayerUpdateInfo[playerid][iB_Money] = 0;
	PlayerUpdateInfo[playerid][iB_WantedLevel] = 0;
	PlayerUpdateInfo[playerid][iB_Score] = 0;
	format(PlayerUpdateInfo[playerid][iB_Weapon], 13, "");
	format(PlayerUpdateInfo[playerid][iB_Ammo], 13, "");
	PlayerUpdateInfo[playerid][iB_CurrentWeapon] = 0;
	PlayerUpdateInfo[playerid][iB_Vehicle] = 0;
	PlayerUpdateInfo[playerid][iB_Seat] = -1;
	PlayerUpdateInfo[playerid][iB_Health] = 100.0;
	PlayerUpdateInfo[playerid][iB_Armour] = 0.0;
	PlayerUpdateInfo[playerid][iB_World] = 0;
	PlayerUpdateInfo[playerid][iB_Ping] = 0;
	PlayerUpdateInfo[playerid][iB_FPS] = 0;
	PlayerUpdateInfo[playerid][iB_DrunkLevel] = 0;
	PlayerUpdateInfo[playerid][iB_Freezed] = false;
	PlayerUpdateInfo[playerid][iB_Team] = 255;
	PlayerFPSInfo[playerid][iB_PlayerFPS] = 0;
	PlayerFPSInfo[playerid][iB_LastPlayerDrunkLevel] = 0;
	PlayerFPSInfo[playerid][iB_NewPlayerDrunkLevel] = 0;
	PlayerUpdateInfo[playerid][iB_IsAiming] = false;
	return 1;
}

hook OnPlayerConnect(playerid)
{
	CleanPlayerUpdateInfo(playerid);
    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	CleanPlayerUpdateInfo(playerid);
    return 1;
}

hook OnGameModeInit()
{
	SetTimer("iBranch_Update", 80, false);
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	new weapon = GetPlayerWeapon(playerid);
	if(RELEASED(KEY_AIM) && PlayerUpdateInfo[playerid][iB_IsAiming])
	{
		#if defined OnPlayerAimStateChange
			CallRemoteFunction("OnPlayerAimStateChange", "iii", playerid, weapon, AIM_MODE_RELEASE);
		#endif
		PlayerUpdateInfo[playerid][iB_IsAiming] = false;
		return 1;
	}
	if(PRESSED(KEY_AIM) && !PlayerUpdateInfo[playerid][iB_IsAiming] && !IsPlayerInAnyVehicle(playerid))//detect if player is holding aim
	{
		switch(weapon)
		{
			case 22..34, 38:
			{
				CallRemoteFunction("OnPlayerAimStateChange", "iii", playerid, weapon, AIM_MODE_HOLD);
				PlayerUpdateInfo[playerid][iB_IsAiming] = true;
				return 1;
			}
		}
		return 1;
	}
	return 1;
}


forward iBranch_Update();
public iBranch_Update()
{
	foreach(Player, playerid)
	{
		if(!IsPlayerConnected(playerid)) return CleanPlayerUpdateInfo(playerid);

		#if defined OnPlayerSkinChange
		new upd_skin = GetPlayerSkin(playerid);

		if(upd_skin != PlayerUpdateInfo[playerid][iB_Skin])
		{
			#if defined OnPlayerGenderChange
			if(iB_GetSkinGender(upd_skin) != PlayerUpdateInfo[playerid][iB_Gender])
			{
				OnPlayerGenderChange(playerid, iB_GetSkinGender(upd_skin), iB_GetSkinGender(PlayerUpdateInfo[playerid][iB_Skin]));
				PlayerUpdateInfo[playerid][iB_Gender] = iB_GetSkinGender(upd_skin);
			}
			#endif
			OnPlayerSkinChange(playerid, upd_skin, PlayerUpdateInfo[playerid][iB_Skin]);
			PlayerUpdateInfo[playerid][iB_Skin] = upd_skin;
		}
		#endif

		#if defined OnPlayerNameChange
		new upd_name[MAX_PLAYER_NAME];
		GetPlayerName(playerid, upd_name, sizeof(upd_name));

		if(strcmp(upd_name, PlayerUpdateInfo[playerid][iB_Name]))
		{
			if(!isnull(upd_name) && !isnull(PlayerUpdateInfo[playerid][iB_Name])) OnPlayerNameChange(playerid, upd_name, PlayerUpdateInfo[playerid][iB_Name]);
			strcpy(PlayerUpdateInfo[playerid][iB_Name], upd_name);
		}
		#endif

		#if defined OnPlayerMoneyChange
		new upd_money = GetPlayerMoney(playerid);

		if(upd_money != PlayerUpdateInfo[playerid][iB_Money])
		{
			OnPlayerMoneyChange(playerid, upd_money, PlayerUpdateInfo[playerid][iB_Money]);
			PlayerUpdateInfo[playerid][iB_Money] = upd_money;
		}
		#endif

		#if defined OnPlayerWantedLevelChange
		new upd_wantedlevel = GetPlayerWantedLevel(playerid);

		if(upd_wantedlevel != PlayerUpdateInfo[playerid][iB_WantedLevel])
		{
			OnPlayerWantedLevelChange(playerid, upd_wantedlevel, PlayerUpdateInfo[playerid][iB_WantedLevel]);
			PlayerUpdateInfo[playerid][iB_WantedLevel] = upd_wantedlevel;
		}
		#endif

		#if defined OnPlayerScoreChange
		new upd_score = GetPlayerScore(playerid);

		if(upd_score != PlayerUpdateInfo[playerid][iB_Score])
		{
			OnPlayerScoreChange(playerid, upd_score, PlayerUpdateInfo[playerid][iB_Score]);
			PlayerUpdateInfo[playerid][iB_Score] = upd_score;
		}
		#endif
		new upd_weapon[13],	upd_ammo[13];

		for(new s; s < 13; s++)
		{
			GetPlayerWeaponData(playerid, s, upd_weapon[s], upd_ammo[s]);

			#if defined OnPlayerWeaponSlotChange
			if(upd_weapon[s] != PlayerUpdateInfo[playerid][iB_Weapon][s])
			{
				OnPlayerWeaponSlotChange(playerid, s, upd_weapon[s], PlayerUpdateInfo[playerid][iB_Weapon][s]);
				PlayerUpdateInfo[playerid][iB_Weapon][s] = upd_weapon[s];
			}
			#endif

			#if defined OnPlayerAmmoChange
			if(upd_ammo[s] != PlayerUpdateInfo[playerid][iB_Ammo][s] && upd_weapon[s])
			{
				OnPlayerAmmoChange(playerid, upd_weapon[s], upd_ammo[s], PlayerUpdateInfo[playerid][iB_Ammo][s]);
				PlayerUpdateInfo[playerid][iB_Ammo][s] = upd_ammo[s];
			}
			#endif
		}

		#if defined OnPlayerCurrentWeaponChange
		new upd_currentweapon = GetPlayerWeapon(playerid);

		if(upd_currentweapon != PlayerUpdateInfo[playerid][iB_CurrentWeapon])
		{
			OnPlayerCurrentWeaponChange(playerid, upd_currentweapon, PlayerUpdateInfo[playerid][iB_CurrentWeapon]);
			PlayerUpdateInfo[playerid][iB_CurrentWeapon] = upd_currentweapon;
		}
		#endif

		#if defined OnPlayerVehicleChange
		new upd_vehicle = GetPlayerVehicleID(playerid);

		if(upd_vehicle != PlayerUpdateInfo[playerid][iB_Vehicle])
		{
			if(upd_vehicle != 128)
			{
				OnPlayerVehicleChange(playerid, upd_vehicle, PlayerUpdateInfo[playerid][iB_Vehicle]);
				PlayerUpdateInfo[playerid][iB_Vehicle] =  upd_vehicle;
			}
		}
		#endif

		#if defined OnPlayerVehicleSeatChange
		new upd_seat = GetPlayerVehicleSeat(playerid);

		if(upd_seat != PlayerUpdateInfo[playerid][iB_Seat])
		{
			OnPlayerVehicleSeatChange(playerid, upd_seat, PlayerUpdateInfo[playerid][iB_Seat]);
			PlayerUpdateInfo[playerid][iB_Seat] = upd_seat;
		}
		#endif

		#if defined OnPlayerHealthChange
		new Float:upd_health;
		GetPlayerHealth(playerid, upd_health);

		if(upd_health != PlayerUpdateInfo[playerid][iB_Health])
		{
			OnPlayerHealthChange(playerid, upd_health, PlayerUpdateInfo[playerid][iB_Health]);
			PlayerUpdateInfo[playerid][iB_Health] = upd_health;
		}
		#endif

		#if defined OnPlayerArmourChange
		new Float:upd_armour;
		GetPlayerArmour(playerid, upd_armour);

		if(upd_armour != PlayerUpdateInfo[playerid][iB_Armour])
		{
			OnPlayerArmourChange(playerid, upd_armour, PlayerUpdateInfo[playerid][iB_Armour]);
			PlayerUpdateInfo[playerid][iB_Armour] = upd_armour;
		}
		#endif

		#if defined OnPlayerVirtualWorldChange
		new upd_world = GetPlayerVirtualWorld(playerid);

		if(upd_world != PlayerUpdateInfo[playerid][iB_World])
		{
			OnPlayerVirtualWorldChange(playerid, upd_world, PlayerUpdateInfo[playerid][iB_World]);
			PlayerUpdateInfo[playerid][iB_World] = upd_world;
		}
		#endif

		#if defined OnPlayerPingChange
		new upd_ping = GetPlayerPing(playerid);

		if(upd_ping != PlayerUpdateInfo[playerid][iB_Ping])
		{
			OnPlayerPingChange(playerid, upd_ping, PlayerUpdateInfo[playerid][iB_Ping]);
			PlayerUpdateInfo[playerid][iB_Ping] = upd_ping;
		}
		#endif

		#if defined OnPlayerFPSChange
		new upd_fps = GetPlayerFPS(playerid);

		if(upd_fps != PlayerUpdateInfo[playerid][iB_FPS])
		{
			OnPlayerFPSChange(playerid, upd_fps, PlayerUpdateInfo[playerid][iB_FPS]);
			PlayerUpdateInfo[playerid][iB_FPS] = upd_fps;
		}
		#endif

		#if defined OnPlayerDrunkLevelChange
		new upd_drunklevel = GetPlayerDrunkLevel(playerid);

		if(upd_drunklevel != PlayerUpdateInfo[playerid][iB_DrunkLevel])
		{
			if(upd_drunklevel != 2000)//ignore FPS updater
			{
				OnPlayerDrunkLevelChange(playerid, upd_drunklevel, PlayerUpdateInfo[playerid][iB_DrunkLevel]);
				PlayerUpdateInfo[playerid][iB_DrunkLevel] = upd_drunklevel;
			}
		}
		#endif

		#if defined OnPlayerTeamChange
		new upd_team = GetPlayerTeam(playerid);

		if(upd_team != PlayerUpdateInfo[playerid][iB_Team])
		{
			OnPlayerTeamChange(playerid, upd_team, PlayerUpdateInfo[playerid][iB_Team]);
			PlayerUpdateInfo[playerid][iB_Team] = upd_team;
		}
		#endif
	}
	return SetTimer("iBranch_Update", 80, false);//reset the timer manually to avoid desync
}


#if defined OnPlayerFPSChange
iB_GetPlayerFPS(playerid)
{
	PlayerFPSInfo[playerid][iB_LastPlayerDrunkLevel] =  GetPlayerDrunkLevel(playerid);
	if(PlayerFPSInfo[playerid][iB_LastPlayerDrunkLevel] < 100)
	{
		SetPlayerDrunkLevel(playerid, 2000);
	}
	else
	{
		if(PlayerFPSInfo[playerid][iB_NewPlayerDrunkLevel] != PlayerFPSInfo[playerid][iB_LastPlayerDrunkLevel])
		{
			PlayerFPSInfo[playerid][iB_PlayerFPS] = PlayerFPSInfo[playerid][iB_NewPlayerDrunkLevel] - PlayerFPSInfo[playerid][iB_LastPlayerDrunkLevel];
			PlayerFPSInfo[playerid][iB_NewPlayerDrunkLevel] = PlayerFPSInfo[playerid][iB_LastPlayerDrunkLevel];
			if(0 < && PlayerFPSInfo[playerid][iB_PlayerFPS] < 256)
			{
 				return PlayerFPSInfo[playerid][iB_PlayerFPS] - 1;
 			}
 		}
	}
	return 0;
}
#endif


#if defined OnPlayerGenderChange
iB_GetSkinGender(skinid)
{
    switch(skinid)
    {
        case 74: return SKIN_GENDER_NONE;
        case 0..8, 14..30, 32..38, 42..52, 57..62, 66..68, 70..73, 78..84, 86, 94..128, 132..137, 142..144, 146, 147, 149, 153..156, 158..168, 170, 171, 173..177, 179..189, 200,
        202..204, 206..210, 212, 213, 217, 220..223, 227..230, 234..236, 239..242, 247..250, 252..255, 258..262, 264..297, 299..305, 310, 311: return SKIN_GENDER_MALE;
        default: return SKIN_GENDER_FEMALE;
    }
    return SKIN_GENDER_NONE;
}
#endif

#if defined OnPlayerFreezeStateChange
hook TogglePlayerControllable(playerid, toggle)
{
	CallRemoteFunction("OnPlayerFreezeStateChange", "iii", playerid, toggle, PlayerUpdateInfo[playerid][iB_Freezed]);
	return 1;
}
#endif
