$path = "$PSScriptRoot\GeneratedReports"

If(!(test-path $path))
{
      New-Item -ItemType Directory -Force -Path $path
}

Remove-Item "$path\*.*" -Recurse -Exclude "Archive" -Force


$nugetOpenCoverPackage = Join-Path -Path $env:USERPROFILE -ChildPath "\.nuget\packages\OpenCover"
$latestOpenCover = Join-Path -Path ((Get-ChildItem -Path $nugetOpenCoverPackage | Sort-Object Fullname -Descending)[0].FullName) -ChildPath "tools\OpenCover.Console.exe"


$nugetReportGeneratorPackage = Join-Path -Path $env:USERPROFILE -ChildPath "\.nuget\packages\\reportgenerator"
$lastestReportGenerator = Join-Path -Path ((Get-ChildItem -Path $nugetReportGeneratorPackage | Sort-Object Fullname -Descending)[0].FullName) -ChildPath "tools\ReportGenerator.exe"


If (Test-Path "$PSScriptRoot\OpenCover"){
	Remove-Item "$PSScriptRoot\OpenCover"
}

& dotnet build $PSScriptRoot\TDC.Metrics.sln

$filter = "+[*]* -[TDC.Metrics.UnitTest]*"

$dotnetArguments = "xunit", "-xml `"`"$PSScriptRoot\GeneratedReports\testRuns.testresults`"`""

& $latestOpenCover `
        -register:user `
        -target:dotnet.exe  `
        -targetdir:$PSScriptRoot\TDC.Metrics.UnitTest `
        "-targetargs:$dotnetArguments" `
        -output:"$PSScriptRoot\OpenCover.xml" `
        -mergebyhash `
        -oldStyle `
        -excludebyattribute:System.CodeDom.Compiler.GeneratedCodeAttribute `
        -filter:"$filter"`


Write-Host $lastestReportGenerator

& $lastestReportGenerator `
    -reports:"$PSScriptRoot\OpenCover.xml" `
    -targetdir:$PSScriptRoot\GeneratedReports 



Read-Host -Prompt "Press Enter to continue"