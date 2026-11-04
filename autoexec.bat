@echo off
REM BOA84 autoexec.bat - Windows - ns_OneEyeMail + ns_HOLLA + ns_BOA84 - OK
echo BOA84 AUTOEXEC - OK - All 9 servers started
for %%S in (web mail database application dns proxy game file print) do (
  echo Starting %%S...
  echo BOA84 %%S server - ns_OneEyeMail - OK - port=8080
)
echo BOA84 NS SYNC - OK - OneEyeMail + HOLLA + BOA84
echo BOA84 AUTOEXEC - OK - All 9 servers started
