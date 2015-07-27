/*******************************************************************************
* FILENAME :        modules/gameplay/tutorial.pwn
*
* DESCRIPTION :
*       Handle tutorial clicks and pages.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include "../modules/visual/tutorial.pwn"

#include <YSI\y_hooks>

static gPlayerTutorialPart[MAX_PLAYERS];

//------------------------------------------------------------------------------

new gTutorialMessages[][] =
{
    "~r~Bem-vindo!~n~~n~~w~Bem-vindo ao ~b~~h~Paradise City RPG~w~! Este tutorial explicara muitas duvidas que voce~n~podera ter enquanto comeca no servidor, por isso aconselhamos fortemente que~n~o leia.~n~~n~Esperamos que voce se divirta tanto quanto nos nos divertimos o desenvolvendo.~n~~n~Para nos, sua opiniao e importante. Por isso sempre estamos ouvindo nossos~n~jogadores em nosso forum para trazer a melhor experiencia possivel para~n~todos.~n~~n~Desejamos boa sorte e um bom divertimento!",
    "~r~Auto Escola~n~~n~~w~Para dirigir veiculos legalmente em San Andreas voce precisa de uma carteira de~n~habilitacao (CNH), a auto escola oferece testes para carteira A, B, C/D e aerea.~n~~n~As carteiras de motorista possuem vencimento, tendo que ser revalidadas para~n~evitar multas.~n~~n~As provas sao feitas em ~r~2 ~w~testes, um teorico e um pratico. Voce precisa se sair~n~bem em ambos para conseguir receber sua carteira.",
    "~r~Hospital~n~~n~~w~Caso sua HP chegue a ~r~0~w~ voce sera encaminhado para o hospital de los santos~n~onde sera tratado durante algum tempo antes de poder ser liberado.~n~~n~Os tratamentos hospitalares e as consultas sao pagas. Entao tome cuidado~n~antes de pensar em fazer algo arriscado.",
    "~r~LSPD~n~~n~~w~A policia de Los Santos e responsavel por manter a cidade segura. caso voce~n~cometa algum crime eles serao acionados e irao tentar prende-lo.~n~~n~Dentro da prisao voce passara algum tempo para refletir sobre seus atos,~n~pense duas vezes antes de cometer um crime ou tres vezes em como fugir.",
    "~r~Concessionaria~n~~n~~w~Na concessionaria voce pode comprar veiculos pessoais e estaciona-los em~n~qualquer local.~n~~n~E possivel comprar multiplos veiculos.",
    "~r~Status~n~~w~Com o tempo seu personagem sentira fome e sede e precisara se alimentar para~n~continuar vivo.~n~~n~Caso voce nao se alimente sua vida ira descer com o tempo, se nesse periodo~n~voce nao se alimentar voce ira desmaiar e sera encaminhado para o hospital.~n~~n~Voce pode se alimentar em varias lanchonetes e restaurantes.~n~~n~Ele tambem sentira sono, caso voce nao durma ele ira desmair de sono.~n~Dormir no chao ira apenas recuperar uma porcentagem do status, dormir em cama~n~ira recuperar totalmente. Caso nao tenha casa voce pode dormir no ~r~jefferson~n~motel.~n~~n~Para visualizar o status de seu personagem segura a tecla ~r~N~w~.",
    "~r~Finalizando~n~~n~~w~Existe ~r~muito ~w~mais para se fazer em Los Santos.~n~Nao perca tempo e comece a descobrir.~n~~n~Mal podemos esperar para encontra-lo por ai!"
};

//------------------------------------------------------------------------------

new Float:gTutorialCameras[][] =
{
    {1836.7856, -1506.5116, 129.4090, 1329.2134, -1568.2776, 110.3695, 1835.8972, -1506.9802, 129.0290, 1330.0320, -1568.8605, 109.9746},
    {1365.7269, -1390.2742, 44.3216, 1251.0057, -1410.7408, 45.0354, 1364.8326, -1389.8158, 43.6616, 1251.8533, -1410.1996, 44.5055},
    {1211.4429, -1407.0830, 25.9981, 1215.3201, -1267.7822, 25.9981, 1211.0593, -1406.1536, 25.8331, 1214.7445, -1268.6066, 25.8881},
    {1513.2186, -1731.4973, 12.6044, 1507.5874, -1596.2528, 23.4955, 1513.8774, -1730.7402, 12.7944, 1508.1594, -1597.0760, 23.4155},
    {489.0393, -1287.6118, 25.5172, 568.9899, -1258.9834, 21.4891, 489.9581, -1288.0050, 25.3824, 568.3211, -1259.7261, 21.3942},
    {827.1743, -1560.5813, 41.3742, 824.6799, -1633.9563, 17.0515, 826.7572, -1561.4894, 40.8943, 823.9068, -1633.3241, 17.1566},
    {1139.2487, -2453.1433, 57.2415, 1440.9519, -2287.3855, 15.1798, 1140.0836, -2452.5967, 56.8816, 1441.9508, -2287.3733, 15.1399}
};

//------------------------------------------------------------------------------

OnPlayerClickTutorialButton(playerid, BUTTON:button)
{
    if(button == BUTTON_RIGHT)
    {
        if(gPlayerTutorialPart[playerid]+1 > sizeof(gTutorialMessages))
        {
            PlayErrorSound(playerid);
            return 0;
        }
        gPlayerTutorialPart[playerid]++;
        PlaySelectSound(playerid);
    }
    else if(button == BUTTON_LEFT)
    {
        if(gPlayerTutorialPart[playerid]-1 < 0)
        {
            PlayErrorSound(playerid);
            return 0;
        }
        gPlayerTutorialPart[playerid]--;
        PlaySelectSound(playerid);
    }

    if(gPlayerTutorialPart[playerid] == sizeof(gTutorialMessages))
    {
        gPlayerTutorialPart[playerid] = 0;
        HideTutorialTextForPlayer(playerid);
        TogglePlayerSpectating(playerid, false);

        SendClientMessage(playerid, 0xFFFFFFFF, "Para visualizar o stats de seu personagem digite {88aa62}/stats{ffffff}.");
        SendClientMessage(playerid, 0xFFFFFFFF, "Apenas jogadores próximo a você irão ouvir o que você diz.");
        return 1;
    }

    new i = gPlayerTutorialPart[playerid];
    SetPlayerTutorialText(playerid, gTutorialMessages[i]);
    InterpolateCameraPos(playerid, gTutorialCameras[i][0], gTutorialCameras[i][1], gTutorialCameras[i][2], gTutorialCameras[i][3], gTutorialCameras[i][4], gTutorialCameras[i][5], 25000, CAMERA_MOVE);
    InterpolateCameraLookAt(playerid, gTutorialCameras[i][6], gTutorialCameras[i][7], gTutorialCameras[i][8], gTutorialCameras[i][9], gTutorialCameras[i][10], gTutorialCameras[i][11], 25000, CAMERA_MOVE);
    return 1;
}

//------------------------------------------------------------------------------

ShowTutorialForPlayer(playerid)
{
    ClearPlayerScreen(playerid);
    TogglePlayerSpectating(playerid, true);
    ShowTutorialTextForPlayer(playerid);

    new i = gPlayerTutorialPart[playerid];
    SetPlayerTutorialText(playerid, gTutorialMessages[i]);
    InterpolateCameraPos(playerid, gTutorialCameras[i][0], gTutorialCameras[i][1], gTutorialCameras[i][2], gTutorialCameras[i][3], gTutorialCameras[i][4], gTutorialCameras[i][5], 25000, CAMERA_MOVE);
    InterpolateCameraLookAt(playerid, gTutorialCameras[i][6], gTutorialCameras[i][7], gTutorialCameras[i][8], gTutorialCameras[i][9], gTutorialCameras[i][10], gTutorialCameras[i][11], 25000, CAMERA_MOVE);
    return 1;
}

//------------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
    gPlayerTutorialPart[playerid] = 0;
    return 1;
}
