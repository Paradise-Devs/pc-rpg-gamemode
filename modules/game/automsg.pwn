/*******************************************************************************
* FILENAME :        modules/game/automsg.pwn
*
* DESCRIPTION :
*       Sends periodically server messages to the players.
*
* NOTES :
*       -
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

//------------------------------------------------------------------------------

static gMessageIndex = 0;

static advertises_array[][] =
{
	"Precisa de ajuda? Digite /ajuda ou procure um backup.",
	"Você sabia? Você pode conversar no IRC do servidor usando um Walkie Talkie na freq. 1337Mhz.",
	"Você é um bom jogador e sabe tudo sobre nosso servidor? Candidate-se para backup em nosso fórum.",
	"Viu algum jogador quebrando alguma regra? /reportar [id] [motivo]",
	"Gostou do servidor? Quer elogiar ou criticar algo? Acesse nosso fórum www.pc-rpg.com.br/forum",
	"O site do nosso servidor sempre possui novidades e noticias, fique atento! www.pc-rpg.com.br",
	"Existem eventos programados especialmente pela nossa equipe, eles são divulgados no fórum e no site, fique ligado.",
	"Caso esteja enfrentando algum problema, procure um adminstrador.",
	"Se você encontrou algum bug, relate aos desenvolvedores pelo fórum.",
	"Dá curtiu nossa página no Facebook? www.facebook.com/paradisecityrpg",
	"Interaja com outros membros e com os administradores no fórum. www.pc-rpg.com.br/forum",
	"Os empregos são a melhor forma de ganhar dinheiro, o tempo que você fica logado também influencia no pagamento.",
	"Tem alguma sugestão? Use o fórum!."
};

//------------------------------------------------------------------------------

task SendServerMessages[INTERVAL_BETWEEN_SERVER_MESSAGES]()
{
	if(gMessageIndex > sizeof(advertises_array)-1)
		gMessageIndex = 0;
    foreach(new i: Player)
    {
        if(!IsPlayerLogged(i) || IsPlayerPaused(i))
            continue;

		SendServerMessage(advertises_array[gMessageIndex]);
    }
	gMessageIndex++;
}
