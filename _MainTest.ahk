#Requires AutoHotkey 2.0.15+          ;Needs a recent AHK v2 version
SetWorkingDir(A_ScriptDir)            ;Dir used for testing
tFile:="_Test.exe"                    ;File name used for bundle testing

FileCopy("Test.exe",tFile,1)          ;Copy original AHK Exe
SizeE:=gSize(tFile)                   ;Get copy's file size
aFile("Conf.txt",tFile)               ;Append Config file to copy
wSize(tFile,SizeE)                    ;Write original exe size to bundle
MsgBox(iFile(tFile))                  ;Show packed file's info (reference only)

eFile(tFile,"_Test.txt")              ;Extract the config file to text file
fText:=FileRead("_Test.txt")          ;Read new config into memory
FileDelete("_Test.txt")               ;Delete new config
MsgBox(fText)                         ;Display read config from memory
sFile(tFile,"__Cfg.txt","__Exe.exe")  ;Split apart original exe and config

sFile(Src,Cfg,Exe?){  ;Split Src into original Exe and Cfg
  M:=gSize(Src),P:=rSize(Src),S:=M-P-4
  If IsSet(Exe){
    O:=FileOpen(Src,"r"),O.RawRead(B:=Buffer(P),P),O.Close()
    nFile(Exe)
    N:=FileOpen(Exe,"a"),N.RawWrite(B,P),N.Close()
  }
  eFile(Src,Cfg)
}
iFile(Src){  ;Get info from bundled Src; namely the position/sizes of Exe, Cfg, and Dat (size info)
  M:=gSize(Src),P:=rSize(Src),S:=M-P-4
  Return ("Name:`t" Src "`nExe:`t0 > " P " (" P ")`nCfg:`t" P+1 " > " M-4 " (" S ")`nDat:`t" M-3 " > " M " (4)")
}
eFile(Src,Cfg){  ;Extract Cfg from bundled Src
  M:=gSize(Src),P:=rSize(Src),S:=M-P-4
  O:=FileOpen(Src,"r"),O.Pos:=P,O.RawRead(B:=Buffer(S),S),O.Close()
  nFile(Cfg)
  N:=FileOpen(Cfg,"a"),N.RawWrite(B,S),N.Close()
}
aFile(Src,Cfg){  ;Append Cfg to Src exe
  O:=FileOpen(Src,"r"),S:=O.Length,O.RawRead(B:=Buffer(S),S),O.Close()
  N:=FileOpen(Cfg,"a"),N.RawWrite(B,S),N.Close()
}
nFile(Src){  ;Creates an empty Src ready for population (deletes existing file, if any)
  Try FileDelete(Src)
  FileAppend("",Src)
}  ;nFile(Src) => (FileExist(Src)?FileDelete(Src):"",FileAppend("",Src))
gSize(Src){  ;Get file size of Src
  O:=FileOpen(Src,"r"),S:=O.Length,O.Close()
  Return S
}  ;gSize(Src) => FileOpen(Src,"r").Length
wSize(Src,Siz?){  ;Append a size position point (Siz) to Src for splitting the exe and cfg 
  F:=FileOpen(Src,"a"),Siz:=IsSet(Siz)?Siz:gSize(Src),NumPut("UInt",Siz,B:=Buffer(4)),F.RawWrite(B,4),F.Close()
}
rSize(Src){  ;Just reads the appended size position point from the Src file
  F:=FileOpen(Src,"r"),F.Pos:=F.Length-4,F.RawRead(B:=Buffer(4),4),F.Close()
  Return NumGet(B,0,"UInt")
}