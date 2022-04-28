# Game Variables
$global:playerCharacter = $null
$global:playerDragonTip = $false
$global:runGame = $true

function Setup-Display([string]$title, [int]$width, [int]$height) {
    $psHost = Get-Host
    $window = $psHost.UI.RawUI
    $newSize = $window.WindowSize
    $newSize.Height = $height
    $newSize.Width = $width
    $window.WindowSize = $newSize
    $window.WindowTitle = $title
}

function Read-NextKey() {
    return $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").Character
}

function Title-Screen() {
    $Host.UI.RawUI.FlushInputBuffer()

    Clear-Host

    Write-Host "                                                                     "
    Write-Host "                     _____                                           "
    Write-Host "                    |  __ \                                          "
    Write-Host "                    | |  | |_ __ __ _  __ _  ___  _ __               "
    Write-Host "                    | |  | | '__/ _` |/ _` |/ _ \| '_ \              "
    Write-Host "                    | |__| | | | (_| | (_| | (_) | | | |             "
    Write-Host "                    |______|_|  \__,_|\__, |\___/|_| |_|             "
    Write-Host "                     / ____| |         __/ |                         "
    Write-Host "                    | (___ | | __ _ _ |___/___ _ __                  "
    Write-Host "                     \___ \| |/ _` | | | |/ _ | '__|                 "
    Write-Host "                     ____) | | (_| | |_| |  __| |                    "
    Write-Host "                    |_____/|_|\__,_|\__, |\___|_|                    "
    Write-Host "                                     __/ |                           "
    Write-Host "                                    |___/                            "
    Write-Host "                                                                     "

    Write-Host "                                   \||/                              "
    Write-Host "                                   |  @___oo                         "
    Write-Host "                         /\  /\   / (__,,,,|                         "
    Write-Host "                        ) /^\) ^\/ _)                                "
    Write-Host "                        )   /^\/   _)                                "
    Write-Host "                        )   _ /  / _)                                "
    Write-Host "                    /\  )/\/ ||  | )_)                               "
    Write-Host "                      >      |(,,) )__)                              "
    Write-Host "                    ||      /    \)___)\                             "
    Write-Host "                    | \____(      )___) )___                         "
    Write-Host "                     \______(_______;;; __;;;                        "
    Write-Host "                                                                     "
    Write-Host "                        Press Any Key to Play or Q to quit           "

    $continue = Read-NextKey

    if ($continue -eq 'q') {
        $global:runGame = $false
    }

}

function Character-Selection() {
    Clear-Host

    # Dragon Slayer
    Write-Host "################################################################"
    Write-Host "#                                                               "
    Write-Host "#           Dragon Slayer 1.0 by Jason Rueckert                 "
    Write-Host "#                       'Come get some.'                        "
    Write-Host "#                                                               "
    Write-Host "################################################################"
    Write-Host "                                                                "
    Write-Host "################################################################"
    Write-Host "                                                                "
    Write-Host "                        Character Selection                     "
    Write-Host "                                                                "
    Write-Host "                        A: Slorvak                              "
    Write-Host "                        B: Prince Valant                        "
    Write-Host "                        C: Zanthe                               "
    Write-Host "                        D: Amara                                "
    Write-Host "                                                                "
    Write-Host "                                                                "
    Write-Host "################################################################"
    Write-Host "                                                                "

    $userResponse = Read-Host -Prompt "Choose a character"

    Write-Host = ""

    switch ($userResponse) {
        A { $global:playerCharacter = "Slorvak" }
        B { $global:playerCharacter = "Prince Valant" }
        C { $global:playerCharacter = "Zanthe" }
        D { $global:playerCharacter = "Amara" }
        Default { $global:playerCharacter = "Slorvak" }
    }

    Write-Host = "You selected $global:playerCharacter. Let's begin."

    Start-Sleep 3
}

function Accept-TheQuest() {
    Clear-Host

    # Dragon Slayer
    Write-Host "################################################################"
    Write-Host "                                                                "
    Write-Host " The King requests your help to slay the dragon, FireWing.      "
    Write-Host " FireWing has been woken from a deep slumber and has started    "
    Write-Host " terrorising the local villages.                                "
    Write-Host "                                                                "
    Write-Host " The people are scared and have started to leave the kingdom.   "
    Write-Host "                                                                "
    Write-Host " The King must protect his people.                              "
    Write-Host "                                                                "
    Write-Host "################################################################"
    Write-Host "                                                                "

    do {
        $userResponse = Read-Host -Prompt "Are you willing to help? (yes/no) "
    } while ($userResponse -notlike "Yes" -and $userResponse -notlike "No")
    Write-Host ""

    switch ($userResponse) {
        "Yes" {
            Write-Host "The King thanks you, $global:playerCharacter."
            Write-Host ""
            Write-Host "Now, start your quest!"
            Start-Sleep 4
            return $true
        }
        "No" {
            Write-Host "Your King is dissappointed in you and sends you on your way home."
            Start-Sleep 4
            return $false
        }
    }
}

function Arrive-AtVillage() {
    Clear-Host
    Write-Host ""
    Write-Host "After two day's ride you arrive at Florin, a small village on the"
    Write-Host "outskirts of the kingdom."
    Write-Host ""
    Write-Host "You choose Florin to make your stand due to its remote location"
    Write-Host "and nearby army detachment camping nearby."
    Write-Host ""
    Write-Host "On your arrival do you?"
    Write-Host ""
    Write-Host "A) Talk to the villagers"
    Write-Host "B) Talk to the commander in charge of the local detachment"
    Write-Host ""

    do {
        $userResponse = Read-Host -Prompt "Answer (A or B)"
    } while ($userResponse -notlike "A" -and $userResponse -notlike "B")

    Write-Host = ""

    switch ($userResponse) {
        "A" { Speak-ToVillagers }
        "B" { Speak-ToDetachment }
    }
}

