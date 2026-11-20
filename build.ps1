$ErrorActionPreference = 'Stop'
$compiler = Join-Path $env:WINDIR 'Microsoft.NET/Framework64/v4.0.30319/csc.exe'
if (!(Test-Path $compiler)) {
    $compiler = Join-Path $env:WINDIR 'Microsoft.NET/Framework/v4.0.30319/csc.exe'
}
$output = Join-Path $PSScriptRoot 'dist'
New-Item -ItemType Directory -Path $output -Force | Out-Null
$executable = Join-Path $output 'SleepMonitors.exe'
$source = Join-Path $PSScriptRoot 'SleepMonitors.cs'
& $compiler /nologo /target:winexe /optimize+ /platform:anycpu "/out:$executable" $source
if ($LASTEXITCODE -ne 0) { throw 'Compilation failed.' }
Write-Output "$output/SleepMonitors.exe"
