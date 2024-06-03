E:=gSize(A_ScriptName)
S:=rSize(A_ScriptName)

D:=E-S
MsgBox("Name:`t" A_ScriptName
   . "`nComp:`t" E
   . "`nDiff:`t" ((D<0)?"Orig":D "b larger."))

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