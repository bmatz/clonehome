# clonehome
WSL Init Script

`bash -c "$(wget -O- https://raw.githubusercontent.com/bmatz/clonehome/master/install.sh)"`

## SSH AGENT

Download latest version of `wsl-ssh-agent` from https://github.com/rupor-github/wsl-ssh-agent/releases.
Unpack it to `c:\Program Files\wsl-ssh-agent`.

Ensure running windows ssh-agent in PowerShell
```PowerShell
Start-Service ssh-agent
Set-Service -StartupType Automatic ssh-agent
```

```
WinKey + R
shell:startup
```
Add Shortcut to `c:\Program Files\wsl-ssh-agent\wsl-ssh-agent-gui.exe`
Update Target in Shortcut by adding `-socket "%USERPROFILE%\ssh-agent.sock"`

## Windows Terminal Settings

#### Terminal Profile
```json
 {
      "name": "Ubuntu-Blank",
      "commandline": "wsl.exe ~ -d Ubuntu-Blank",
      "acrylicOpacity": 0.80000001192092896,
      "closeOnExit": true,
      "colorScheme": "Solarized Dark",
      "cursorColor": "#FFFFFF",
      "cursorShape": "bar",
      "fontFace": "Fira Code",
      "fontSize": 12,
      "historySize": 9001,
      "icon": "ms-appx:///ProfileIcons/{9acb9455-ca41-5af7-950f-6bca1bc9722f}.png",
      "padding": "0, 0, 0, 0",
      "snapOnInput": true,
      "useAcrylic": true
    },
```

#### Terminal Scheme
```json
{
      "name": "Solarized Dark",
      "background": "#001d27",
      "black": "#073642",
      "blue": "#268BD2",
      "brightBlack": "#91b6c3",
      "brightBlue": "#839496",
      "brightCyan": "#93A1A1",
      "brightGreen": "#586E75",
      "brightPurple": "#6C71C4",
      "brightRed": "#CB4B16",
      "brightWhite": "#FDF6E3",
      "brightYellow": "#657B83",
      "cyan": "#2AA198",
      "foreground": "#839496",
      "green": "#859900",
      "purple": "#D33682",
      "red": "#DC322F",
      "white": "#EEE8D5",
      "yellow": "#B58900"
},
```

#### Other Terminal Settings
```json
  "initialCols": 120,
  "initialRows": 35,
  "requestedTheme": "system",
  "showTabsInTitlebar": true,
  "showTerminalTitleInTitlebar": true,
  "wordDelimiters": " ./\\()\"'-:,.;<>~!@#$%^&*|+=[]{}~?\u2502",
```

## Deprecated

#### Import Distro
```cmd
wsl --import c:\users\Bernhard\WSLDistros\UbuntuBlank ubuntu_1804_blank
```

#### PowerShell

```PowerShell
Get-ItemProperty Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Lxss\*\ DistributionName | Where-Object -Property DistributionName -eq Ubuntu-Blank | Set-ItemProperty -Name DefaultUid -Value 1000
```

