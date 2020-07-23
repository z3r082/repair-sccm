#-------------------------------------------------------------- 
# report parameters 
#-------------------------------------------------------------- 
$inputParams = @{
    "Colecciones" = '$NULL'
}

#-------------------------------------------------------------- 
# add assembly 
#-------------------------------------------------------------- 
Add-Type -AssemblyName "Microsoft.ReportViewer.WinForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91"

#-------------------------------------------------------------- 
# display calculated month end date 
#-------------------------------------------------------------- 
$startTime = Get-Date 
Write-Host ("=" * 80) 
Write-Host "Generando Reporte" 
Write-Host "Hora Inicio: $startTime" 
Write-Host ("=" * 80)

#-------------------------------------------------------------- 
# create timestamped folder 
# where we will save our report 
#-------------------------------------------------------------- 
$dt = Get-Date -format "dd_mm_yyyy_hh_mm_ss"
            
$rv = New-Object Microsoft.Reporting.WinForms.ReportViewer

#-------------------------------------------------------------- 
# report Server Properties 
#-------------------------------------------------------------- 
$rv.ServerReport.ReportServerUrl = "" #servidor de reportes sccm p.e. http://serverccm01/ReportServer_SQCMP0

$rv.ServerReport.ReportPath = "" #path del reporte p.e. /ConfigMgr_A00/SCCM_NoClient

$rv.ProcessingMode = "Remote"

#-------------------------------------------------------------- 
# set up report parameters 
#-------------------------------------------------------------- 
$params = $null

$params = New-Object Microsoft.Reporting.WinForms.ReportParameter($inputParams.GetEnumerator().Name, $false) 

# set the parameters 
$rv.ServerReport.SetParameters($params)
$rv.ShowParameterPrompts = $false 
$rv.RefreshReport() 
$rv.ServerReport.Refresh()

#-------------------------------------------------------------- 
# set rendering parameters 
#-------------------------------------------------------------- 
$mimeType = $null 
$encoding = $null
$extension = $null 
$streamids = $null 
$warnings = $null

#-------------------------------------------------------------- 
# render the SSRS report en CSV
#-------------------------------------------------------------- 
$bytes = $null 
$bytes = $rv.ServerReport.Render("CSV", 
    $null, 
    [ref] $mimeType, 
    [ref] $encoding,
    [ref] $extension, 
    [ref] $streamids, 
    [ref] $warnings)

#-------------------------------------------------------------- 
# Formateamos los datos para meterlos en la variable
#--------------------------------------------------------------

$Result = [text.encoding]::UTF8.getString($bytes)

#-------------------------------------------------------------- 
# Guardamos en el disco el csv
#--------------------------------------------------------------
            
if (Test-Path C:\temp\resultado.csv) {
            
    Remove-Item C:\temp\resultado.csv -Force

}
            
$Result > c:\temp\resultado.csv

$FinalResult = Get-Content -path c:\temp\resultado.csv | where { $_ -ne "" }     


$total = $FinalResult.Count

#--------------------------------------------------------------
# Calculamos el tiempo de finalizacion 
#--------------------------------------------------------------
$endTime = Get-Date
$duration = New-TimeSpan -Start $startTime -End $endTime 
Write-Host ("=" * 80) 
Write-Host "End Time: $endTime"
Write-Host "Duration: $duration "
Write-Host ("=" * 80) 

#-------------------------------------------------------------- 
# Mostramos el resultado
#--------------------------------------------------------------

$resultadofinal = $FinalResult[(1..$total)]

$resultadofinal


####### Ponemos a Null las variables #######

$Equipos4136 = $null
$Equipos1043 = $null
$Equipos4812 = $null
$Equipos1516 = $null
$Equiposj23120= $null
$Equipos1456 = $null
$EquiposL24220= $null
$Equipos4621 = $null
$Equipos1219 = $null
$Equipos2597 = $null
$Equipos4613 = $null
$EquiposT45261= $null
$Equipos2827 = $null
$Equipos0808 = $null
$Equipos2815 = $null
$Equipos6200 = $null
$Equipos6201 = $null
$Equipos6000 = $null
$Equiposotros = $null




