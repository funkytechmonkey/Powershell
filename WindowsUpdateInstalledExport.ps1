#Pull list of installed Windows Patches on a server.
# This pulls more patches installed than Get-HotFix does.
##Check if c:\temp exists, if it doesnt create it. 
If(-not(Test-Path -Path "c:\temp"))
  {New-Item -ItemType Directory -Force -Path C:\temp}
#
#RegEx to pull the KB number from the Title field.
$regex = "(KB.[0-9]*)"
$hostname = HOSTNAME
$Session = New-Object -ComObject "Microsoft.Update.Session"
$Searcher = $Session.CreateUpdateSearcher()
$FormatEnumerationLimit=-1
$historyCount = $Searcher.GetTotalHistoryCount()

$Searcher.QueryHistory(0, $historyCount)  | where date -gt (Get-Date "1/1/2000") | Select-Object  @{name="HostName"; expression = { $hostname }}, @{name="Install_Date"; expression = { $_.Date }},@{name="KB"; expression = { (select-string $regex -inputobject $_.Title).matches.groups[1].value }}, Title, Description, 
#@{name="KB"; expression = { $(If ($_.Title -match $Regex) { $Matches['ic'] } Else { '<UNKNOWN>' })}}, #Trying to Regex out the KB# from Title line. I figured it out, just leaving this line as reference.
@{name="Operation"; expression={switch($_.operation){1 {"Installation"}; 2 {"Uninstallation"}; 3 {"Other"}}}}, 
@{name="Status"; expression={switch($_.resultcode){1 {"In Progress"}; 2 {"Succeeded"}; 3 {"Succeeded With Errors"};4 {"Failed"}; 5 {"Aborted"} }}}, SupportUrl | Export-Csv -NoTypeInformation -path "C:\Temp\WindowsUpdateLogs\Windows_Patch_History-for-$hostname-runon-$(get-date -f yyyyMMdd-hhmm).csv"
