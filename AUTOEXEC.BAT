@ECHO OFF
REM BOA84 FAT32 KDP - AUTOEXEC.BAT - Compadre Edition - OK
ECHO BOA84 Starting...
ECHO OneEyeMail - BLUH - NASA
CD servers\web
START python3 main.py
CD ..\mail
START python3 main.py
CD ..\database
START python3 main.py
CD ..\..
ECHO BOA84 AUTOEXEC - OK - All servers started
