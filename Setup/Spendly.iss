; Inno Setup installer for Spendly
; Build the app first with:
;   pyinstaller packaging/spendly.spec

#define MyAppName "Spendly"
#define MyAppVersion "1.0.0"
#define MyAppPublisher "Spendly"
#define MyAppExeName "Spendly.exe"

[Setup]
AppId={{8A8B6F70-7D76-4B80-AF8B-5B5C9D9F4A21}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={autopf}\Spendly
DefaultGroupName=Spendly
OutputDir=installer
OutputBaseFilename=Spendly-Setup
Compression=lzma
SolidCompression=yes
WizardStyle=modern
SetupIconFile=spendly.ico
UninstallDisplayIcon={app}\Spendly.exe

[Files]
Source: "..\dist\Spendly.exe"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{group}\Spendly"; Filename: "{app}\Spendly.exe"; IconFilename: "{app}\Spendly.exe"
Name: "{autodesktop}\Spendly"; Filename: "{app}\Spendly.exe"; IconFilename: "{app}\Spendly.exe"

[Run]
Filename: "{app}\Spendly.exe"; Description: "Launch Spendly"; Flags: nowait postinstall skipifsilent
