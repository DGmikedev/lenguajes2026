function Getuuid{

    try{
        $uuid = Get-CimInstance Win32_ComputerSystemProduct | 
        Select-Object Caption ,Description ,IdentifyingNumber ,Name ,
        SKUNumber ,Vendor ,Version ,UUID
        return $uuid
    }catch{
        return "ERROR EN MODULO"
    }

}