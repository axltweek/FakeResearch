param (
    [string]$fakeExePath = ""
)

if(Test-Path $fakeExePath) {
    Write-Error "Invalid path ('$fakeExePath') to the FAKE."
    return;
}

& $fakeExePath build.fsx


<#
cls;
$fakeExePath = "packages\FAKE\tools\FAKE.exe"
$paketFolderPath =  ".paket\"
$paketExeBootstraper = [System.IO.Path]::Combine($paketFolderPath, "paket.bootstrapper.exe")
if(Test-Path $paketExeBootstraper) {

    Write-Host "Paket: package managment"
    & $paketExeBootstraper

    $paketExePath = [System.IO.Path]::Combine($paketFolderPath, "paket.exe")
    if(Test-Path $paketExePath) {
        Write-Host "Paket: restore"
        & $paketExePath restore

        Write-Host "Paket: convert nuget's 'package.config' to 'paket.dependencies'"
        & $paketExePath convert-from-nuget --force 
        & $paketExePath simplify

        Write-Host "Paket: install packages"
        & $paketExePath install

        if(Test-Path $fakeExePath) {
            & $fakeExePath build.fsx
        }
        else {
            throw [System.IO.FileNotFoundException] "File '$fakeExePath' not found."
        }
    }
    else {
        throw [System.IO.FileNotFoundException] "File '$paketExePath' not found."
    }
}
else {
    throw [System.IO.FileNotFoundException] "File '$pathToPaketBootstrapper' not found. Please download from 'https://github.com/fsprojects/Paket/releases/tag/3.21.0'"
}
#>