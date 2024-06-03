#Requires AutoHotkey 2.0.15+
SetWorkingDir("E:\Downloads\AHK\")
tFile:="_.exe"
nFile(tFile),SizeB:=gSize(tFile)
aFile("Conf.txt",tFile),SizeM:=gSize(tFile)
wSize(tFile,SizeB),SizeE:=gSize(tFile)
;MsgBox(SizeB " > " SizeM " > " SizeE)

oSize:=gSize(tFile),oUInt:=rSize(tFile),oDiff:=oSize-oUInt-4
;MsgBox("N:`t" tFile "`nS:`t" oSize "`nD:`t" ((oDiff<0)?0:oDiff "b"))
eFile(tFile,"Test.txt")

eFile(Src,Dst){
  M:=gSize(Src),P:=rSize(Src),S:=M-P-4,O:=FileOpen(Src,"r")
  O.Pos:=P,O.RawRead(B:=Buffer(S),S),O.Close(),nFile(Dst)
  MsgBox("S: " P "`nF: " M "`nS: " S)
  N:=FileOpen(Dst,"a"),N.RawWrite(B,S),N.Close()
}
aFile(Src,Dst){
  O:=FileOpen(Src,"r"),S:=O.Length,O.RawRead(B:=Buffer(S),S),O.Close()
  N:=FileOpen(Dst,"a"),N.RawWrite(B,S),N.Close()
}
nFile(File){
  Try FileDelete(File)
  FileAppend("",File)
}
gSize(File){
  Return FileOpen(File,"r").Length
}
wSize(File,Size?){
  F:=FileOpen(File,"a"),Size:=IsSet(Size)?Size:gSize(File)
  NumPut("UInt",Size,B:=Buffer(4)),F.RawWrite(B,4),F.Close()
}
rSize(File){
  F:=FileOpen(File,"r"),F.Pos:=F.Length-4,F.RawRead(B:=Buffer(4),4)
  Return NumGet(B,0,"UInt")
}