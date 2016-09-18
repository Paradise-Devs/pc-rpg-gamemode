/*
	SA-MP Log include

	Description:
		This include provide code to create server logs.

	Version:
		1.0
*/

//------------------------------------------------------------------------------

stock WriteLog(file[], text[])
{
    new File:handle = fopen(file, io_append);
    if(handle)
    {
        new string[256], second, minute, hour, day, month, year;
        getdate(year, month, day);
        gettime(hour, minute, second);

        format(string, sizeof(string), "[%02d/%02d/%d - %02d:%02d:%02d] %s\r\n", day, month, year, hour, minute, second, text);
    	fwrite(handle, string);

        fclose(handle);
    }
    else
    {
    	printf("ERROR: Failed to open file \"%s\".", file);
    }
}
