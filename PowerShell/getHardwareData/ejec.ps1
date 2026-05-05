param(
    [string]$t 
)

try{
    remove-module getDataCPUModule
    remove-module getDataRAMModule
    remove-module getDataDISKModule
    remove-module getDataEQPModule
    remove-module getDataNETModule
    remove-module getDataFDISKModule
    remove-module getDataIPNTModule
    remove-module getDataUIDModule
    remove-module exportCstmObjctToJsn
    remove-module getDataTimeZoneServer
    remove-module Create-Document
    

    .\Auditoria.ps1 -depth $t

}catch{
    .\Auditoria.ps1 -depth $t
}



