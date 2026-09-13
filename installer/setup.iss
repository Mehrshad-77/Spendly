; Spendly installer script
; Wraps the PyInstaller-built Spendly.exe into a Windows installer with a
; Start Menu shortcut and an uninstaller. Build the .exe first (see the
; README's "Building a Windows executable" section), then compile this
; with: iscc installer\setup.iss

#define MyAppName "Spendly"
#define MyAppVersion "1.0.0"
#define MyAppPublisher "Mehrshad"
#define MyAppExeName "Spendly.exe"

[Setup]
; Uniquely identifies this application across installs/upgrades - do not
; reuse this value for a different application.
AppId={{5DDC2172-1B0F-4FF6-B935-99947D0CF132}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={autopf}\{#MyAppName}
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
; Installing to Program Files requires admin rights.
PrivilegesRequired=admin
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
OutputDir=dist
OutputBaseFilename={#MyAppName}-Setup-{#MyAppVersion}
Compression=lzma2
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
; Path is relative to this .iss file's own location, matching the
; pyinstaller/windows.spec convention used elsewhere in this project.
Source: "..\pyinstaller\dist\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent
