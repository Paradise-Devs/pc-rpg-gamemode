# Paradise City RPG (SA-MP)

Paradise City RPG é um gamemode para [San Andreas Multiplayer](http://sa-mp.com/) com o propósito de criar um ambiente onde jogadores possam interagir entre si e criar situações parecidas com a da vida real.

## Configurando

* Copie os arquivos do SA-MP server para a raiz do projeto.
* Edite as credenciais do arquivo [connection.pwn](https://github.com/Wuzi/pc-rpg-gamemode/blob/master/modules/data/connection.pwn).
* Compile o arquivo [main.pwn](https://github.com/Wuzi/pc-rpg-gamemode/blob/master/gamemodes/main.pwn)¹², os [filterscripts](https://github.com/Wuzi/pc-rpg-gamemode/tree/master/filterscripts) e os [npcmodes](https://github.com/Wuzi/pc-rpg-gamemode/tree/master/npcmodes).
* Importe o arquivo [pcrpg.sql](https://github.com/Wuzi/pc-rpg-gamemode/blob/master/database/pcrpg.sql) no banco de dados.
* Inicie o servidor.

¹ Você precisará direcionar o compilador para utilizar a pasta includes ou apenas copie a pasta includes para a pasta de seu compilador.

² É necessário utilizar [este compilador](https://github.com/pawn-lang/compiler) para compilar o gamemode.