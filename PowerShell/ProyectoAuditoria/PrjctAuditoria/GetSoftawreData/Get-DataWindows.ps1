# #Get-wmiobject -Class Win32_product | 
# Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* 
# Where-Object { $_.Name -imatch 'Windows|C\+\+|Python|PHP|Oracle|MySQL'} |
# Select-Object DisplayName, DisplayVersion | 
# ConvertTo-JSON


Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*


# $apps = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*
# 
# $result = [PSCustomObject]@{
#     Windows = $apps | Where-Object { $_.DisplayName -match 'Windows' } |
#         Select-Object DisplayName, DisplayVersion
# 
#     CPP = $apps | Where-Object { $_.DisplayName -match 'C\+\+|Visual C\+\+' } |
#         Select-Object DisplayName, DisplayVersion
# 
#     Python = $apps | Where-Object { $_.DisplayName -match 'Python' } |
#         Select-Object DisplayName, DisplayVersion
# 
#     PHP = $apps | Where-Object { $_.DisplayName -match 'PHP' } |
#         Select-Object DisplayName, DisplayVersion
# 
#     NODE = $apps | Where-Object { $_.DisplayName -match 'node' } |
#         Select-Object DisplayName, DisplayVersion
# 
#     Oracle = $apps | Where-Object { $_.DisplayName -match 'Oracle' } |
#         Select-Object DisplayName, DisplayVersion
# 
#     POSTMAN = $apps | Where-Object { $_.DisplayName -match 'Postman' } |
#         Select-Object DisplayName, DisplayVersion
#     
#     CARGO = $apps | Where-Object { $_.DisplayName -match 'Rust|rustup|cargo' } |
#         Select-Object DisplayName, DisplayVersion
# 
#     MySQL = $apps | Where-Object { $_.DisplayName -match 'MySQL' } |
#         Select-Object DisplayName, DisplayVersion
# }
# 
# $result | ConvertTo-Json -Depth 6