function Speak-ToDetachment() {
    Clear-Host
    if ($global:playerDragonTip) {
        Write-Host ""
        Write-Host "You speak to Cedric who is commanding the local "
        Write-Host "detachment of soldiers."
        Write-Host ""
        Write-Host "Cendric is making his way north to rejoin the rest of the"
        Write-Host "troops but is willing to assist in finding FireWing and "
        Write-Host "suggests waiting until the dragon returns and slay it in combat."
        Write-Host ""
        Write-Host "Press any key to continue."

        $continue = Read-NextKey

        Wait-ForDragon
    }
    else {
        Write-Host ""
        Write-Host "You speak to Cedric who is commanding the local detachment"
        Write-Host "of soldiers."
        Write-Host ""
        Write-Host "Cendric is making his way north to rejoin the rest of the"
        Write-Host "troops but is willing to assist in finding FireWing."
        Write-Host ""
        Write-Host "You tell Cendric that the local villiagers know where the"
        Write-Host "dragon may be resting at night together you formulate"
        Write-Host "a plan of attack."
        Write-Host ""
        Write-Host "Press any key to continue."

        $continue = Read-NextKey

        Attack-DragonWithDetachment
    }
}

function Wait-ForDragon() {
    Clear-Host

    Write-Host "You setup camp with the detachment and prepare the weapons."
    Write-Host ""
    Write-Host "During the night FireWing attacks the camp and villagers."
    Write-Host "Everyone runs for their life but you are engulfed in flames"
    Write-Host "and don't make it out alive!"
    Write-Host ""
    Write-Host "You have failed to protect the villagers."
    Write-Host ""
    Write-Host "Game Over"
    Write-Host ""
    Write-Host "Press any key to continue"

    $continue = Read-NextKey
}

function Attack-DragonWithDetachment() {
    Clear-Host

    Write-Host "You ready your weapons and with the villiagers help you"
    Write-Host "formulate a plan. The plan is to setup a large chainmail"
    Write-Host "net over the cave entrance."
    Write-Host ""
    Write-Host "When FireWing enters the cave to rest you will drop the"
    Write-Host "net to block his escape."
    Write-Host ""
    Write-Host "The troops will then fire their bows into the cave and"
    Write-Host "slay the dragon!"
    Write-Host ""
    Write-Host "You work with Cedric and the troops to prepare the trap"
    Write-Host "and wait in hiding."
    Write-Host ""
    Write-Host "During the night FireWing enters the cave and the trap"
    Write-Host "is sprung. Huge arrows are fired into the cave and fire"
    Write-Host "bellows out from the cave entrance. More arrows fly and"
    Write-Host "then silence.."
    Write-Host ""
    Write-Host "You enter the cave and and find nothing but a pile of"
    Write-Host "ash on the floor."
    Write-Host ""
    Write-Host "Congratulations! you have defeated FireWing and"
    Write-Host "protected the Kingdom."
    Write-Host ""
    Write-Host "You are indeed a cunning and mighty warrior!"
    Write-Host ""
    Write-Host "Press any key to continue."

    $continue = Read-NextKey
}

function Attack-DragonOnOwn() {
    Clear-Host

    Write-Host ""
    Write-Host "After dark Hadrain takes you to the cave and leaves you to"
    Write-Host "investigate."
    Write-Host ""
    Write-Host "You get close to the cave but cant see any sign of FireWing"
    Write-Host "so you move close still."
    Write-Host ""
    Write-Host "Suddenly you hear a noise from behind! you turn quickly"
    Write-Host "and are engolved by flames!"
    Write-Host ""
    Write-Host "FireWing as struck you down with his fire breath and you"
    Write-Host "are turned to ashes."
    Write-Host ""
    Write-Host "Press any key to continue"

    $continue = Read-NextKey
}

function Speak-ToVillagers() {
    Clear-Host
    Write-Host ""
    Write-Host "You speak to Hadrain an elder of the village who explains that "
    Write-Host "FireWing has been seen resting in a cave nearby after nightfall."
    Write-Host "He suggests speaking to the local detachment and launching a surprise"
    Write-Host "attack after dark with their help. "
    Write-Host ""
    Write-Host "What do you do next?"
    Write-Host ""
    Write-Host "A) Speak to the detachments commander"
    Write-Host "B) Ask Hadarin to take you to the cave after dark"
    Write-Host ""
    #Player has picked up a tip from the local villagers! #This will change the outcome of future decisions
    $global:playerDragonTip = $true

    do {
        $userResponse = Read-Host -Prompt "Answer (A or B)"
    }
    while ($userResponse -notlike "A" -and $userResponse -notlike "B")
    Write-Host ""
    Switch ($userResponse) {
        "A" { Speak-ToDetachment }
        "B" { Attack-DragonOnOwn }
    }
}

Setup-Display "Dragon Slayer" 64 38

while ($global:runGame) {
    Character-Selection
    $accept = Accept-TheQuest
    if ($accept -eq $true) {
        Arrive-AtVillage
    }
    else {
        #Player Quit
        Write-Host ""
        Write-Host "Thanks for Playing"
        $global:runGame = $false
        Start-Sleep 3
    }
}

