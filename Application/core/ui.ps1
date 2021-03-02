class ui{

}

function ui_is_loaded(){
        returns 0;
}
#NORMAL REPLY
function reply($msg){
        ui_print_reply($msg);
}
function ui_reply($msg){
        ui_print_reply($msg);
}
function ui_print_reply($msg){
        $final_msg = "V3: "+$msg
        Write-Host $final_msg -ForegroundColor GREEN;
}
#LOGO
function ui_print_logo(){
    
}
#WARNINGS
function ui_print_warning([string]$msg){
        Write-Host "$msg" -ForegroundColor White -BackgroundColor Red;
}
function ui_print_success([string]$msg){
        Write-Host "$msg" -ForegroundColor White -BackgroundColor Green;
}
ui_reply("UI-CORE FINISHED LOADING");