/*******************************************************************************
* FILENAME :        modules/job/commands.pwn
*
* DESCRIPTION :
*       Global jobs commands
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

YCMD:ajudaemprego(playerid, params[], help)
{
    if(GetPlayerJobID(playerid) == INVALID_JOB_ID)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não possui um emprego.");

    switch(GetPlayerJobID(playerid)) {
        case PARAMEDIC_JOB_ID: {
            new string[1000];
            strcat(string, "{FFFFFF}Paramédico.\n\n");
            strcat(string, "\t {00FF00}- {9F9F9F}Sua função como paramédico é ir até pessoas que precisam de algum tipo de assistência médica.\n");
            strcat(string, "\t {00FF00}- {9F9F9F}Você também tem consegue utilizar de suas habilidades médicas para medicar e hidratar outros jogadores.\n");
            strcat(string, "\t {00FF00}- {9F9F9F}Se você encontrar algum viciado pelo caminho, também pode realizar a internação dele para a reabilitação.\n");
            strcat(string, "\t {00FF00}- {9F9F9F}Para trabalhar, basta ir até o ícone de trabalho, aceitar e aguardar uma chamada.\n\n");
            strcat(string, "{FFFFFF}Comandos:\n\n");
            strcat(string, "\t {00FF00}/servico \t\tPermite que você saia do trabalho quando quiser.\n");
            strcat(string, "\t {00FF00}/curar [id] \t\tPermite que você ofereça medicamentos para o jogador. (custo de $30 para o jogador alvo)\n");
            strcat(string, "\t {00FF00}/hidratar [id] \t\tPermite que você ofereça vitaminas para saciar necessidades do jogador. (custo de $15 para o jogador alvo)\n");
            strcat(string, "\t {00FF00}/sairdoemprego \tPermite que saia do emprego após cumprir o tempo de emprego requerido no contrato.\n");

            ShowPlayerDialog(playerid, DIALOG_JOB_HELP, DIALOG_STYLE_MSGBOX, "Ajuda Emprego: Paramédico", string, "Ok", "");
        }
    }
    return 1;
}

YCMD:servico(playerid, params[], help)
{
    if(GetPlayerJobID(playerid) == INVALID_JOB_ID)
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não possui um emprego.");

    if(!IsPlayerWorking(playerid))
        return SendClientMessage(playerid, COLOR_ERROR, "* Você não está trabalhando.");

    if(IsPlayerWorking(playerid)) {
        SetPlayerWorking(playerid, false);
        SetPlayerCivilSkin(playerid);
        SendClientMessage(playerid, COLOR_INFO, "* Você saiu do trabalho.");

        if(GetPlayerJobID(playerid) == PARAMEDIC_JOB_ID)
            CallRemoteFunction("DestroyPlayerParamedicInfo", "i", playerid);

        return 1;
    }

    return 1;
}
