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

Export-ModuleMember -Function *
