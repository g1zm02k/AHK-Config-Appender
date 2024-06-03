#Requires AutoHotkey 2.0.15+
DetectHiddenWindows 1

If A_Args.Length{
  If FileExist(A:=A_Args[1])
    WinClose("ahk_exe " A),FileDelete(A)
  Else
    MsgBox("Passed: " A)
  MsgBox("It works!")
  ExitApp
}Else{
  If FileExist("Fixer.exe"){
    MsgBox("You're running 'Fixer' manually!")
    ExitApp()
  }
  FileCopy(S:=A_ScriptName,"Fixer.exe",1)
  Run("Fixer.exe " S)
}

Esc::ExitApp  ;Safety key!