#Requires AutoHotkey 2.0.15+
SetWorkingDir(A_ScriptDir)

FileCopy("Test.exe","TestMod.exe",1)
wSize("TestMod.exe")

gSize(File){
  Return FileOpen(File,"r").Length
}
wSize(File){
  F:=FileOpen(File,"a")
  NumPut("UInt",gSize(File),B:=Buffer(4))
  F.RawWrite(B,4),F.Close()
}
rSize(File){
  F:=FileOpen(File,"r")
  F.Pos:=F.Length-4,F.RawRead(B:=Buffer(4),4)
  Return NumGet(B,0,"UInt")
}