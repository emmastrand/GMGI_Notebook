# Setting Up VSCode for Windows 

I love using VSCode ([Visual Studio Code](https://code.visualstudio.com/)) and find this to be the best interface for coding, using github, connecting to a server, etc. Especially because Windows requires an SSH client (e.g., PuTTYgen). Mac systems do not require this set-up. 

Resources:  
- Starting instructions: https://code.visualstudio.com/docs/remote/ssh  
- For a remote SSH host: https://learn.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse?tabs=gui  


# Remote Development using SSH 

VSCode allows for a SSH extension but requires several set-up steps below. 

## 01. Installation
 
1. Install [VSCode](https://code.visualstudio.com/).   
2. Install [Remote SSH extension application](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh). This is an extension in VSCode that lets you work with an SSH server.    
3. Install an [OpenSSH compatible SSH client](https://code.visualstudio.com/docs/remote/troubleshooting#_installing-a-supported-ssh-client) if one is not already present. *See below for instructions from the link above.* 

OpenSSH compatible SSH client: Get started with OpenSSH for Windows

### 01a. Prerequisities  

- **A device running at least Windows Server 2019 or Windows 10 (build 1809).** To check this, open Windows Powershell and use the command `winver.exe`. This will open a pop-up window with your computer's current software.    
- **PowerShell 5.1 or later**. Run `$PSVersionTable.PSVersion` in Windows Powershell. Verify your major version is at least 5, and your minor version at least 1.   
- **An account that is a member of the built-in Administrators group.** To check this, run the command below. If you are running shell as an admin then the output will be True. If the output is False, click the down arrow next the new tab icon and select 'Settings'. Under 'Profiles', select 'Defaults'. For the option 'Run this profile as Administrator' select 'on'. Save your changes and restart Powershell. Run the below again to double check this worked.  

```
(New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
```

If you need to download Windows Powershell, see [here](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.3). This program likely came already installed on your computer. 

### 01b. Install OpenSSH for Windows 

GUI instructions outlined [here](https://learn.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse?tabs=powershell). Powershell instructions (from the same above link) are annotated below: 

1. To make sure that OpenSSH is available, run the following cmdlet: 

```
Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH*'
```

The output will show if Open.SSH Client or Server are installed. My output is below. 

```
Name  : OpenSSH.Client~~~~0.0.1.0
State : Installed

Name  : OpenSSH.Server~~~~0.0.1.0
State : NotPresent
```

2. Install the serve or client components as needed:

```
# Install the OpenSSH Client
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0

# Install the OpenSSH Server
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
```

My output is below. This might take a few minutes.  

```
Path          :
Online        : True
RestartNeeded : False
```

3. To start and configure OpenSSH Server for initial use, open an elevated PowerShell prompt (right click, Run as an administrator), then run the following commands to start the `sshd service`: 

Start sshd service: `Start-Service sshd`  
Recommended by Microsoft: `Set-Service -Name sshd -StartupType 'Automatic'`  

Confirm the Firewall rule is configured. It should be created automatically by setup. Run the following to verify

```
if (!(Get-NetFirewallRule -Name "OpenSSH-Server-In-TCP" -ErrorAction SilentlyContinue | Select-Object Name, Enabled)) {
    Write-Output "Firewall Rule 'OpenSSH-Server-In-TCP' does not exist, creating it..."
    New-NetFirewallRule -Name 'OpenSSH-Server-In-TCP' -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
} else {
    Write-Output "Firewall rule 'OpenSSH-Server-In-TCP' has been created and exists."
}
```

My output: `Firewall rule 'OpenSSH-Server-In-TCP' has been created and exists.`

## 02. Connect to OpenSSH Server 

Once installed, you can connect to OpenSSH Server from a Windows or Windows Server device with the OpenSSH client installed. From a PowerShell prompt, run the following command.

Fill in with GMGI's information (server name is the IP address): `ssh username@servername`. 

My output: 

```
The authenticity of host 'servername (10.00.00.001)' can't be established.
ECDSA key fingerprint is SHA256:(<a large string>).
Are you sure you want to continue connecting (yes/no)?
```

Entering yes adds that server to the list of known SSH hosts on your Windows client.

At this point, you'll be prompted for your password. As a security precaution, your password won't be displayed as you type.

Once connected, you'll see the Windows command shell prompt:

```
domain\username@SERVERNAME C:\Users\username>
```

## 03. Connecting to a remote host 

1. Verify you can connect to the SSH host by running the following command from a terminal / PowerShell window replacing `user@hostname` as appropriate.

```
ssh user@hostname
# Or for Windows when using a domain / AAD account
ssh user@domain@hostname
```

*Warning: I couldn't get the steps below to work but am able to access the server through the terminal portion of VSCode, which is what I'm used to doing anyway.. come back to these final steps..* 

2. In VS Code, select Remote-SSH: Connect to Host... from the Command Palette (`F1`, `Ctrl+Shift+P`) and use the same user@hostname as in step 1.

![](https://code.visualstudio.com/assets/docs/remote/ssh/ssh-user@box.png)

3. If VS Code cannot automatically detect the type of server you are connecting to, you will be asked to select the type manually.

![](https://code.visualstudio.com/assets/docs/remote/ssh/ssh-select-platform.png)

Once you select a platform, it will be stored in [VS Code settings](https://code.visualstudio.com/docs/getstarted/settings) under the remote.SSH.remotePlatform property so you can change it at any time.

4. After a moment, VS Code will connect to the SSH server and set itself up. VS Code will keep you up-to-date using a progress notification and you can see a detailed log in the `Remote - SSH` output channel.

5. After you are connected, you'll be in an empty window. You can always refer to the Status bar to see which host you are connected to.

![](https://code.visualstudio.com/assets/docs/remote/ssh/ssh-statusbar.png)

6. You can then open any folder or workspace on the remote machine using File > Open... or File > Open Workspace... just as you would locally! 

![](https://code.visualstudio.com/assets/docs/remote/ssh/ssh-open-folder.png)