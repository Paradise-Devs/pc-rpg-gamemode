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

ShowPlayerDataHud(playerid)
{
	if(GetPVarInt(playerid, "isDataHudVisible"))
		return false;

	new stats_color[12] = "~b~~h~";
	if(GetPlayerStatsColor(playerid) == PLAYER_STATS_COLOR_YELLOW)
		format(stats_color, sizeof(stats_color), "~y~");
	else if(GetPlayerStatsColor(playerid) == PLAYER_STATS_COLOR_GREEN)
		format(stats_color, sizeof(stats_color), "~g~");
	else if(GetPlayerStatsColor(playerid) == PLAYER_STATS_COLOR_RED)
		format(stats_color, sizeof(stats_color), "~r~");
	else if(GetPlayerStatsColor(playerid) == PLAYER_STATS_COLOR_PURPLE)
		format(stats_color, sizeof(stats_color), "~p~");

	SetPVarInt(playerid, "isDataHudVisible", true);
	gpt_data_hud[0][playerid] = CreatePlayerTextDraw(playerid, 531.667907, 108.937042, "usebox");
	PlayerTextDrawLetterSize(playerid, gpt_data_hud[0][playerid], 0.000000, 21.655763);
	PlayerTextDrawTextSize(playerid, gpt_data_hud[0][playerid], 146.333526, 0.000000);
	PlayerTextDrawAlignment(playerid, gpt_data_hud[0][playerid], 1);
	PlayerTextDrawColor(playerid, gpt_data_hud[0][playerid], 0);
	PlayerTextDrawUseBox(playerid, gpt_data_hud[0][playerid], true);
	PlayerTextDrawBoxColor(playerid, gpt_data_hud[0][playerid], 102);
	PlayerTextDrawSetShadow(playerid, gpt_data_hud[0][playerid], 0);
	PlayerTextDrawSetOutline(playerid, gpt_data_hud[0][playerid], 0);
	PlayerTextDrawFont(playerid, gpt_data_hud[0][playerid], 0);

	gpt_data_hud[1][playerid] = CreatePlayerTextDraw(playerid, 233.666305, 108.937042, "usebox");
	PlayerTextDrawLetterSize(playerid, gpt_data_hud[1][playerid], 0.000000, 21.622430);
	PlayerTextDrawTextSize(playerid, gpt_data_hud[1][playerid], 146.000213, 0.000000);
	PlayerTextDrawAlignment(playerid, gpt_data_hud[1][playerid], 1);
	PlayerTextDrawColor(playerid, gpt_data_hud[1][playerid], 0);
	PlayerTextDrawUseBox(playerid, gpt_data_hud[1][playerid], true);
	PlayerTextDrawBoxColor(playerid, gpt_data_hud[1][playerid], 102);
	PlayerTextDrawSetShadow(playerid, gpt_data_hud[1][playerid], 0);
	PlayerTextDrawSetOutline(playerid, gpt_data_hud[1][playerid], 0);
	PlayerTextDrawFont(playerid, gpt_data_hud[1][playerid], 0);

	gpt_data_hud[8][playerid] = CreatePlayerTextDraw(playerid, 233.666625, 108.937057, "usebox");
	PlayerTextDrawLetterSize(playerid, gpt_data_hud[8][playerid], 0.000000, 1.463167);
	PlayerTextDrawTextSize(playerid, gpt_data_hud[8][playerid], 528.999694, 0.000000);
	PlayerTextDrawAlignment(playerid, gpt_data_hud[8][playerid], 1);
	PlayerTextDrawColor(playerid, gpt_data_hud[8][playerid], 0);
	PlayerTextDrawUseBox(playerid, gpt_data_hud[8][playerid], true);
	PlayerTextDrawBoxColor(playerid, gpt_data_hud[8][playerid], 102);
	PlayerTextDrawSetShadow(playerid, gpt_data_hud[8][playerid], 0);
	PlayerTextDrawSetOutline(playerid, gpt_data_hud[8][playerid], 0);
	PlayerTextDrawFont(playerid, gpt_data_hud[8][playerid], 0);

	new string[64];
	format(string, sizeof(string), "Nome: %s%s", stats_color, GetPlayerFirstName(playerid));
	gpt_data_hud[3][playerid] = CreatePlayerTextDraw(playerid, 232.999923, 107.437034, string);
	PlayerTextDrawLetterSize(playerid, gpt_data_hud[3][playerid], 0.219999, 1.419999);
	PlayerTextDrawAlignment(playerid, gpt_data_hud[3][playerid], 1);
	PlayerTextDrawColor(playerid, gpt_data_hud[3][playerid], -1);
	PlayerTextDrawSetShadow(playerid, gpt_data_hud[3][playerid], 0);
	PlayerTextDrawSetOutline(playerid, gpt_data_hud[3][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, gpt_data_hud[3][playerid], 51);
	PlayerTextDrawFont(playerid, gpt_data_hud[3][playerid], 2);
	PlayerTextDrawSetProportional(playerid, gpt_data_hud[3][playerid], 1);

	format(string, sizeof(string), "Sobrenome: %s%s", stats_color, GetPlayerLastName(playerid));
	gpt_data_hud[4][playerid] = CreatePlayerTextDraw(playerid, 368.000122, 107.851852, string);
	PlayerTextDrawLetterSize(playerid, gpt_data_hud[4][playerid], 0.219999, 1.419999);
	PlayerTextDrawAlignment(playerid, gpt_data_hud[4][playerid], 1);
	PlayerTextDrawColor(playerid, gpt_data_hud[4][playerid], -1);
	PlayerTextDrawSetShadow(playerid, gpt_data_hud[4][playerid], 0);
	PlayerTextDrawSetOutline(playerid, gpt_data_hud[4][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, gpt_data_hud[4][playerid], 51);
	PlayerTextDrawFont(playerid, gpt_data_hud[4][playerid], 2);
	PlayerTextDrawSetProportional(playerid, gpt_data_hud[4][playerid], 1);

	format(string, sizeof(string), "Conta: %s%s", stats_color, GetPlayerRankName(playerid));
	gpt_data_hud[5][playerid] = CreatePlayerTextDraw(playerid, 232.999923, 121.540756, string);
	PlayerTextDrawLetterSize(playerid, gpt_data_hud[5][playerid], 0.184999, 1.391703);
	PlayerTextDrawAlignment(playerid, gpt_data_hud[5][playerid], 1);
	PlayerTextDrawColor(playerid, gpt_data_hud[5][playerid], -1);
	PlayerTextDrawSetShadow(playerid, gpt_data_hud[5][playerid], 0);
	PlayerTextDrawSetOutline(playerid, gpt_data_hud[5][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, gpt_data_hud[5][playerid], 51);
	PlayerTextDrawFont(playerid, gpt_data_hud[5][playerid], 2);
	PlayerTextDrawSetProportional(playerid, gpt_data_hud[5][playerid], 1);

	format(string, sizeof(string), "Nivel: %s%d", stats_color, GetPlayerLevel(playerid));
	gpt_data_hud[6][playerid] = CreatePlayerTextDraw(playerid, 232.999923, 135.644393, string);
	PlayerTextDrawLetterSize(playerid, gpt_data_hud[6][playerid], 0.184900, 1.391700);
	PlayerTextDrawAlignment(playerid, gpt_data_hud[6][playerid], 1);
	PlayerTextDrawColor(playerid, gpt_data_hud[6][playerid], -1);
	PlayerTextDrawSetShadow(playerid, gpt_data_hud[6][playerid], 0);
	PlayerTextDrawSetOutline(playerid, gpt_data_hud[6][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, gpt_data_hud[6][playerid], 51);
	PlayerTextDrawFont(playerid, gpt_data_hud[6][playerid], 2);
	PlayerTextDrawSetProportional(playerid, gpt_data_hud[6][playerid], 1);

	format(string, sizeof(string), "Exp.: %s%d/%d", stats_color, GetPlayerXP(playerid), GetPlayerRequiredXP(playerid));
	gpt_data_hud[7][playerid] = CreatePlayerTextDraw(playerid, 232.999923, 151.407379, string);
	PlayerTextDrawLetterSize(playerid, gpt_data_hud[7][playerid], 0.184900, 1.391700);
	PlayerTextDrawAlignment(playerid, gpt_data_hud[7][playerid], 1);
	PlayerTextDrawColor(playerid, gpt_data_hud[7][playerid], -1);
	PlayerTextDrawSetShadow(playerid, gpt_data_hud[7][playerid], 0);
	PlayerTextDrawSetOutline(playerid, gpt_data_hud[7][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, gpt_data_hud[7][playerid], 51);
	PlayerTextDrawFont(playerid, gpt_data_hud[7][playerid], 2);
	PlayerTextDrawSetProportional(playerid, gpt_data_hud[7][playerid], 1);

	format(string, sizeof(string), "Dinheiro: %s$%d", stats_color, GetPlayerCash(playerid));
	gpt_data_hud[9][playerid] = CreatePlayerTextDraw(playerid, 232.999923, 165.511108, string);
	PlayerTextDrawLetterSize(playerid, gpt_data_hud[9][playerid], 0.180233, 1.346070);
	PlayerTextDrawAlignment(playerid, gpt_data_hud[9][playerid], 1);
	PlayerTextDrawColor(playerid, gpt_data_hud[9][playerid], -1);
	PlayerTextDrawSetShadow(playerid, gpt_data_hud[9][playerid], 0);
	PlayerTextDrawSetOutline(playerid, gpt_data_hud[9][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, gpt_data_hud[9][playerid], 51);
	PlayerTextDrawFont(playerid, gpt_data_hud[9][playerid], 2);
	PlayerTextDrawSetProportional(playerid, gpt_data_hud[9][playerid], 1);

	/*format(string, sizeof(string), "Banco: %s$%d", stats_color, GetPlayerBankCash(playerid));
	gpt_data_hud[10][playerid] = CreatePlayerTextDraw(playerid, 232.999923, 179.614929, string);
	PlayerTextDrawLetterSize(playerid, gpt_data_hud[10][playerid], 0.184900, 1.391700);
	PlayerTextDrawAlignment(playerid, gpt_data_hud[10][playerid], 1);
	PlayerTextDrawColor(playerid, gpt_data_hud[10][playerid], -1);
	PlayerTextDrawSetShadow(playerid, gpt_data_hud[10][playerid], 0);
	PlayerTextDrawSetOutline(playerid, gpt_data_hud[10][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, gpt_data_hud[10][playerid], 51);
	PlayerTextDrawFont(playerid, gpt_data_hud[10][playerid], 2);
	PlayerTextDrawSetProportional(playerid, gpt_data_hud[10][playerid], 1);*/

	new phoneNumber[16] = "N/A";
	if(GetPlayerPhoneNumber(playerid))
		format(phoneNumber, sizeof(phoneNumber), "%d", GetPlayerPhoneNumber(playerid));

	format(string, sizeof(string), "Tel.: %s%s", stats_color, phoneNumber);
	gpt_data_hud[11][playerid] = CreatePlayerTextDraw(playerid, 232.999923, 194.962921, string);
	PlayerTextDrawLetterSize(playerid, gpt_data_hud[11][playerid], 0.184900, 1.391700);
	PlayerTextDrawAlignment(playerid, gpt_data_hud[11][playerid], 1);
	PlayerTextDrawColor(playerid, gpt_data_hud[11][playerid], -1);
	PlayerTextDrawSetShadow(playerid, gpt_data_hud[11][playerid], 0);
	PlayerTextDrawSetOutline(playerid, gpt_data_hud[11][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, gpt_data_hud[11][playerid], 51);
	PlayerTextDrawFont(playerid, gpt_data_hud[11][playerid], 2);
	PlayerTextDrawSetProportional(playerid, gpt_data_hud[11][playerid], 1);

	new	phoneNetworkName[32] = "N/A";
	if(GetPlayerPhoneNumber(playerid))
		format(phoneNetworkName, sizeof(phoneNetworkName), GetBusinessName(GetPlayerPhoneNetwork(playerid)));

	format(string, sizeof(string), "Oper.: %s%s", stats_color, phoneNetworkName);
	gpt_data_hud[12][playerid] = CreatePlayerTextDraw(playerid, 232.999923, 208.651840, string);
	PlayerTextDrawLetterSize(playerid, gpt_data_hud[12][playerid], 0.184900, 1.391700);
	PlayerTextDrawAlignment(playerid, gpt_data_hud[12][playerid], 1);
	PlayerTextDrawColor(playerid, gpt_data_hud[12][playerid], -1);
	PlayerTextDrawSetShadow(playerid, gpt_data_hud[12][playerid], 0);
	PlayerTextDrawSetOutline(playerid, gpt_data_hud[12][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, gpt_data_hud[12][playerid], 51);
	PlayerTextDrawFont(playerid, gpt_data_hud[12][playerid], 2);
	PlayerTextDrawSetProportional(playerid, gpt_data_hud[12][playerid], 1);

	/*format(string, sizeof(string), "Nascimento: %s%s", stats_color, gPlayerData[playerid][E_PLAYER_BIRTHDAY]);
	gpt_data_hud[13][playerid] = CreatePlayerTextDraw(playerid, 232.999923, 223.170364, string);
	PlayerTextDrawLetterSize(playerid, gpt_data_hud[13][playerid], 0.180566, 1.346070);
	PlayerTextDrawAlignment(playerid, gpt_data_hud[13][playerid], 1);
	PlayerTextDrawColor(playerid, gpt_data_hud[13][playerid], -1);
	PlayerTextDrawSetShadow(playerid, gpt_data_hud[13][playerid], 0);
	PlayerTextDrawSetOutline(playerid, gpt_data_hud[13][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, gpt_data_hud[13][playerid], 51);
	PlayerTextDrawFont(playerid, gpt_data_hud[13][playerid], 2);
	PlayerTextDrawSetProportional(playerid, gpt_data_hud[13][playerid], 1);*/

	format(string, sizeof(string), "Emprego: %s%s", stats_color, ConvertToGameText(GetJobName(GetPlayerJobID(playerid), true)));
	gpt_data_hud[14][playerid] = CreatePlayerTextDraw(playerid, 368.000122, 121.540733, string);
	PlayerTextDrawLetterSize(playerid, gpt_data_hud[14][playerid], 0.184900, 1.391700);
	PlayerTextDrawAlignment(playerid, gpt_data_hud[14][playerid], 1);
	PlayerTextDrawColor(playerid, gpt_data_hud[14][playerid], -1);
	PlayerTextDrawSetShadow(playerid, gpt_data_hud[14][playerid], 0);
	PlayerTextDrawSetOutline(playerid, gpt_data_hud[14][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, gpt_data_hud[14][playerid], 51);
	PlayerTextDrawFont(playerid, gpt_data_hud[14][playerid], 2);
	PlayerTextDrawSetProportional(playerid, gpt_data_hud[14][playerid], 1);

	new jobNvl[8] = "N/A";
	if(GetPlayerJobID(playerid) != INVALID_JOB_ID)
		format(jobNvl, sizeof(jobNvl), "%d", GetPlayerJobLV(playerid));

	format(string, sizeof(string), "Nvl. Emprego: %s%s", stats_color, jobNvl);
	gpt_data_hud[15][playerid] = CreatePlayerTextDraw(playerid, 367.999938, 134.400009, string);
	PlayerTextDrawLetterSize(playerid, gpt_data_hud[15][playerid], 0.184900, 1.391700);
	PlayerTextDrawAlignment(playerid, gpt_data_hud[15][playerid], 1);
	PlayerTextDrawColor(playerid, gpt_data_hud[15][playerid], -1);
	PlayerTextDrawSetShadow(playerid, gpt_data_hud[15][playerid], 0);
	PlayerTextDrawSetOutline(playerid, gpt_data_hud[15][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, gpt_data_hud[15][playerid], 51);
	PlayerTextDrawFont(playerid, gpt_data_hud[15][playerid], 2);
	PlayerTextDrawSetProportional(playerid, gpt_data_hud[15][playerid], 1);

	new jobXP[32] = "N/A";
	if(GetPlayerJobID(playerid) != INVALID_JOB_ID)
		format(jobXP, sizeof(jobXP), "%d/%d", GetPlayerJobXP(playerid), GetPlayerJobRequiredXP(playerid));

	format(string, sizeof(string), "XP. Emprego: %s%s", stats_color, jobXP);
	gpt_data_hud[16][playerid] = CreatePlayerTextDraw(playerid, 367.666717, 148.503707, string);
	PlayerTextDrawLetterSize(playerid, gpt_data_hud[16][playerid], 0.162566, 1.437329);
	PlayerTextDrawAlignment(playerid, gpt_data_hud[16][playerid], 1);
	PlayerTextDrawColor(playerid, gpt_data_hud[16][playerid], -1);
	PlayerTextDrawSetShadow(playerid, gpt_data_hud[16][playerid], 0);
	PlayerTextDrawSetOutline(playerid, gpt_data_hud[16][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, gpt_data_hud[16][playerid], 51);
	PlayerTextDrawFont(playerid, gpt_data_hud[16][playerid], 2);
	PlayerTextDrawSetProportional(playerid, gpt_data_hud[16][playerid], 1);

	/*format(string, sizeof(string), "Org.: %s%s", stats_color, ConvertToGameText(GetFactionName(GetPlayerFactionID(playerid))));
	gpt_data_hud[17][playerid] = CreatePlayerTextDraw(playerid, 367.333374, 163.851837, string);
	PlayerTextDrawLetterSize(playerid, gpt_data_hud[17][playerid], 0.184900, 1.391700);
	PlayerTextDrawAlignment(playerid, gpt_data_hud[17][playerid], 1);
	PlayerTextDrawColor(playerid, gpt_data_hud[17][playerid], -1);
	PlayerTextDrawSetShadow(playerid, gpt_data_hud[17][playerid], 0);
	PlayerTextDrawSetOutline(playerid, gpt_data_hud[17][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, gpt_data_hud[17][playerid], 51);
	PlayerTextDrawFont(playerid, gpt_data_hud[17][playerid], 2);
	PlayerTextDrawSetProportional(playerid, gpt_data_hud[17][playerid], 1);

	format(string, sizeof(string), "Cargo: %s%s", stats_color, ConvertToGameText(GetPlayerFactionRankName(playerid)));
	gpt_data_hud[18][playerid] = CreatePlayerTextDraw(playerid, 366.999847, 178.785217, string);
	PlayerTextDrawLetterSize(playerid, gpt_data_hud[18][playerid], 0.184900, 1.391700);
	PlayerTextDrawAlignment(playerid, gpt_data_hud[18][playerid], 1);
	PlayerTextDrawColor(playerid, gpt_data_hud[18][playerid], -1);
	PlayerTextDrawSetShadow(playerid, gpt_data_hud[18][playerid], 0);
	PlayerTextDrawSetOutline(playerid, gpt_data_hud[18][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, gpt_data_hud[18][playerid], 51);
	PlayerTextDrawFont(playerid, gpt_data_hud[18][playerid], 2);
	PlayerTextDrawSetProportional(playerid, gpt_data_hud[18][playerid], 1);*/

	new house_str[4] = "Nao";
	if(GetPlayerHouseID(playerid) != INVALID_HOUSE_ID)
		house_str = "Sim";

	format(string, sizeof(string), "Casa: %s%s", stats_color, house_str);
	gpt_data_hud[19][playerid] = CreatePlayerTextDraw(playerid, 367.000000, 193.718505, string);
	PlayerTextDrawLetterSize(playerid, gpt_data_hud[19][playerid], 0.184900, 1.391700);
	PlayerTextDrawAlignment(playerid, gpt_data_hud[19][playerid], 1);
	PlayerTextDrawColor(playerid, gpt_data_hud[19][playerid], -1);
	PlayerTextDrawSetShadow(playerid, gpt_data_hud[19][playerid], 0);
	PlayerTextDrawSetOutline(playerid, gpt_data_hud[19][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, gpt_data_hud[19][playerid], 51);
	PlayerTextDrawFont(playerid, gpt_data_hud[19][playerid], 2);
	PlayerTextDrawSetProportional(playerid, gpt_data_hud[19][playerid], 1);

	new business_str[32] = "Nao";
	if(GetPlayerBusinessID(playerid) != INVALID_BUSINESS_ID)
		format(business_str, sizeof(business_str), "%s", GetBusinessName(GetPlayerBusinessID(playerid)));

	format(string, sizeof(string), "Empresa: %s%s", stats_color, business_str);
	gpt_data_hud[20][playerid] = CreatePlayerTextDraw(playerid, 367.000030, 209.066650, string);
	PlayerTextDrawLetterSize(playerid, gpt_data_hud[20][playerid], 0.184900, 1.391700);
	PlayerTextDrawAlignment(playerid, gpt_data_hud[20][playerid], 1);
	PlayerTextDrawColor(playerid, gpt_data_hud[20][playerid], -1);
	PlayerTextDrawSetShadow(playerid, gpt_data_hud[20][playerid], 0);
	PlayerTextDrawSetOutline(playerid, gpt_data_hud[20][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, gpt_data_hud[20][playerid], 51);
	PlayerTextDrawFont(playerid, gpt_data_hud[20][playerid], 2);
	PlayerTextDrawSetProportional(playerid, gpt_data_hud[20][playerid], 1);

	new vehicle_count = 0;
	for(new i = 0; i < MAX_VEHICLES_PER_PLAYER; i++)
		if(g_pDealershipData[playerid][i][E_DEALERSHIP_VEHICLE_DBID] != 0)
			vehicle_count++;

	format(string, sizeof(string), "Veiculos: %s%d/%d", stats_color, vehicle_count, MAX_VEHICLES_PER_PLAYER);
	gpt_data_hud[21][playerid] = CreatePlayerTextDraw(playerid, 367.333343, 222.755554, string);
	PlayerTextDrawLetterSize(playerid, gpt_data_hud[21][playerid], 0.184900, 1.391700);
	PlayerTextDrawAlignment(playerid, gpt_data_hud[21][playerid], 1);
	PlayerTextDrawColor(playerid, gpt_data_hud[21][playerid], -1);
	PlayerTextDrawSetShadow(playerid, gpt_data_hud[21][playerid], 0);
	PlayerTextDrawSetOutline(playerid, gpt_data_hud[21][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, gpt_data_hud[21][playerid], 51);
	PlayerTextDrawFont(playerid, gpt_data_hud[21][playerid], 2);
	PlayerTextDrawSetProportional(playerid, gpt_data_hud[21][playerid], 1);

	format(string, sizeof(string), "Membro desde: %s%s", stats_color, convertTimestamp(GetPlayerRegDataUnix(playerid)));
	gpt_data_hud[22][playerid] = CreatePlayerTextDraw(playerid, 190.333084, 303.644317, string);
	PlayerTextDrawLetterSize(playerid, gpt_data_hud[22][playerid], 0.184900, 1.391700);
	PlayerTextDrawAlignment(playerid, gpt_data_hud[22][playerid], 1);
	PlayerTextDrawColor(playerid, gpt_data_hud[22][playerid], -1);
	PlayerTextDrawSetShadow(playerid, gpt_data_hud[22][playerid], 0);
	PlayerTextDrawSetOutline(playerid, gpt_data_hud[22][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, gpt_data_hud[22][playerid], 51);
	PlayerTextDrawFont(playerid, gpt_data_hud[22][playerid], 2);
	PlayerTextDrawSetProportional(playerid, gpt_data_hud[22][playerid], 1);

	new lastLogin[32] = "Nunca";
	if(GetPlayerLastLoginUnix(playerid) != 0)
		format(lastLogin, 32, "%s", convertTimestamp(GetPlayerLastLoginUnix(playerid)));

	format(string, sizeof(string), "Ultimo Login: %s%s", stats_color, lastLogin);
	gpt_data_hud[23][playerid] = CreatePlayerTextDraw(playerid, 355.999969, 303.229583, string);
	PlayerTextDrawLetterSize(playerid, gpt_data_hud[23][playerid], 0.184900, 1.391700);
	PlayerTextDrawAlignment(playerid, gpt_data_hud[23][playerid], 1);
	PlayerTextDrawColor(playerid, gpt_data_hud[23][playerid], -1);
	PlayerTextDrawSetShadow(playerid, gpt_data_hud[23][playerid], 0);
	PlayerTextDrawSetOutline(playerid, gpt_data_hud[23][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, gpt_data_hud[23][playerid], 51);
	PlayerTextDrawFont(playerid, gpt_data_hud[23][playerid], 2);
	PlayerTextDrawSetProportional(playerid, gpt_data_hud[23][playerid], 1);

	/*format(string, sizeof(string), "Tempo Jogado: %s%s", stats_color, GetPlayerPlayedTimeStamp(playerid));
	gpt_data_hud[24][playerid] = CreatePlayerTextDraw(playerid, 280.333343, 95.822250, string);// 364
	PlayerTextDrawLetterSize(playerid, gpt_data_hud[24][playerid], 0.184900, 1.391700);
	PlayerTextDrawAlignment(playerid, gpt_data_hud[24][playerid], 1);
	PlayerTextDrawColor(playerid, gpt_data_hud[24][playerid], -1);
	PlayerTextDrawSetShadow(playerid, gpt_data_hud[24][playerid], 0);
	PlayerTextDrawSetOutline(playerid, gpt_data_hud[24][playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, gpt_data_hud[24][playerid], 51);
	PlayerTextDrawFont(playerid, gpt_data_hud[24][playerid], 2);
	PlayerTextDrawSetProportional(playerid, gpt_data_hud[24][playerid], 1);*/

	gpt_data_hud[25][playerid] = CreatePlayerTextDraw(playerid, 514.333312, 107.022224, "ld_chat:thumbdn");
	PlayerTextDrawLetterSize(playerid, gpt_data_hud[25][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, gpt_data_hud[25][playerid], 15.666687, 14.103698);
	PlayerTextDrawAlignment(playerid, gpt_data_hud[25][playerid], 1);
	PlayerTextDrawColor(playerid, gpt_data_hud[25][playerid], -1);
	PlayerTextDrawSetShadow(playerid, gpt_data_hud[25][playerid], 0);
	PlayerTextDrawSetOutline(playerid, gpt_data_hud[25][playerid], 0);
	PlayerTextDrawFont(playerid, gpt_data_hud[25][playerid], 4);
	PlayerTextDrawSetSelectable(playerid, gpt_data_hud[25][playerid], true);

	gpt_data_hud[26][playerid] = CreatePlayerTextDraw(playerid, 85.000000, 95.000000, "PlayerSkinModel");
	PlayerTextDrawBackgroundColor(playerid, gpt_data_hud[26][playerid], 0x00000000);
	PlayerTextDrawFont(playerid, gpt_data_hud[26][playerid], 5);
	PlayerTextDrawLetterSize(playerid, gpt_data_hud[26][playerid], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid, gpt_data_hud[26][playerid], -1);
	PlayerTextDrawSetOutline(playerid, gpt_data_hud[26][playerid], 0);
	PlayerTextDrawSetProportional(playerid, gpt_data_hud[26][playerid], 1);
	PlayerTextDrawSetShadow(playerid, gpt_data_hud[26][playerid], 1);
	PlayerTextDrawUseBox(playerid, gpt_data_hud[26][playerid], 1);
	PlayerTextDrawBoxColor(playerid, gpt_data_hud[26][playerid], 0x00000000);
	PlayerTextDrawTextSize(playerid, gpt_data_hud[26][playerid], 205.000000, 204.000000);
	PlayerTextDrawSetPreviewModel(playerid, gpt_data_hud[26][playerid], GetPlayerSkin(playerid));

	gpt_data_hud[2][playerid] = CreatePlayerTextDraw(playerid, 141.666625, 86.281486, "Stats");
	PlayerTextDrawLetterSize(playerid, gpt_data_hud[2][playerid], 0.763333, 3.093333);
	PlayerTextDrawAlignment(playerid, gpt_data_hud[2][playerid], 1);
	PlayerTextDrawColor(playerid, gpt_data_hud[2][playerid], -1);
	PlayerTextDrawSetShadow(playerid, gpt_data_hud[2][playerid], -1);
	PlayerTextDrawSetOutline(playerid, gpt_data_hud[2][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, gpt_data_hud[2][playerid], 51);
	PlayerTextDrawFont(playerid, gpt_data_hud[2][playerid], 0);
	PlayerTextDrawSetProportional(playerid, gpt_data_hud[2][playerid], 1);

	gpt_data_hud[27][playerid] = CreatePlayerTextDraw(playerid, 518.000244, 292.859222, "LD_SPAC:white");// Yellow change color
	PlayerTextDrawLetterSize(playerid, gpt_data_hud[27][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, gpt_data_hud[27][playerid], 12.000000, 12.000000);
	PlayerTextDrawAlignment(playerid, gpt_data_hud[27][playerid], 1);
	PlayerTextDrawColor(playerid, gpt_data_hud[27][playerid], -65281);
	PlayerTextDrawSetShadow(playerid, gpt_data_hud[27][playerid], 0);
	PlayerTextDrawSetOutline(playerid, gpt_data_hud[27][playerid], 0);
	PlayerTextDrawFont(playerid, gpt_data_hud[27][playerid], 4);
	PlayerTextDrawSetSelectable(playerid, gpt_data_hud[27][playerid], true);

	gpt_data_hud[28][playerid] = CreatePlayerTextDraw(playerid, 518.000244, 280.859222, "LD_SPAC:white");// Blue change color
	PlayerTextDrawLetterSize(playerid, gpt_data_hud[28][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, gpt_data_hud[28][playerid], 12.000000, 12.000000);
	PlayerTextDrawAlignment(playerid, gpt_data_hud[28][playerid], 1);
	PlayerTextDrawColor(playerid, gpt_data_hud[28][playerid], 0x4099FFFF);
	PlayerTextDrawSetShadow(playerid, gpt_data_hud[28][playerid], 0);
	PlayerTextDrawSetOutline(playerid, gpt_data_hud[28][playerid], 0);
	PlayerTextDrawFont(playerid, gpt_data_hud[28][playerid], 4);
	PlayerTextDrawSetSelectable(playerid, gpt_data_hud[28][playerid], true);

	gpt_data_hud[29][playerid] = CreatePlayerTextDraw(playerid, 518.000244, 268.859222, "LD_SPAC:white");// Green change color
	PlayerTextDrawLetterSize(playerid, gpt_data_hud[29][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, gpt_data_hud[29][playerid], 12.000000, 12.000000);
	PlayerTextDrawAlignment(playerid, gpt_data_hud[29][playerid], 1);
	PlayerTextDrawColor(playerid, gpt_data_hud[29][playerid], 0x6DC066FF);
	PlayerTextDrawSetShadow(playerid, gpt_data_hud[29][playerid], 0);
	PlayerTextDrawSetOutline(playerid, gpt_data_hud[29][playerid], 0);
	PlayerTextDrawFont(playerid, gpt_data_hud[29][playerid], 4);
	PlayerTextDrawSetSelectable(playerid, gpt_data_hud[29][playerid], true);

	gpt_data_hud[30][playerid] = CreatePlayerTextDraw(playerid, 518.000244, 256.859222, "LD_SPAC:white");// Red change color
	PlayerTextDrawLetterSize(playerid, gpt_data_hud[30][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, gpt_data_hud[30][playerid], 12.000000, 12.000000);
	PlayerTextDrawAlignment(playerid, gpt_data_hud[30][playerid], 1);
	PlayerTextDrawColor(playerid, gpt_data_hud[30][playerid], 0xCC0000FF);
	PlayerTextDrawSetShadow(playerid, gpt_data_hud[30][playerid], 0);
	PlayerTextDrawSetOutline(playerid, gpt_data_hud[30][playerid], 0);
	PlayerTextDrawFont(playerid, gpt_data_hud[30][playerid], 4);
	PlayerTextDrawSetSelectable(playerid, gpt_data_hud[30][playerid], true);

	gpt_data_hud[31][playerid] = CreatePlayerTextDraw(playerid, 518.000244, 244.859222, "LD_SPAC:white");// Purple change color
	PlayerTextDrawLetterSize(playerid, gpt_data_hud[31][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, gpt_data_hud[31][playerid], 12.000000, 12.000000);
	PlayerTextDrawAlignment(playerid, gpt_data_hud[31][playerid], 1);
	PlayerTextDrawColor(playerid, gpt_data_hud[31][playerid], 0x7D26CDFF);
	PlayerTextDrawSetShadow(playerid, gpt_data_hud[31][playerid], 0);
	PlayerTextDrawSetOutline(playerid, gpt_data_hud[31][playerid], 0);
	PlayerTextDrawFont(playerid, gpt_data_hud[31][playerid], 4);
	PlayerTextDrawSetSelectable(playerid, gpt_data_hud[31][playerid], true);

	for(new i = 0; i < sizeof(gpt_data_hud); i++)
		PlayerTextDrawShow(playerid, gpt_data_hud[i][playerid]);

	SelectTextDraw(playerid, 0xC7E9FFAA);
	PlaySelectSound(playerid);
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

		format(string, sizeof(string), "Dinheiro: %s$%d", stats_color, GetPlayerCash(playerid));
		PlayerTextDrawSetString(playerid, gpt_data_hud[9][playerid], string);

		/*format(string, sizeof(string), "Banco: %s$%d", stats_color, GetPlayerBankCash(playerid));
		PlayerTextDrawSetString(playerid, gpt_data_hud[10][playerid], string);*/

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

		/*format(string, sizeof(string), "Nascimento: %s%s", stats_color, gPlayerData[playerid][E_PLAYER_BIRTHDAY]);
		PlayerTextDrawSetString(playerid, gpt_data_hud[13][playerid], string);*/

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

		/*format(string, sizeof(string), "Org.: %s%s", stats_color, GetFactionName(GetPlayerFactionID(playerid)));
		PlayerTextDrawSetString(playerid, gpt_data_hud[17][playerid], string);*/

		/*format(string, sizeof(string), "Cargo: %s%s", stats_color, GetPlayerFactionRankName(playerid));
		PlayerTextDrawSetString(playerid, gpt_data_hud[18][playerid], string);*/

		new house_str[4] = "Nao";
		if(GetPlayerHouseID(playerid))
			house_str = "Sim";

		format(string, sizeof(string), "Casa: %s%s", stats_color, house_str);
		PlayerTextDrawSetString(playerid, gpt_data_hud[19][playerid], string);

		new business_str[32] = "Nao";
		if(GetPlayerBusinessID(playerid))
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

		/*format(string, sizeof(string), "Tempo Jogado: %s%s", stats_color, GetPlayerPlayedTimeStamp(playerid));
		PlayerTextDrawSetString(playerid, gpt_data_hud[24][playerid], string);*/
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
