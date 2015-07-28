/*******************************************************************************
* FILENAME :        modules/gameplays/lottery.pwn
*
* DESCRIPTION :
*       Adds lottery to the server.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
* AUTHOR :    Larceny           START DATE :    25 Jul 15
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

#define LOTTERY_TICKET_PRICE			25
#define MAX_LOTTERY_VALUE				200

//------------------------------------------------------------------------------

// Countdown time (in minutes) to lottery
new g_lotteryAdvertisement = 0;

// Jackpot of lottery
new g_lotteryJackpot = 0;

// Next lottery raffle time (UNIX timestamp)
new g_lotteryNextRaffle = 0;

// Checkpointid
static STREAMER_TAG_CP gCheckpointid;

//------------------------------------------------------------------------------

forward LoadLotteryData();

//------------------------------------------------------------------------------

/*
    Called every 60 seconds to send countdown messages.
*/

timer OnLotteryUpdates[60000]()
{
	// If lottery is greater than zero, send countdown messages
	if(g_lotteryAdvertisement > 0)
	{
		foreach(new i: Player)
		{
			if(!IsPlayerLogged(i))
				continue;

			new message[82 + 20];
			if(g_lotteryAdvertisement > 1)
				format(message, sizeof(message), "* Faltam apenas {008282}%d{B0E0E6} minutos para o sorteio de {008282}$%s{B0E0E6}.", g_lotteryAdvertisement, formatnumber(g_lotteryJackpot));
			else
				format(message, sizeof(message), "* Falta apenas {008282}%d{B0E0E6} minuto para o sorteio de {008282}$%s{B0E0E6}.", g_lotteryAdvertisement, formatnumber(g_lotteryJackpot));
			SendClientMessage(i, 0xB0E0E6FF, " ");
			SendClientMessage(i, 0x008282FF, "* Lóterica.");
			SendClientMessage(i, 0xB0E0E6FF, message);
			SendClientMessage(i, 0xB0E0E6FF, "* Vá até a lóterica e faça sua aposta!");
		}
		g_lotteryAdvertisement--;
		defer OnLotteryUpdates();
	}
	else
	{
		new
			winningTicket = random(MAX_LOTTERY_VALUE) + 1,
			amountOfWinners = 0
		;

		foreach(new i: Player)
		{
			if(!IsPlayerLogged(i))
				continue;

			new message[72 + 4];
			format(message, sizeof(message), "* O bilhete premiado foi {008282}%d{B0E0E6}!", winningTicket);
			SendClientMessage(i, 0xB0E0E6FF, " ");
			SendClientMessage(i, 0x008282FF, "* Lóterica.");
			SendClientMessage(i, 0xB0E0E6FF, message);
			if(winningTicket == GetPlayerLotteryTicket(i))
				amountOfWinners++;
			else
				SendClientMessage(i, 0xB0E0E6FF, "* Seu bilhete {008282}não{B0E0E6} foi o premiado, mais sorte na próxima vez.");
		}

		new winnersName[MAX_PLAYER_NAME] = "Ninguem";
		if(amountOfWinners > 0)
		{
			new message[56 + 15];
			if(amountOfWinners == 1)
				format(message, sizeof(message), "* O vencedor da bolada de {008282}$%s{B0E0E6} foi:", formatnumber(g_lotteryJackpot));
			else
				format(message, sizeof(message), "* Os vencedores da bolada de {008282}$%s{B0E0E6} foram:", formatnumber(g_lotteryJackpot));

			foreach(new i: Player)
			{
				if(!IsPlayerLogged(i))
					continue;

				SendClientMessage(i, 0xB0E0E6FF, message);
				if(winningTicket == GetPlayerLotteryTicket(i))
				{
					foreach(new j: Player)
					{
						if(!IsPlayerLogged(j))
							continue;

						format(message, sizeof(message), "* {008282}%s{B0E0E6}.", GetPlayerNamef(i));
						SendClientMessage(j, 0xB0E0E6FF, message);
						format(winnersName, sizeof(winnersName), GetPlayerNamef(i));
					}
					if(amountOfWinners > 1)
					{
						SendClientMessage(i, 0xB0E0E6FF, "* O premio foi {008282}dividido{B0E0E6} entre os vencedores.");
						format(winnersName, sizeof(winnersName), "Varios vencedores");
					}

					if(!GetPlayerAchievement(i, ACHIEVEMENT_BLOWJOB))
						SetPlayerAchievement(i, ACHIEVEMENT_BLOWJOB, true);

					GivePlayerCash(i, g_lotteryJackpot / amountOfWinners);
					PlayerPlaySound(i, 1097, 0.0, 0.0, 0.0);
                    defer StopPlayingWinnerSound(i);
					GameTextForPlayer(i, "~g~Vencedor!", 10000, 3);
				}
				SetPlayerLotteryTicket(i, 0);
			}
			g_lotteryJackpot = random(3214) + 5000;
			UpdateJackpotOnDatabase();
		}
		else
		{
			foreach(new i: Player)
			{
				if(!IsPlayerLogged(i))
					continue;

				new message[86 + 15];
				format(message, sizeof(message), "* {008282}Não{B0E0E6} houve vencedores. A bolada foi acumulada em {008282}$%s{B0E0E6}.", formatnumber(g_lotteryJackpot));
				SendClientMessage(i, 0xB0E0E6FF, message);
				SetPlayerLotteryTicket(i, 0);
			}
		}
		new query[64 + MAX_PLAYER_NAME];
		mysql_format(mysql, query, sizeof(query), "UPDATE `lottery` SET `Active`=0, `LastWinner`='%s' WHERE `ID`=1", winnersName);
		mysql_tquery(mysql, "UPDATE `lottery` SET `Active`=0 WHERE `ID`=1");
	}
}

