/* *************************************************************************** *
*  Description: Ammunation shooting range module file.
*
*  Assignment: A script to add ammunation shooting range on server.
*
*           Copyright Paradise Devs 2015.  All rights reserved.
* *************************************************************************** */

#if defined _MODULE_shootingrange
	#endinput
#endif
#define _MODULE_shootingrange

#include <YSI\y_hooks>

// Object positions
new Float:gObjectsPositions[][][] =
{
	{
		{294.83914, -138.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{292.83914, -138.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{290.83914, -138.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{288.83914, -138.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{286.83914, -138.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{284.83914, -138.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{282.83914, -138.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{280.83914, -138.76210, 1006.95007, 90.00000, 0.00000, 90.00000}
	},
	{
		{294.83914, -136.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{292.83914, -136.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{290.83914, -136.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{288.83914, -136.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{286.83914, -136.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{284.83914, -136.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{282.83914, -136.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{280.83914, -136.76210, 1006.95007, 90.00000, 0.00000, 90.00000}
	},
	{
		{294.83914, -134.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{292.83914, -134.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{290.83914, -134.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{288.83914, -134.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{286.83914, -134.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{284.83914, -134.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{282.83914, -134.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{280.83914, -134.76210, 1006.95007, 90.00000, 0.00000, 90.00000}
	},
	{
		{294.83914, -132.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{292.83914, -132.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{290.83914, -132.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{288.83914, -132.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{286.83914, -132.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{284.83914, -132.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{282.83914, -132.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{280.83914, -132.76210, 1006.95007, 90.00000, 0.00000, 90.00000}
	},
	{
		{294.83914, -130.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{292.83914, -130.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{290.83914, -130.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{288.83914, -130.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{286.83914, -130.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{284.83914, -130.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{282.83914, -130.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{280.83914, -130.76210, 1006.95007, 90.00000, 0.00000, 90.00000}
	},
	{
		{294.83914, -128.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{292.83914, -128.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{290.83914, -128.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{288.83914, -128.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{286.83914, -128.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{284.83914, -128.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{282.83914, -128.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{280.83914, -128.76210, 1006.95007, 90.00000, 0.00000, 90.00000}
	},
	{
		{294.83914, -126.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{292.83914, -126.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{290.83914, -126.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{288.83914, -126.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{286.83914, -126.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{284.83914, -126.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{282.83914, -126.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{280.83914, -126.76210, 1006.95007, 90.00000, 0.00000, 90.00000}
	},
	{
		{294.83914, -124.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{292.83914, -124.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{290.83914, -124.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{288.83914, -124.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{286.83914, -124.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{284.83914, -124.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{282.83914, -124.76210, 1006.95007, 90.00000, 0.00000, 90.00000},
		{280.83914, -124.76210, 1006.95007, 90.00000, 0.00000, 90.00000}
	}
};

// Cabin positions
new Float:gCabinPositions[][] =
{
	{300.0891, -138.5000, 1004.0625, 90.0000},
	{300.0891, -137.0000, 1004.0625, 90.0000},
	{300.0891, -135.5000, 1004.0625, 90.0000},
	{300.0891, -134.0000, 1004.0625, 90.0000},
	{300.0891, -132.5000, 1004.0625, 90.0000},
	{300.0891, -131.0000, 1004.0625, 90.0000},
	{300.0891, -129.5000, 1004.0625, 90.0000},
	{300.0891, -128.0000, 1004.0625, 90.0000}
};

// Weapon data
static gWeapons[][][] =
{
	{WEAPON_COLT45,					1,		2000,		"Colt45"},
	{WEAPON_SILENCED,				1,		2500,		"Colt45 Silenciosa"},
	{WEAPON_DEAGLE,					10,		10000,		"Desert Eagle"},
	{WEAPON_SHOTGUN,				4,		10000,		"Escopeta"},
	{WEAPON_SAWEDOFF,				5,		5000,		"Escopeta Cano-Serrado"},
	{WEAPON_SHOTGSPA,				8,		8000,		"Escopeta Automatica"},
	{WEAPON_UZI,					7,		7500,		"Micro-UZi"},
	{WEAPON_MP5,					9,		9250,		"MP5"},
	{WEAPON_AK47,					12,		12000,		"AK-47"},
	{WEAPON_M4,						13,		13000,		"M4"},
	{WEAPON_SNIPER,					15,		50000,		"Sniper Rifle"}
};

// Textdraw data
new PlayerText:PWSkillTD[MAX_PLAYERS][14];
new PlayerBar:PWSkillBar[MAX_PLAYERS][11];
new bool:gIsWeaponSkillVisible[MAX_PLAYERS];

// Checks if a player is in shooting range
new bool:gIsPlayerInShootingRange[MAX_PLAYERS];

// Current stage of shooting range
new gPlayerShootingRangeStage[MAX_PLAYERS];

// CabinID the player is current in
new gPlayerShootingRangeCabin[MAX_PLAYERS];

// Remaining player objects
new gPlayerRemainingObjects[MAX_PLAYERS];

// Checks if the player is in moving test
new bool:gIsPlayerInMovingStage[MAX_PLAYERS];

// Objects IDs
new gPlayerShootingRangeObjects[MAX_PLAYERS][8];

// Amount of player currently in shooting range
new gShootingRangePlayerCount = 0;

// Checks if dialog is visible
static bool:gIsDialogVisible[MAX_PLAYERS];

// Amount of bullets player spent
new gPlayerBulletsShot[MAX_PLAYERS];

// Amount of bullets the player did not miss
new gPlayerBulletsHit[MAX_PLAYERS];

// ID of the skill the player is training
new gPlayerWeaponTraining[MAX_PLAYERS];

/*
	OnShootingRangeStart
		Called when a player starts the shooting range

	playerid
		The ID of the player

	cabinid
		The ID of the cabin

	stageid
		The stage the player is in
*/
OnShootingRangeStart(playerid, cabinid, stageid)
{
	if(stageid == sizeof(gObjectsPositions[]))
	{
		SendClientMessage(playerid, -1, "* Você finalizou seu treino e {9AFEFF}melhorou{FFFFFF} as habilidades com essa arma.");
		SetPlayerPos(playerid, 309.3642, -141.7543, 1004.0625);
		SetPlayerFacingAngle(playerid, 267.7211);
		SetCameraBehindPlayer(playerid);

		new Float:ratio = floatmul(floatdiv(gPlayerBulletsHit[playerid], gPlayerBulletsShot[playerid]), 100.0);
		new peformance[16];

		if(ratio < 33.0)
		{
			SetPlayerWeaponSkill(playerid, gPlayerWeaponTraining[playerid], GetPlayerWeaponSkill(playerid, gPlayerWeaponTraining[playerid]) + 50);
			peformance = "{FF0000}Ruim";
		}
		else if(ratio > 32.0 && ratio < 66.0)
		{
			SetPlayerWeaponSkill(playerid, gPlayerWeaponTraining[playerid], GetPlayerWeaponSkill(playerid, gPlayerWeaponTraining[playerid]) + 100);
			peformance = "{FFFF00}Mediana";
		}
		else if(ratio > 65.0)
		{
			SetPlayerWeaponSkill(playerid, gPlayerWeaponTraining[playerid], GetPlayerWeaponSkill(playerid, gPlayerWeaponTraining[playerid]) + 150);
			peformance = "{00FF00}Boa";
		}

		new output[222 + MAX_PLAYER_NAME];
		format(output, sizeof(output), "* %d acertos, %d erros. Porcent. de acertos: %.2f%%%%, Porcent. de erros: %.2f%%%%. Performance: %s", gPlayerBulletsHit[playerid], gPlayerBulletsShot[playerid]-gPlayerBulletsHit[playerid], ratio, 100.0-ratio, peformance);
		SendClientMessage(playerid, -1, output);

		format(output, sizeof(output), "* %s completou o treino. %d acertos, %d erros. Porcentagem: Acertos: %.2f%%%%, Erros: %.2f%%%%. Performance: %s", GetPlayerNamef(playerid), gPlayerBulletsHit[playerid], gPlayerBulletsShot[playerid]-gPlayerBulletsHit[playerid], ratio, 100.0-ratio, peformance);
		foreach(new i: Player)
			if(GetPlayerDistanceFromPlayer(playerid, i) < 30.0 && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i) && i != playerid)
				SendClientMessage(i, -1, output);

		if(ratio == 100.0)
		{
			SetPlayerWeaponSkill(playerid, gPlayerWeaponTraining[playerid], GetPlayerWeaponSkill(playerid, gPlayerWeaponTraining[playerid]) + 100);
			SendClientMessage(playerid, -1, "* Você conseguiu um treino {00FF00}perfeito{FFFFFF}! Ganhou habilidade bônus!");
			if(!GetPlayerAchievement(playerid, ACHIEVEMENT_SHOOTINGRANGE))
				SetPlayerAchievement(playerid, ACHIEVEMENT_SHOOTINGRANGE, true);
		}
		SetPlayerSkillLevel(playerid, gPlayerWeaponTraining[playerid], GetPlayerWeaponSkill(playerid, gPlayerWeaponTraining[playerid]));

		gIsPlayerInShootingRange[playerid]	= false;
		gPlayerShootingRangeStage[playerid]	= 0;
		gPlayerShootingRangeCabin[playerid]	= 0;
		gPlayerRemainingObjects[playerid]	= 0;
		gIsPlayerInMovingStage[playerid]	= false;
		gPlayerBulletsShot[playerid]		= 0;
		gPlayerBulletsHit[playerid]			= 0;

		for(new i = 0; i < 8; i++)
			gPlayerShootingRangeObjects[playerid][i] = INVALID_OBJECT_ID;

		gShootingRangePlayerCount--;

		ResetPlayerWeapons(playerid);
		GivePlayerWeapons(playerid);
		return 1;
	}

	new modelid = 3018;
	for(new i = 0; i < 8; i++)
	{
		gPlayerShootingRangeObjects[playerid][i] = CreatePlayerObject(playerid, modelid + i, gObjectsPositions[cabinid][stageid][0], gObjectsPositions[cabinid][stageid][1], gObjectsPositions[cabinid][stageid][2], gObjectsPositions[cabinid][stageid][3], gObjectsPositions[cabinid][stageid][4], gObjectsPositions[cabinid][stageid][5]);
		MovePlayerObject(playerid, gPlayerShootingRangeObjects[playerid][i], gObjectsPositions[cabinid][stageid][0], gObjectsPositions[cabinid][stageid][1] + 0.001, gObjectsPositions[cabinid][stageid][2], 0.001, gObjectsPositions[cabinid][stageid][3] - 90.0000, gObjectsPositions[cabinid][stageid][4], gObjectsPositions[cabinid][stageid][5]);
	}
	gPlayerRemainingObjects[playerid] = 7;
	return 1;
}

hook OnGameModeInit()
{
	CreateDynamicPickup(1239, 1, 306.1543, -141.8075, 1004.0547, -1, 7, -1, MAX_PICKUP_RANGE);
	CreateDynamic3DTextLabel("Treinamento de armas", 0xFFFFFFFF, 306.1543, -141.8075, 1004.0547, MAX_TEXT3D_RANGE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
}

hook OnPlayerPickUpDynPickup(playerid, pickupid)
{
	if(IsPlayerInRangeOfPoint(playerid, 2.0, 306.1543, -141.8075, 1004.0547) && !gIsDialogVisible[playerid])
	{
		PlaySelectSound(playerid);
		gIsDialogVisible[playerid] = true;

		new info[322], weapondata[34];
		strcat(info, "Arma\tNível\tPreço");
		for(new i = 0; i < sizeof(gWeapons); i++)
		{
			format(weapondata, 32, "\n%s\t%i\t$%i", gWeapons[i][3], gWeapons[i][1], gWeapons[i][2]);
			strcat(info, weapondata);
		}

		ShowPlayerDialog(playerid, DIALOG_SHOOTING_RANGE, DIALOG_STYLE_TABLIST_HEADERS, "Treinamento de armas", info, "Treinar", "Cancelar");
		return -2;
	}
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case DIALOG_SHOOTING_RANGE:
		{
			if(!response)
				return PlayCancelSound(playerid), gIsDialogVisible[playerid] = false;

			if(IsPlayerInShootingRange(playerid))
				return gIsDialogVisible[playerid] = false;

			if(GetPlayerCash(playerid) < gWeapons[listitem][2][0])
			{
				gIsDialogVisible[playerid] = false;
				SendClientMessage(playerid, COLOR_ERROR, "* Você não possui dinheiro suficiente.");
				PlayErrorSound(playerid);
				return 1;
			}
			else if(GetPlayerLevel(playerid) < gWeapons[listitem][1][0])
			{
				gIsDialogVisible[playerid] = false;
				SendClientMessage(playerid, COLOR_ERROR, "* Você não possui nível suficiente.");
				PlayErrorSound(playerid);
				return 1;
			}
			else if(GetPlayerWeaponSkill(playerid, listitem) > 999)
			{
				gIsDialogVisible[playerid] = false;
				SendClientMessage(playerid, COLOR_ERROR, "* Você já é profissional com essa arma.");
				PlayErrorSound(playerid);
				return 1;
			}
			else if(gShootingRangePlayerCount == sizeof(gCabinPositions))
			{
				gIsDialogVisible[playerid] = false;
				SendClientMessage(playerid, COLOR_ERROR, "* As cabines estão lotadas, aguarde alguém terminar o treino.");
				PlayErrorSound(playerid);
				return 1;
			}

			GetPlayerWeaponsData(playerid); // Custom Function

			ResetPlayerWeapons(playerid);
			GivePlayerWeapon(playerid, gWeapons[listitem][0][0], 99999);

			new message[92];
			format(message, sizeof(message), "* Você começou seu treino de {9AFEFF}%s{FFFFFF}, destrua os alvos.", gWeapons[listitem][3]);
			SendClientMessage(playerid, -1, message);
			SendClientMessage(playerid, -1, "* Caso você ande o treino será cancelado.");
			GivePlayerCash(playerid, -gWeapons[listitem][2][0]);
			defer OnPlayerShootingRangeUpdate(playerid);

			new cabinid = gShootingRangePlayerCount;
			SetPlayerFacingAngle(playerid, gCabinPositions[cabinid][3]);
			SetPlayerPos(playerid, gCabinPositions[cabinid][0], gCabinPositions[cabinid][1], gCabinPositions[cabinid][2]);
			OnShootingRangeStart(playerid, cabinid, gPlayerShootingRangeStage[playerid]);
			gPlayerShootingRangeCabin[playerid] = cabinid;
			gIsPlayerInShootingRange[playerid] = true;
			gPlayerWeaponTraining[playerid]	= listitem;
			gShootingRangePlayerCount++;
			gIsDialogVisible[playerid] = false;
			return -2;
		}
	}
	return 1;
}

hook OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if(gIsPlayerInShootingRange[playerid])
		gPlayerBulletsShot[playerid]++;
	if(hittype == BULLET_HIT_TYPE_PLAYER_OBJECT && IsPlayerInShootingRange(playerid))
	{
		for(new i = 0; i < 7; i++)
		{
			if(gPlayerShootingRangeObjects[playerid][i] == hitid)
			{
				defer DestroyShootingRangeObject(playerid, hitid);
				gPlayerRemainingObjects[playerid]--;
				gPlayerBulletsHit[playerid]++;
				if(gPlayerRemainingObjects[playerid] == 0)
				{
					new cabinid = gPlayerShootingRangeCabin[playerid];
					new stageid = gPlayerShootingRangeStage[playerid];

					if(!gIsPlayerInMovingStage[playerid])
					{
						MovePlayerObject(playerid, gPlayerShootingRangeObjects[playerid][7], gObjectsPositions[cabinid][stageid][0], gObjectsPositions[cabinid][stageid][1], gObjectsPositions[cabinid][stageid][2], 0.001, gObjectsPositions[cabinid][stageid][3], gObjectsPositions[cabinid][stageid][4], gObjectsPositions[cabinid][stageid][5]);
						defer DestroyShootingRangeObject(playerid, gPlayerShootingRangeObjects[playerid][7]);
					}
					else
					{
						defer MoveDelayObject(playerid, gPlayerShootingRangeObjects[playerid][7], gObjectsPositions[cabinid][stageid][0], gObjectsPositions[cabinid][stageid][1]-0.001, gObjectsPositions[cabinid][stageid][2], 0.001, gObjectsPositions[cabinid][stageid][3], gObjectsPositions[cabinid][stageid][4], gObjectsPositions[cabinid][stageid][5]);
						defer DestroyShootingRangeObject[3000](playerid, gPlayerShootingRangeObjects[playerid][7]);
					}

					if(++gPlayerShootingRangeStage[playerid] == sizeof(gObjectsPositions[]) && !gIsPlayerInMovingStage[playerid])
					{
						gIsPlayerInMovingStage[playerid] = true;
						gPlayerShootingRangeStage[playerid] = 0;
					}

					StartNextShootingRangeStage(playerid, cabinid, gPlayerShootingRangeStage[playerid]);
				}
			}
		}
	}
	return 1;
}

timer OnPlayerShootingRangeUpdate[900](playerid)
{
	if(gIsPlayerInShootingRange[playerid])
	{
		if(!IsPlayerInShootingRangeCabin(playerid))
		{
			SendClientMessage(playerid, COLOR_ERROR, "* Você abandonou o treino.");

			SetPlayerPos(playerid, 309.3642, -141.7543, 1004.0625);
			SetPlayerFacingAngle(playerid, 267.7211);
			SetCameraBehindPlayer(playerid);

			for(new i = 0; i < 8; i++)
				if(IsValidPlayerObject(playerid, gPlayerShootingRangeObjects[playerid][i]))
					DestroyPlayerObject(playerid, gPlayerShootingRangeObjects[playerid][i]);

			gIsPlayerInShootingRange[playerid] = false;
			gPlayerShootingRangeStage[playerid]	= 0;
			gPlayerShootingRangeCabin[playerid]	= 0;
			gPlayerRemainingObjects[playerid]	= 0;
			gIsPlayerInMovingStage[playerid]	= false;
			gPlayerBulletsShot[playerid]		= 0;
			gPlayerBulletsHit[playerid]			= 0;

			gShootingRangePlayerCount--;

			ResetPlayerWeapons(playerid);
			GivePlayerWeapons(playerid);
			return 1;
		}

		/*new Float:fVX, Float:fVY, Float:fVZ;
	    GetPlayerCameraFrontVector(playerid, fVX, fVY, fVZ);
		if(fVY < -0.3 || fVY > 0.0)
			SetPlayerArmedWeapon(playerid, 0);*/

		if(gIsPlayerInMovingStage[playerid])
		{
			if(gPlayerRemainingObjects[playerid] > 0)
			{
				for(new i = 0; i < 8; i++)
				{
					if(IsValidPlayerObject(playerid, gPlayerShootingRangeObjects[playerid][i]))
					{
						new cabinid = gPlayerShootingRangeCabin[playerid];
						new stageid = gPlayerShootingRangeStage[playerid];
						new Float:x, Float:y, Float:z;
						GetPlayerObjectPos(playerid, gPlayerShootingRangeObjects[playerid][i], x, y, z);
						if((gObjectsPositions[cabinid][stageid][1] - 1.0000) != y)
							MovePlayerObject(playerid, gPlayerShootingRangeObjects[playerid][i], gObjectsPositions[cabinid][stageid][0], gObjectsPositions[cabinid][stageid][1] - 1.0000, gObjectsPositions[cabinid][stageid][2], 1.00000, gObjectsPositions[cabinid][stageid][3] - 90.0000, gObjectsPositions[cabinid][stageid][4], gObjectsPositions[cabinid][stageid][5]);
						else
							MovePlayerObject(playerid, gPlayerShootingRangeObjects[playerid][i], gObjectsPositions[cabinid][stageid][0], gObjectsPositions[cabinid][stageid][1] + 1.0000, gObjectsPositions[cabinid][stageid][2], 1.00000, gObjectsPositions[cabinid][stageid][3] - 90.0000, gObjectsPositions[cabinid][stageid][4], gObjectsPositions[cabinid][stageid][5]);
					}
				}
			}
		}
		defer OnPlayerShootingRangeUpdate(playerid);
	}
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	if(gIsPlayerInShootingRange[playerid])
	{
		gIsPlayerInShootingRange[playerid]	= false;
		gPlayerShootingRangeStage[playerid]	= 0;
		gPlayerShootingRangeCabin[playerid]	= 0;
		gPlayerRemainingObjects[playerid]	= 0;
		gIsPlayerInMovingStage[playerid]	= false;
		gPlayerBulletsShot[playerid]		= 0;
		gPlayerBulletsHit[playerid]			= 0;

		for(new i = 0; i < 8; i++)
			gPlayerShootingRangeObjects[playerid][i] = INVALID_OBJECT_ID;

		gShootingRangePlayerCount--;
	}
	if(gIsWeaponSkillVisible[playerid]) gIsWeaponSkillVisible[playerid] = false;
	return 1;
}

timer MoveDelayObject[1500](playerid, objectid, Float:x, Float:y, Float:z, Float:speed, Float:rotx, Float:roty, Float:rotz)
{
	MovePlayerObject(playerid, objectid, x, y, z, speed, rotx, roty, rotz);
}

timer DestroyShootingRangeObject[1500](playerid, objectid)
{
	DestroyPlayerObject(playerid, objectid);
	return 1;
}

timer StartNextShootingRangeStage[1750](playerid, cabinid, stageid)
{
	OnShootingRangeStart(playerid, cabinid, stageid);
	return 1;
}

IsPlayerInShootingRange(playerid)
	return gIsPlayerInShootingRange[playerid];

IsPlayerInShootingRangeCabin(playerid)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);

	new cabinid = gPlayerShootingRangeCabin[playerid];
	if(IsPlayerInRangeOfPoint(playerid, 2.0, gCabinPositions[cabinid][0], gCabinPositions[cabinid][1], gCabinPositions[cabinid][2]))
		return true;
	return false;
}

ShowPlayerWeaponSkill(playerid)
{
	if(!gIsWeaponSkillVisible[playerid])
	{
		PWSkillTD[playerid][0] = CreatePlayerTextDraw(playerid, 185.000015, 95.836997, "box");
		PlayerTextDrawLetterSize(playerid, PWSkillTD[playerid][0], 0.000000, 27.469369);
		PlayerTextDrawTextSize(playerid, PWSkillTD[playerid][0], 418.765655, 0.000000);
		PlayerTextDrawAlignment(playerid, PWSkillTD[playerid][0], 1);
		PlayerTextDrawColor(playerid, PWSkillTD[playerid][0], 714);
		PlayerTextDrawUseBox(playerid, PWSkillTD[playerid][0], 1);
		PlayerTextDrawBoxColor(playerid, PWSkillTD[playerid][0], 109);
		PlayerTextDrawSetShadow(playerid, PWSkillTD[playerid][0], 0);
		PlayerTextDrawSetOutline(playerid, PWSkillTD[playerid][0], 0);
		PlayerTextDrawBackgroundColor(playerid, PWSkillTD[playerid][0], 714);
		PlayerTextDrawFont(playerid, PWSkillTD[playerid][0], 1);
		PlayerTextDrawSetProportional(playerid, PWSkillTD[playerid][0], 1);
		PlayerTextDrawSetShadow(playerid, PWSkillTD[playerid][0], 0);

		PWSkillTD[playerid][1] = CreatePlayerTextDraw(playerid, 190.333389, 86.296302, "Habilidade_com_Armas");
		PlayerTextDrawLetterSize(playerid, PWSkillTD[playerid][1], 0.400000, 1.600000);
		PlayerTextDrawAlignment(playerid, PWSkillTD[playerid][1], 1);
		PlayerTextDrawColor(playerid, PWSkillTD[playerid][1], -1);
		PlayerTextDrawSetShadow(playerid, PWSkillTD[playerid][1], 0);
		PlayerTextDrawSetOutline(playerid, PWSkillTD[playerid][1], 1);
		PlayerTextDrawBackgroundColor(playerid, PWSkillTD[playerid][1], 255);
		PlayerTextDrawFont(playerid, PWSkillTD[playerid][1], 0);
		PlayerTextDrawSetProportional(playerid, PWSkillTD[playerid][1], 1);
		PlayerTextDrawSetShadow(playerid, PWSkillTD[playerid][1], 0);

		PWSkillTD[playerid][2] = CreatePlayerTextDraw(playerid, 194.100128, 88.262863, "");
		PlayerTextDrawLetterSize(playerid, PWSkillTD[playerid][2], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, PWSkillTD[playerid][2], 62.353168, 70.078315);
		PlayerTextDrawAlignment(playerid, PWSkillTD[playerid][2], 1);
		PlayerTextDrawColor(playerid, PWSkillTD[playerid][2], -1);
		PlayerTextDrawSetShadow(playerid, PWSkillTD[playerid][2], 0);
		PlayerTextDrawSetOutline(playerid, PWSkillTD[playerid][2], 0);
		PlayerTextDrawBackgroundColor(playerid, PWSkillTD[playerid][2], 0);
		PlayerTextDrawFont(playerid, PWSkillTD[playerid][2], 5);
		PlayerTextDrawSetProportional(playerid, PWSkillTD[playerid][2], 0);
		PlayerTextDrawSetShadow(playerid, PWSkillTD[playerid][2], 0);
		PlayerTextDrawSetPreviewModel(playerid, PWSkillTD[playerid][2], 346);
		PlayerTextDrawSetPreviewRot(playerid, PWSkillTD[playerid][2], 0.000000, 0.000000, 0.000000, 1.000000);

		PWSkillTD[playerid][3] = CreatePlayerTextDraw(playerid, 199.266754, 122.007003, "");
		PlayerTextDrawLetterSize(playerid, PWSkillTD[playerid][3], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, PWSkillTD[playerid][3], 62.353168, 70.078315);
		PlayerTextDrawAlignment(playerid, PWSkillTD[playerid][3], 1);
		PlayerTextDrawColor(playerid, PWSkillTD[playerid][3], -1);
		PlayerTextDrawSetShadow(playerid, PWSkillTD[playerid][3], 0);
		PlayerTextDrawSetOutline(playerid, PWSkillTD[playerid][3], 0);
		PlayerTextDrawBackgroundColor(playerid, PWSkillTD[playerid][3], 0);
		PlayerTextDrawFont(playerid, PWSkillTD[playerid][3], 5);
		PlayerTextDrawSetProportional(playerid, PWSkillTD[playerid][3], 0);
		PlayerTextDrawSetShadow(playerid, PWSkillTD[playerid][3], 0);
		PlayerTextDrawSetPreviewModel(playerid, PWSkillTD[playerid][3], 347);
		PlayerTextDrawSetPreviewRot(playerid, PWSkillTD[playerid][3], 0.000000, 0.000000, 0.000000, 1.000000);

		PWSkillTD[playerid][4] = CreatePlayerTextDraw(playerid, 198.200210, 157.062835, "");
		PlayerTextDrawLetterSize(playerid, PWSkillTD[playerid][4], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, PWSkillTD[playerid][4], 62.353168, 70.078315);
		PlayerTextDrawAlignment(playerid, PWSkillTD[playerid][4], 1);
		PlayerTextDrawColor(playerid, PWSkillTD[playerid][4], -1);
		PlayerTextDrawSetShadow(playerid, PWSkillTD[playerid][4], 0);
		PlayerTextDrawSetOutline(playerid, PWSkillTD[playerid][4], 0);
		PlayerTextDrawBackgroundColor(playerid, PWSkillTD[playerid][4], 0);
		PlayerTextDrawFont(playerid, PWSkillTD[playerid][4], 5);
		PlayerTextDrawSetProportional(playerid, PWSkillTD[playerid][4], 0);
		PlayerTextDrawSetShadow(playerid, PWSkillTD[playerid][4], 0);
		PlayerTextDrawSetPreviewModel(playerid, PWSkillTD[playerid][4], 348);
		PlayerTextDrawSetPreviewRot(playerid, PWSkillTD[playerid][4], 0.000000, 0.000000, 0.000000, 1.000000);

		PWSkillTD[playerid][5] = CreatePlayerTextDraw(playerid, 329.766754, 88.677665, "");
		PlayerTextDrawLetterSize(playerid, PWSkillTD[playerid][5], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, PWSkillTD[playerid][5], 68.019836, 48.507949);
		PlayerTextDrawAlignment(playerid, PWSkillTD[playerid][5], 1);
		PlayerTextDrawColor(playerid, PWSkillTD[playerid][5], -1);
		PlayerTextDrawSetShadow(playerid, PWSkillTD[playerid][5], 0);
		PlayerTextDrawSetOutline(playerid, PWSkillTD[playerid][5], 0);
		PlayerTextDrawBackgroundColor(playerid, PWSkillTD[playerid][5], 0);
		PlayerTextDrawFont(playerid, PWSkillTD[playerid][5], 5);
		PlayerTextDrawSetProportional(playerid, PWSkillTD[playerid][5], 0);
		PlayerTextDrawSetShadow(playerid, PWSkillTD[playerid][5], 0);
		PlayerTextDrawSetPreviewModel(playerid, PWSkillTD[playerid][5], 352);
		PlayerTextDrawSetPreviewRot(playerid, PWSkillTD[playerid][5], 0.000000, 0.000000, 0.000000, 1.000000);

		PWSkillTD[playerid][6] = CreatePlayerTextDraw(playerid, 200.533401, 201.712814, "");
		PlayerTextDrawLetterSize(playerid, PWSkillTD[playerid][6], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, PWSkillTD[playerid][6], 62.353168, 70.078315);
		PlayerTextDrawAlignment(playerid, PWSkillTD[playerid][6], 1);
		PlayerTextDrawColor(playerid, PWSkillTD[playerid][6], -1);
		PlayerTextDrawSetShadow(playerid, PWSkillTD[playerid][6], 0);
		PlayerTextDrawSetOutline(playerid, PWSkillTD[playerid][6], 0);
		PlayerTextDrawBackgroundColor(playerid, PWSkillTD[playerid][6], 0);
		PlayerTextDrawFont(playerid, PWSkillTD[playerid][6], 5);
		PlayerTextDrawSetProportional(playerid, PWSkillTD[playerid][6], 0);
		PlayerTextDrawSetShadow(playerid, PWSkillTD[playerid][6], 0);
		PlayerTextDrawSetPreviewModel(playerid, PWSkillTD[playerid][6], 349);
		PlayerTextDrawSetPreviewRot(playerid, PWSkillTD[playerid][6], 25.000000, 0.000000, 0.000000, 1.000000);

		PWSkillTD[playerid][7] = CreatePlayerTextDraw(playerid, 200.733505, 251.883575, "");
		PlayerTextDrawLetterSize(playerid, PWSkillTD[playerid][7], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, PWSkillTD[playerid][7], 62.353168, 70.078315);
		PlayerTextDrawAlignment(playerid, PWSkillTD[playerid][7], 1);
		PlayerTextDrawColor(playerid, PWSkillTD[playerid][7], -1);
		PlayerTextDrawSetShadow(playerid, PWSkillTD[playerid][7], 0);
		PlayerTextDrawSetOutline(playerid, PWSkillTD[playerid][7], 0);
		PlayerTextDrawBackgroundColor(playerid, PWSkillTD[playerid][7], 0);
		PlayerTextDrawFont(playerid, PWSkillTD[playerid][7], 5);
		PlayerTextDrawSetProportional(playerid, PWSkillTD[playerid][7], 0);
		PlayerTextDrawSetShadow(playerid, PWSkillTD[playerid][7], 0);
		PlayerTextDrawSetPreviewModel(playerid, PWSkillTD[playerid][7], 350);
		PlayerTextDrawSetPreviewRot(playerid, PWSkillTD[playerid][7], 25.000000, 0.000000, 0.000000, 1.000000);

		PWSkillTD[playerid][8] = CreatePlayerTextDraw(playerid, 200.200180, 294.460174, "");
		PlayerTextDrawLetterSize(playerid, PWSkillTD[playerid][8], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, PWSkillTD[playerid][8], 62.353168, 70.078315);
		PlayerTextDrawAlignment(playerid, PWSkillTD[playerid][8], 1);
		PlayerTextDrawColor(playerid, PWSkillTD[playerid][8], -1);
		PlayerTextDrawSetShadow(playerid, PWSkillTD[playerid][8], 0);
		PlayerTextDrawSetOutline(playerid, PWSkillTD[playerid][8], 0);
		PlayerTextDrawBackgroundColor(playerid, PWSkillTD[playerid][8], 0);
		PlayerTextDrawFont(playerid, PWSkillTD[playerid][8], 5);
		PlayerTextDrawSetProportional(playerid, PWSkillTD[playerid][8], 0);
		PlayerTextDrawSetShadow(playerid, PWSkillTD[playerid][8], 0);
		PlayerTextDrawSetPreviewModel(playerid, PWSkillTD[playerid][8], 351);
		PlayerTextDrawSetPreviewRot(playerid, PWSkillTD[playerid][8], 25.000000, 0.000000, 0.000000, 1.000000);

		PWSkillTD[playerid][9] = CreatePlayerTextDraw(playerid, 329.766754, 133.777420, "");
		PlayerTextDrawLetterSize(playerid, PWSkillTD[playerid][9], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, PWSkillTD[playerid][9], 68.019836, 48.507949);
		PlayerTextDrawAlignment(playerid, PWSkillTD[playerid][9], 1);
		PlayerTextDrawColor(playerid, PWSkillTD[playerid][9], -1);
		PlayerTextDrawSetShadow(playerid, PWSkillTD[playerid][9], 0);
		PlayerTextDrawSetOutline(playerid, PWSkillTD[playerid][9], 0);
		PlayerTextDrawBackgroundColor(playerid, PWSkillTD[playerid][9], 0);
		PlayerTextDrawFont(playerid, PWSkillTD[playerid][9], 5);
		PlayerTextDrawSetProportional(playerid, PWSkillTD[playerid][9], 0);
		PlayerTextDrawSetShadow(playerid, PWSkillTD[playerid][9], 0);
		PlayerTextDrawSetPreviewModel(playerid, PWSkillTD[playerid][9], 353);
		PlayerTextDrawSetPreviewRot(playerid, PWSkillTD[playerid][9], 0.000000, 0.000000, 0.000000, 1.000000);

		PWSkillTD[playerid][10] = CreatePlayerTextDraw(playerid, 329.766754, 167.279464, "");
		PlayerTextDrawLetterSize(playerid, PWSkillTD[playerid][10], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, PWSkillTD[playerid][10], 68.019836, 48.507949);
		PlayerTextDrawAlignment(playerid, PWSkillTD[playerid][10], 1);
		PlayerTextDrawColor(playerid, PWSkillTD[playerid][10], -1);
		PlayerTextDrawSetShadow(playerid, PWSkillTD[playerid][10], 0);
		PlayerTextDrawSetOutline(playerid, PWSkillTD[playerid][10], 0);
		PlayerTextDrawBackgroundColor(playerid, PWSkillTD[playerid][10], 0);
		PlayerTextDrawFont(playerid, PWSkillTD[playerid][10], 5);
		PlayerTextDrawSetProportional(playerid, PWSkillTD[playerid][10], 0);
		PlayerTextDrawSetShadow(playerid, PWSkillTD[playerid][10], 0);
		PlayerTextDrawSetPreviewModel(playerid, PWSkillTD[playerid][10], 355);
		PlayerTextDrawSetPreviewRot(playerid, PWSkillTD[playerid][10], 0.000000, 0.000000, 0.000000, 1.000000);

		PWSkillTD[playerid][11] = CreatePlayerTextDraw(playerid, 327.766754, 209.799011, "");
		PlayerTextDrawLetterSize(playerid, PWSkillTD[playerid][11], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, PWSkillTD[playerid][11], 68.019836, 48.507949);
		PlayerTextDrawAlignment(playerid, PWSkillTD[playerid][11], 1);
		PlayerTextDrawColor(playerid, PWSkillTD[playerid][11], -1);
		PlayerTextDrawSetShadow(playerid, PWSkillTD[playerid][11], 0);
		PlayerTextDrawSetOutline(playerid, PWSkillTD[playerid][11], 0);
		PlayerTextDrawBackgroundColor(playerid, PWSkillTD[playerid][11], 0);
		PlayerTextDrawFont(playerid, PWSkillTD[playerid][11], 5);
		PlayerTextDrawSetProportional(playerid, PWSkillTD[playerid][11], 0);
		PlayerTextDrawSetShadow(playerid, PWSkillTD[playerid][11], 0);
		PlayerTextDrawSetPreviewModel(playerid, PWSkillTD[playerid][11], 356);
		PlayerTextDrawSetPreviewRot(playerid, PWSkillTD[playerid][11], 0.000000, 0.000000, 0.000000, 1.000000);

		PWSkillTD[playerid][12] = CreatePlayerTextDraw(playerid, 323.766754, 262.347442, "");
		PlayerTextDrawLetterSize(playerid, PWSkillTD[playerid][12], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, PWSkillTD[playerid][12], 68.019836, 48.507949);
		PlayerTextDrawAlignment(playerid, PWSkillTD[playerid][12], 1);
		PlayerTextDrawColor(playerid, PWSkillTD[playerid][12], -1);
		PlayerTextDrawSetShadow(playerid, PWSkillTD[playerid][12], 0);
		PlayerTextDrawSetOutline(playerid, PWSkillTD[playerid][12], 0);
		PlayerTextDrawBackgroundColor(playerid, PWSkillTD[playerid][12], 0);
		PlayerTextDrawFont(playerid, PWSkillTD[playerid][12], 5);
		PlayerTextDrawSetProportional(playerid, PWSkillTD[playerid][12], 0);
		PlayerTextDrawSetShadow(playerid, PWSkillTD[playerid][12], 0);
		PlayerTextDrawSetPreviewModel(playerid, PWSkillTD[playerid][12], 358);
		PlayerTextDrawSetPreviewRot(playerid, PWSkillTD[playerid][12], 0.000000, 0.000000, 0.000000, 1.000000);

		PWSkillTD[playerid][13] = CreatePlayerTextDraw(playerid, 329.936584, 318.933380, "~r~ESC~w~~n~~n~para fechar");
		PlayerTextDrawLetterSize(playerid, PWSkillTD[playerid][13], 0.305001, 0.740000);
		PlayerTextDrawAlignment(playerid, PWSkillTD[playerid][13], 1);
		PlayerTextDrawColor(playerid, PWSkillTD[playerid][13], -1);
		PlayerTextDrawSetShadow(playerid, PWSkillTD[playerid][13], 0);
		PlayerTextDrawSetOutline(playerid, PWSkillTD[playerid][13], 0);
		PlayerTextDrawBackgroundColor(playerid, PWSkillTD[playerid][13], 255);
		PlayerTextDrawFont(playerid, PWSkillTD[playerid][13], 2);
		PlayerTextDrawSetProportional(playerid, PWSkillTD[playerid][13], 1);
		PlayerTextDrawSetShadow(playerid, PWSkillTD[playerid][13], 0);

		new bar_color = 12183807;
		if(GetPlayerStatsColor(playerid) == PLAYER_STATS_COLOR_YELLOW)
			bar_color = 0xFFFF00FF;
		else if(GetPlayerStatsColor(playerid) == PLAYER_STATS_COLOR_GREEN)
			bar_color = 0x00FF00FF;
		else if(GetPlayerStatsColor(playerid) == PLAYER_STATS_COLOR_RED)
			bar_color = 0xFF0000FF;
		else if(GetPlayerStatsColor(playerid) == PLAYER_STATS_COLOR_PURPLE)
			bar_color = 0xAA00AAFF;

		PWSkillBar[playerid][0] = CreatePlayerProgressBar(playerid, 195.000000, 133.000000, 50.000000, 5.000000, bar_color, 999.00, BAR_DIRECTION_RIGHT);
		PWSkillBar[playerid][1] = CreatePlayerProgressBar(playerid, 195.000000, 168.000000, 50.000000, 4.000000, bar_color, 999.00, BAR_DIRECTION_RIGHT);
		PWSkillBar[playerid][2] = CreatePlayerProgressBar(playerid, 196.000000, 204.000000, 50.000000, 5.000000, bar_color, 999.00, BAR_DIRECTION_RIGHT);
		PWSkillBar[playerid][3] = CreatePlayerProgressBar(playerid, 198.000000, 248.000000, 50.000000, 5.000000, bar_color, 999.00, BAR_DIRECTION_RIGHT);
		PWSkillBar[playerid][4] = CreatePlayerProgressBar(playerid, 198.000000, 295.000000, 50.000000, 5.000000, bar_color, 999.00, BAR_DIRECTION_RIGHT);
		PWSkillBar[playerid][5] = CreatePlayerProgressBar(playerid, 198.000000, 338.000000, 50.000000, 4.000000, bar_color, 999.00, BAR_DIRECTION_RIGHT);
		PWSkillBar[playerid][6] = CreatePlayerProgressBar(playerid, 332.000000, 135.000000, 50.000000, 4.000000, bar_color, 999.00, BAR_DIRECTION_RIGHT);
		PWSkillBar[playerid][7] = CreatePlayerProgressBar(playerid, 331.000000, 170.000000, 50.000000, 3.000000, bar_color, 999.00, BAR_DIRECTION_RIGHT);
		PWSkillBar[playerid][8] = CreatePlayerProgressBar(playerid, 332.000000, 208.000000, 50.000000, 4.000000, bar_color, 999.00, BAR_DIRECTION_RIGHT);
		PWSkillBar[playerid][9] = CreatePlayerProgressBar(playerid, 330.000000, 247.000000, 50.000000, 5.000000, bar_color, 999.00, BAR_DIRECTION_RIGHT);
		PWSkillBar[playerid][10] = CreatePlayerProgressBar(playerid, 330.000000, 293.000000, 50.000000, 6.000000, bar_color, 999.00, BAR_DIRECTION_RIGHT);

		gIsWeaponSkillVisible[playerid] = true;

		for(new i = 0; i < sizeof(PWSkillBar[]); i++)
		{
			SetPlayerProgressBarValue(playerid, PWSkillBar[playerid][i], GetPlayerWeaponSkill(playerid, i));
			ShowPlayerProgressBar(playerid, PWSkillBar[playerid][i]);
		}

		for(new i = 0; i < sizeof(PWSkillTD[]); i++)
			PlayerTextDrawShow(playerid, PWSkillTD[playerid][i]);
	}
}

HidePlayerWeaponSkill(playerid)
{
	if(gIsWeaponSkillVisible[playerid])
	{
		for(new i = 0; i < sizeof(PWSkillBar[]); i++)
			DestroyPlayerProgressBar(playerid, PWSkillBar[playerid][i]);

		for(new i = 0; i < sizeof(PWSkillTD[]); i++)
			PlayerTextDrawDestroy(playerid, PWSkillTD[playerid][i]);

		gIsWeaponSkillVisible[playerid] = false;
	}
}

YCMD:habarmas(playerid, params[], help)
{
	ShowPlayerWeaponSkill(playerid);
	SelectTextDraw(playerid, -1);
	return 1;
}

hook OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(gIsWeaponSkillVisible[playerid] && clickedid == Text:INVALID_TEXT_DRAW)
	{
		HidePlayerWeaponSkill(playerid);
		CancelSelectTextDraw(playerid);
	}
}
