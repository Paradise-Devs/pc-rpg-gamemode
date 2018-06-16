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

#define MYSQL_HOST        "127.0.0.1"
#define MYSQL_USER        "root"
#define MYSQL_PASS        ""
#define MYSQL_DB        "pcrpg"
#define MYSQL_DEBUG        true

new mysql;

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
    #if MYSQL_DEBUG == true
        mysql_log(LOG_ERROR | LOG_WARNING | LOG_DEBUG);
    #endif

    mysql = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_DB, MYSQL_PASS);

    if (mysql_errno(mysql) != 0)
    {
        print("ERROR: Could not connect to database!");
        return -1;
    }
    else
    {
        print("Connected to database successfully!");
    }
    return 1;
}
