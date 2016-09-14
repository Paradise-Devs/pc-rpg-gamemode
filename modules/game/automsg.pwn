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
	"* Precisa de ajuda? Digite /ajuda ou procure um paradiser.",
	"* Você sabia? Você pode conversar conosco no Discord do servidor, visite o site para mais informações.",
	"* Você é um bom jogador e sabe tudo sobre nosso servidor? Candidate-se para paradiser em nosso site.",
	"* Viu algum jogador quebrando alguma regra? /reportar [id] [motivo]",
	"* Gostou do servidor? Quer elogiar ou criticar algo? Acesse nosso fórum www.pc-rpg.com",
	"* O site do nosso servidor sempre possui novidades e noticias, fique atento! www.pc-rpg.com",
	"* Existem eventos programados especialmente pela nossa equipe, eles são divulgados no discord e no site, fique ligado.",
	"* Caso esteja enfrentando algum problema, procure um adminstrador.",
	"* Se você encontrou algum bug, relate aos desenvolvedores pelo UCP em feedback.",
	"* Já curtiu nossa página no Facebook? www.facebook.com/paradisecityrpg",
	"* Interaja com outros membros e com os administradores no UCP. www.pc-rpg.com",
	"* Os empregos são a melhor forma de ganhar dinheiro, o tempo que você fica logado também influencia no pagamento.",
	"* Tem alguma sugestão? Use o site!."
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

		SendClientMessage(i, COLOR_SPECIAL, advertises_array[gMessageIndex]);
    }

	gMessageIndex++;
}