#equiposoficina
switch -Regex ($resultadofinal) {
    "[A-Z][a-z]{2}4136[0-9]*" { [array]$Equipos4136 += $_ }
    "[A-Z][a-z]{2}1043[0-9]*" { [array]$Equipos1043 += $_ }
    "[A-Z][a-z]{2}4812[0-9]*" { [array]$Equipos4812 += $_ }
    "[A-Z][a-z]{2}1516[0-9]*" { [array]$Equipos1516 += $_ }
    "[A-Z][a-z]{2}23120[0-9]*" { [array]$Equipos23120 += $_ }
    "[A-Z][a-z]{2}1456[0-9]*" { [array]$Equipos1456 += $_ }
    "[A-Z][a-z]{2}24220[0-9]*" { [array]$Equipos24220 += $_ }
    "[A-Z][a-z]{2}4621[0-9]*" { [array]$Equipos4621 += $_ }
    "[A-Z][a-z]{2}1219[0-9]*" { [array]$Equipos1219 += $_ }
    "[A-Z][a-z]{2}2597[0-9]*" { [array]$Equipos2597 += $_ }
    "[A-Z][a-z]{2}4613[0-9]*" { [array]$Equipos4613 += $_ }
    "[A-Z][a-z]{2}45261[0-9]*" { [array]$Equipos45261 += $_ }
    "[A-Z][a-z]{2}2827[0-9]*" { [array]$Equipos2827 += $_ }
    "[A-Z][a-z]{2}0808[0-9]*" { [array]$Equipos0808 += $_ }
    "[A-Z][a-z]{2}2815[0-9]*" { [array]$Equipos2815 += $_ }
    "[A-Z][a-z]{2}6200[0-9]*" { [array]$Equipos6200 += $_ }
    "[A-Z][a-z]{2}6201[0-9]*" { [array]$Equipos6201 += $_ }
    "[A-Z][a-z]{2}6000[0-9]*" { [array]$Equipos6000 += $_ }
    default { [array]$Equiposotros += $_ }
}





$unidad = "" #servidor y unidad a mapear p.e. \\server\ccm

if (Test-Path -Path C:\ccm\Resultado) {

}
else {
    
    New-Item -Path c:\ccm\ -Name resultado -ItemType directory   

}

$out = "C:\ccm\resultado\resultado.csv" #ruta con el registro de instalaciones correctas e incorrectas


$usuario = ""#admin user
$Encrypted = gc 'encrypted.txt'
$securestring = ConvertTo-SecureString -String $Encrypted # Convierte en secureString
$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($securestring)
$password = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
$pass = $password
$Credenciales = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $usuario, $securestring

$equiposcentro = ""#indicar $EquiposOficina

if (Test-Path -Path $out) {
    Remove-Item -Path $out -Force 
}

write-host "Tenemos en total " $equiposcentro.count