//------------------------------------------------------------------------------

timer StopPlayingWinnerSound[10000](playerid)
{
    PlayerPlaySound(playerid, 1188, 0.0, 0.0, 0.0);
}

//------------------------------------------------------------------------------

/*
    Called when the server starts
*/

hook OnGameModeInit()
{
	print("Loading lottery data.");
	mysql_tquery(mysql, "SELECT * FROM `lottery`", "LoadLotteryData");
    gCheckpointid = CreateDynamicCP(822.0087, 2.4446, 1004.1797, 1.0, 0, 3);
}

//------------------------------------------------------------------------------

hook OnPlayerEnterDynamicCP(playerid, STREAMER_TAG_CP checkpointid)
{
    if(checkpointid == gCheckpointid)
    {
        if(GetPlayerLotteryTicket(playerid) != 0)
        {
            SendClientMessage(playerid, COLOR_ERROR, "* Você já possui um bilhete.");
            return -1;
        }

		SetPlayerCameraPos(playerid, 822.3589, 3.0130, 1004.6008);
		SetPlayerCameraLookAt(playerid, 821.3605, 3.0032, 1004.6359, CAMERA_MOVE);

        new info[90];
        inline Response(pid, dialogid, response, listitem, string:inputtext[])
        {
            #pragma unused pid, dialogid, listitem
            if(!response)
			{
				SetCameraBehindPlayer(playerid);
                PlayCancelSound(playerid);
			}
            else
            {
                if(!isnumeric(inputtext))
                {
                    PlayErrorSound(playerid);
                    SendClientMessage(playerid, COLOR_ERROR, "* Utilize apenas números.");
                    Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_INPUT, "Lotérica", info, "Comprar", "Cancelar");
                }
                else if(LOTTERY_TICKET_PRICE > GetPlayerCash(playerid))
                {
                    PlayErrorSound(playerid);
                    SendClientMessage(playerid, COLOR_ERROR, "* Você não tem dinheiro suficiente.");
                    Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_INPUT, "Lotérica", info, "Comprar", "Cancelar");
                }
                else if(strval(inputtext) < 1 || strval(inputtext) > MAX_LOTTERY_VALUE)
                {
                    PlayErrorSound(playerid);
                    SendClientMessage(playerid, COLOR_ERROR, "* Valor inválido.");
                    Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_INPUT, "Lotérica", info, "Comprar", "Cancelar");
                }
                else
                {
                    PlayConfirmSound(playerid);
                    SetPlayerLotteryTicket(playerid, strval(inputtext));
    				GivePlayerCash(playerid, -LOTTERY_TICKET_PRICE);
    				g_lotteryJackpot += LOTTERY_TICKET_PRICE;

    				SendClientMessage(playerid, COLOR_SUCCESS, "* Você comprou um bilhete.");

    				SendClientActionMessage(playerid, 15.0, "compra um bilhete na Lotérica.");
    				DeletePVar(playerid, "lottery_ticket_shown");
    				SetCameraBehindPlayer(playerid);
    				UpdateJackpotOnDatabase();
                }
            }
        }
		format(info, sizeof(info), "Digite o número do bilhete que deseja comprar.\n\nPossibilidades: 1 ~ %d\nPreço: $%i.", MAX_LOTTERY_VALUE, LOTTERY_TICKET_PRICE);
        Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_INPUT, "Lotérica", info, "Comprar", "Cancelar");
        PlaySelectSound(playerid);
        return -2;
    }
    return 1;
}

