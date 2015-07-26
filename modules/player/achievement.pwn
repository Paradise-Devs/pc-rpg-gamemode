//------------------------------------------------------------------------------

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

new ACHIEVEMENT:g_pAchievementData[MAX_PLAYERS];
new PlayerText:g_pt_achievement[7][MAX_PLAYERS];
new bool:g_bIsAchievementVisible[MAX_PLAYERS];

//------------------------------------------------------------------------------

GetPlayerAchievements(playerid)
    return _:g_pAchievementData[playerid];

SetPlayerAchievements(playerid, val)
    g_pAchievementData[playerid] = ACHIEVEMENT:val;

//------------------------------------------------------------------------------

/*
	ResetPlayerAchievementData
		Resets all achievement of a player
	params
		playerid - The ID of the player
	return
		This function doesn't return any specific value
*/
ResetPlayerAchievementData(playerid)
{
	g_pAchievementData[playerid]  &= ~ACHIEVEMENT_BLOWJOB;
	g_pAchievementData[playerid]  &= ~ACHIEVEMENT_LOTTERY;
	g_pAchievementData[playerid]  &= ~ACHIEVEMENT_HOSPITAL;
	g_pAchievementData[playerid]  &= ~ACHIEVEMENT_SECQUEST;
	g_pAchievementData[playerid]  &= ~ACHIEVEMENT_SHOOTINGRANGE;
}

/*
	SetPlayerAchievement
		Sets an achievement for a player
	params
		playerid	- The ID of the player
		achievement - The ID of the achievement
		stat		- State of achievement true or false
	return
		This function doesn't return any specific value
*/
SetPlayerAchievement(playerid, ACHIEVEMENT:achievement, bool:stat)
{
	switch(achievement)
	{
		case ACHIEVEMENT_BLOWJOB:
		{
			if(stat)
				g_pAchievementData[playerid] |= ACHIEVEMENT_BLOWJOB;
			else
				g_pAchievementData[playerid] &= ~ACHIEVEMENT_BLOWJOB;
		}
		case ACHIEVEMENT_LOTTERY:
		{
			if(stat)
				g_pAchievementData[playerid] |= ACHIEVEMENT_LOTTERY;
			else
				g_pAchievementData[playerid] &= ~ACHIEVEMENT_LOTTERY;
		}
		case ACHIEVEMENT_HOSPITAL:
		{
			if(stat)
				g_pAchievementData[playerid] |= ACHIEVEMENT_HOSPITAL;
			else
				g_pAchievementData[playerid] &= ~ACHIEVEMENT_HOSPITAL;
		}
		case ACHIEVEMENT_SECQUEST:
		{
			if(stat)
				g_pAchievementData[playerid] |= ACHIEVEMENT_SECQUEST;
			else
				g_pAchievementData[playerid] &= ~ACHIEVEMENT_SECQUEST;
		}
		case ACHIEVEMENT_SHOOTINGRANGE:
		{
			if(stat)
				g_pAchievementData[playerid] |= ACHIEVEMENT_SHOOTINGRANGE;
			else
				g_pAchievementData[playerid] &= ~ACHIEVEMENT_SHOOTINGRANGE;
		}
	}
	if(stat == true)
		ShowPlayerAchievement(playerid, achievement);
}

/*
	GetPlayerAchievement
		Sets an achievement for a player
	params
		playerid	- The ID of the player
		achievement - The ID of the achievement
	return
		The state of the achievement (true or false)
*/
GetPlayerAchievement(playerid, ACHIEVEMENT:achievement)
{
	switch(achievement)
	{
		case ACHIEVEMENT_BLOWJOB:
			if(g_pAchievementData[playerid] & ACHIEVEMENT_BLOWJOB)
				return true;
		case ACHIEVEMENT_LOTTERY:
			if(g_pAchievementData[playerid] & ACHIEVEMENT_LOTTERY)
				return true;
		case ACHIEVEMENT_HOSPITAL:
			if(g_pAchievementData[playerid] & ACHIEVEMENT_HOSPITAL)
				return true;
		case ACHIEVEMENT_SECQUEST:
			if(g_pAchievementData[playerid] & ACHIEVEMENT_SECQUEST)
				return true;
		case ACHIEVEMENT_SHOOTINGRANGE:
			if(g_pAchievementData[playerid] & ACHIEVEMENT_SHOOTINGRANGE)
				return true;
	}
	return false;
}

