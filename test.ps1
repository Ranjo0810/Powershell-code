# C:\Users\ranjith\Desktop\test.json

#Read config file path from prompt
$configfilePath = Read-Host -Prompt 'Enter configfilePath'
Write-Host "Your input for config file: '$configfilepath'"

# make an JSONObj 
$JSONObj = Get-Content -Raw -Path $configfilePath | ConvertFrom-Json
$count = $JSONObj.FilesToLocate.Count
Write-Host "The number of files specified by the FilesToLocate attribute: $count"

# check if configfilePath exists on system, if not then return 1
if (-not(Test-Path -Path $configfilePath -PathType Leaf)) { Write-Host "1"}

# check if DirectoryPath attribute is missing, if so then return 2
elseif (-not(Get-Member -inputobject $JSONObj -name "DirectoryPath" -Membertype Properties)) {
    Write-Host "2"
}

# check if path specified by the DirectoryPath attribute does not exist, or if it is a file, the script should return 3
elseif (Get-Member -inputobject $JSONObj -name "DirectoryPath" -Membertype Properties) {
    # Read value of DirectoryPath from Json
    $DirPath = $JSONObj.DirectoryPath

    if (-not(Test-Path -Path $DirPath -PathType Leaf)) { Write-Host "3" }
    else { write-Host "Path exists on system" }  
}

# check if FilesToLocate attribute is missing, if so then return 4
elseif (-not(Get-Member -inputobject $JSONObj -name "FilesToLocate" -Membertype Properties)) {
    Write-Host "4"
}

else {
    # check if FileToLocate attribute exists in Json
    if (Get-Member -inputobject $JSONObj -name "FilesToLocate" -Membertype Properties) {

        #check if file specified by the FileToLocate attribute does not exist
        if ((Test-Path -Path $JSONObj.FilesToLocate[0] -PathType Leaf) -or 
        (Test-Path -Path $JSONObj.FilesToLocate[1] -PathType Leaf) ) { Write-Host "File exists on system" }

        else {
            Write-Host "Files doesn't exists on system"
        } 
    }
}