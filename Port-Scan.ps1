#Get Param
param(
    [string]$target,
    [int]$startPort,
    [int]$endPort,
    [int]$time,
    [bool]$fast
)

#Check the Parameters and Set default value of loaclhost
if(-not $target){$target = "127.0.0.1"}
if(-not $startPort){$startPort = 1}
if(-not $endPort){$endPort = 1024}
if(-not $time){ $time = 1}

#Help Statement
if($args.Count -eq 1 -and ($args[0] -eq "-h")){
    Write-Host "Usage => .\Port-Scan.ps1 -target <TARGET_IP> -startPort <START_PORT> -endPort <END_PORT> -time <TIME_DELAY> -fast <BOOLEAN_VALUE>"
    Write-Host "`n"
    Write-Host "Example => .\Port-Scan.ps1 -target 127.0.0.1 -startPort 1 -endPort 1024 -time 3 -fast 1"
    exit 1
}

Write-Host "Port Scanning on target : $target"

#Define Open Port array
$global:openPorts = @()

#Common Port Hashtable
$commonPorts = @{
    21 = "FTP"          # FTP (File Transfer) on port 21
    22 = "SSH"          # SSH (Secure Shell) on port 22
    23 = "Telnet"       # Telnet (Remote login service)
    25 = "SMTP"         # SMTP (Mail) on port 25
    53 = "DNS"          # DNS (Domain Name System)
    80 = "HTTP"         # HTTP (Web Service) on port 80
    110 = "POP3"        # POP3 (Post Office Protocol)
    123 = "NTP"         # (Network Time Protocol)
    135 = "RPC"         # RPC (Remote Procedural Call)
    143 = "IMAP"        # IMAP (Internet Message Access Protocol)
    389 = "LDAP"        # LDAP (Directory) on port 389
    443 = "HTTPS"       # HTTPS (Secure Web Service) on port 443
    445 = "SMB"         # SMB (Server Message Block)
    636 = "LDAPS"       # LDAPS (Secure LDAP) on port 636
    1433 = "MSSQL"       # (Microsoft SQL Server)
    1521 = "Oracle"     # Oracle Database on port 1521
    3306 = "MySQL"      # MySQL Database on port 3306
    5432 = "PostgreSQL" # PostgreSQL Database on port 5432
    8080 = "HTTP-Alt"   # HTTP Alternate (commonly used for web proxy and caching server)
    8443 = "HTTPS-alt"   # (Alternative port for HTTPS)
    # Add more ports and their services as needed
}


#Test-Port Function Definition
function Test-Port{

    param (
    [string]$target,
    [int]$port,
    [int]$time
    )

    $connectObj = New-Object System.Net.Sockets.TcpClient
    $connectResult = $connectObj.BeginConnect($target,$port,$null,$null)
    # Error handling for the connection attempt
    try {
        $wait = $connectResult.AsyncWaitHandle.WaitOne($time * 100, $false)
        if ($wait -and $connectObj.Connected) {
            $serviceName = $commonPorts[$port]
            $serviceInfo = if ($serviceName) { "$port - $serviceName" } else { "Unknown Service on $port" }
            $global:openPorts += $serviceInfo
            $connectObj.Close()
        }
    }
    catch {
        Write-Host "Error occurred while connecting to port $port :ls
         $_"
    }

}

Write-Host "Scanning...."
if($fast){
    foreach($port in $commonPorts.Keys){
        #Function Call
        Test-Port -target $target -port $port -time $time
    }
}
else{
#Loop through port 1 - 1024 using for loop
    for($port=$startPort; $port -le $endPort; $port++){
        #Function Call
        Test-Port -target $target -port $port -time $time
    }
}

#Print it out
if($openPorts -eq 0){

    Write-Host "There is no port open in the target : $target"
}
else{

    $global:openPorts | ForEach-Object {Write-Host "Port $_ is open!"}

}