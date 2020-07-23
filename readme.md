# Reparar cliente SCCM de forma remota con Powershell
## Objetivo

Al lanzar el script desde una máquina o server:
- Consulta contra informes sccm que máquinas tienen erroneo o no tienen cliente sccm
- Extrae las maquinas que corresponden a la oficina que queremos reparar.
- Conecta contra las maquinas a través de jobs y repara cliente sccm.

De este modo lo hace de forma automatizada sin tener que buscar los equipos manualmente o extraer informes por nuestra cuenta, por lo que se puede crear una tarea programada para que lo lance todas las noches y realice la reparación sin afectar al rendimiento de la máquina. No obstante, se puede realizar en producción ya que es totalmente transparante para el usuario y no debe notar nada.

## Requisitos

- Los equipos cliente deben tener psremote habilitado y los puertos correspondientes abiertos.
- Tener un usuario administrador de los puestos cliente (admin de dominio o local)
- Acceso a una unidad en red donde esté el soft del cliente de sccm
- El server o equipo que lance el script debe tener instalado:
  - **ReportViewer.msi**. Microsoft Report Viewer 2015 Runtime
  - **SQLSysClrTypes.msi**. Microsoft System CLR Types para Sql Server 2014

## Funcionamiento

- Git clone en la ruta más cercada a c:\. P.e. c:\sccm-repair\
- Lanzar Get-SecureString.ps1 para generar el fichero con las credenciales encriptadas.
- Añadir los parametros a repair-sccm.ps1:
  - $rv.ServerReport.ReportServerUrl = "" #servidor de reportes sccm p.e. http://serverccm01/ReportServer_SQCMP0
  - $rv.ServerReport.ReportPath = "" #path del reporte p.e. /ConfigMgr_A00/SCCM_NoClient
  - Existen variables según oficina con regex. Modificar a gusto del consumidor:$EquiposXXXX
  - $unidad = "" #servidor y unidad a mapear p.e. \\server\ccm
  - $usuario = ""#admin user
  - $equiposcentro = ""#indicar $EquiposOficina

## Proxima versión

Pasar por argumento las modificaciones del script para personalización.