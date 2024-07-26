# Directory and File Management Script

## Scenario

Imagine you're managing a large project where you need to organize and maintain multiple directories and files for various phases of development. For instance, you have directories for different stages of a project and files that log progress, configuration settings, and more. You need a script that can:

- Create directories for new phases.
- Delete obsolete directories.
- Rename directories to reflect changes in project names or stages.
- Perform file operations like reading, writing, and deleting.

This script helps streamline these tasks by automating directory and file management. It includes robust error handling and logging to ensure you can quickly troubleshoot any issues.

## Features

- **Create Directories**: Automatically create directories for project phases or other organizational needs.
- **Delete Directories**: Remove directories that are no longer needed, with confirmation prompts.
- **Rename Directories**: Update directory names to match changes in project stages or naming conventions.
- **File Operations**: Read, write, and delete files with error handling and logging.

## Prerequisites

- PowerShell 5.0 or higher
- Necessary permissions to manage directories and files in the specified paths

## Usage

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/2110Shiv/repositoryname.git
   cd Directory_FileManagement
Configure Paths:

Open DirectoryManagement.ps1 and FileManagement.ps1 in a text editor.
Update $basedir in DirectoryManagement.ps1 with the path where you want to manage directories.
Update $filepaths and $logfilepath in FileManagement.ps1 with the paths to your files and log file.
powershell
Copy code
# For DirectoryManagement.ps1
$basedir = "D:\path\to\your\directories"

# For FileManagement.ps1
$filepaths = @(
    "D:\path\to\your\files\file1.txt",
    "D:\path\to\your\files\file2.txt",
    "D:\path\to\your\files\file3.txt"
)
$logfilepath = "D:\path\to\your\files\error.log"
Run the Scripts:

Open PowerShell as Administrator and navigate to the script directory:

.\DirectoryManagement.ps1
Then execute the file management script:

.\FileManagement.ps1
Check the Error Log:

If any errors occur during execution, they will be logged in the error.log file located in the specified path.

Script Details
DirectoryManagement.ps1
Create-Directory: Creates directories if they do not exist. Logs errors if creation fails.
Delete-Directory: Deletes directories after user confirmation. Logs errors if deletion fails.
Rename-Directory: Renames directories after user confirmation. Logs errors if renaming fails.
FileManagement.ps1
Read-File: Reads and outputs the content of specified files. Logs errors if the file does not exist or cannot be read.
Write-File: Appends specified content to files. Logs errors if content cannot be written.
Delete-File: Prompts for confirmation before deleting files. Logs errors if deletion fails.
Error Handling and Logging
Errors are captured using try/catch/finally blocks.
Errors encountered during operations are logged to the specified error.log file.
The script continues executing even if errors occur, ensuring other operations are not affected.
Troubleshooting
File Paths: Ensure that the file and directory paths are correct and accessible.

Permissions: Verify that you have the necessary permissions to perform the operations.

Execution Policy: If you encounter issues running the scripts, set your PowerShell execution policy to allow script execution:

powershell

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
License
This script is licensed under the MIT License. See the LICENSE file for more details.

