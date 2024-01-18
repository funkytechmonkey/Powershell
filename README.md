Export Bitlocker Keys from AD to CSV 

.EXAMPLE
   .\Get-ADComputers-BitLockerInfo.ps1

   Description
   -----------
   Generates a CSV file with computer names and BitLocker Recovery Keys
   
.EXAMPLE
   .\Get-ADComputers-BitLockerInfo.ps1 -OU "OU=Computers,OU=IT Department,DC=myDomain,DC=com"

   Description
   -----------
   Generates a CSV file with computer names and BitLocker Recovery Keys for computers in targed OU

.EXAMPLE
   .\Get-ADComputers-BitLockerInfo.ps1 -OU "OU=Computers,OU=IT Department,DC=myDomain,DC=com" -LogFilePath "C:\Scripts" -LogFileName "BitlockerInfo.csv"

   Description
   -----------
   Generates a CSV file with specific name and path
