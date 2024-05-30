$lethalCompanyDirI = Read-Host "What drive is your Lethal Company install on? (press enter for C & MAKE SURE TO CAPITALIZE)"
$action = Read-Host "Do you want to:`n1. Update`n2. Uninstall`n3. Install`n4. Disable/Enable Mods`n"

$number = 1

function enableDisableMods {
	$folderItems = Get-ChildItem -Path $lethalCompanyDir\BepInEx\plugins
	
	if ($folderItems.Count -eq 0) {
	Write-Host "Enabling mods..." -ForegroundColor Blue
	Move-Item -Path $lethalCompanyDir\BepInEx\disabled_mods\* -Destination $lethalCompanyDir\BepInEx\plugins
	Remove-Item -Path $lethalCompanyDir\BepInEx\disabled_mods -Recurse -Force
	Write-Host "Finished enabling mods..." -ForegroundColor Green
	exit
	} else {
	Write-Host "Disabling mods..." -ForegroundColor Blue
	New-Item -ItemType Directory -Path $lethalCompanyDir\BepInEx\disabled_mods -Force
	Move-Item -Path $lethalCompanyDir\BepInEx\plugins\* -Destination $lethalCompanyDir\BepInEx\disabled_mods
	Write-Host "Finished disabling mods" -ForegroundColor Green
	exit
	}
}

function checkBepInEx {
	if (-not (Test-Path -Path "$lethalCompanyDir\BepInEx")) {
		Write-Host "Installing/Reinstalling BepInEx..." -ForegroundColor Blue
		
		New-Item -ItemType Directory -Path .\temp -Force
	
		# Specify the local path where you want to save the downloaded file
		$downloadFilePath = ".\temp\BepInEx.zip"
	
		# Download the file using Invoke-WebRequest
		Invoke-WebRequest -Uri https://thunderstore.io/package/download/BepInEx/BepInExPack/5.4.2100/ -OutFile $downloadFilePath
	
		# Unzip the contents to the specified temporary destination folder
		Expand-Archive -Path $downloadFilePath -DestinationPath ".\temp\" -Force
		
		Copy-Item .\temp\BepInExPack\* -Destination $lethalCompanyDir -Recurse
	
		# Remove the temporary download folder
		Remove-Item -Path .\temp -Recurse -Force
		Write-Host "Finished installing BepInEx" -ForegroundColor Green
	}
}


function uninstallMods {
	$confirmation = Read-Host "Are you sure you want to uninstall BepInEx and all related files?`ny/n"
	if ($confirmation -eq "y" -or $confirmation -eq "Y" -or $confirmation -eq "") {
		Remove-Item -Path $lethalCompanyDir\BepInEx\ -Recurse -Force
		Remove-Item -Path $lethalCompanyDir\winhttp.dll -Force
		Remove-Item -Path $lethalCompanyDir\doorstop_config.ini -Force
		exit
	} else {
		exit
	}
}
function updateMods {
	Remove-Item -Path $lethalCompanyDir\BepInEx\ -Recurse -Force
	Remove-Item -Path $lethalCompanyDir\winhttp.dll -Force
	Remove-Item -Path $lethalCompanyDir\doorstop_config.ini -Force
	checkBepInEx
}

if ($lethalCompanyDirI -eq "" -or $lethalCompanyDirI -eq "C") {
    $lethalCompanyDir = "C:\Program Files (x86)\Steam\steamapps\common\Lethal Company"
} else {
    $lethalCompanyDir = "${lethalCompanyDirI}:\SteamLibrary\steamapps\common\Lethal Company"
}

if ($action -eq "1") {
	updateMods
} elseif ($action -eq "2") {
	Write-Host "Uninstalling Mods..." -ForegroundColor Blue
	uninstallMods
	Write-Host "Success" -ForegroundColor Green
} elseif ($action -eq "4") {
	enableDisableMods
}

Write-Host "Installing Mods..." -ForegroundColor Blue

checkBepInEx