/*
	ShowPlayerAchievement
		Shows achievement textdraw for a player
	params
		playerid	- The ID of the player
		achievement - The ID of the achievement
	return
		This function doesn't return any specific value
*/
ShowPlayerAchievement(playerid, ACHIEVEMENT:achievement)
{
	if(!g_bIsAchievementVisible[playerid])
	{
		g_pt_achievement[0][playerid] = CreatePlayerTextDraw(playerid, 476.000000, 114.744438, "usebox");
		PlayerTextDrawLetterSize(playerid, g_pt_achievement[0][playerid], 0.000000, 15.861112);
		PlayerTextDrawTextSize(playerid, g_pt_achievement[0][playerid], 183.666671, 0.000000);
		PlayerTextDrawAlignment(playerid, g_pt_achievement[0][playerid], 1);
		PlayerTextDrawColor(playerid, g_pt_achievement[0][playerid], 0);
		PlayerTextDrawUseBox(playerid, g_pt_achievement[0][playerid], true);
		PlayerTextDrawBoxColor(playerid, g_pt_achievement[0][playerid], 102);
		PlayerTextDrawSetShadow(playerid, g_pt_achievement[0][playerid], 0);
		PlayerTextDrawSetOutline(playerid, g_pt_achievement[0][playerid], 0);
		PlayerTextDrawFont(playerid, g_pt_achievement[0][playerid], 0);

		g_pt_achievement[1][playerid] = CreatePlayerTextDraw(playerid, 348.999969, 122.785186, "ld_drv:ribb");
		PlayerTextDrawLetterSize(playerid, g_pt_achievement[1][playerid], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, g_pt_achievement[1][playerid], 47.000000, 37.748153);
		PlayerTextDrawAlignment(playerid, g_pt_achievement[1][playerid], 1);
		PlayerTextDrawColor(playerid, g_pt_achievement[1][playerid], -1);
		PlayerTextDrawSetShadow(playerid, g_pt_achievement[1][playerid], 0);
		PlayerTextDrawSetOutline(playerid, g_pt_achievement[1][playerid], 0);
		PlayerTextDrawFont(playerid, g_pt_achievement[1][playerid], 4);

		g_pt_achievement[2][playerid] = CreatePlayerTextDraw(playerid, 313.666687, 122.785186, "ld_drv:ribb");
		PlayerTextDrawLetterSize(playerid, g_pt_achievement[2][playerid], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, g_pt_achievement[2][playerid], -47.000000, 37.748153);
		PlayerTextDrawAlignment(playerid, g_pt_achievement[2][playerid], 1);
		PlayerTextDrawColor(playerid, g_pt_achievement[2][playerid], -1);
		PlayerTextDrawSetShadow(playerid, g_pt_achievement[2][playerid], 0);
		PlayerTextDrawSetOutline(playerid, g_pt_achievement[2][playerid], 0);
		PlayerTextDrawFont(playerid, g_pt_achievement[2][playerid], 4);

		g_pt_achievement[3][playerid] = CreatePlayerTextDraw(playerid, 299.000000, 112.829635, "ld_drv:nawtxt");
		PlayerTextDrawLetterSize(playerid, g_pt_achievement[3][playerid], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, g_pt_achievement[3][playerid], 63.666656, 55.170364);
		PlayerTextDrawAlignment(playerid, g_pt_achievement[3][playerid], 1);
		PlayerTextDrawColor(playerid, g_pt_achievement[3][playerid], -1);
		PlayerTextDrawSetShadow(playerid, g_pt_achievement[3][playerid], 0);
		PlayerTextDrawSetOutline(playerid, g_pt_achievement[3][playerid], 0);
		PlayerTextDrawFont(playerid, g_pt_achievement[3][playerid], 4);

		g_pt_achievement[4][playerid] = CreatePlayerTextDraw(playerid, 299.333312, 175.881530, "Parabens!");
		PlayerTextDrawLetterSize(playerid, g_pt_achievement[4][playerid], 0.449999, 1.600000);
		PlayerTextDrawAlignment(playerid, g_pt_achievement[4][playerid], 1);
		PlayerTextDrawColor(playerid, g_pt_achievement[4][playerid], -1);
		PlayerTextDrawSetShadow(playerid, g_pt_achievement[4][playerid], 0);
		PlayerTextDrawSetOutline(playerid, g_pt_achievement[4][playerid], 1);
		PlayerTextDrawBackgroundColor(playerid, g_pt_achievement[4][playerid], 51);
		PlayerTextDrawFont(playerid, g_pt_achievement[4][playerid], 1);
		PlayerTextDrawSetProportional(playerid, g_pt_achievement[4][playerid], 1);

		g_pt_achievement[5][playerid] = CreatePlayerTextDraw(playerid, 242.666641, 201.185195, "Voce recebeu a conquista:~n~                Teste.");
		PlayerTextDrawLetterSize(playerid, g_pt_achievement[5][playerid], 0.305000, 1.413333);
		PlayerTextDrawAlignment(playerid, g_pt_achievement[5][playerid], 1);
		PlayerTextDrawColor(playerid, g_pt_achievement[5][playerid], -1);
		PlayerTextDrawSetShadow(playerid, g_pt_achievement[5][playerid], 0);
		PlayerTextDrawSetOutline(playerid, g_pt_achievement[5][playerid], 1);
		PlayerTextDrawBackgroundColor(playerid, g_pt_achievement[5][playerid], 51);
		PlayerTextDrawFont(playerid, g_pt_achievement[5][playerid], 2);
		PlayerTextDrawSetProportional(playerid, g_pt_achievement[5][playerid], 1);

		g_pt_achievement[6][playerid] = CreatePlayerTextDraw(playerid, 460.666748, 112.414817, "ld_chat:thumbdn");
		PlayerTextDrawLetterSize(playerid, g_pt_achievement[6][playerid], 0.000000, 0.000000);
		PlayerTextDrawTextSize(playerid, g_pt_achievement[6][playerid], 13.333343, 14.103698);
		PlayerTextDrawAlignment(playerid, g_pt_achievement[6][playerid], 1);
		PlayerTextDrawColor(playerid, g_pt_achievement[6][playerid], -1);
		PlayerTextDrawSetShadow(playerid, g_pt_achievement[6][playerid], 0);
		PlayerTextDrawSetOutline(playerid, g_pt_achievement[6][playerid], 0);
		PlayerTextDrawFont(playerid, g_pt_achievement[6][playerid], 4);
		PlayerTextDrawSetSelectable(playerid, g_pt_achievement[6][playerid], true);

		for(new i = 0; i < sizeof(g_pt_achievement); i++)
			PlayerTextDrawShow(playerid, g_pt_achievement[i][playerid]);

		SelectTextDraw(playerid, 0xC7E9FFAA);

		g_bIsAchievementVisible[playerid] = true;
	}
	switch(achievement)
	{
		case ACHIEVEMENT_BLOWJOB:
			PlayerTextDrawSetString(playerid, g_pt_achievement[5][playerid], "Voce recebeu a conquista:~n~   Boquinha de veludo.");
		case ACHIEVEMENT_LOTTERY:
			PlayerTextDrawSetString(playerid, g_pt_achievement[5][playerid], "Voce recebeu a conquista:~n~              Sortudo.");
		case ACHIEVEMENT_HOSPITAL:
			PlayerTextDrawSetString(playerid, g_pt_achievement[5][playerid], "Voce recebeu a conquista:~n~     Cuidados Medicos.");
		case ACHIEVEMENT_SECQUEST:
			PlayerTextDrawSetString(playerid, g_pt_achievement[5][playerid], "Voce recebeu a conquista:~n~   Ajudando o proximo.");
		case ACHIEVEMENT_SHOOTINGRANGE:
			PlayerTextDrawSetString(playerid, g_pt_achievement[5][playerid], "Voce recebeu a conquista:~n~       Bom no gatilho.");
	}
	PlayerPlaySound(playerid, 5203, 0.0, 0.0, 0.0);
}

