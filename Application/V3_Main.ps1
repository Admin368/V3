# Set-ExecutionPolicy unrestricted ##if execution policy restricted
######################################################
######################################################
# Import-Module -Global -Force 'C:\Users\Admin68\Desktop\$2_GITHUB\V3\Application\core\ui.ps1';
#GLOBAL VARIABLES
$global:v3_location = $PSScriptRoot
$global:info_services = @(); #stores created services

Write-Host "Global_Location : $global:v3_location";
# $global:info_services += "service0";
# $global:info_services;
# $global:info_services += "service1";
# # # WELCOME
Write-Host "Welcome To V3";
#User
#debug
[boolean]$global:debug_state = $false;
function debug_on(){
    $debug_state = $true;
}
function debug_off(){
    $debug_state = $false;
}

function debug_post([string]$debug_post_info,[string]$debug_post_topic){
    $debug_post_final = "DEBUG_POST :"+$debug_post_topic+" "+$debug
}
#CUSTOME SCTRIPT PLACE HERE
function v3_startup(){
    # ui_reply("sds");
    # pause;
}
#FUNCTIONS
function rs(){ #restart
    cd $global:v3_location
    cd ../
    powershell -NoExit .\V3.bat;
}
function v3_Start(){
    v3_init;
    v3_startup;
    v3_main;
}
function v3_init(){
    #INCLUDE
    #LOAD CORE SCRIPTS
    populate_cores;
    init_cores;
}
class core{
    [string]$name;
    [string]$description;
    [string]$location;
    [boolean]$is_loaded;
    core([string]$name){
        if($this.is_loaded -eq $True){
            Write-Host "CORE COMPONENT ALREADY REGISTERED";
            break;
        }
        else{
            $this.name = $name;
            $this.location = $global:v3_location+"\core";
            $this.is_loaded = $False;
        }
    }
    set_is_loaded_true(){
        $this.is_loaded = $True;
    }
    set_is_loaded_false(){
        $this.is_loaded = $False;
    }
    load_core(){
        if($this.is_loaded -eq $False){
            $msg = "LOADING MAIN COMPONENT"+"["+$this.name+"]";
            Write-Host $msg;
            $global:info_services += $this.name;
            try{
                $final_location = $this.location+"\"+$this.name+".ps1";
                Write-Host $final_location;
                # . $final_location;
                # Import-Module $final_location -Scope Global;
                # call $final_location;
                . $final_location;
                $this.set_is_loaded_true;
                $msg = "SUCESSEFFULY TO LOAD CORE COMPONENT"+"["+$this.name+"]";
                Write-Host $msg -Foreground White -Background Green;
            }
            catch{ #if a core fails to load
                $msg = "FAILED TO LOAD CORE COMPONENT"+"["+$this.name+"]";
                Write-Host $msg -Foreground White -Background Red;
                v3_exit;
            }
        }
        else {
            $msg = "CORE-COMPONENT ["+$this.name+"] IS ALREADY LOADED";
            Write-Host $msg;
        }
        
        # Write-Host $global:info_services;
        # Write-Host $global:v3_location;
    }
}
function new_core([string]$name){
    if($name.is_loaded -eq $True){
        ui_print_warning("MODULE ALREADY INITIATED");
    }
    else{
        $global:info_services += $name;
    }
}
function init_cores(){
    foreach($item in $global:info_services){
        Write-Host $item;
        $item = [core]::new($item);
        $item.load_core();
    }
}
function populate_cores(){
    new_core("ui");
    new_core("users");
    # new_core("init");
    # new_core("execute");
    # new_core("execute");
}
function v3_exit(){
    Write-Host "EXITING V3";

    [Environment]::Exit(1);
}
function v3_main(){
    while($v3_isRunning -eq $True){
        Write-Host "         v3_name:"$v3_name
        Write-Host "         v3_name:"$v3_name
        Write-Host "      user_input:"$user_input
        Write-Host "    v3_isRunning:"$v3_isRunning
        Write-Host "v3_inputCommands:"$v3_inputCommands   
        vf_printLogo;
        test_warning("TEST WARNING");
        $user_input = Read-Host -prompt "V3_"
        Clear-Host;
        #EXECUTE
        if($v3_inputCommands -eq $True){ 
            #CLEAN
            #PREPARE COMMAND
            $user_input_cleared = "& "+$user_input;
            #RUN IN POWERSHELL
            Write-Host $user_input_cleared;
            Invoke-Expression $user_input_cleared;

            # & cmd.exe $user_input
        }
        else { #V3 COMMANDSS
            
        }

    }
}
# V3_Main;
V3_Start;
ui_reply("V3 LOADED FULLY");