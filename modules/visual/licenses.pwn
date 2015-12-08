/* *************************************************************************** *
*  Description: Licenses visual module file.
*
*  Assignment: A script to licenses via TD.
*
*           Copyright Paradise Devs 2015.  All rights reserved.
* *************************************************************************** */

#include <YSI\y_hooks>

static PlayerText:CNH[MAX_PLAYERS][30];

stock ShowPlayerLicense(playerid, targetid, licenseid)
{
	if(!GetPVarInt(targetid, "isLicenseVisible"))
	{
		SetPVarInt(targetid, "isLicenseVisible", true);

		CNH[targetid][0] = CreatePlayerTextDraw(targetid, 213.466735, 110.520027, "box");
		PlayerTextDrawLetterSize(targetid, CNH[targetid][0], 0.000000, 21.504777);
		PlayerTextDrawTextSize(targetid, CNH[targetid][0], 439.180969, 0.000000);
		PlayerTextDrawAlignment(targetid, CNH[targetid][0], 1);
		PlayerTextDrawColor(targetid, CNH[targetid][0], -1);
		PlayerTextDrawUseBox(targetid, CNH[targetid][0], 1);
		PlayerTextDrawBoxColor(targetid, CNH[targetid][0], 97);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][0], 0);
		PlayerTextDrawSetOutline(targetid, CNH[targetid][0], 0);
		PlayerTextDrawBackgroundColor(targetid, CNH[targetid][0], 125);
		PlayerTextDrawFont(targetid, CNH[targetid][0], 1);
		PlayerTextDrawSetProportional(targetid, CNH[targetid][0], 1);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][0], 0);

		CNH[targetid][1] = CreatePlayerTextDraw(targetid, 213.466720, 111.113365, "box");
		PlayerTextDrawLetterSize(targetid, CNH[targetid][1], 0.000000, 21.372564);
		PlayerTextDrawTextSize(targetid, CNH[targetid][1], 239.376800, 0.000000);
		PlayerTextDrawAlignment(targetid, CNH[targetid][1], 1);
		PlayerTextDrawColor(targetid, CNH[targetid][1], -1);
		PlayerTextDrawUseBox(targetid, CNH[targetid][1], 1);
		PlayerTextDrawBoxColor(targetid, CNH[targetid][1], 97);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][1], 0);
		PlayerTextDrawSetOutline(targetid, CNH[targetid][1], 0);
		PlayerTextDrawBackgroundColor(targetid, CNH[targetid][1], 255);
		PlayerTextDrawFont(targetid, CNH[targetid][1], 1);
		PlayerTextDrawSetProportional(targetid, CNH[targetid][1], 1);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][1], 0);

		CNH[targetid][2] = CreatePlayerTextDraw(targetid, 242.380966, 110.713363, "box");
		PlayerTextDrawLetterSize(targetid, CNH[targetid][2], 0.000000, 3.980950);
		PlayerTextDrawTextSize(targetid, CNH[targetid][2], 439.523864, 0.000000);
		PlayerTextDrawAlignment(targetid, CNH[targetid][2], 1);
		PlayerTextDrawColor(targetid, CNH[targetid][2], -1);
		PlayerTextDrawUseBox(targetid, CNH[targetid][2], 1);
		PlayerTextDrawBoxColor(targetid, CNH[targetid][2], 97);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][2], 0);
		PlayerTextDrawSetOutline(targetid, CNH[targetid][2], 0);
		PlayerTextDrawBackgroundColor(targetid, CNH[targetid][2], 255);
		PlayerTextDrawFont(targetid, CNH[targetid][2], 1);
		PlayerTextDrawSetProportional(targetid, CNH[targetid][2], 1);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][2], 0);

		CNH[targetid][3] = CreatePlayerTextDraw(targetid, 212.714355, 109.773368, "ld_drv:nawtxt");
		PlayerTextDrawLetterSize(targetid, CNH[targetid][3], 0.000000, 0.000000);
		PlayerTextDrawTextSize(targetid, CNH[targetid][3], 32.476184, 37.519996);
		PlayerTextDrawAlignment(targetid, CNH[targetid][3], 1);
		PlayerTextDrawColor(targetid, CNH[targetid][3], -1);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][3], 0);
		PlayerTextDrawSetOutline(targetid, CNH[targetid][3], 0);
		PlayerTextDrawBackgroundColor(targetid, CNH[targetid][3], 255);
		PlayerTextDrawFont(targetid, CNH[targetid][3], 4);
		PlayerTextDrawSetProportional(targetid, CNH[targetid][3], 0);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][3], 0);

		CNH[targetid][4] = CreatePlayerTextDraw(targetid, 256.476226, 113.200103, "Departamento Nacional de Transito");
		PlayerTextDrawLetterSize(targetid, CNH[targetid][4], 0.278095, 1.715198);
		PlayerTextDrawAlignment(targetid, CNH[targetid][4], 1);
		PlayerTextDrawColor(targetid, CNH[targetid][4], -1);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][4], 0);
		PlayerTextDrawSetOutline(targetid, CNH[targetid][4], 0);
		PlayerTextDrawBackgroundColor(targetid, CNH[targetid][4], 255);
		PlayerTextDrawFont(targetid, CNH[targetid][4], 3);
		PlayerTextDrawSetProportional(targetid, CNH[targetid][4], 1);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][4], 0);

		CNH[targetid][5] = CreatePlayerTextDraw(targetid, 240.999816, 157.780090, "ld_chat:dpad_lr");
		PlayerTextDrawLetterSize(targetid, CNH[targetid][5], 0.000000, 0.000000);
		PlayerTextDrawTextSize(targetid, CNH[targetid][5], 104.047683, 20.026674);
		PlayerTextDrawAlignment(targetid, CNH[targetid][5], 1);
		PlayerTextDrawColor(targetid, CNH[targetid][5], -1);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][5], 0);
		PlayerTextDrawSetOutline(targetid, CNH[targetid][5], 0);
		PlayerTextDrawBackgroundColor(targetid, CNH[targetid][5], 255);
		PlayerTextDrawFont(targetid, CNH[targetid][5], 4);
		PlayerTextDrawSetProportional(targetid, CNH[targetid][5], 0);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][5], 0);

		CNH[targetid][6] = CreatePlayerTextDraw(targetid, 440.999938, 157.759994, "ld_chat:dpad_lr");
		PlayerTextDrawLetterSize(targetid, CNH[targetid][6], 0.000000, 0.000000);
		PlayerTextDrawTextSize(targetid, CNH[targetid][6], -139.333465, 20.038509);
		PlayerTextDrawAlignment(targetid, CNH[targetid][6], 1);
		PlayerTextDrawColor(targetid, CNH[targetid][6], -1);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][6], 0);
		PlayerTextDrawSetOutline(targetid, CNH[targetid][6], 0);
		PlayerTextDrawBackgroundColor(targetid, CNH[targetid][6], 255);
		PlayerTextDrawFont(targetid, CNH[targetid][6], 4);
		PlayerTextDrawSetProportional(targetid, CNH[targetid][6], 0);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][6], 0);

		CNH[targetid][7] = CreatePlayerTextDraw(targetid, 242.161972, 147.106719, "Nome:");
		PlayerTextDrawLetterSize(targetid, CNH[targetid][7], 0.217904, 1.215999);
		PlayerTextDrawAlignment(targetid, CNH[targetid][7], 1);
		PlayerTextDrawColor(targetid, CNH[targetid][7], -1);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][7], 0);
		PlayerTextDrawSetOutline(targetid, CNH[targetid][7], 0);
		PlayerTextDrawBackgroundColor(targetid, CNH[targetid][7], 255);
		PlayerTextDrawFont(targetid, CNH[targetid][7], 1);
		PlayerTextDrawSetProportional(targetid, CNH[targetid][7], 1);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][7], 0);

		CNH[targetid][8] = CreatePlayerTextDraw(targetid, 251.481033, 162.286773, GetPlayerNamef(playerid));
		PlayerTextDrawLetterSize(targetid, CNH[targetid][8], 0.260951, 1.126399);
		PlayerTextDrawAlignment(targetid, CNH[targetid][8], 1);
		PlayerTextDrawColor(targetid, CNH[targetid][8], -1);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][8], 0);
		PlayerTextDrawSetOutline(targetid, CNH[targetid][8], 0);
		PlayerTextDrawBackgroundColor(targetid, CNH[targetid][8], 255);
		PlayerTextDrawFont(targetid, CNH[targetid][8], 2);
		PlayerTextDrawSetProportional(targetid, CNH[targetid][8], 1);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][8], 0);

		CNH[targetid][9] = CreatePlayerTextDraw(targetid, 203.190597, 165.513351, "");
		PlayerTextDrawLetterSize(targetid, CNH[targetid][9], 0.000000, 0.000000);
		PlayerTextDrawTextSize(targetid, CNH[targetid][9], 109.047630, 168.079956);
		PlayerTextDrawAlignment(targetid, CNH[targetid][9], 1);
		PlayerTextDrawColor(targetid, CNH[targetid][9], -1);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][9], 0);
		PlayerTextDrawSetOutline(targetid, CNH[targetid][9], 0);
		PlayerTextDrawBackgroundColor(targetid, CNH[targetid][9], 0);
		PlayerTextDrawFont(targetid, CNH[targetid][9], 5);
		PlayerTextDrawSetProportional(targetid, CNH[targetid][9], 0);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][9], 0);
		PlayerTextDrawSetPreviewModel(targetid, CNH[targetid][9], GetPlayerSkin(playerid));
		PlayerTextDrawSetPreviewRot(targetid, CNH[targetid][9], 320.000000, 0.000000, 0.000000, 1.000000);

		CNH[targetid][10] = CreatePlayerTextDraw(targetid, 282.861480, 191.059661, "ld_chat:dpad_lr");
		PlayerTextDrawLetterSize(targetid, CNH[targetid][10], 0.000000, 0.000000);
		PlayerTextDrawTextSize(targetid, CNH[targetid][10], 54.585865, 19.403348);
		PlayerTextDrawAlignment(targetid, CNH[targetid][10], 1);
		PlayerTextDrawColor(targetid, CNH[targetid][10], -1);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][10], 0);
		PlayerTextDrawSetOutline(targetid, CNH[targetid][10], 0);
		PlayerTextDrawBackgroundColor(targetid, CNH[targetid][10], 255);
		PlayerTextDrawFont(targetid, CNH[targetid][10], 4);
		PlayerTextDrawSetProportional(targetid, CNH[targetid][10], 0);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][10], 0);

		CNH[targetid][11] = CreatePlayerTextDraw(targetid, 364.513702, 190.833007, "ld_chat:dpad_lr");
		PlayerTextDrawLetterSize(targetid, CNH[targetid][11], 0.000000, 0.000000);
		PlayerTextDrawTextSize(targetid, CNH[targetid][11], -57.033210, 19.836673);
		PlayerTextDrawAlignment(targetid, CNH[targetid][11], 1);
		PlayerTextDrawColor(targetid, CNH[targetid][11], -1);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][11], 0);
		PlayerTextDrawSetOutline(targetid, CNH[targetid][11], 0);
		PlayerTextDrawBackgroundColor(targetid, CNH[targetid][11], 255);
		PlayerTextDrawFont(targetid, CNH[targetid][11], 4);
		PlayerTextDrawSetProportional(targetid, CNH[targetid][11], 0);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][11], 0);

		CNH[targetid][12] = CreatePlayerTextDraw(targetid, 283.204742, 180.253479, "Data de Nascimento:");
		PlayerTextDrawLetterSize(targetid, CNH[targetid][12], 0.217142, 1.262933);
		PlayerTextDrawAlignment(targetid, CNH[targetid][12], 1);
		PlayerTextDrawColor(targetid, CNH[targetid][12], -1);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][12], 0);
		PlayerTextDrawSetOutline(targetid, CNH[targetid][12], 0);
		PlayerTextDrawBackgroundColor(targetid, CNH[targetid][12], 255);
		PlayerTextDrawFont(targetid, CNH[targetid][12], 1);
		PlayerTextDrawSetProportional(targetid, CNH[targetid][12], 1);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][12], 0);

		CNH[targetid][13] = CreatePlayerTextDraw(targetid, 261.095367, 131.466934, "Carteira de Habilitacao");
		PlayerTextDrawLetterSize(targetid, CNH[targetid][13], 0.297140, 0.985598);
		PlayerTextDrawAlignment(targetid, CNH[targetid][13], 1);
		PlayerTextDrawColor(targetid, CNH[targetid][13], -1);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][13], 0);
		PlayerTextDrawSetOutline(targetid, CNH[targetid][13], 0);
		PlayerTextDrawBackgroundColor(targetid, CNH[targetid][13], 255);
		PlayerTextDrawFont(targetid, CNH[targetid][13], 2);
		PlayerTextDrawSetProportional(targetid, CNH[targetid][13], 1);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][13], 0);

		//CNH[targetid][14] = CreatePlayerTextDraw(targetid, 287.676147, 194.066650, gPlayerData[playerid][E_PLAYER_BIRTHDAY]);
		CNH[targetid][14] = CreatePlayerTextDraw(targetid, 287.676147, 194.066650, "00/00/0000");
		PlayerTextDrawLetterSize(targetid, CNH[targetid][14], 0.281141, 1.220265);
		PlayerTextDrawAlignment(targetid, CNH[targetid][14], 1);
		PlayerTextDrawColor(targetid, CNH[targetid][14], -1);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][14], 0);
		PlayerTextDrawSetOutline(targetid, CNH[targetid][14], 0);
		PlayerTextDrawBackgroundColor(targetid, CNH[targetid][14], 255);
		PlayerTextDrawFont(targetid, CNH[targetid][14], 2);
		PlayerTextDrawSetProportional(targetid, CNH[targetid][14], 1);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][14], 0);

		CNH[targetid][15] = CreatePlayerTextDraw(targetid, 384.077270, 190.839965, "ld_chat:dpad_lr");
		PlayerTextDrawLetterSize(targetid, CNH[targetid][15], 0.000000, 0.000000);
		PlayerTextDrawTextSize(targetid, CNH[targetid][15], 25.999996, 19.599994);
		PlayerTextDrawAlignment(targetid, CNH[targetid][15], 1);
		PlayerTextDrawColor(targetid, CNH[targetid][15], -1);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][15], 0);
		PlayerTextDrawSetOutline(targetid, CNH[targetid][15], 0);
		PlayerTextDrawBackgroundColor(targetid, CNH[targetid][15], 255);
		PlayerTextDrawFont(targetid, CNH[targetid][15], 4);
		PlayerTextDrawSetProportional(targetid, CNH[targetid][15], 0);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][15], 0);

		CNH[targetid][16] = CreatePlayerTextDraw(targetid, 426.847534, 190.966613, "ld_chat:dpad_lr");
		PlayerTextDrawLetterSize(targetid, CNH[targetid][16], 0.000000, 0.000000);
		PlayerTextDrawTextSize(targetid, CNH[targetid][16], -27.333337, 19.543308);
		PlayerTextDrawAlignment(targetid, CNH[targetid][16], 1);
		PlayerTextDrawColor(targetid, CNH[targetid][16], -1);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][16], 0);
		PlayerTextDrawSetOutline(targetid, CNH[targetid][16], 0);
		PlayerTextDrawBackgroundColor(targetid, CNH[targetid][16], 255);
		PlayerTextDrawFont(targetid, CNH[targetid][16], 4);
		PlayerTextDrawSetProportional(targetid, CNH[targetid][16], 0);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][16], 0);

		CNH[targetid][17] = CreatePlayerTextDraw(targetid, 384.538024, 181.313385, "Cat.Hab.:");
		PlayerTextDrawLetterSize(targetid, CNH[targetid][17], 0.215999, 1.169065);
		PlayerTextDrawAlignment(targetid, CNH[targetid][17], 1);
		PlayerTextDrawColor(targetid, CNH[targetid][17], -1);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][17], 0);
		PlayerTextDrawSetOutline(targetid, CNH[targetid][17], 0);
		PlayerTextDrawBackgroundColor(targetid, CNH[targetid][17], 255);
		PlayerTextDrawFont(targetid, CNH[targetid][17], 1);
		PlayerTextDrawSetProportional(targetid, CNH[targetid][17], 1);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][17], 0);

		if(licenseid == LICENSE_HELI || licenseid == LICENSE_PLANE)
			CNH[targetid][18] = CreatePlayerTextDraw(targetid, 400.757080, 192.559997, "Ar");
		else if(licenseid == LICENSE_BOAT)
			CNH[targetid][18] = CreatePlayerTextDraw(targetid, 400.757080, 192.559997, "Mar");
		else if(licenseid == LICENSE_BIKE)
			CNH[targetid][18] = CreatePlayerTextDraw(targetid, 400.757080, 192.559997, "A");
		else if(licenseid == LICENSE_TRUCK)
			CNH[targetid][18] = CreatePlayerTextDraw(targetid, 400.757080, 192.559997, "C");
		else
			CNH[targetid][18] = CreatePlayerTextDraw(targetid, 400.757080, 192.559997, "B");
		PlayerTextDrawLetterSize(targetid, CNH[targetid][18], 0.334856, 1.570132);
		PlayerTextDrawAlignment(targetid, CNH[targetid][18], 1);
		PlayerTextDrawColor(targetid, CNH[targetid][18], -1);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][18], 0);
		PlayerTextDrawSetOutline(targetid, CNH[targetid][18], 0);
		PlayerTextDrawBackgroundColor(targetid, CNH[targetid][18], 255);
		PlayerTextDrawFont(targetid, CNH[targetid][18], 2);
		PlayerTextDrawSetProportional(targetid, CNH[targetid][18], 1);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][18], 0);

		CNH[targetid][19] = CreatePlayerTextDraw(targetid, 282.861480, 224.961730, "ld_chat:dpad_lr");
		PlayerTextDrawLetterSize(targetid, CNH[targetid][19], 0.000000, 0.000000);
		PlayerTextDrawTextSize(targetid, CNH[targetid][19], 54.585865, 19.403348);
		PlayerTextDrawAlignment(targetid, CNH[targetid][19], 1);
		PlayerTextDrawColor(targetid, CNH[targetid][19], -1);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][19], 0);
		PlayerTextDrawSetOutline(targetid, CNH[targetid][19], 0);
		PlayerTextDrawBackgroundColor(targetid, CNH[targetid][19], 255);
		PlayerTextDrawFont(targetid, CNH[targetid][19], 4);
		PlayerTextDrawSetProportional(targetid, CNH[targetid][19], 0);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][19], 0);

		CNH[targetid][20] = CreatePlayerTextDraw(targetid, 364.513702, 225.035095, "ld_chat:dpad_lr");
		PlayerTextDrawLetterSize(targetid, CNH[targetid][20], 0.000000, 0.000000);
		PlayerTextDrawTextSize(targetid, CNH[targetid][20], -57.033210, 19.316661);
		PlayerTextDrawAlignment(targetid, CNH[targetid][20], 1);
		PlayerTextDrawColor(targetid, CNH[targetid][20], -1);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][20], 0);
		PlayerTextDrawSetOutline(targetid, CNH[targetid][20], 0);
		PlayerTextDrawBackgroundColor(targetid, CNH[targetid][20], 255);
		PlayerTextDrawFont(targetid, CNH[targetid][20], 4);
		PlayerTextDrawSetProportional(targetid, CNH[targetid][20], 0);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][20], 0);

		CNH[targetid][21] = CreatePlayerTextDraw(targetid, 283.447540, 215.893432, "Validade:");
		PlayerTextDrawLetterSize(targetid, CNH[targetid][21], 0.266285, 1.062399);
		PlayerTextDrawAlignment(targetid, CNH[targetid][21], 1);
		PlayerTextDrawColor(targetid, CNH[targetid][21], -1);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][21], 0);
		PlayerTextDrawSetOutline(targetid, CNH[targetid][21], 0);
		PlayerTextDrawBackgroundColor(targetid, CNH[targetid][21], 255);
		PlayerTextDrawFont(targetid, CNH[targetid][21], 1);
		PlayerTextDrawSetProportional(targetid, CNH[targetid][21], 1);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][21], 0);

		new sFormatted[32];
		if(licenseid == LICENSE_CAR) format(sFormatted, sizeof(sFormatted), "%s", convertTimestamp(GetPlayerCarLicense(playerid)));
		else if(licenseid == LICENSE_BIKE) format(sFormatted, sizeof(sFormatted), "%s", convertTimestamp(GetPlayerBikeLicense(playerid)));
		else if(licenseid == LICENSE_TRUCK) format(sFormatted, sizeof(sFormatted), "%s", convertTimestamp(GetPlayerTruckLicense(playerid)));
		else if(licenseid == LICENSE_HELI) format(sFormatted, sizeof(sFormatted), "%s", convertTimestamp(GetPlayerHeliLicense(playerid)));
		else if(licenseid == LICENSE_PLANE) format(sFormatted, sizeof(sFormatted), "%s", convertTimestamp(GetPlayerPlaneLicense(playerid)));
		else if(licenseid == LICENSE_BOAT) format(sFormatted, sizeof(sFormatted), "%s", convertTimestamp(GetPlayerBoatLicense(playerid)));
		strdel(sFormatted, 0, 9);
		CNH[targetid][22] = CreatePlayerTextDraw(targetid, 288.657135, 228.253234, sFormatted);
		PlayerTextDrawLetterSize(targetid, CNH[targetid][22], 0.278856, 1.228800);
		PlayerTextDrawAlignment(targetid, CNH[targetid][22], 1);
		PlayerTextDrawColor(targetid, CNH[targetid][22], -1);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][22], 0);
		PlayerTextDrawSetOutline(targetid, CNH[targetid][22], 0);
		PlayerTextDrawBackgroundColor(targetid, CNH[targetid][22], 255);
		PlayerTextDrawFont(targetid, CNH[targetid][22], 2);
		PlayerTextDrawSetProportional(targetid, CNH[targetid][22], 1);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][22], 0);

		CNH[targetid][23] = CreatePlayerTextDraw(targetid, 365.585601, 225.061737, "ld_chat:dpad_lr");
		PlayerTextDrawLetterSize(targetid, CNH[targetid][23], 0.000000, 0.000000);
		PlayerTextDrawTextSize(targetid, CNH[targetid][23], 54.585865, 19.403348);
		PlayerTextDrawAlignment(targetid, CNH[targetid][23], 1);
		PlayerTextDrawColor(targetid, CNH[targetid][23], -1);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][23], 0);
		PlayerTextDrawSetOutline(targetid, CNH[targetid][23], 0);
		PlayerTextDrawBackgroundColor(targetid, CNH[targetid][23], 255);
		PlayerTextDrawFont(targetid, CNH[targetid][23], 4);
		PlayerTextDrawSetProportional(targetid, CNH[targetid][23], 0);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][23], 0);

		CNH[targetid][24] = CreatePlayerTextDraw(targetid, 440.418334, 225.035095, "ld_chat:dpad_lr");
		PlayerTextDrawLetterSize(targetid, CNH[targetid][24], 0.000000, 0.000000);
		PlayerTextDrawTextSize(targetid, CNH[targetid][24], -57.033210, 19.316661);
		PlayerTextDrawAlignment(targetid, CNH[targetid][24], 1);
		PlayerTextDrawColor(targetid, CNH[targetid][24], -1);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][24], 0);
		PlayerTextDrawSetOutline(targetid, CNH[targetid][24], 0);
		PlayerTextDrawBackgroundColor(targetid, CNH[targetid][24], 255);
		PlayerTextDrawFont(targetid, CNH[targetid][24], 4);
		PlayerTextDrawSetProportional(targetid, CNH[targetid][24], 0);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][24], 0);

		CNH[targetid][25] = CreatePlayerTextDraw(targetid, 366.933166, 215.273315, "Primeira Hab.:");
		PlayerTextDrawLetterSize(targetid, CNH[targetid][25], 0.257142, 1.122133);
		PlayerTextDrawAlignment(targetid, CNH[targetid][25], 1);
		PlayerTextDrawColor(targetid, CNH[targetid][25], -1);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][25], 0);
		PlayerTextDrawSetOutline(targetid, CNH[targetid][25], 0);
		PlayerTextDrawBackgroundColor(targetid, CNH[targetid][25], 255);
		PlayerTextDrawFont(targetid, CNH[targetid][25], 1);
		PlayerTextDrawSetProportional(targetid, CNH[targetid][25], 1);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][25], 0);

		CNH[targetid][26] = CreatePlayerTextDraw(targetid, 371.566680, 227.199111, "23/23/1999");
		PlayerTextDrawLetterSize(targetid, CNH[targetid][26], 0.249142, 1.356799);
		PlayerTextDrawAlignment(targetid, CNH[targetid][26], 1);
		PlayerTextDrawColor(targetid, CNH[targetid][26], -1);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][26], 0);
		PlayerTextDrawSetOutline(targetid, CNH[targetid][26], 0);
		PlayerTextDrawBackgroundColor(targetid, CNH[targetid][26], 255);
		PlayerTextDrawFont(targetid, CNH[targetid][26], 2);
		PlayerTextDrawSetProportional(targetid, CNH[targetid][26], 1);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][26], 0);

		CNH[targetid][27] = CreatePlayerTextDraw(targetid, 339.666748, 250.999938, "ld_drv:ribb");
		PlayerTextDrawLetterSize(targetid, CNH[targetid][27], 0.000000, 0.000000);
		PlayerTextDrawTextSize(targetid, CNH[targetid][27], 56.476196, 50.746685);
		PlayerTextDrawAlignment(targetid, CNH[targetid][27], 1);
		PlayerTextDrawColor(targetid, CNH[targetid][27], -1);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][27], 0);
		PlayerTextDrawSetOutline(targetid, CNH[targetid][27], 0);
		PlayerTextDrawBackgroundColor(targetid, CNH[targetid][27], 255);
		PlayerTextDrawFont(targetid, CNH[targetid][27], 4);
		PlayerTextDrawSetProportional(targetid, CNH[targetid][27], 0);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][27], 0);

		CNH[targetid][29] = CreatePlayerTextDraw(targetid, 339.666748, 250.999938, "ld_drv:ribb");
		PlayerTextDrawLetterSize(targetid, CNH[targetid][29], 0.000000, 0.000000);
		PlayerTextDrawTextSize(targetid, CNH[targetid][29], -48.666667, 50.746685);
		PlayerTextDrawAlignment(targetid, CNH[targetid][29], 1);
		PlayerTextDrawColor(targetid, CNH[targetid][29], -1);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][29], 0);
		PlayerTextDrawSetOutline(targetid, CNH[targetid][29], 0);
		PlayerTextDrawBackgroundColor(targetid, CNH[targetid][29], 255);
		PlayerTextDrawFont(targetid, CNH[targetid][29], 4);
		PlayerTextDrawSetProportional(targetid, CNH[targetid][29], 0);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][29], 0);

		if(licenseid == LICENSE_HELI || licenseid == LICENSE_PLANE)
			CNH[targetid][28] = CreatePlayerTextDraw(targetid, 319.857116, 245.453247, "ld_drv:golfly");
		else if(licenseid == LICENSE_BOAT)
			CNH[targetid][28] = CreatePlayerTextDraw(targetid, 319.857116, 245.453247, "ld_drv:goboat");
		else
			CNH[targetid][28] = CreatePlayerTextDraw(targetid, 319.857116, 245.453247, "ld_drv:gold");
		PlayerTextDrawLetterSize(targetid, CNH[targetid][28], 0.000000, 0.000000);
		PlayerTextDrawTextSize(targetid, CNH[targetid][28], 48.047626, 59.588176);
		PlayerTextDrawAlignment(targetid, CNH[targetid][28], 1);
		PlayerTextDrawColor(targetid, CNH[targetid][28], -1);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][28], 0);
		PlayerTextDrawSetOutline(targetid, CNH[targetid][28], 0);
		PlayerTextDrawBackgroundColor(targetid, CNH[targetid][28], 255);
		PlayerTextDrawFont(targetid, CNH[targetid][28], 4);
		PlayerTextDrawSetProportional(targetid, CNH[targetid][28], 0);
		PlayerTextDrawSetShadow(targetid, CNH[targetid][28], 0);

		for (new i = 0; i < sizeof(CNH[]); i++)
			PlayerTextDrawShow(targetid, CNH[targetid][i]);

		SelectTextDraw(targetid, 0xDC322FFF);
	}
}

stock HidePlayerLicense(playerid)
{
	if(GetPVarInt(playerid, "isLicenseVisible"))
	{
		for (new i = 0; i < sizeof(CNH[]); i++)
			PlayerTextDrawDestroy(playerid, CNH[playerid][i]);

		DeletePVar(playerid, "isLicenseVisible");
	}
}

hook OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(_:clickedid == INVALID_TEXT_DRAW && GetPVarInt(playerid, "isLicenseVisible"))
	{
		HidePlayerLicense(playerid);
		return 1;
	}
	return 1;
}
