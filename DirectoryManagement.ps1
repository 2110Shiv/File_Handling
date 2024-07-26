# DirectoryManagement.ps1
# This script performs directory management operations and demonstrates error handling using try/catch/finally.
# Errors encountered during execution are logged using the $Error variable.

# Define directory paths
$basedir = "D:\College\Sam_4\SYST16023 MS Powershell Scripting\Week10\Directories\File_Handling"
$pathtocreate = @("$basedir\Dir1", "$basedir\Dir2", "$basedir\Dir3")
$logfilepath = "$basedir\error.log"

# Clear previous error log
Clear-Content $logFilePath -ErrorAction SilentlyContinue

#Create a directory
function Create-Directory {
    param ([string]$dirpath)
    try {
        if (-not (Test-Path $dirpath)) {
            New-Item -ItemType Directory -Path $dirpath -ErrorAction Stop | Out-Null
            Write-Output "Directory created successfully: $dirpath"
        } else {
            Write-Output "Directory already exists: $dirpath"
        }
    } catch {
        Write-Error "Error creating directory $dirpath : $_"
        $Error[0] | Out-File $logfilepath -Append
    } finally {
        Write-Output "Create operation completed for $dirpath."
    }
}

# Create directories
foreach ($dir in $pathtocreate) {
    Create-Directory -dirpath $dir
}

# Function to delete a directory
function Delete-Directory {
    param ([string]$dirpath)
    try {
        if (Test-Path $dirpath) {
            $confirmation = Read-Host "Are you sure you want to delete the directory $dirpath? (Yes/No)"
            if ($confirmation -eq 'Yes') {
                Remove-Item $dirpath -Recurse -Force -ErrorAction Stop
                Write-Output "Directory deleted successfully: $dirpath"
            } else {
                Write-Output "Directory deletion canceled: $dirpath"
            }
        } else {
            throw "Directory does not exist: $dirpath"
        }
    } catch {
        Write-Error "Error deleting directory $dirpath : $_"
        $Error[0] | Out-File $logfilepath -Append
    } finally  {
        Write-Output "Delete operation completed for $dirpath."
    }
}

# Delete directories
foreach ($dir in $pathtocreate) {
    Delete-Directory -dirpath $dir
}

#Function to rename.
function  Rename-Directory {
    param ([string]$dirpath, [string]$newname)

    try {
        if (Test-Path $dirpath) {
            $confirmation = Read-Host "Are you sure you want to rename the directory $dirpath? (Yes/No)"
            if ($confirmation -eq 'Yes') {
            $newdirpath = Join-Path (Split-Path $dirpath -Parent) $newname
            Rename-Item -path $dirpath -newname $newname -ErrorAction Stop
            Write-Output "Directory renamed successfully for $dirpath to $newdirpath"
        } else {
            Write-Output "Rename operation canceled for $dirPath"
        }
    } else {
            throw "Directory does not exist: $dirpath"
    }

        } catch {
        Write-Error "Error renaming directory $dirpath to $newname : $_"
        $Error[0] | Out-File $logfilepath -Append
    } finally {
       Write-Output "Rename operation completed for $dirpath" 
    }
}

$renameddir = @{
"Dir1" = "Dir1New"
"Dir2" = "Dir2New"
"Dir3" = "Dir3New"
}


foreach ($dir in $pathtocreate) {
    $dirname = Split-Path -Leaf $dir
    if ($renameddir.ContainsKey($dirname)) {
        Rename-Directory -dirpath $dir -newname $renameddir[$dirname]
    } else {
        Write-Output "No new name found for $dirname"
    }
}