# Array of links
$downloadLinks = @(
    "https://thunderstore.io/package/download/notnotnotswipez/MoreCompany/1.9.1/",
    "https://thunderstore.io/package/download/RickArg/Helmet_Cameras/2.1.5/",
    "https://thunderstore.io/package/download/RugbugRedfern/Skinwalkers/5.0.0/",
    "https://thunderstore.io/package/download/Norman/Lightsabers/1.1.2/",
	"https://thunderstore.io/package/download/Evaisa/LethalLib/0.16.0/",
    "https://thunderstore.io/package/download/MoonJuice/RubberChicken/1.0.3/",
    "https://thunderstore.io/package/download/Kittenji/Groan_Tube_Scrap/1.0.1/",
    "https://thunderstore.io/package/download/Nemotoad/PortalTurrets/1.0.0/",
    "https://thunderstore.io/package/download/no00ob/LCSoundTool/1.5.1/",
    "https://thunderstore.io/package/download/Clementinise/CustomSounds/2.3.2/",
    "https://thunderstore.io/package/download/TryToDiveMe/Bikini_Bottom/2.1.0/",
    "https://thunderstore.io/package/download/jockie/LethalExpansionCore/1.3.15/",
    "https://thunderstore.io/package/download/sfDesat/Celest/1.1.2/",
	"https://thunderstore.io/package/download/sfDesat/ViewExtension/1.2.0/",
	"https://thunderstore.io/package/download/IAmBatby/LethalLevelLoader/1.2.4/",
    "https://thunderstore.io/package/download/Kittenji/Maxwell_ScrapItem/1.0.1/",
    "https://thunderstore.io/package/download/blink9803/DimmingFlashlights/1.0.1/",
    "https://thunderstore.io/package/download/PanHouse/LethalClunk/1.1.1/",
    "https://thunderstore.io/package/download/Azim/LethalPresents/1.0.7/",
    "https://thunderstore.io/package/download/Evaisa/HookGenPatcher/0.0.5/",
    "https://thunderstore.io/package/download/CTMods/GoOutWithABang/1.0.1/",
    "https://thunderstore.io/package/download/sunnobunno/LandMineFartReverb/1.0.3/",
    "https://thunderstore.io/package/download/sunnobunno/BonkHitSFX/1.0.5/",
    "https://thunderstore.io/package/download/x753/Mimics/2.6.0/",
    "https://thunderstore.io/package/download/sfDesat/Orion/2.1.1/",
    "https://thunderstore.io/package/download/Sligili/More_Emotes/1.3.3/",
    "https://thunderstore.io/package/download/Ozone/Runtime_Netcode_Patcher/0.2.5/",
    "https://thunderstore.io/package/download/sunnobunno/YippeeMod/1.2.4/",
    "https://thunderstore.io/package/download/FlipMods/ReservedItemSlotCore/2.0.30/",
    "https://thunderstore.io/package/download/FlipMods/ReservedWalkieSlot/2.0.5/",
    "https://thunderstore.io/package/download/FlipMods/ReservedFlashlightSlot/2.0.5/",
    "https://thunderstore.io/package/download/PXC/ShipLootPlus/1.1.0/",
	"https://thunderstore.io/package/download/AinaVT/LethalConfig/1.4.2/"
)

foreach ($link in $downloadLinks) {
    # Extract the file name from the URI
    $fileName = $number

    # Create a temp folder
    New-Item -ItemType Directory -Path .\temp -Force

    # Specify the local path where you want to save the downloaded file
    $downloadFilePath = ".\temp\${fileName}.zip"

    # Download the file using Invoke-WebRequest
    Invoke-WebRequest -Uri $link -OutFile $downloadFilePath

    # Unzip the contents to the specified temporary destination folder
    Expand-Archive -Path $downloadFilePath -DestinationPath $lethalCompanyDir -Force

    # Remove the temporary download folder
    Remove-Item -Path .\temp -Recurse -Force

    $number + 1
}

# List of files to exclude from moving
$filesToExclude = @("doorstop_config.ini", "Lethal Company.exe", "nvngx_dlss.dll", "NVUnityPlugin.dll", "UnityCrashHandler64.exe", "UnityPlayer.dll", "winhttp.dll", "Lethal Company_Data", "MonoBleedingEdge")

# Get all files in the source folder
$files = Get-ChildItem -Path $lethalCompanyDir

# Loop through each file and move it if not in the exclusion list
foreach ($file in $files) {
    if ($filesToExclude -notcontains $file.Name) {
        Move-Item -Path $file.FullName -Destination "${lethalCompanyDir}\BepInEx\plugins" -Force
    }
}

Write-Host "Finished installing mods" -ForegroundColor Green
Pause