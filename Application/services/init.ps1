#Initializing Variables
[string]$global:v3_name = "Keanu_V3";
[string]$global:v3_version = "1.0 Beta";
[string]$global:v3_user_input;
[boolean]$global:v3_isResolved = $True;
[boolean]$global:v3_isRunning = $True;
[boolean]$global:v3_inputCommands = $True;

function init(){
    #Initializing Core FUNCTIONS

    #Initializing Services
    Write-Host $v3_name"##INITIALZING SERVICES" -Foregroundcolor yellow -BackgroundColor black
    vf_populateServices;
    #Checking Modules
    Write-Host $v3_name"##CHECKING MODULES" -ForegroundColor yellow -BackgroundColor black
    vf_checkModule("nuget");
    vf_checkModule("importexcel");
    Write-Host $v3_name"##FINISHED INIT" -ForegroundColor yellow -BackgroundColor black
    #pause;
    #exit;
}
#SERVICES CLASS
class services{
    [string]$name
    [string]$type
    [string]$location
    [string]$execute
    [boolean]$isInit
    services([string]$name,[string]$type){
        $this.name = $name;
        $this.type = $type;
        #$global:v3_location
        $this.location = $global:v3_location+"\Services"
        $this.execute = $this.location+"\"+$this.name+".ps1"
        $this.isInit = $False
    }
    initService(){
        Write-Host "> Initializing ["$this.name"]"
        try{
            . $this.execute
            # Write-Host "This Service Type is $this.type ";
            Write-Host "["$this.name"] initiated Successfully" -Foregroundcolor black -BackgroundColor green;
            $this.isInit = $True
        }
        catch{
            Write-Host "Error:"$error
            Write-Host "["$this.name"] Failed to Initiate" -BackgroundColor red
        }
    }
}
#FUNCTIONS
function vf_checkModule([string]$moduleName){
    if (Get-Module -ListAvailable -Name $moduleName) {
        $v3_isResolved=$True;
        Write-Host "Module [$moduleName] exists"
        #return;
    } 
    else {
        $v3_isResolved = $False;
        while($v3_isResolved -eq $False){
            Write-Host "MODULE [$moduleName] DOES NOT EXIST" -Foreground black -BackgroundColor Red
            Write-Host "WOULD YOU LIKE TO INSTALL [$moduleName]?(Y/N)"
            Write-Host "PRESS Y FOR YES"
            Write-Host "PRESS N FOR NO"
            Write-Host "PRESS 1 FOR LOCAL INSTALL"
            $user_input = Read-Host -prompt "Answer"
            switch ($user_input) {
                    "y" {
                    Write-Host "Installing [$moduleName]" -ForegroundColor black -BackgroundColor green;
                    Install-Module $moduleName -Scope CurrentUser
                    #$v3_isResolved=$True;
                    vf_checkModule($moduleName);
                    #return;
                    }
                    "n" {Write-Host "Skipping" -ForegroundColor black -BackgroundColor yellow;$v3_isResolved=$True;break;return;}
                    Default {Write-Host "Please Resolve [$moduleName] Error [Y/N]" -BackgroundColor red}
                    "1"{
                        if(test-Path "C:\Program Files\WindowsPowerShell\Modules\$moduleName"){Write-Host "folder Exists";return;}
                        Write-Host "INSTALLING OFFLINE MODULE $moduleName" -ForegroundColor black -BackgroundColor Blue;
                        vf_installModule($moduleName);
                        vf_checkModule($moduleName);
                    }
            }
         } 
    }
}

#SERVICES DECLARATION
function vf_populateServices(){
    $Service_alarm = [services]::new("alarm","service");$Service_alarm.initService();
    $Service_install = [services]::new("install","service");$Service_install.initService();
}
#LOGO
function vf_printLogo(){
[string]$logoX = "$v3_name Version: $v3_version"
$dateX = Get-Date -UFormat "%A %m/%d/%Y %R"
Write-Host "
#############################
$logoX
$dateX
#############################"-Foreground blue
}
#initiate all service object auto(foreach)

function vf_installModule([string]$moduleNameX) {
    Copy-Item -Path "$v3_location\install\$moduleNameX" -Destination "C:\Program Files\WindowsPowerShell\Modules" -PassThru -recurse -Force
}