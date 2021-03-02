#formart .xlsx

#importing
Import-Excel -path .\DB.xlsx #imports 1st sheet by default

#specifying worksheet
Import-Excel -path .\DB.xlsx -WorksheetName users

#import into Object
$data = Import-Excel -path .\DB.xlsx -WorksheetName users

#things are imported as objects with the first row as header or properties
$data
<# RESULT
user_id         : 0
username        : admin68
password_hash   :
identity_device : 
device_ip       : 
#>

#geting a property
$data[0].username

#foreach-object
$data | foreach-object { $_.username } #prints every user in sheet

#Exporting
$data | Export-Excel -Path .\DB.xlsx -killExcel -WorksheetName "Users" -ClearSheet -AutoSize -AutoFilter -BoldTopRow -FreezeTopRow -PassThru

#Export and open
$data | Export-Excel -Path .\DB.xlsx -killExcel -WorksheetName "Users" -ClearSheet -AutoSize -AutoFilter -BoldTopRow -FreezeTopRow -PassThru -Show

#
$xl = $data | Export-Excel -Path .\DB.xlsx -killExcel -WorksheetName "users" -ClearSheet -Show -AutoSize -AutoFilter -BoldTopRow -FreezeTopRow -PassThru