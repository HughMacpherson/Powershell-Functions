Function Write-ToLog {
  <#
  .Synopsis
  function to log progress to a logfile and to screen

  .NOTES
  Name       : Write-ToLog
  Author     : Hugh Macpherson
  Version    : 1.1
  DateCreated: 2017-04-15
  DateUpdated: 2017-05-02

  .PARAMETER Message
  Message to be logged and displayed

  .PARAMETER Path
  Path to be defined in the calling script, will also output any errors to the log file.

  .PARAMETER Level
  5 Levels exist: INFO, WARN, ERROR, FATAL, DEBUG
  These will appear at the start of line or after TimeStamp. The default is 'INFO'.

  .PARAMETER ToScreen
  Writes the output to the screen as well as to the file.

  .PARAMETER TimeStamp
  Writes a Timstamp to the begining of the log line.

  .EXAMPLE
  PS:\> Write-ToLog -TimeStamp -Message $Message -Path D:\Script.log -ToScreen

  2017-04-23 14:29:30 - INFO, Writing to Log and screen.

  Dexcription
  ---
  This will write a TimeStamped output to the log file and to the screen.
  
  #>

  [CmdletBinding()]
  param(
    [parameter(Mandatory=$True,HelpMessage="message to be logged and displayed")]
    [ValidateNotNullOrEmpty()]
    [string[]]$Message,
    [parameter(Mandatory=$True,HelpMessage="Path of the Logfile")]
    [ValidateScript({Test-Path $_})]
    [string[]]$Path,
    [Parameter(Mandatory=$False)]
    [ValidateSet("INFO","WARN","ERROR","FATAL","DEBUG")]
    [String]$Level = "INFO",
    [Parameter(Mandatory=$false)]
    [switch]$ToScreen
    [switch]$TimeStamp
  ) #Closes Param block

  BEGIN {
        #Add the date and time to the message
        $Timestamp = get-date -format "yyyy-MM-dd hh-mm-ss"
        $Line = "$Timestamp - $Level, $Message"
  } #Closes BEGIN block
  PROCESS {
        #Send the message to the log
        $Line | out-file -append $Path
        #Send the message to the screen
        IF ($ToScreen) {
            Write-Output $Line
        } # Closes If
  } #Closes PROCESS block
  END {

  } #Closes End block
} #Closes Function Write-ToLog