function Install-SCCM ($ruta, $user, $pass) {
    $Instalado = $false
    
    function get-ccminstalado {
        $Keys = Get-ChildItem HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall
        $Items = $keys | foreach-object { Get-ItemProperty $_.PsPath }
        [string]$fecha = get-date -Format 'yyyyMMdd'

        foreach ($item in $items) {
            if ($item.Displayname -like "Configuration Manager Client") {
                if ($item.InstallDate -eq $fecha) {
                    
                    $instalado = $true
                    break
                
                }
                else {
                    $instalado = $false
                }

            }
            else {
                $instalado = $false
            }
        }

        return $instalado
    }
    
    function mensaje-info {
        param ($mensaje) 
        Write-Host "[" -ForegroundColor Green -NoNewline; Write-Host "+" -ForegroundColor Red -NoNewline ; Write-Host "] " -ForegroundColor Green -NoNewline ; Write-Host $mensaje `n -ForegroundColor Green -NoNewline
    }
    
    
    function espera_proceso {
        param($proceso)
        do { $fecha = get-date; sleep -Seconds 30; mensaje-info -mensaje "$fecha Esperando al proceso $proceso" } while ((Get-Process "$proceso" -ErrorAction SilentlyContinue).count)
    }
    
    mensaje-info -mensaje "Parando servicio SCCM"
    mensaje-info -mensaje "Parando el servicio CCMExec"
    Get-Service "CCM*" | Stop-Service
    Get-Process "*Ccm*" | Stop-Process # paramos el proceso del cliente SCCM
    
    
    
    
    if ((Test-Path -Path "C:\Windows\ccmsetup\scepinstall.exe") -eq $true) {
        mensaje-info -mensaje "Desinstalando SCEP"
        Start-Process "C:\Windows\ccmsetup\scepinstall.exe" -ArgumentList " /u /s" -ErrorAction SilentlyContinue #desinstalar scep
        espera_proceso -proceso "scepinstall"
    }
    
    if ((Test-Path -Path "C:\Windows\ccmsetup\ccmsetup.exe") -eq $true) {
        Start-Process "C:\Windows\ccmsetup\ccmsetup.exe" -ArgumentList "/uninstall"  -ErrorAction SilentlyContinue #desinstalar sccm
        espera_proceso -proceso "ccmsetup"
    }
    
    #cd C:\Windows\ccmsetup\
    #.\ccmsetup.exe /uninstall
    #borrar carpetas cccmcache ccm ccmsetup
    
    if ((Test-Path -Path "c:\windows\ccmcache") -eq $true) { Remove-Item C:\Windows\ccmcache -Force -Recurse ; Remove-Item C:\Windows\ccm -Force -Recurse }
    
    mensaje-info -mensaje "Eliminando claves de registro"
    Remove-Item -Path 'HKLM:\SOFTWARE\Microsoft\SystemCertificates\SMS\Certificates\*' -force 
    mensaje-info -mensaje "Eliminando smscfg.ini"
    if ((Test-Path -Path "c:\windows\smscfg.ini") -eq $true) { rm c:\windows\smscfg.ini }
    
    
    mkdir c:\windows\ccm -ErrorAction SilentlyContinue | Out-Null
    #if ((Test-Path -Path "a:") -eq $true) {net use A: /d} 
    mensaje-info -mensaje "Mapeamos"
    net use A: $ruta $pass /user:$user
    #New-PSDrive -name a -psprovider Filesystem -root $ruta -Credential $creden -Verbose
    mensaje-info -mensaje "copiamos"
    Copy-Item a:\*.* C:\Windows\CCM
    start-sleep 30
    
    Start-Process "C:\Windows\ccm\ccmsetup.exe" -ArgumentList " /mp:ate2800ccm01.atento.es SMSMP=ate2800ccm01.atento.es FSP=ate2800ccm01.atento.es SMSSITECODE=A00 RESETKEYINFORMATION=true SMSSLP=ate2800ccm01.atento.es" -Wait
    Start-Sleep 10

    while (Get-Process "*ccmsetup*") {
        Start-Sleep 10
    }

    mensaje-info -mensaje "instalamos"
    mensaje-info -mensaje "finalizamos instalacion"
    #forzar instalacion
    #Klist -li 0x3e7 purge
    #gpupdate /force
    wuauclt /detectnow

    $Instalado = get-ccminstalado
    $final = New-Object psobject -Property @{
        "Equipo"    = $env:COMPUTERNAME
        "Instalado" = $Instalado
        "Encendido" = $true
    }
    
    $final | Select-Object "Equipo", "Instalado", "Encendido" | Export-Csv -Path a:\resultado\resultado.csv  -Append -Encoding UTF8 -NoTypeInformation -Delimiter ";"
    net use A: /delete
    
}


foreach ($equipo in $equiposcentro) {
    if (Test-Connection -ComputerName $equipo -count 1 -quiet) {
        write-host "Entramos en $equipo" -ForegroundColor Cyan
        $sesion = ""
                
        $sesion = New-PSSession -ComputerName $equipo -Credential $credenciales -EnableNetworkAccess
        
        if ($sesion) {
            write-host "ejecutamos funcion"    
            Invoke-Command -Session $sesion -ScriptBlock ${function:Install-SCCM} -ArgumentList $unidad, $usuario, $pass -AsJob -JobName $equipo
            write-host "Finalizado"
            #Remove-PSSession -Session $sesion

        }
        else {

            write-host "Sin sesion $equipo" -ForegroundColor Green
        
            $final = New-Object psobject -Property @{
                "Equipo"    = $equipo
                "Instalado" = $false
                "Encendido" = $true
            }
            $final | Select-Object "Equipo", "Instalado", "Encendido" | Export-Csv -Path $out -Append -Encoding UTF8 -NoTypeInformation -Delimiter ";"
        }

    }
    else {
        write-host "No entramos en $equipo" -ForegroundColor Yellow
        
        $final = New-Object psobject -Property @{
            "Equipo"    = $equipo
            "Instalado" = $false
            "Encendido" = $false
        }
    
        $final | Select-Object "Equipo", "Instalado", "Encendido" | Export-Csv -Path $out -Append -Encoding UTF8 -NoTypeInformation -Delimiter ";"

    }

}


$contador = 0

while ((gc -Path $out).count -lt $equiposcentro.Count + 1 -and $contador -lt 60) {
    cls
    write-host "Aun no han finalizado"
    Get-Job | where-object -filterscript { $_.state -ne "completed" }
    Start-Sleep 10
    $contador ++
    write-host "contador vale $contador"
}

$csv = import-csv -Path $out -Delimiter ";"

$csv = $csv.equipo

if ($contador -eq 20) {
    
    $faltas = Compare-Object $equiposcentro $csv

    foreach ($falta in $faltas) {
        $final = New-Object psobject -Property @{
            "Equipo"    = $falta.inputobject
            "Instalado" = $false
            "Encendido" = "Windows 10, Measure Object"
        }
        $final | Select-Object "Equipo", "Instalado", "Encendido" | Export-Csv -Path $out -Append -Encoding UTF8 -NoTypeInformation -Delimiter ";"
    }
}

Write-Host "Finalizado. Revisa el csv en $out"
Invoke-Item -Path $out