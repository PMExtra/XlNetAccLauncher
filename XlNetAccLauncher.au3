#Region ;**** 编译指令由 AutoIt3Wrapper 选项编译窗口创建 ****
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_Change2CUI=y
#AutoIt3Wrapper_Res_requestedExecutionLevel=requireAdministrator
#EndRegion ;**** 编译指令由 AutoIt3Wrapper 选项编译窗口创建 ****

Func GetPath()
	Local $path = RegRead("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run", "XlNetAcc")
	If @error == 0 Then
		RegDelete("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run", "XlNetAcc")
		RegWrite("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\XlNetAccLauncher", "XlNetAcc", "REG_SZ", "rem|" & $path)
		Return $path
	EndIf
	$path = RegRead("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\XlNetAccLauncher", "XlNetAcc")
	If @error == 0 Then
		$path = StringSplit($path, "|")[2]
		Return $path
	EndIf
	Local $regError = @error
	If FileExists("XlNetAcc.exe") Then
		$path = "XlNetAcc.exe"
		Return $path
	EndIf
	SetError($regError)
	Return ""
EndFunc

Local $path = GetPath()
If @error Then
	ConsoleWrite("Cannot found Thunder Net Accelerator. @error = " & @error)
	Sleep(10000)
	Exit
EndIf

ConsoleWrite("$path = " & $path)
Run($path)
WinWait("迅雷快鸟", "", 15)
WinClose("迅雷快鸟")