/*
	HidePlayerAchievement
		Hides achievement textdraw for a player
	params
		playerid	- The ID of the player
	return
		This function doesn't return any specific value
*/
HidePlayerAchievement(playerid)
{
	if(g_bIsAchievementVisible[playerid])
	{
		for(new i = 0; i < sizeof(g_pt_achievement); i++)
		{
			PlayerTextDrawDestroy(playerid, g_pt_achievement[i][playerid]);
			g_bIsAchievementVisible[playerid] = false;
		}
	}
}

/*
	HandleAchievementTextdrawClick
		Called when a player clicks a playertextdraw
	params
		playerid   		- The ID of the player
		playertextid	- The ID of the textdraw
	return
		This function doesn't specific values
*/
hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
	if(playertextid == g_pt_achievement[6][playerid])
	{
		HidePlayerAchievement(playerid);
		CancelSelectTextDraw(playerid);
		PlayCancelSound(playerid);
	}
	return 1;
}

//------------------------------------------------------------------------------

/*
	OnPlayerConnect
		Called when a player connects to the server
	params
		playerid - The ID of the player
	return
		This function doesn't specific values
*/
hook OnPlayerConnect(playerid)
{
	ResetPlayerAchievementData(playerid);
}

/*
	OnPlayerDisconnect
		Called when a player connects to the server
	params
		playerid - The ID of the player
		reason   - Reason the player disconnected from the server
	return
		This function doesn't specific values
*/
hook OnPlayerDisconnect(playerid, reason)
{
	g_bIsAchievementVisible[playerid] = false;
}

/*
	OnPlayerClickTextDraw
		Called when a player clicks a textdraw
	params
		playerid    - The ID of the player
		clickedid   - The ID of the textdraw
	return
		This function doesn't specific values
*/
hook OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(_:clickedid == INVALID_TEXT_DRAW && g_bIsAchievementVisible[playerid])
	{
		HidePlayerAchievement(playerid);
		CancelSelectTextDraw(playerid);
		PlayCancelSound(playerid);
	}
	return 1;
}
