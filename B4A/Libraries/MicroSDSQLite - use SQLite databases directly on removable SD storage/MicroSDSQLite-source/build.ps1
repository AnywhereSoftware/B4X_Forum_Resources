param(
    [switch]$Install,
    [string]$InstallDir = $env:B4A_ADDITIONAL_LIBS
)

$ErrorActionPreference = "Stop"

$ProjectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$OutDir = Join-Path $ProjectRoot "out"
$ClassesDir = Join-Path $OutDir "classes"
$JarPath = Join-Path $OutDir "MicroSDSQLite.jar"
$XmlPath = Join-Path $ProjectRoot "MicroSDSQLite.xml"

$Javac = "C:\Java\bin\javac.exe"
$Jar = "C:\Java\bin\jar.exe"
$AndroidJar = "C:\Android\platforms\android-36\android.jar"
$B4ALibs = "C:\Program Files\Anywhere Software\B4A\Libraries"
$B4AShared = Join-Path $B4ALibs "B4AShared.jar"
$SqlJar = Join-Path $B4ALibs "Sql.jar"

foreach ($path in @($Javac, $Jar, $AndroidJar, $B4AShared, $SqlJar, $XmlPath)) {
    if (-not (Test-Path -LiteralPath $path)) {
        throw "Required build input not found: $path"
    }
}

if (Test-Path -LiteralPath $OutDir) {
    Remove-Item -LiteralPath $OutDir -Recurse -Force
}
New-Item -ItemType Directory -Path $ClassesDir | Out-Null

$Sources = Get-ChildItem -Path (Join-Path $ProjectRoot "src") -Recurse -Filter "*.java" | ForEach-Object { $_.FullName }
if ($Sources.Count -eq 0) {
    throw "No Java sources found."
}

$Classpath = @($AndroidJar, $B4AShared, $SqlJar) -join ";"
& $Javac -source 8 -target 8 -encoding UTF-8 -classpath $Classpath -d $ClassesDir $Sources
& $Jar cf $JarPath -C $ClassesDir .

Copy-Item -LiteralPath $XmlPath -Destination (Join-Path $OutDir "MicroSDSQLite.xml") -Force

if ($Install) {
    if ([string]::IsNullOrWhiteSpace($InstallDir)) {
        throw "InstallDir was not supplied. Use -InstallDir `"C:\Path\To\Your\B4A\AdditionalLibraries`" or set the B4A_ADDITIONAL_LIBS environment variable."
    }
    if (-not (Test-Path -LiteralPath $InstallDir)) {
        New-Item -ItemType Directory -Path $InstallDir | Out-Null
    }
    Copy-Item -LiteralPath $JarPath -Destination (Join-Path $InstallDir "MicroSDSQLite.jar") -Force
    Copy-Item -LiteralPath $XmlPath -Destination (Join-Path $InstallDir "MicroSDSQLite.xml") -Force
}

Write-Host "Built: $JarPath"
Write-Host "Built: $(Join-Path $OutDir 'MicroSDSQLite.xml')"
if ($Install) {
    Write-Host "Installed to: $InstallDir"
}
