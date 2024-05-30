#!/bin/bash

number=1

lethalCompanyDir='/run/media/deck/8d6b7a8c-3438-4d30-a279-03ac9405b35e/steamapps/common/Lethal Company'

#!/bin/bash

read -p "What drive is your Lethal Company install on? (press enter for /mnt/c/ & MAKE SURE TO CAPITALIZE) " lethalCompanyDirI
read -p "Do you want to:
1. Update
2. Uninstall
3. Install
4. Disable/Enable Mods
" action

number=1

enableDisableMods() {
    folderItems=$(ls -A "$lethalCompanyDir/BepInEx/plugins")
    
    if [ -z "$folderItems" ]; then
        echo -e "\e[34mEnabling mods...\e[0m"
        mv "$lethalCompanyDir/BepInEx/disabled_mods/"* "$lethalCompanyDir/BepInEx/plugins"
        rm -rf "$lethalCompanyDir/BepInEx/disabled_mods"
        echo -e "\e[32mFinished enabling mods...\e[0m"
        exit
    else
        echo -e "\e[34mDisabling mods...\e[0m"
        mkdir -p "$lethalCompanyDir/BepInEx/disabled_mods"
        mv "$lethalCompanyDir/BepInEx/plugins/"* "$lethalCompanyDir/BepInEx/disabled_mods"
        echo -e "\e[32mFinished disabling mods\e[0m"
        exit
    fi
}

checkBepInEx() {
    if [ ! -d "$lethalCompanyDir/BepInEx" ]; then
        echo -e "\e[34mInstalling/Reinstalling BepInEx...\e[0m"
        mkdir -p ./temp
        downloadFilePath="./temp/BepInEx.zip"
        
        curl -L -o "$downloadFilePath" "https://thunderstore.io/package/download/BepInEx/BepInExPack/5.4.2100/"
        
        unzip -o "$downloadFilePath" -d ./temp/
        
        cp -r ./temp/BepInExPack/* "$lethalCompanyDir"
        
        rm -rf ./temp
        echo -e "\e[32mFinished installing BepInEx\e[0m"
    fi
}

uninstallMods() {
    read -p "Are you sure you want to uninstall BepInEx and all related files? (y/n) " confirmation
    if [[ "$confirmation" == "y" || "$confirmation" == "Y" || -z "$confirmation" ]]; then
        rm -rf "$lethalCompanyDir/BepInEx"
        rm -f "$lethalCompanyDir/winhttp.dll"
        rm -f "$lethalCompanyDir/doorstop_config.ini"
        exit
    else
        exit
    fi
}

updateMods() {
    rm -rf "$lethalCompanyDir/BepInEx"
    rm -f "$lethalCompanyDir/winhttp.dll"
    rm -f "$lethalCompanyDir/doorstop_config.ini"
    checkBepInEx
}

case "$action" in
    1)
        updateMods
        ;;
    2)
        echo -e "\e[34mUninstalling Mods...\e[0m"
        uninstallMods
        echo -e "\e[32mSuccess\e[0m"
        ;;
    4)
        enableDisableMods
        ;;
esac

echo -e "\e[34mInstalling Mods...\e[0m"

checkBepInEx

# Array of links
downloadLinks=(
    "https://thunderstore.io/package/download/notnotnotswipez/MoreCompany/1.9.1/"
    "https://thunderstore.io/package/download/RickArg/Helmet_Cameras/2.1.5/"
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

for link in "${downloadLinks[@]}"; do
    fileName=$number
    mkdir -p ./temp
    downloadFilePath="./temp/${fileName}.zip"
    
    curl -L -o "$downloadFilePath" "$link"
    
    unzip -o "$downloadFilePath" -d "$lethalCompanyDir"
    
    rm -rf ./temp
    
    number=$((number + 1))
done

# List of files to exclude from moving
filesToExclude=("doorstop_config.ini" "Lethal Company.exe" "nvngx_dlss.dll" "NVUnityPlugin.dll" "UnityCrashHandler64.exe" "UnityPlayer.dll" "winhttp.dll" "Lethal Company_Data" "MonoBleedingEdge")

# Get all files in the source folder
files=$(ls -A "$lethalCompanyDir")

# Loop through each file and move it if not in the exclusion list
for file in $files; do
    if [[ ! " ${filesToExclude[@]} " =~ " $(basename $file) " ]]; then
        mv "$lethalCompanyDir/$file" "$lethalCompanyDir/BepInEx/plugins"
    fi
done

echo -e "\e[32mFinished installing mods\e[0m"
read -p "Press Enter to continue..."
