# Set-ExecutionPolicy unrestricted ##if execution policy restricted
######################################################
$global:v3_location = $PSScriptRoot###################
. $v3_location\Services\init.ps1;init;#Initialization#
######################################################
# WELCOME
Write-Host "Welcome To V3";
#User
#MainLoop
function V3_Main(){
    while($v3_isRunning -eq $True){
        Write-Host "         v3_name:"$v3_name
        Write-Host "         v3_name:"$v3_name
        Write-Host "      user_input:"$user_input
        Write-Host "    v3_isRunning:"$v3_isRunning
        Write-Host "v3_inputCommands:"$v3_inputCommands   
        vf_printLogo;
        $user_input = Read-Host -prompt "V3_"
        Clear-Host;
        #EXECUTE
        if($v3_inputCommands -eq $True){ #RUN IN POWERSHELL
            & $user_input
        }
        else { #V3 COMMANDSS
            
        }

    }
}
V3_Main;