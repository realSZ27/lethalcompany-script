#!/bin/bash

number=1

lethalCompanyDir='/run/media/deck/8d6b7a8c-3438-4d30-a279-03ac9405b35e/steamapps/common/Lethal Company'

# Array of links
downloadLinks=(
    "https://thunderstore.io/package/download/notnotnotswipez/MoreCompany/1.9.1/"
    "https://thunderstore.io/package/download/RickArg/Helmet_Cameras/2.1.5/",
    "https://thunderstore.io/package/download/RugbugRedfern/Skinwalkers/5.0.0/"
    "https://thunderstore.io/package/download/Norman/Lightsabers/1.1.2/"
	"https://thunderstore.io/package/download/Evaisa/LethalLib/0.16.0/"
    "https://thunderstore.io/package/download/MoonJuice/RubberChicken/1.0.3/"
    "https://thunderstore.io/package/download/Kittenji/Groan_Tube_Scrap/1.0.1/"
    "https://thunderstore.io/package/download/Nemotoad/PortalTurrets/1.0.0/"
    "https://thunderstore.io/package/download/no00ob/LCSoundTool/1.5.1/"
    "https://thunderstore.io/package/download/Clementinise/CustomSounds/2.3.2/"
    "https://thunderstore.io/package/download/TryToDiveMe/Bikini_Bottom/2.1.0/"
    "https://thunderstore.io/package/download/jockie/LethalExpansionCore/1.3.15/"
    "https://thunderstore.io/package/download/sfDesat/Celest/1.1.2/"
	"https://thunderstore.io/package/download/sfDesat/ViewExtension/1.2.0/"
	"https://thunderstore.io/package/download/IAmBatby/LethalLevelLoader/1.2.4/"
    "https://thunderstore.io/package/download/Kittenji/Maxwell_ScrapItem/1.0.1/"
    "https://thunderstore.io/package/download/blink9803/DimmingFlashlights/1.0.1/"
    "https://thunderstore.io/package/download/PanHouse/LethalClunk/1.1.1/"
    "https://thunderstore.io/package/download/Azim/LethalPresents/1.0.7/"
    "https://thunderstore.io/package/download/Evaisa/HookGenPatcher/0.0.5/"
    "https://thunderstore.io/package/download/CTMods/GoOutWithABang/1.0.1/"
    "https://thunderstore.io/package/download/sunnobunno/LandMineFartReverb/1.0.3/"
    "https://thunderstore.io/package/download/sunnobunno/BonkHitSFX/1.0.5/"
    "https://thunderstore.io/package/download/x753/Mimics/2.6.0/"
    "https://thunderstore.io/package/download/sfDesat/Orion/2.1.1/"
    "https://thunderstore.io/package/download/Sligili/More_Emotes/1.3.3/"
    "https://thunderstore.io/package/download/Ozone/Runtime_Netcode_Patcher/0.2.5/"
    "https://thunderstore.io/package/download/sunnobunno/YippeeMod/1.2.4/"
    "https://thunderstore.io/package/download/FlipMods/ReservedItemSlotCore/2.0.30/"
    "https://thunderstore.io/package/download/FlipMods/ReservedWalkieSlot/2.0.5/"
    "https://thunderstore.io/package/download/FlipMods/ReservedFlashlightSlot/2.0.5/"
    "https://thunderstore.io/package/download/PXC/ShipLootPlus/1.1.0/"
	"https://thunderstore.io/package/download/AinaVT/LethalConfig/1.4.2/"
)

echo "Installing BepInEx..."

mkdir -p "./temp"
	
# Specify the local path where you want to save the downloaded file
downloadFilePath="./temp/BepInEx.zip"

# Download the file using Invoke-WebRequest
curl -L -o "$downloadFilePath" "https://thunderstore.io/package/download/BepInEx/BepInExPack/5.4.2100/"
	
# Unzip the contents to the specified temporary destination folder
unzip -o "$downloadFilePath" -d "./temp/"

cp -r ./temp/BepInExPack/* $lethalCompanyDir

# Remove the temporary download folder
rm -rf ./temp
echo "Finished installing BepInEx"

# Temporary folder for downloading and extracting contents
tempFolder="./temp"

for link in "${downloadLinks[@]}"; do
    # Extract the file name from the URI
    fileName="$number"

    # Create a temp folder
    mkdir -p "$tempFolder"

    # Specify the local path where you want to save the downloaded file
    downloadFilePath="$tempFolder/${fileName}.zip"

    # Download the file using curl
    curl -L -o "$downloadFilePath" "$link"

    # Unzip the contents to the specified temporary destination folder
    unzip -o "$downloadFilePath" -d "$lethalCompanyDir"

    # Remove the temporary download folder
    rm -rf "$tempFolder"

    number=$((number + 1))
done

# List of files to exclude from moving
filesToExclude=("doorstop_config.ini" "Lethal Company.exe" "nvngx_dlss.dll" "NVUnityPlugin.dll" "UnityCrashHandler64.exe" "UnityPlayer.dll" "winhttp.dll" "Lethal Company_Data" "MonoBleedingEdge")

# Get all files in the source folder
files=("$lethalCompanyDir"/*)

# Loop through each file and move it if not in the exclusion list
for file in "${files[@]}"; do
    fileName=$(basename "$file")
    if [[ ! " ${filesToExclude[@]} " =~ " $fileName " ]]; then
        mv "$file" "${lethalCompanyDir}/BepInEx/plugins" -f
    fi
done

read -p "Press Enter to exit..."
