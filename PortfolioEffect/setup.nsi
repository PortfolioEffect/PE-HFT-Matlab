; NSIS Excel Add-In Installer Script
; Include
!include MUI2.nsh
!include LogicLib.nsh
!include x64.nsh

;--------------------------------
; General
	Name "PortfolioEffect - Matlab Toolbox"
	OutFile "PortfolioEffect_Matlab.exe"
	RequestExecutionLevel admin
	InstallDir "$PROGRAMFILES\PortfolioEffect\MatlabToolbox"
	InstallDirRegKey HKCU "Software\PortfolioEffect\MatlabToolbox" "InstallDir" ; Overrides InstallDir

;--------------------------------
;Variables
Var StartMenuFolder
  
; Interface Settings
!define MUI_ABORTWARNING
!define MUI_FINISHPAGE_RUN
!define MUI_FINISHPAGE_RUN_TEXT "Installation Complete"

;Start Menu Folder Page Configuration
!define MUI_STARTMENUPAGE_REGISTRY_ROOT "HKLM" 
!define MUI_STARTMENUPAGE_REGISTRY_KEY "Software\PortfolioEffect\MatlabToolbox" 
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "Start Menu Folder"

; Installer Pages
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "license.txt"
!insertmacro MUI_PAGE_DIRECTORY
  
!insertmacro MUI_PAGE_STARTMENU Application $StartMenuFolder
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

; Uninstaller Pages
!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

; Languages
!insertmacro MUI_LANGUAGE "English"

Function StrRep
  Exch $R4 ; $R4 = Replacement String
  Exch
  Exch $R3 ; $R3 = String to replace (needle)
  Exch 2
  Exch $R1 ; $R1 = String to do replacement in (haystack)
  Push $R2 ; Replaced haystack
  Push $R5 ; Len (needle)
  Push $R6 ; len (haystack)
  Push $R7 ; Scratch reg
  StrCpy $R2 ""
  StrLen $R5 $R3
  StrLen $R6 $R1
loop:
  StrCpy $R7 $R1 $R5
  StrCmp $R7 $R3 found
  StrCpy $R7 $R1 1 ; - optimization can be removed if U know len needle=1
  StrCpy $R2 "$R2$R7"
  StrCpy $R1 $R1 $R6 1
  StrCmp $R1 "" done loop
found:
  StrCpy $R2 "$R2$R4"
  StrCpy $R1 $R1 $R6 $R5
  StrCmp $R1 "" done loop
done:
  StrCpy $R3 $R2
  Pop $R7
  Pop $R6
  Pop $R5
  Pop $R2
  Pop $R1
  Pop $R4
  Exch $R3
FunctionEnd

Function WriteToFileLine
Exch $0 ;file
Exch
Exch $1 ;line number
Exch 2
Exch $2 ;string to write
Exch 2
Push $3
Push $4
Push $5
Push $6
Push $7
 
 GetTempFileName $7
 FileOpen $4 $0 r
 FileOpen $5 $7 w
 StrCpy $3 0
 
Loop:
ClearErrors
FileRead $4 $6
IfErrors Exit
 IntOp $3 $3 + 1
 StrCmp $3 $1 0 +3
FileWrite $5 "$2$\r$\n$6" # THIS CODE ADD NEW TEXT IN LINE x WITHOUT REMOVING OLD TEXT INSTED ADD OLD TEXT IN NEW LINE
Goto Loop
FileWrite $5 $6
Goto Loop
Exit:
 
 FileClose $5
 FileClose $4
 
SetDetailsPrint none
Delete $0
Rename $7 $0
SetDetailsPrint both
 
Pop $7
Pop $6
Pop $5
Pop $4
Pop $3
Pop $2
Pop $1
Pop $0
FunctionEnd


!macro _StrReplaceConstructor ORIGINAL_STRING TO_REPLACE REPLACE_BY
  Push "${ORIGINAL_STRING}"
  Push "${TO_REPLACE}"
  Push "${REPLACE_BY}"
  Call StrRep
  Pop $0
