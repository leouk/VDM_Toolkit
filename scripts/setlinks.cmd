:: !\bin\bash
:: Copy jars and set symlinks to Maven

@echo off


setlocal enableDelayedExpansion
set argCount=0
for %%x in (%*) do (
   set /A argCount+=1
)

if %argCount% NEQ 2 (
    echo "setlinks_windows.sh <VDM VSCode version> <VDMJ suite version>"
    exit 1
)


cd %UserProfile%\.vscode
set VERSION=%1
set SUITE=%2

if NOT exist  extensions\overturetool.vdm-vscode-%VERSION%\ (
    echo "Cannot find extensions\overturetool.vdm-vscode-%VERSION%"
    exit 1
)

set RESOURCES=extensions\overturetool.vdm-vscode-%VERSION%\resources


setlocal enableDelayedExpansion 

for %%x in (jars\vdmj, jars\vdmj_hp, jars\plugins) do (
	echo "Jars already saved, cleaning %x..."
	del %RESOURCES%\%%x\vdmj*.jar 
	del %RESOURCES%\%%x\lsp*.jar 
	del %RESOURCES%\%%x\annotations*.jar 
	del %RESOURCES%\%%x\libs\stdlib*.jar 
	del %RESOURCES%\%%x\vdm2isa*.jar 
	del %RESOURCES%\%%x\libs\vdmlib*.jar 
)
echo "Creating jar links"


mklink %RESOURCES%\jars\vdmj\annotations-%SUITE%-SNAPSHOT.jar  %UserProfile%\.m2\repository\com\fujitsu\annotations\%SUITE%-SNAPSHOT\annotations-%SUITE%-SNAPSHOT.jar 
mklink %RESOURCES%\jars\vdmj\annotations2-%SUITE%-SNAPSHOT.jar  %UserProfile%\.m2\repository\com\fujitsu\annotations2\%SUITE%-SNAPSHOT\annotations2-%SUITE%-SNAPSHOT.jar 
mklink %RESOURCES%\jars\vdmj\vdmj-%SUITE%-SNAPSHOT.jar  %UserProfile%\.m2\repository\com\fujitsu\vdmj\%SUITE%-SNAPSHOT\vdmj-%SUITE%-SNAPSHOT.jar 
mklink %RESOURCES%\jars\vdmj\lsp-%SUITE%-SNAPSHOT.jar  %UserProfile%\.m2\repository\com\fujitsu\lsp\%SUITE%-SNAPSHOT\lsp-%SUITE%-SNAPSHOT.jar 
mklink %RESOURCES%\jars\vdmj\libs\stdlib-%SUITE%-SNAPSHOT.jar %UserProfile%\.m2\repository\com\fujitsu\stdlib\%SUITE%-SNAPSHOT\stdlib-%SUITE%-SNAPSHOT.jar 

mklink %RESOURCES%\jars\vdmj\annotationsVDMToolkit-%SUITE%-SNAPSHOT.jar %UserProfile%\.m2\repository\vdmtoolkit\annotationsVDMToolkit\%SUITE%-SNAPSHOT\annotationsVDMToolkit-%SUITE%-SNAPSHOT.jar 
mklink %RESOURCES%\jars\plugins\vdm2isa-%SUITE%-SNAPSHOT.jar  %UserProfile%\.m2\repository\vdmtoolkit\vdm2isa\%SUITE%-SNAPSHOT\vdm2isa-%SUITE%-SNAPSHOT.jar 
mklink %RESOURCES%\jars\vdmj\libs\vdmlib-%SUITE%-SNAPSHOT.jar %UserProfile%\.m2\repository\vdmtoolkit\vdmlib\%SUITE%-SNAPSHOT\vdmlib-%SUITE%-SNAPSHOT.jar 
echo "Created jar links"

mklink %RESOURCES%\jars\vdmj_hp\annotations-%SUITE%-P-SNAPSHOT.jar  %UserProfile%\.m2\repository\com\fujitsu\annotations\%SUITE%-P-SNAPSHOT\annotations-%SUITE%-P-SNAPSHOT.jar 
mklink %RESOURCES%\jars\vdmj_hp\annotations2-%SUITE%-P-SNAPSHOT.jar %UserProfile%\.m2\repository\com\fujitsu\annotations2\%SUITE%-P-SNAPSHOT\annotations2-%SUITE%-P-SNAPSHOT.jar 
mklink %RESOURCES%\jars\vdmj_hp\vdmj-%SUITE%-P-SNAPSHOT.jar  %UserProfile%\.m2\repository\com\fujitsu\vdmj\%SUITE%-P-SNAPSHOT\vdmj-%SUITE%-P-SNAPSHOT.jar 
mklink %RESOURCES%\jars\vdmj_hp\lsp-%SUITE%-P-SNAPSHOT.jar %UserProfile%\.m2\repository\com\fujitsu\lsp\%SUITE%-P-SNAPSHOT\lsp-%SUITE%-P-SNAPSHOT.jar 
mklink %RESOURCES%\jars\vdmj_hp\libs\stdlib-%SUITE%-P-SNAPSHOT.jar %UserProfile%\.m2\repository\com\fujitsu\stdlib\%SUITE%-P-SNAPSHOT\stdlib-%SUITE%-P-SNAPSHOT.jar 

mklink %RESOURCES%\jars\vdmj_hp\libs\vdmlib-%SUITE%-P-SNAPSHOT.jar  %UserProfile%\.m2\repository\vdmtoolkit\vdmlib\%SUITE%-SNAPSHOT\vdmlib-%SUITE%-P-SNAPSHOT.jar 
echo "Created high precision links"

echo "Done"
