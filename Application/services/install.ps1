class install {
    [string]$name
    [string]$location
    [string]$command
    [boolean]$isOffline
    install ([string]$name, [boolean]$isOffline, [string]$location, [string]$command){
        $this.[string]$name
        $this.[string]$location
        $this.[string]$command
        $this.[boolean]$isOffline
    }
}

function populateInstall {
    
    
}