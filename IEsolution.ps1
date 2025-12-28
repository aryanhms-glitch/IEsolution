$siteUrl       = "http://time.servohyd.com"  
$xmlPath       = "C:\inetpub\wwwroot\ie-mode-sitelist.xml"  
$regKeyPathHKLM = "HKLM:\SOFTWARE\Policies\Microsoft\Edge"


$xmlDir = Split-Path $xmlPath -Parent
if (-not (Test-Path $xmlDir)) {
    New-Item -Path $xmlDir -ItemType Directory -Force | Out-Null
}

$xmlContent = @"
<?xml version="1.0" encoding="utf-8"?>
<site-list version="1">
  <site url="http://time.servohyd.com">
    <open-in>IE11</open-in>
    <include-subdomains>true</include-subdomains>
  </site>
</site-list>

"@

$xmlContent | Out-File -FilePath $xmlPath -Encoding UTF8 -Force
Write-Host "IE mode site list XML created at: $xmlPath"


if (-not (Test-Path $regKeyPathHKLM)) {
    New-Item -Path $regKeyPathHKLM -Force | Out-Null
}


Set-ItemProperty -Path $regKeyPathHKLM -Name "InternetExplorerIntegrationLevel" -Value 1 -Type DWord


$siteListUrl = "file:///$($xmlPath -replace '\\', '/')"
Set-ItemProperty -Path $regKeyPathHKLM -Name "InternetExplorerIntegrationSiteList" -Value $siteListUrl -Type String
Write-Host "`nScript completed."