//------------------------------------------------------------------------------

/*
    Called when server loads lottery data from database
*/

public LoadLotteryData()
{
	new rows, fields;
	cache_get_data(rows, fields, mysql);
	if(rows)
	{
		g_lotteryJackpot = cache_get_field_content_int(0, "Jackpot");
		g_lotteryNextRaffle = cache_get_field_content_int(0, "Date");
		mysql_tquery(mysql, "UPDATE `lottery` SET `Active`=0, `LastWinner`='Ninguem' WHERE `ID`=1");
	}
	else
	{
		new query[128];
		mysql_format(mysql, query, sizeof(query), "INSERT INTO `lottery` (`Jackpot`, `Date`, `LastWinner`, `Active`) VALUES (%d, %d, 'Ninguem', 0)", random(3214) + 5000, gettime() + 201600);
		mysql_tquery(mysql, query);
	}
}

//------------------------------------------------------------------------------

/*
    Starts the lottery
    	time - Time in minutes
*/

StartLottery(time = 5)
{
	if(g_lotteryAdvertisement)
		return 0;

	g_lotteryAdvertisement = time;
	g_lotteryNextRaffle = gettime() + 201600;

	new query[80];
	mysql_format(mysql, query, sizeof(query), "UPDATE `lottery` SET `Active`=1, `Date`=%d WHERE `ID`=1", g_lotteryNextRaffle);
	mysql_tquery(mysql, query);

	OnLotteryUpdates();
	return 1;
}

//------------------------------------------------------------------------------

/*
	Updates jackpot value on database
*/

UpdateJackpotOnDatabase()
{
	new query[80];
	mysql_format(mysql, query, sizeof(query), "UPDATE `lottery` SET `Jackpot`=%d WHERE `ID`=1", g_lotteryJackpot);
	mysql_tquery(mysql, query);
}

//------------------------------------------------------------------------------

/*
	Starts lottery
*/

YCMD:lotto(playerid, params[], help)
{
	if(GetPlayerHighestRank(playerid) < PLAYER_RANK_ADMIN)
		return SendClientMessage(playerid, COLOR_ERROR, "* Você não tem permissão.");

	new time;
	if(sscanf(params, "i", time))
		SendClientMessage(playerid, COLOR_INFO, "* /lotto <tempo>");
	else if(time < 1 || time > 10)
		SendClientMessage(playerid, COLOR_ERROR, "* Use apenas valores entre 1 e 10.");
	else if(g_lotteryAdvertisement)
		SendClientMessage(playerid, COLOR_ERROR, "* A Lotérica ja foi iniciada.");
	else
		StartLottery(time);
	return 1;
}
