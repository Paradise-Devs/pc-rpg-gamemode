/*******************************************************************************
* FILENAME :        modules/visual/stats.pwn
*
* DESCRIPTION :
*       Create/Destroy and Show player stats GUI functions.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

// Player stats textcolor
enum
{
	PLAYER_STATS_COLOR_BLUE,
	PLAYER_STATS_COLOR_YELLOW,
	PLAYER_STATS_COLOR_GREEN,
	PLAYER_STATS_COLOR_RED,
	PLAYER_STATS_COLOR_PURPLE
}

new playerStatsColor[MAX_PLAYERS];
new PlayerText:gpt_data_hud[32][MAX_PLAYERS];

//--------------------------------------------------------------------

ShowPlayerDataHud(playerid, targetid = INVALID_PLAYER_ID)
{
	if(GetPVarInt(targetid, "isDataHudVisible"))
		return false;

	if(targetid == INVALID_PLAYER_ID)
		targetid = playerid;

	new stats_color[12] = "~b~~h~";
	if(GetPlayerStatsColor(playerid) == PLAYER_STATS_COLOR_YELLOW)
		format(stats_color, sizeof(stats_color), "~y~");
	else if(GetPlayerStatsColor(playerid) == PLAYER_STATS_COLOR_GREEN)
		format(stats_color, sizeof(stats_color), "~g~");
	else if(GetPlayerStatsColor(playerid) == PLAYER_STATS_COLOR_RED)
		format(stats_color, sizeof(stats_color), "~r~");
	else if(GetPlayerStatsColor(playerid) == PLAYER_STATS_COLOR_PURPLE)
		format(stats_color, sizeof(stats_color), "~p~");

	SetPVarInt(targetid, "isDataHudVisible", true);
	gpt_data_hud[0][targetid] = CreatePlayerTextDraw(targetid, 531.667907, 108.937042, "usebox");
	PlayerTextDrawLetterSize(targetid, gpt_data_hud[0][targetid], 0.000000, 21.655763);
	PlayerTextDrawTextSize(targetid, gpt_data_hud[0][targetid], 146.333526, 0.000000);
	PlayerTextDrawAlignment(targetid, gpt_data_hud[0][targetid], 1);
	PlayerTextDrawColor(targetid, gpt_data_hud[0][targetid], 0);
	PlayerTextDrawUseBox(targetid, gpt_data_hud[0][targetid], true);
	PlayerTextDrawBoxColor(targetid, gpt_data_hud[0][targetid], 102);
	PlayerTextDrawSetShadow(targetid, gpt_data_hud[0][targetid], 0);
	PlayerTextDrawSetOutline(targetid, gpt_data_hud[0][targetid], 0);
	PlayerTextDrawFont(targetid, gpt_data_hud[0][targetid], 0);

	gpt_data_hud[1][targetid] = CreatePlayerTextDraw(targetid, 233.666305, 108.937042, "usebox");
	PlayerTextDrawLetterSize(targetid, gpt_data_hud[1][targetid], 0.000000, 21.622430);
	PlayerTextDrawTextSize(targetid, gpt_data_hud[1][targetid], 146.000213, 0.000000);
	PlayerTextDrawAlignment(targetid, gpt_data_hud[1][targetid], 1);
	PlayerTextDrawColor(targetid, gpt_data_hud[1][targetid], 0);
	PlayerTextDrawUseBox(targetid, gpt_data_hud[1][targetid], true);
	PlayerTextDrawBoxColor(targetid, gpt_data_hud[1][targetid], 102);
	PlayerTextDrawSetShadow(targetid, gpt_data_hud[1][targetid], 0);
	PlayerTextDrawSetOutline(targetid, gpt_data_hud[1][targetid], 0);
	PlayerTextDrawFont(targetid, gpt_data_hud[1][targetid], 0);

	gpt_data_hud[8][targetid] = CreatePlayerTextDraw(targetid, 233.666625, 108.937057, "usebox");
	PlayerTextDrawLetterSize(targetid, gpt_data_hud[8][targetid], 0.000000, 1.463167);
	PlayerTextDrawTextSize(targetid, gpt_data_hud[8][targetid], 528.999694, 0.000000);
	PlayerTextDrawAlignment(targetid, gpt_data_hud[8][targetid], 1);
	PlayerTextDrawColor(targetid, gpt_data_hud[8][targetid], 0);
	PlayerTextDrawUseBox(targetid, gpt_data_hud[8][targetid], true);
	PlayerTextDrawBoxColor(targetid, gpt_data_hud[8][targetid], 102);
	PlayerTextDrawSetShadow(targetid, gpt_data_hud[8][targetid], 0);
	PlayerTextDrawSetOutline(targetid, gpt_data_hud[8][targetid], 0);
	PlayerTextDrawFont(targetid, gpt_data_hud[8][targetid], 0);

	new string[64];
	format(string, sizeof(string), "Nome: %s%s", stats_color, GetPlayerFirstName(playerid));
	gpt_data_hud[3][targetid] = CreatePlayerTextDraw(targetid, 232.999923, 107.437034, string);
	PlayerTextDrawLetterSize(targetid, gpt_data_hud[3][targetid], 0.219999, 1.419999);
	PlayerTextDrawAlignment(targetid, gpt_data_hud[3][targetid], 1);
	PlayerTextDrawColor(targetid, gpt_data_hud[3][targetid], -1);
	PlayerTextDrawSetShadow(targetid, gpt_data_hud[3][targetid], 0);
	PlayerTextDrawSetOutline(targetid, gpt_data_hud[3][targetid], 1);
	PlayerTextDrawBackgroundColor(targetid, gpt_data_hud[3][targetid], 51);
	PlayerTextDrawFont(targetid, gpt_data_hud[3][targetid], 2);
	PlayerTextDrawSetProportional(targetid, gpt_data_hud[3][targetid], 1);

	format(string, sizeof(string), "Sobrenome: %s%s", stats_color, GetPlayerLastName(playerid));
	gpt_data_hud[4][targetid] = CreatePlayerTextDraw(targetid, 368.000122, 107.851852, string);
	PlayerTextDrawLetterSize(targetid, gpt_data_hud[4][targetid], 0.219999, 1.419999);
	PlayerTextDrawAlignment(targetid, gpt_data_hud[4][targetid], 1);
	PlayerTextDrawColor(targetid, gpt_data_hud[4][targetid], -1);
	PlayerTextDrawSetShadow(targetid, gpt_data_hud[4][targetid], 0);
	PlayerTextDrawSetOutline(targetid, gpt_data_hud[4][targetid], 1);
	PlayerTextDrawBackgroundColor(targetid, gpt_data_hud[4][targetid], 51);
	PlayerTextDrawFont(targetid, gpt_data_hud[4][targetid], 2);
	PlayerTextDrawSetProportional(targetid, gpt_data_hud[4][targetid], 1);

	format(string, sizeof(string), "Conta: %s%s", stats_color, GetPlayerRankName(playerid));
	gpt_data_hud[5][targetid] = CreatePlayerTextDraw(targetid, 232.999923, 121.540756, string);
	PlayerTextDrawLetterSize(targetid, gpt_data_hud[5][targetid], 0.184999, 1.391703);
	PlayerTextDrawAlignment(targetid, gpt_data_hud[5][targetid], 1);
	PlayerTextDrawColor(targetid, gpt_data_hud[5][targetid], -1);
	PlayerTextDrawSetShadow(targetid, gpt_data_hud[5][targetid], 0);
	PlayerTextDrawSetOutline(targetid, gpt_data_hud[5][targetid], 1);
	PlayerTextDrawBackgroundColor(targetid, gpt_data_hud[5][targetid], 51);
	PlayerTextDrawFont(targetid, gpt_data_hud[5][targetid], 2);
	PlayerTextDrawSetProportional(targetid, gpt_data_hud[5][targetid], 1);

	format(string, sizeof(string), "Nivel: %s%d", stats_color, GetPlayerLevel(playerid));
	gpt_data_hud[6][targetid] = CreatePlayerTextDraw(targetid, 232.999923, 135.644393, string);
	PlayerTextDrawLetterSize(targetid, gpt_data_hud[6][targetid], 0.184900, 1.391700);
	PlayerTextDrawAlignment(targetid, gpt_data_hud[6][targetid], 1);
	PlayerTextDrawColor(targetid, gpt_data_hud[6][targetid], -1);
	PlayerTextDrawSetShadow(targetid, gpt_data_hud[6][targetid], 0);
	PlayerTextDrawSetOutline(targetid, gpt_data_hud[6][targetid], 1);
	PlayerTextDrawBackgroundColor(targetid, gpt_data_hud[6][targetid], 51);
	PlayerTextDrawFont(targetid, gpt_data_hud[6][targetid], 2);
	PlayerTextDrawSetProportional(targetid, gpt_data_hud[6][targetid], 1);

	format(string, sizeof(string), "Exp.: %s%d/%d", stats_color, GetPlayerXP(playerid), GetPlayerRequiredXP(playerid));
	gpt_data_hud[7][targetid] = CreatePlayerTextDraw(targetid, 232.999923, 151.407379, string);
	PlayerTextDrawLetterSize(targetid, gpt_data_hud[7][targetid], 0.184900, 1.391700);
	PlayerTextDrawAlignment(targetid, gpt_data_hud[7][targetid], 1);
	PlayerTextDrawColor(targetid, gpt_data_hud[7][targetid], -1);
	PlayerTextDrawSetShadow(targetid, gpt_data_hud[7][targetid], 0);
	PlayerTextDrawSetOutline(targetid, gpt_data_hud[7][targetid], 1);
	PlayerTextDrawBackgroundColor(targetid, gpt_data_hud[7][targetid], 51);
	PlayerTextDrawFont(targetid, gpt_data_hud[7][targetid], 2);
	PlayerTextDrawSetProportional(targetid, gpt_data_hud[7][targetid], 1);

	format(string, sizeof(string), "Dinheiro: %s$%s", stats_color, formatnumber(GetPlayerCash(playerid)));
	gpt_data_hud[9][targetid] = CreatePlayerTextDraw(targetid, 232.999923, 165.511108, string);
	PlayerTextDrawLetterSize(targetid, gpt_data_hud[9][targetid], 0.180233, 1.346070);
	PlayerTextDrawAlignment(targetid, gpt_data_hud[9][targetid], 1);
	PlayerTextDrawColor(targetid, gpt_data_hud[9][targetid], -1);
	PlayerTextDrawSetShadow(targetid, gpt_data_hud[9][targetid], 0);
	PlayerTextDrawSetOutline(targetid, gpt_data_hud[9][targetid], 1);
	PlayerTextDrawBackgroundColor(targetid, gpt_data_hud[9][targetid], 51);
	PlayerTextDrawFont(targetid, gpt_data_hud[9][targetid], 2);
	PlayerTextDrawSetProportional(targetid, gpt_data_hud[9][targetid], 1);

	format(string, sizeof(string), "Banco: %s$%s", stats_color, formatnumber(GetPlayerBankCash(playerid)));
	gpt_data_hud[10][targetid] = CreatePlayerTextDraw(targetid, 232.999923, 179.614929, string);
	PlayerTextDrawLetterSize(targetid, gpt_data_hud[10][targetid], 0.184900, 1.391700);
	PlayerTextDrawAlignment(targetid, gpt_data_hud[10][targetid], 1);
	PlayerTextDrawColor(targetid, gpt_data_hud[10][targetid], -1);
	PlayerTextDrawSetShadow(targetid, gpt_data_hud[10][targetid], 0);
	PlayerTextDrawSetOutline(targetid, gpt_data_hud[10][targetid], 1);
	PlayerTextDrawBackgroundColor(targetid, gpt_data_hud[10][targetid], 51);
	PlayerTextDrawFont(targetid, gpt_data_hud[10][targetid], 2);
	PlayerTextDrawSetProportional(targetid, gpt_data_hud[10][targetid], 1);

	new phoneNumber[16] = "N/A";
	if(GetPlayerPhoneNumber(playerid))
		format(phoneNumber, sizeof(phoneNumber), "%d", GetPlayerPhoneNumber(playerid));

	format(string, sizeof(string), "Tel.: %s%s", stats_color, phoneNumber);
	gpt_data_hud[11][targetid] = CreatePlayerTextDraw(targetid, 232.999923, 194.962921, string);
	PlayerTextDrawLetterSize(targetid, gpt_data_hud[11][targetid], 0.184900, 1.391700);
	PlayerTextDrawAlignment(targetid, gpt_data_hud[11][targetid], 1);
	PlayerTextDrawColor(targetid, gpt_data_hud[11][targetid], -1);
	PlayerTextDrawSetShadow(targetid, gpt_data_hud[11][targetid], 0);
	PlayerTextDrawSetOutline(targetid, gpt_data_hud[11][targetid], 1);
	PlayerTextDrawBackgroundColor(targetid, gpt_data_hud[11][targetid], 51);
	PlayerTextDrawFont(targetid, gpt_data_hud[11][targetid], 2);
	PlayerTextDrawSetProportional(targetid, gpt_data_hud[11][targetid], 1);

	new	phoneNetworkName[32] = "N/A";
	if(GetPlayerPhoneNumber(playerid))
		format(phoneNetworkName, sizeof(phoneNetworkName), GetBusinessName(GetPlayerPhoneNetwork(playerid)));

	format(string, sizeof(string), "Oper.: %s%s", stats_color, phoneNetworkName);
	gpt_data_hud[12][targetid] = CreatePlayerTextDraw(targetid, 232.999923, 208.651840, string);
	PlayerTextDrawLetterSize(targetid, gpt_data_hud[12][targetid], 0.184900, 1.391700);
	PlayerTextDrawAlignment(targetid, gpt_data_hud[12][targetid], 1);
	PlayerTextDrawColor(targetid, gpt_data_hud[12][targetid], -1);
	PlayerTextDrawSetShadow(targetid, gpt_data_hud[12][targetid], 0);
	PlayerTextDrawSetOutline(targetid, gpt_data_hud[12][targetid], 1);
	PlayerTextDrawBackgroundColor(targetid, gpt_data_hud[12][targetid], 51);
	PlayerTextDrawFont(targetid, gpt_data_hud[12][targetid], 2);
	PlayerTextDrawSetProportional(targetid, gpt_data_hud[12][targetid], 1);

	format(string, sizeof(string), "Conta Banc.: %s%s", stats_color, formatnumber(GetPlayerBankAccount(playerid)));
	gpt_data_hud[13][targetid] = CreatePlayerTextDraw(targetid, 232.999923, 223.170364, string);
	PlayerTextDrawLetterSize(targetid, gpt_data_hud[13][targetid], 0.180566, 1.346070);
	PlayerTextDrawAlignment(targetid, gpt_data_hud[13][targetid], 1);
	PlayerTextDrawColor(targetid, gpt_data_hud[13][targetid], -1);
	PlayerTextDrawSetShadow(targetid, gpt_data_hud[13][targetid], 0);
	PlayerTextDrawSetOutline(targetid, gpt_data_hud[13][targetid], 1);
	PlayerTextDrawBackgroundColor(targetid, gpt_data_hud[13][targetid], 51);
	PlayerTextDrawFont(targetid, gpt_data_hud[13][targetid], 2);
	PlayerTextDrawSetProportional(targetid, gpt_data_hud[13][targetid], 1);

	format(string, sizeof(string), "Emprego: %s%s", stats_color, ConvertToGameText(GetJobName(GetPlayerJobID(playerid), true)));
	gpt_data_hud[14][targetid] = CreatePlayerTextDraw(targetid, 368.000122, 121.540733, string);
	PlayerTextDrawLetterSize(targetid, gpt_data_hud[14][targetid], 0.184900, 1.391700);
	PlayerTextDrawAlignment(targetid, gpt_data_hud[14][targetid], 1);
	PlayerTextDrawColor(targetid, gpt_data_hud[14][targetid], -1);
	PlayerTextDrawSetShadow(targetid, gpt_data_hud[14][targetid], 0);
	PlayerTextDrawSetOutline(targetid, gpt_data_hud[14][targetid], 1);
	PlayerTextDrawBackgroundColor(targetid, gpt_data_hud[14][targetid], 51);
	PlayerTextDrawFont(targetid, gpt_data_hud[14][targetid], 2);
	PlayerTextDrawSetProportional(targetid, gpt_data_hud[14][targetid], 1);

	new jobNvl[8] = "N/A";
	if(GetPlayerJobID(playerid) != INVALID_JOB_ID)
		format(jobNvl, sizeof(jobNvl), "%d", GetPlayerJobLV(playerid));

	format(string, sizeof(string), "Nvl. Emprego: %s%s", stats_color, jobNvl);
	gpt_data_hud[15][targetid] = CreatePlayerTextDraw(targetid, 367.999938, 134.400009, string);
	PlayerTextDrawLetterSize(targetid, gpt_data_hud[15][targetid], 0.184900, 1.391700);
	PlayerTextDrawAlignment(targetid, gpt_data_hud[15][targetid], 1);
	PlayerTextDrawColor(targetid, gpt_data_hud[15][targetid], -1);
	PlayerTextDrawSetShadow(targetid, gpt_data_hud[15][targetid], 0);
	PlayerTextDrawSetOutline(targetid, gpt_data_hud[15][targetid], 1);
	PlayerTextDrawBackgroundColor(targetid, gpt_data_hud[15][targetid], 51);
	PlayerTextDrawFont(targetid, gpt_data_hud[15][targetid], 2);
	PlayerTextDrawSetProportional(targetid, gpt_data_hud[15][targetid], 1);

	new jobXP[32] = "N/A";
	if(GetPlayerJobID(playerid) != INVALID_JOB_ID)
		format(jobXP, sizeof(jobXP), "%d/%d", GetPlayerJobXP(playerid), GetPlayerJobRequiredXP(playerid));

	format(string, sizeof(string), "XP. Emprego: %s%s", stats_color, jobXP);
	gpt_data_hud[16][targetid] = CreatePlayerTextDraw(targetid, 367.666717, 148.503707, string);
	PlayerTextDrawLetterSize(targetid, gpt_data_hud[16][targetid], 0.162566, 1.437329);
	PlayerTextDrawAlignment(targetid, gpt_data_hud[16][targetid], 1);
	PlayerTextDrawColor(targetid, gpt_data_hud[16][targetid], -1);
	PlayerTextDrawSetShadow(targetid, gpt_data_hud[16][targetid], 0);
	PlayerTextDrawSetOutline(targetid, gpt_data_hud[16][targetid], 1);
	PlayerTextDrawBackgroundColor(targetid, gpt_data_hud[16][targetid], 51);
	PlayerTextDrawFont(targetid, gpt_data_hud[16][targetid], 2);
	PlayerTextDrawSetProportional(targetid, gpt_data_hud[16][targetid], 1);

	format(string, sizeof(string), "Org.: %s%s", stats_color, ConvertToGameText(GetFactionName(GetPlayerFactionID(playerid))));
	gpt_data_hud[17][targetid] = CreatePlayerTextDraw(targetid, 367.333374, 163.851837, string);
	PlayerTextDrawLetterSize(targetid, gpt_data_hud[17][targetid], 0.184900, 1.391700);
	PlayerTextDrawAlignment(targetid, gpt_data_hud[17][targetid], 1);
	PlayerTextDrawColor(targetid, gpt_data_hud[17][targetid], -1);
	PlayerTextDrawSetShadow(targetid, gpt_data_hud[17][targetid], 0);
	PlayerTextDrawSetOutline(targetid, gpt_data_hud[17][targetid], 1);
	PlayerTextDrawBackgroundColor(targetid, gpt_data_hud[17][targetid], 51);
	PlayerTextDrawFont(targetid, gpt_data_hud[17][targetid], 2);
	PlayerTextDrawSetProportional(targetid, gpt_data_hud[17][targetid], 1);

	format(string, sizeof(string), "Cargo: %s%s", stats_color, ConvertToGameText(GetFactionRankName(GetPlayerFactionID(playerid), GetPlayerFactionRankID(playerid))));
	gpt_data_hud[18][targetid] = CreatePlayerTextDraw(targetid, 366.999847, 178.785217, string);
	PlayerTextDrawLetterSize(targetid, gpt_data_hud[18][targetid], 0.184900, 1.391700);
	PlayerTextDrawAlignment(targetid, gpt_data_hud[18][targetid], 1);
	PlayerTextDrawColor(targetid, gpt_data_hud[18][targetid], -1);
	PlayerTextDrawSetShadow(targetid, gpt_data_hud[18][targetid], 0);
	PlayerTextDrawSetOutline(targetid, gpt_data_hud[18][targetid], 1);
	PlayerTextDrawBackgroundColor(targetid, gpt_data_hud[18][targetid], 51);
	PlayerTextDrawFont(targetid, gpt_data_hud[18][targetid], 2);
	PlayerTextDrawSetProportional(targetid, gpt_data_hud[18][targetid], 1);

	new house_str[4] = "Nao";
	if(GetPlayerHouseID(playerid) != INVALID_HOUSE_ID)
		house_str = "Sim";

	format(string, sizeof(string), "Casa: %s%s", stats_color, house_str);
	gpt_data_hud[19][targetid] = CreatePlayerTextDraw(targetid, 367.000000, 193.718505, string);
	PlayerTextDrawLetterSize(targetid, gpt_data_hud[19][targetid], 0.184900, 1.391700);
	PlayerTextDrawAlignment(targetid, gpt_data_hud[19][targetid], 1);
	PlayerTextDrawColor(targetid, gpt_data_hud[19][targetid], -1);
	PlayerTextDrawSetShadow(targetid, gpt_data_hud[19][targetid], 0);
	PlayerTextDrawSetOutline(targetid, gpt_data_hud[19][targetid], 1);
	PlayerTextDrawBackgroundColor(targetid, gpt_data_hud[19][targetid], 51);
	PlayerTextDrawFont(targetid, gpt_data_hud[19][targetid], 2);
	PlayerTextDrawSetProportional(targetid, gpt_data_hud[19][targetid], 1);

	new business_str[32] = "Nao";
	if(GetPlayerBusinessID(playerid) != INVALID_BUSINESS_ID)
		format(business_str, sizeof(business_str), "%s", GetBusinessName(GetPlayerBusinessID(playerid)));

	format(string, sizeof(string), "Empresa: %s%s", stats_color, business_str);
	gpt_data_hud[20][targetid] = CreatePlayerTextDraw(targetid, 367.000030, 209.066650, string);
	PlayerTextDrawLetterSize(targetid, gpt_data_hud[20][targetid], 0.184900, 1.391700);
	PlayerTextDrawAlignment(targetid, gpt_data_hud[20][targetid], 1);
	PlayerTextDrawColor(targetid, gpt_data_hud[20][targetid], -1);
	PlayerTextDrawSetShadow(targetid, gpt_data_hud[20][targetid], 0);
	PlayerTextDrawSetOutline(targetid, gpt_data_hud[20][targetid], 1);
	PlayerTextDrawBackgroundColor(targetid, gpt_data_hud[20][targetid], 51);
	PlayerTextDrawFont(targetid, gpt_data_hud[20][targetid], 2);
	PlayerTextDrawSetProportional(targetid, gpt_data_hud[20][targetid], 1);

	new vehicle_count = 0;
	for(new i = 0; i < MAX_VEHICLES_PER_PLAYER; i++)
		if(g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_DBID] != 0)
			vehicle_count++;

	format(string, sizeof(string), "Veiculos: %s%d/%d", stats_color, vehicle_count, MAX_VEHICLES_PER_PLAYER);
	gpt_data_hud[21][targetid] = CreatePlayerTextDraw(targetid, 367.333343, 222.755554, string);
	PlayerTextDrawLetterSize(targetid, gpt_data_hud[21][targetid], 0.184900, 1.391700);
	PlayerTextDrawAlignment(targetid, gpt_data_hud[21][targetid], 1);
	PlayerTextDrawColor(targetid, gpt_data_hud[21][targetid], -1);
	PlayerTextDrawSetShadow(targetid, gpt_data_hud[21][targetid], 0);
	PlayerTextDrawSetOutline(targetid, gpt_data_hud[21][targetid], 1);
	PlayerTextDrawBackgroundColor(targetid, gpt_data_hud[21][targetid], 51);
	PlayerTextDrawFont(targetid, gpt_data_hud[21][targetid], 2);
	PlayerTextDrawSetProportional(targetid, gpt_data_hud[21][targetid], 1);

	format(string, sizeof(string), "Membro desde: %s%s", stats_color, convertTimestamp(GetPlayerRegDataUnix(playerid)));
	gpt_data_hud[22][targetid] = CreatePlayerTextDraw(targetid, 190.333084, 303.644317, string);
	PlayerTextDrawLetterSize(targetid, gpt_data_hud[22][targetid], 0.184900, 1.391700);
	PlayerTextDrawAlignment(targetid, gpt_data_hud[22][targetid], 1);
	PlayerTextDrawColor(targetid, gpt_data_hud[22][targetid], -1);
	PlayerTextDrawSetShadow(targetid, gpt_data_hud[22][targetid], 0);
	PlayerTextDrawSetOutline(targetid, gpt_data_hud[22][targetid], 1);
	PlayerTextDrawBackgroundColor(targetid, gpt_data_hud[22][targetid], 51);
	PlayerTextDrawFont(targetid, gpt_data_hud[22][targetid], 2);
	PlayerTextDrawSetProportional(targetid, gpt_data_hud[22][targetid], 1);

	new lastLogin[32] = "Nunca";
	if(GetPlayerLastLoginUnix(playerid) != 0)
		format(lastLogin, 32, "%s", convertTimestamp(GetPlayerLastLoginUnix(playerid)));

	format(string, sizeof(string), "Ultimo Login: %s%s", stats_color, lastLogin);
	gpt_data_hud[23][targetid] = CreatePlayerTextDraw(targetid, 355.999969, 303.229583, string);
	PlayerTextDrawLetterSize(targetid, gpt_data_hud[23][targetid], 0.184900, 1.391700);
	PlayerTextDrawAlignment(targetid, gpt_data_hud[23][targetid], 1);
	PlayerTextDrawColor(targetid, gpt_data_hud[23][targetid], -1);
	PlayerTextDrawSetShadow(targetid, gpt_data_hud[23][targetid], 0);
	PlayerTextDrawSetOutline(targetid, gpt_data_hud[23][targetid], 1);
	PlayerTextDrawBackgroundColor(targetid, gpt_data_hud[23][targetid], 51);
	PlayerTextDrawFont(targetid, gpt_data_hud[23][targetid], 2);
	PlayerTextDrawSetProportional(targetid, gpt_data_hud[23][targetid], 1);

	format(string, sizeof(string), "Tempo Jogado: %s%s", stats_color, GetPlayerPlayedTimeStamp(playerid));
	gpt_data_hud[24][targetid] = CreatePlayerTextDraw(targetid, 280.333343, 95.822250, string);// 364
	PlayerTextDrawLetterSize(targetid, gpt_data_hud[24][targetid], 0.184900, 1.391700);
	PlayerTextDrawAlignment(targetid, gpt_data_hud[24][targetid], 1);
	PlayerTextDrawColor(targetid, gpt_data_hud[24][targetid], -1);
	PlayerTextDrawSetShadow(targetid, gpt_data_hud[24][targetid], 0);
	PlayerTextDrawSetOutline(targetid, gpt_data_hud[24][targetid], 1);
	PlayerTextDrawBackgroundColor(targetid, gpt_data_hud[24][targetid], 51);
	PlayerTextDrawFont(targetid, gpt_data_hud[24][targetid], 2);
	PlayerTextDrawSetProportional(targetid, gpt_data_hud[24][targetid], 1);

	gpt_data_hud[25][targetid] = CreatePlayerTextDraw(targetid, 514.333312, 107.022224, "ld_chat:thumbdn");
	PlayerTextDrawLetterSize(targetid, gpt_data_hud[25][targetid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(targetid, gpt_data_hud[25][targetid], 15.666687, 14.103698);
	PlayerTextDrawAlignment(targetid, gpt_data_hud[25][targetid], 1);
	PlayerTextDrawColor(targetid, gpt_data_hud[25][targetid], -1);
	PlayerTextDrawSetShadow(targetid, gpt_data_hud[25][targetid], 0);
	PlayerTextDrawSetOutline(targetid, gpt_data_hud[25][targetid], 0);
	PlayerTextDrawFont(targetid, gpt_data_hud[25][targetid], 4);
	PlayerTextDrawSetSelectable(targetid, gpt_data_hud[25][targetid], true);

	gpt_data_hud[26][targetid] = CreatePlayerTextDraw(targetid, 85.000000, 95.000000, "PlayerSkinModel");
	PlayerTextDrawBackgroundColor(targetid, gpt_data_hud[26][targetid], 0x00000000);
	PlayerTextDrawFont(targetid, gpt_data_hud[26][targetid], 5);
	PlayerTextDrawLetterSize(targetid, gpt_data_hud[26][targetid], 0.500000, 1.000000);
	PlayerTextDrawColor(targetid, gpt_data_hud[26][targetid], -1);
	PlayerTextDrawSetOutline(targetid, gpt_data_hud[26][targetid], 0);
	PlayerTextDrawSetProportional(targetid, gpt_data_hud[26][targetid], 1);
	PlayerTextDrawSetShadow(targetid, gpt_data_hud[26][targetid], 1);
	PlayerTextDrawUseBox(targetid, gpt_data_hud[26][targetid], 1);
	PlayerTextDrawBoxColor(targetid, gpt_data_hud[26][targetid], 0x00000000);
	PlayerTextDrawTextSize(targetid, gpt_data_hud[26][targetid], 205.000000, 204.000000);
	PlayerTextDrawSetPreviewModel(targetid, gpt_data_hud[26][targetid], GetPlayerSkin(playerid));

	gpt_data_hud[2][targetid] = CreatePlayerTextDraw(targetid, 141.666625, 86.281486, "Stats");
	PlayerTextDrawLetterSize(targetid, gpt_data_hud[2][targetid], 0.763333, 3.093333);
	PlayerTextDrawAlignment(targetid, gpt_data_hud[2][targetid], 1);
	PlayerTextDrawColor(targetid, gpt_data_hud[2][targetid], -1);
	PlayerTextDrawSetShadow(targetid, gpt_data_hud[2][targetid], -1);
	PlayerTextDrawSetOutline(targetid, gpt_data_hud[2][targetid], 0);
	PlayerTextDrawBackgroundColor(targetid, gpt_data_hud[2][targetid], 51);
	PlayerTextDrawFont(targetid, gpt_data_hud[2][targetid], 0);
	PlayerTextDrawSetProportional(targetid, gpt_data_hud[2][targetid], 1);

	gpt_data_hud[27][targetid] = CreatePlayerTextDraw(targetid, 518.000244, 292.859222, "LD_SPAC:white");// Yellow change color
	PlayerTextDrawLetterSize(targetid, gpt_data_hud[27][targetid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(targetid, gpt_data_hud[27][targetid], 12.000000, 12.000000);
	PlayerTextDrawAlignment(targetid, gpt_data_hud[27][targetid], 1);
	PlayerTextDrawColor(targetid, gpt_data_hud[27][targetid], -65281);
	PlayerTextDrawSetShadow(targetid, gpt_data_hud[27][targetid], 0);
	PlayerTextDrawSetOutline(targetid, gpt_data_hud[27][targetid], 0);
	PlayerTextDrawFont(targetid, gpt_data_hud[27][targetid], 4);
	PlayerTextDrawSetSelectable(targetid, gpt_data_hud[27][targetid], true);

	gpt_data_hud[28][targetid] = CreatePlayerTextDraw(targetid, 518.000244, 280.859222, "LD_SPAC:white");// Blue change color
	PlayerTextDrawLetterSize(targetid, gpt_data_hud[28][targetid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(targetid, gpt_data_hud[28][targetid], 12.000000, 12.000000);
	PlayerTextDrawAlignment(targetid, gpt_data_hud[28][targetid], 1);
	PlayerTextDrawColor(targetid, gpt_data_hud[28][targetid], 0x4099FFFF);
	PlayerTextDrawSetShadow(targetid, gpt_data_hud[28][targetid], 0);
	PlayerTextDrawSetOutline(targetid, gpt_data_hud[28][targetid], 0);
	PlayerTextDrawFont(targetid, gpt_data_hud[28][targetid], 4);
	PlayerTextDrawSetSelectable(targetid, gpt_data_hud[28][targetid], true);

	gpt_data_hud[29][targetid] = CreatePlayerTextDraw(targetid, 518.000244, 268.859222, "LD_SPAC:white");// Green change color
	PlayerTextDrawLetterSize(targetid, gpt_data_hud[29][targetid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(targetid, gpt_data_hud[29][targetid], 12.000000, 12.000000);
	PlayerTextDrawAlignment(targetid, gpt_data_hud[29][targetid], 1);
	PlayerTextDrawColor(targetid, gpt_data_hud[29][targetid], 0x6DC066FF);
	PlayerTextDrawSetShadow(targetid, gpt_data_hud[29][targetid], 0);
	PlayerTextDrawSetOutline(targetid, gpt_data_hud[29][targetid], 0);
	PlayerTextDrawFont(targetid, gpt_data_hud[29][targetid], 4);
	PlayerTextDrawSetSelectable(targetid, gpt_data_hud[29][targetid], true);

	gpt_data_hud[30][targetid] = CreatePlayerTextDraw(targetid, 518.000244, 256.859222, "LD_SPAC:white");// Red change color
	PlayerTextDrawLetterSize(targetid, gpt_data_hud[30][targetid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(targetid, gpt_data_hud[30][targetid], 12.000000, 12.000000);
	PlayerTextDrawAlignment(targetid, gpt_data_hud[30][targetid], 1);
	PlayerTextDrawColor(targetid, gpt_data_hud[30][targetid], 0xCC0000FF);
	PlayerTextDrawSetShadow(targetid, gpt_data_hud[30][targetid], 0);
	PlayerTextDrawSetOutline(targetid, gpt_data_hud[30][targetid], 0);
	PlayerTextDrawFont(targetid, gpt_data_hud[30][targetid], 4);
	PlayerTextDrawSetSelectable(targetid, gpt_data_hud[30][targetid], true);

	gpt_data_hud[31][targetid] = CreatePlayerTextDraw(targetid, 518.000244, 244.859222, "LD_SPAC:white");// Purple change color
	PlayerTextDrawLetterSize(targetid, gpt_data_hud[31][targetid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(targetid, gpt_data_hud[31][targetid], 12.000000, 12.000000);
	PlayerTextDrawAlignment(targetid, gpt_data_hud[31][targetid], 1);
	PlayerTextDrawColor(targetid, gpt_data_hud[31][targetid], 0x7D26CDFF);
	PlayerTextDrawSetShadow(targetid, gpt_data_hud[31][targetid], 0);
	PlayerTextDrawSetOutline(targetid, gpt_data_hud[31][targetid], 0);
	PlayerTextDrawFont(targetid, gpt_data_hud[31][targetid], 4);
	PlayerTextDrawSetSelectable(targetid, gpt_data_hud[31][targetid], true);

	for(new i = 0; i < sizeof(gpt_data_hud); i++)
		PlayerTextDrawShow(targetid, gpt_data_hud[i][targetid]);

	SelectTextDraw(targetid, 0xC7E9FFAA);
	PlaySelectSound(targetid);
	return 1;
}

//--------------------------------------------------------------------

HidePlayerDataHud(playerid)
{
	if(!GetPVarInt(playerid, "isDataHudVisible"))
		return false;

	for(new i = 0; i < sizeof(gpt_data_hud); i++)
		PlayerTextDrawDestroy(playerid, gpt_data_hud[i][playerid]);
	DeletePVar(playerid, "isDataHudVisible");
	CancelSelectTextDraw(playerid);
	PlayCancelSound(playerid);
	return 1;
}

//--------------------------------------------------------------------

SetPlayerStatsColor(playerid, color)
{
	playerStatsColor[playerid] = color;

	if(GetPVarInt(playerid, "isDataHudVisible"))
	{
		new stats_color[12] = "~b~~h~";
		if(GetPlayerStatsColor(playerid) == PLAYER_STATS_COLOR_YELLOW)
			format(stats_color, sizeof(stats_color), "~y~");
		else if(GetPlayerStatsColor(playerid) == PLAYER_STATS_COLOR_GREEN)
			format(stats_color, sizeof(stats_color), "~g~");
		else if(GetPlayerStatsColor(playerid) == PLAYER_STATS_COLOR_RED)
			format(stats_color, sizeof(stats_color), "~r~");
		else if(GetPlayerStatsColor(playerid) == PLAYER_STATS_COLOR_PURPLE)
			format(stats_color, sizeof(stats_color), "~p~");

		new string[64];
		format(string, sizeof(string), "Nome: %s%s", stats_color, GetPlayerFirstName(playerid));
		PlayerTextDrawSetString(playerid, gpt_data_hud[3][playerid], string);

		format(string, sizeof(string), "Sobrenome: %s%s", stats_color, GetPlayerLastName(playerid));
		PlayerTextDrawSetString(playerid, gpt_data_hud[4][playerid], string);

		format(string, sizeof(string), "Conta: %s%s", stats_color, GetPlayerRankName(playerid));
		PlayerTextDrawSetString(playerid, gpt_data_hud[5][playerid], string);

		format(string, sizeof(string), "Nivel: %s%d", stats_color, GetPlayerLevel(playerid));
		PlayerTextDrawSetString(playerid, gpt_data_hud[6][playerid], string);

		format(string, sizeof(string), "Exp.: %s%d/%d", stats_color, GetPlayerXP(playerid), GetPlayerRequiredXP(playerid));
		PlayerTextDrawSetString(playerid, gpt_data_hud[7][playerid], string);

		format(string, sizeof(string), "Dinheiro: %s$%s", stats_color, formatnumber(GetPlayerCash(playerid)));
		PlayerTextDrawSetString(playerid, gpt_data_hud[9][playerid], string);

		format(string, sizeof(string), "Banco: %s$%s", stats_color, formatnumber(GetPlayerBankCash(playerid)));
		PlayerTextDrawSetString(playerid, gpt_data_hud[10][playerid], string);

		new phoneNumber[16] = "N/A";
		if(GetPlayerPhoneNumber(playerid))
			format(phoneNumber, sizeof(phoneNumber), "%d", GetPlayerPhoneNumber(playerid));

		format(string, sizeof(string), "Tel.: %s%s", stats_color, phoneNumber);
		PlayerTextDrawSetString(playerid, gpt_data_hud[11][playerid], string);

		new	phoneNetworkName[32] = "N/A";
		if(GetPlayerPhoneNumber(playerid))
			format(phoneNetworkName, sizeof(phoneNetworkName), GetBusinessName(GetPlayerPhoneNetwork(playerid)));

		format(string, sizeof(string), "Oper.: %s%s", stats_color, phoneNetworkName);
		PlayerTextDrawSetString(playerid, gpt_data_hud[12][playerid], string);

		format(string, sizeof(string), "Conta Banc.: %s%s", stats_color, formatnumber(GetPlayerBankAccount(playerid)));
		PlayerTextDrawSetString(playerid, gpt_data_hud[13][playerid], string);

		format(string, sizeof(string), "Emprego: %s%s", stats_color, GetJobName(GetPlayerJobID(playerid)));
		PlayerTextDrawSetString(playerid, gpt_data_hud[14][playerid], string);

		new jobNvl[8] = "N/A";
		if(GetPlayerJobID(playerid) != INVALID_JOB_ID)
			format(jobNvl, sizeof(jobNvl), "%d", GetPlayerJobLV(playerid));

		format(string, sizeof(string), "Nvl. Emprego: %s%s", stats_color, jobNvl);
		PlayerTextDrawSetString(playerid, gpt_data_hud[15][playerid], string);

		new jobXP[32] = "N/A";
		if(GetPlayerJobID(playerid) != INVALID_JOB_ID)
			format(jobXP, sizeof(jobXP), "%d/%d", GetPlayerJobXP(playerid), GetPlayerJobRequiredXP(playerid));

		format(string, sizeof(string), "XP. Emprego: %s%s", stats_color, jobXP);
		PlayerTextDrawSetString(playerid, gpt_data_hud[16][playerid], string);

		format(string, sizeof(string), "Org.: %s%s", stats_color, GetFactionName(GetPlayerFactionID(playerid)));
		PlayerTextDrawSetString(playerid, gpt_data_hud[17][playerid], string);

		format(string, sizeof(string), "Cargo: %s%s", stats_color, GetFactionRankName(GetPlayerFactionID(playerid), GetPlayerFactionRankID(playerid)));
		PlayerTextDrawSetString(playerid, gpt_data_hud[18][playerid], string);

		new house_str[4] = "Nao";
		if(GetPlayerHouseID(playerid) != INVALID_HOUSE_ID)
			house_str = "Sim";

		format(string, sizeof(string), "Casa: %s%s", stats_color, house_str);
		PlayerTextDrawSetString(playerid, gpt_data_hud[19][playerid], string);

		new business_str[32] = "Nao";
		if(GetPlayerBusinessID(playerid) != INVALID_BUSINESS_ID)
			format(business_str, sizeof(business_str), "%s", GetBusinessName(GetPlayerBusinessID(playerid)));

		format(string, sizeof(string), "Empresa: %s%s", stats_color, business_str);
		PlayerTextDrawSetString(playerid, gpt_data_hud[20][playerid], string);

		new vehicle_count = 0;
		for(new i = 0; i < MAX_VEHICLES_PER_PLAYER; i++)
			if(g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_DBID] != 0)
				vehicle_count++;

		format(string, sizeof(string), "Veiculos: %s%d/%d", stats_color, vehicle_count, MAX_VEHICLES_PER_PLAYER);
		PlayerTextDrawSetString(playerid, gpt_data_hud[21][playerid], string);

		format(string, sizeof(string), "Membro desde: %s%s", stats_color, convertTimestamp(GetPlayerRegDataUnix(playerid)));
		PlayerTextDrawSetString(playerid, gpt_data_hud[22][playerid], string);

		new lastLogin[32] = "Nunca";
		if(GetPlayerLastLoginUnix(playerid) != 0)
			format(lastLogin, 32, "%s", convertTimestamp(GetPlayerLastLoginUnix(playerid)));

		format(string, sizeof(string), "Ultimo Login: %s%s", stats_color, lastLogin);
		PlayerTextDrawSetString(playerid, gpt_data_hud[23][playerid], string);

		format(string, sizeof(string), "Tempo Jogado: %s%s", stats_color, GetPlayerPlayedTimeStamp(playerid));
		PlayerTextDrawSetString(playerid, gpt_data_hud[24][playerid], string);
	}
	return 1;
}

//--------------------------------------------------------------------

GetPlayerStatsColor(playerid)
{
	return playerStatsColor[playerid];
}

//--------------------------------------------------------------------

hook OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(GetPVarInt(playerid, "isDataHudVisible"))
		if(clickedid == Text:INVALID_TEXT_DRAW)
			HidePlayerDataHud(playerid);
	return 1;
}

//--------------------------------------------------------------------

hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
	if(GetPVarInt(playerid, "isDataHudVisible"))
	{
		if(playertextid == gpt_data_hud[25][playerid])
			HidePlayerDataHud(playerid);
		else if(playertextid == gpt_data_hud[27][playerid])
			SetPlayerStatsColor(playerid, PLAYER_STATS_COLOR_YELLOW);
		else if(playertextid == gpt_data_hud[28][playerid])
			SetPlayerStatsColor(playerid, PLAYER_STATS_COLOR_BLUE);
		else if(playertextid == gpt_data_hud[29][playerid])
			SetPlayerStatsColor(playerid, PLAYER_STATS_COLOR_GREEN);
		else if(playertextid == gpt_data_hud[30][playerid])
			SetPlayerStatsColor(playerid, PLAYER_STATS_COLOR_RED);
		else if(playertextid == gpt_data_hud[31][playerid])
			SetPlayerStatsColor(playerid, PLAYER_STATS_COLOR_PURPLE);
	}

	return 0;
}
