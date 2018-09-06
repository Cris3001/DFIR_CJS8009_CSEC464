
$osInfo = Get-WmiObject win32_OperatingSystem


#
#Time
#
echo "Printing Time Information:" ""
$time = Get-Date -UFormat "%r"
echo ("Current time: " + $time) | Export-Csv -Path "E:\test.csv"
$zone = Get-TimeZone
echo ("Timezone: " + $zone.StandardName)
$uptime = (Get-Date) - ($osInfo.ConvertToDateTime($osInfo.LastBootUpTime))
$uptimePrint = "Uptime: " + $uptime.Days + " days, " + $uptime.Hours + " hours, " + $uptime.Minutes + " minutes."
$uptimePrint

#
#OS version
#
echo "" "Printing OS version:" ""
$osInfo.Version


#
#System hardware specs
#
echo "" "Printing hardware specs:" ""
$cpuInfo = Get-CimInstance Win32_Processor
echo ("CPU Brand and type: " + $cpuInfo.Name)
$memoryInfo = Get-CimInstance Win32_ComputerSystem
echo ("Total RAM: " + [Math]::Round(($memoryInfo.TotalPhysicalMemory/ 1GB),2) + "GB")
$hardriveInfo = Get-CimInstance Win32_volume -Filter "DriveLetter='C:'"
echo ("Total HDD: " + [Math]::Round(($hardriveInfo.Capacity/ 1GB),2) + "GB")

#
#Get domain controller info
#
echo "" "Printing domain controller info:" ""

#
#Hostname and domain
#
echo "" "Printing hostname and domain:" ""
$domainInfo = Get-CimInstance Win32_ComputerSystem
echo ("Hostname: " + $domainInfo.Name)
echo ("Domain: " + $domainInfo.Domain)

#
#List of users
#
echo "" "Printing list of users:" ""
$userInfo = Get-CimInstance Win32_UserAccount
foreach ($user in $userInfo){
    echo($user.Name + $user.SID)
}
$logonInfo = Get-EventLog -LogName Security 
foreach($event in $logonInfo){
    if(($event.EventID -eq 4624) -and ($event.ReplacementStrings[8] -eq 5)){
        echo ("Type: Local Logon: " + $event.TimeGenerated + " " + $event.ReplacementStrings[5] + $event.UserName)
    }
}


#
#Start at boot
#
echo "" "Printing start at boot programs and services:" ""
$bootInfo = Get-CimInstance Win32_StartupCommand | Select-Object Name, command, Location, User | Format-List
$bootInfo

$servicesInfo = Get-CimInstance Win32_Service -Filter "StartMode='Auto'" | Select-Object Name, StartMode
$servicesInfo

#
#List of scheduled tasks
#
echo "" "Printing scheduled tasks:" ""
#$taskInfo = Get-ScheduledTask
#$taskInfo

#
#Network
#
echo "" "Printing network info:" ""
$arpInfo = arp -a
#$arpInfo
#$macInfo = ipconfig /all 
#$macInfo 
$networkInfo = Get-NetIPAddress
#$networkInfo
$networkInfo.PhysicalAddress

#
#Network shares, printers, and wifi access profiles
#
echo "" "Printing adavance network info:" ""

#
#List of all installed software
#
echo "" "Printing installed software:" ""
$programInfo = Get-CimInstance Win32_Product
$programInfo

#
#Process list
#
echo "" "Printing processes:" ""
$processInfo = Get-Process | Select-Object Name, ID, Location | Format-List
$processInfo

#
#Driver list
#
echo "" "Printing drivers:" ""

#
#Downloads and Documents
#
echo "" "Printing Downloads and Documents:" ""

#
#Todo 1
#
echo "" "Printing todo 1:" ""

#
#Todo 2
#
echo "" "Printing todo 2:" ""

#
#Todo 3
#
echo "" "Printing todo 3:" ""
