$path = (Get-Item -Path ".\" -Verbose).FullName
$paths = @($path + $args[0])

Write-Host "Check package.json for version wildcards"

function FindMatches ($dependencies)
{   
    $props = Get-Member -InputObject $dependencies -MemberType NoteProperty
    $filter = @('^','~','*','>','<')
    $matches = @()

    $props | ForEach-Object {
        $pv = $dependencies | Select-Object -ExpandProperty $_.Name
         foreach ($f in $filter) {
            if ($pv.StartsWith($f)) {
                 $matches += "package " + $_.Name + " version " + $pv
            }
        }
    }

    return $matches
}

function FormatResults ($dep)
{   
    $dep | ForEach-Object { $_ } 
}

$dep = @()
$devDep = @()

$paths | ForEach-Object  { 
    write-host "Checking " + $_
    $packagejson = Get-Content -Raw -Path $_ | ConvertFrom-Json
    $dep += FindMatches($packagejson.dependencies)
    $devDep += FindMatches($packagejson.devDependencies)
} 

if(($dep.Count -ne 0) -or ($devDep.Count -ne 0))
{
    Write-Host "::Error:: wildcards found"

    FormatResults($dep)
    FormatResults($devDep)

    exit 1
}