Script:
```
# Combined Script for Directory and File Management
# This script performs directory and file management operations, demonstrating error handling and logging.

# Define base directory and file paths
$basedir = "D:\College\Sam_4\SYST16023 MS Powershell Scripting\Week10"
$dirPathsToCreate = @("$basedir\Directories\Dir1", "$basedir\Directories\Dir2", "$basedir\Directories\Dir3")
$filePaths = @(
    "$basedir\Files\file1.txt",
    "$basedir\Files\file2.txt",
    "$basedir\Files\file3.txt"
)
$logFilePath = "$basedir\Files\error.log"

# Clear previous error log
Clear-Content $logFilePath -ErrorAction SilentlyContinue

# Directory Management Functions

# Create a directory
function Create-Directory {
    param ([string]$dirPath)
    try {
        if (-not (Test-Path $dirPath)) {
            New-Item -ItemType Directory -Path $dirPath -ErrorAction Stop | Out-Null
            Write-Output "Directory created successfully: $dirPath"
        } else {
            Write-Output "Directory already exists: $dirPath"
        }
    } catch {
        Write-Error "Error creating directory $dirPath : $_"
        $Error[0] | Out-File $logFilePath -Append
    } finally {
        Write-Output "Create operation completed for $dirPath."
    }
}

# Delete a directory
function Delete-Directory {
    param ([string]$dirPath)
    try {
        if (Test-Path $dirPath) {
            $confirmation = Read-Host "Are you sure you want to delete the directory $dirPath? (Yes/No)"
            if ($confirmation -eq 'Yes') {
                Remove-Item $dirPath -Recurse -Force -ErrorAction Stop
                Write-Output "Directory deleted successfully: $dirPath"
            } else {
                Write-Output "Directory deletion canceled: $dirPath"
            }
        } else {
            throw "Directory does not exist: $dirPath"
        }
    } catch {
        Write-Error "Error deleting directory $dirPath : $_"
        $Error[0] | Out-File $logFilePath -Append
    } finally {
        Write-Output "Delete operation completed for $dirPath."
    }
}

# Rename a directory
function Rename-Directory {
    param ([string]$dirPath, [string]$newName)
    try {
        if (Test-Path $dirPath) {
            $confirmation = Read-Host "Are you sure you want to rename the directory $dirPath to $newName? (Yes/No)"
            if ($confirmation -eq 'Yes') {
                $newDirPath = Join-Path (Split-Path $dirPath -Parent) $newName
                Rename-Item -Path $dirPath -NewName $newName -ErrorAction Stop
                Write-Output "Directory renamed successfully from $dirPath to $newDirPath"
            } else {
                Write-Output "Rename operation canceled for $dirPath"
            }
        } else {
            throw "Directory does not exist: $dirPath"
        }
    } catch {
        Write-Error "Error renaming directory $dirPath to $newName : $_"
        $Error[0] | Out-File $logFilePath -Append
    } finally {
        Write-Output "Rename operation completed for $dirPath."
    }
}

# File Management Functions

# Read a file
function Read-File {
    param ([string]$filePath)
    try {
        if (Test-Path $filePath) {
            $content = Get-Content $filePath
            Write-Output "File content from $filePath:"
            Write-Output $content
        } else {
            throw "File does not exist: $filePath"
        }
    } catch {
        Write-Error "Error reading file $filePath: $_"
        $Error[0] | Out-File $logFilePath -Append
    } finally {
        Write-Output "Read operation completed for $filePath."
    }
}

# Write to a file
function Write-File {
    param ([string]$filePath, [string]$content)
    try {
        Add-Content $filePath -Value $content -ErrorAction Stop
        Write-Output "Content appended successfully to file: $filePath"
    } catch {
        Write-Error "Error writing to file $filePath: $_"
        $Error[0] | Out-File $logFilePath -Append
    } finally {
        Write-Output "Write operation completed for $filePath."
    }
}

# Delete a file
function Delete-File {
    param ([string]$filePath)
    try {
        $confirmation = Read-Host "Are you sure you want to delete the file $filePath? (Yes/No)"
        if ($confirmation -eq 'Yes') {
            Remove-Item $filePath -ErrorAction Stop
            Write-Output "File deleted successfully: $filePath"
        } else {
            Write-Output "File deletion canceled: $filePath"
        }
    } catch {
        Write-Error "Error deleting file $filePath: $_"
        $Error[0] | Out-File $logFilePath -Append
    } finally {
        Write-Output "Delete operation completed for $filePath."
    }
}

# Execution

# Create directories
foreach ($dir in $dirPathsToCreate) {
    Create-Directory -dirPath $dir
}

# Delete directories
foreach ($dir in $dirPathsToCreate) {
    Delete-Directory -dirPath $dir
}

# Rename directories
$renamedDirs = @{
    "Dir1" = "Dir1New"
    "Dir2" = "Dir2New"
    "Dir3" = "Dir3New"
}

foreach ($dir in $dirPathsToCreate) {
    $dirName = Split-Path -Leaf $dir
    if ($renamedDirs.ContainsKey($dirName)) {
        Rename-Directory -dirPath $dir -newName $renamedDirs[$dirName]
    } else {
        Write-Output "No new name found for $dirName"
    }
}

# Perform file operations
foreach ($file in $filePaths) {
    Read-File -filePath $file
    Write-File -filePath $file -content "New content"
    Delete-File -filePath $file
}
TO USE THIS SCRIPT COPY AND SAVE THIS AS "SCRIPT.ps1" THEN RUN IT.
```
You can also find the separate scripts for file and directory in the master branch.
