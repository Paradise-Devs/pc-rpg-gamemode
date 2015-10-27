/*******************************************************************************
* FILENAME :        modules/data/connection.pwn
*
* DESCRIPTION :
*       Starts the connection with the database
*
* NOTES :
*       This file should only contain information about connections
*
*       Copyright Paradise Devs 2015.  All rights reserved.
*
*/

#include <YSI\y_hooks>

#define MySQL_HOST		"localhost"
#define MySQL_USER		"root"
#define MySQL_DB		"pcrpg"
#define MySQL_PASS		"adminpass"
new mysql;

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
	mysql_log(LOG_ERROR | LOG_WARNING | LOG_DEBUG);
	mysql = mysql_connect(MySQL_HOST, MySQL_USER, MySQL_DB, MySQL_PASS);
	if(mysql_errno(mysql) != 0)
    {
        print("ERROR: Could not connect to database!");
        return -1;
    }
	else printf("Connected to database %s at %s successfully!", MySQL_DB, MySQL_HOST);
	return 1;
}
