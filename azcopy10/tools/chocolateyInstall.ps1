﻿$ErrorActionPreference = 'Stop';
 
$packageName = 'azcopy10'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName    = $packageName
    url64          = 'https://azcopyvnext.azureedge.net/release20201021/azcopy_windows_amd64_10.6.1.zip'
    checksum64     = '8ee0c126d77fb04731cd0b09e7451932dcd8a4c08308a25a8e84ba5db9c08c5a'
    checksumType64 = 'sha256'
    destination    = $toolsDir
}

#Manage azcopy installation
Install-ChocolateyZipPackage @packageArgs

$targetPath = Join-Path -Path $toolsDir -ChildPath 'azcopy'
If (Test-Path -Path $targetPath -PathType:Container) {
    Remove-Item -Path $targetPath -Force -Recurse
}
Rename-Item -Path (Join-Path -Path $toolsDir -ChildPath (($packageArgs.url64.replace('\', '/') -split '/' | Select-Object -Last 1) -replace ".zip", "") ) -NewName 'azcopy' -Force