!macroend

!define StrReplace '!insertmacro "_StrReplaceConstructor"'

; Installer Section
Section "-Install"

	SetShellVarContext all
	
	SetOutPath "$INSTDIR"
	File "license.txt"
		
	SetOutPath "$INSTDIR\jar"
	File "jar\*.jar"
	
	SetOutPath "$INSTDIR\PortfolioEffect"
	File "PortfolioEffect\*.m"
	File "PortfolioEffect\*.mat"
	
	SetOutPath "$INSTDIR\PortfolioEffect\@optimizer"
	File "PortfolioEffect\@optimizer\*.m"
	
	SetOutPath "$INSTDIR\PortfolioEffect\@portfolioContainer"
	File "PortfolioEffect\@portfolioContainer\*.m"
	
	SetOutPath "$INSTDIR\PortfolioEffect\@portfolioPlot"
	File "PortfolioEffect\@portfolioPlot\*.m"
	
	${If} ${RunningX64}
		SetRegView 64
	${EndIf}
	
	${StrReplace} "$INSTDIR\jar\ice9-quant-client-1.0-allinone.jar" "\" "/"
	StrCpy $R3 $0
	
	Push $R1
	Push $R2
	Push $R3
	
	; LOOP THROUGH ALL MATLAB INSTALLATIONS AND REGISTER TOOLBOX
	StrCpy $R1 0
	outer_loop:
		EnumRegKey $R2 HKLM "SOFTWARE\MathWorks\MATLAB\" $R1
		StrCmp $R2 "" abort
		ReadRegStr $R2 HKLM "SOFTWARE\MathWorks\MATLAB\$R2" "MATLABROOT"    
		StrCmp $R2 "" abort
		;MessageBox MB_OK "$R2"
		
		; Append classpath to the start of file
		;MessageBox MB_OK "$R3"
		Push "$R3"
		Push 1
		Push "$R2\toolbox\local\classpath.txt"
		Call WriteToFileLine
		
		IntOp $R1 $R1 + 1
		
		Push $R2
		Push $R3
		Goto outer_loop
  
	abort:  
	
	; Write keys to uninstall
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\PortfolioEffect\MatlabToolbox" "DisplayName" "MatlabToolbox"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\PortfolioEffect\MatlabToolbox" "UninstallString" '"$INSTDIR\uninstall.exe"'
	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\PortfolioEffect\MatlabToolbox" "NoModify" 1
	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\PortfolioEffect\MatlabToolbox" "NoRepair" 1

	; Create uninstaller
	WriteUninstaller "$INSTDIR\Uninstall.exe"

SectionEnd

; Start Menu
Section -StartMenu
	!insertmacro MUI_STARTMENU_WRITE_BEGIN Application ;This macro sets $SMDir and skips to MUI_STARTMENU_WRITE_END if the "Don't create shortcuts" checkbox is checked... 
	createDirectory "$SMPROGRAMS\$StartMenuFolder"
	createShortCut "$SMPROGRAMS\$StartMenuFolder\Uninstall.lnk" "$INSTDIR\uninstall.exe" "" ""
	!insertmacro MUI_STARTMENU_WRITE_END
SectionEnd

; Uninstaller Section
Section "Uninstall"
	SetShellVarContext all

	; ADD FILES TO REMOVE HERE...
	RMDir "$INSTDIR\jar"
	RMDir "$INSTDIR\PortfolioEffect"
	Delete "$INSTDIR\license.txt"
	Delete "$INSTDIR\uninstall.exe"

	RMDir "$INSTDIR"

	; Remove Start Menu launcher
	!insertmacro MUI_STARTMENU_GETFOLDER Application $StartMenuFolder
	Delete "$SMPROGRAMS\$StartMenuFolder\Uninstall.lnk"
	RMDir "$SMPROGRAMS\$StartMenuFolder\"

	DeleteRegKey HKCU "Software\PortfolioEffect\MatlabToolbox"
	DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\PortfolioEffect\MatlabToolbox"
SectionEnd