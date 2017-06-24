YCMD:criargangue(playerid, params[], help)
{
    if(GetPlayerMoney(playerid) < 200000) return SendClientMessage(playerid, COLOR_ERROR, "Você precisa de no mínimo $200.000 para criar uma gangue!");
    if(PlayerGangInvitationInfo[playerid][sender_id] != INVALID)
    {
        new errormsg[256], sendername[24];
        GetPlayerName(playerid, PlayerGangInvitationInfo[playerid][sender_id], 24);
        format(errormsg, sizeof(errormsg), "Você não pode criar uma gangue porque já está participando do processo de criação da gangue do player {FF0000}%s{FFFFFF}!", sendername);
        return SendClientMessage(playerid, COLOR_ERROR, errormsg);
    }
    ShowPlayerGangMenu(playerid);
    return 1;
}
