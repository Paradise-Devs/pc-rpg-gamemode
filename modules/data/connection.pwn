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
new mysql;

//------------------------------------------------------------------------------

hook OnGameModeInit()
{
	// Reading mysql.cfg data
	new MYSQL_DEBUG[12], MYSQL_HOST[18], MYSQL_USER[32], MYSQL_DB[32], MYSQL_PASS[128];
	if(fexist("mysql.cfg"))
	{
		new
			File:cfg = fopen("mysql.cfg", io_read),
			buffer[28]
		;
	    while(fread(cfg, buffer))
	    {
			if(!strcmp(buffer, "MYSQL_HOST", false, 10))
			{
				strdel(buffer, 0, strfind(buffer, "=") + 1);
				strdel(buffer, strlen(buffer) - 1, strlen(buffer));
				strcat(MYSQL_HOST, buffer);
			}
			if(!strcmp(buffer, "MYSQL_DEBUG", false, 11))
			{
				strdel(buffer, 0, strfind(buffer, "=") + 1);
				strdel(buffer, strlen(buffer) - 1, strlen(buffer));
				strcat(MYSQL_DEBUG, buffer);
			}
			if(!strcmp(buffer, "MYSQL_USER", false, 10))
			{
				strdel(buffer, 0, strfind(buffer, "=") + 1);
				strdel(buffer, strlen(buffer) - 1, strlen(buffer));
				strcat(MYSQL_USER, buffer);
			}
			if(!strcmp(buffer, "MYSQL_DB", false, 8))
			{
				strdel(buffer, 0, strfind(buffer, "=") + 1);
				strdel(buffer, strlen(buffer) - 1, strlen(buffer));
				strcat(MYSQL_DB, buffer);
			}
			if(!strcmp(buffer, "MYSQL_PASS", false, 10))
			{
				strdel(buffer, 0, strfind(buffer, "=") + 1);
				strdel(buffer, strlen(buffer) - 1, strlen(buffer));
				strcat(MYSQL_PASS, buffer);
			}
	    }
		fclose(cfg);
	}
	else
	{
		print("ERROR: Could not find mysql.cfg in scriptfiles!");
		return -1;
	}

	// Enabling LOGs if the server is running in development mode
	if(!strcmp(MYSQL_DEBUG, "true"))
	{
		mysql_log(LOG_ERROR | LOG_WARNING | LOG_DEBUG);
	}

	printf("%s %s %s %s %s", MYSQL_DEBUG, MYSQL_HOST, MYSQL_USER, MYSQL_DB, MYSQL_PASS);
	// Connecting to database
	mysql = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_DB, MYSQL_PASS);

	// If mysql information is wrong
	if(mysql_errno(mysql) != 0)
    {
        print("ERROR: Could not connect to database!");
        return -1;
    }
	else printf("Connected to database %s at %s successfully!", MYSQL_DB, MYSQL_HOST);
	return 1;
}
