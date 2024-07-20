# File_Handling
# File Management PowerShell Script

This PowerShell script performs various file operations and demonstrates error handling using try/catch/finally. It includes functionalities for reading, writing, and deleting files, with error logging to handle and document any issues encountered during execution.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Usage](#usage)
3. [Script Overview](#script-overview)
4. [Error Handling and Logging](#error-handling-and-logging)
5. [Troubleshooting](#troubleshooting)
6. [License](#license)

## Prerequisites

Before running the script, ensure that you have:

- PowerShell installed on your system (recommended version 5.1 or later).
- Appropriate permissions to read from, write to, and delete files in the specified directories.

## Usage

1. **Clone the Repository:**
   Clone this repository to your local machine:
   ```bash
   git clone https://github.com/yourusername/repositoryname.git
Navigate to the directory:

bash
Copy code
cd repositoryname
Modify File Paths:
Open the script file (FileManagement.ps1) in a text editor.

Update the $filepaths array with the paths to the files you want to manage.
Update the $logfilepath variable with the path where you want to store the error log.
Run the Script:
Open PowerShell as Administrator and navigate to the script directory:

bash
Copy code
cd path\to\repository
Execute the script:

powershell
Copy code
.\FileManagement.ps1
Script Overview
Read-File Function: Reads and outputs the content of specified files. Logs errors if the file does not exist or cannot be read.
Write-File Function: Appends specified content to the files. Logs errors if the content cannot be written.
Delete-File Function: Prompts for confirmation before deleting the specified files. Logs errors if the file cannot be deleted.
Error Handling and Logging
Errors are handled using try/catch/finally blocks.
Errors encountered during file operations are logged to the specified error log file ($logfilepath).
The script continues to execute even if errors occur, ensuring that other operations are not affected.
Troubleshooting
File Paths: Ensure that the file paths specified in $filepaths and $logfilepath are correct and accessible.
Permissions: Make sure you have the necessary permissions to perform file operations in the specified directories.
Execution Policy: If you encounter issues running the script, check your PowerShell execution policy. You may need to set it to allow script execution:
powershell
Copy code
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
License
This script is provided under the MIT License. See the LICENSE file for more details.

``` Script:

# This script performs various file operations and demonstrates error handling using try/catch/finally.
# Errors encountered during execution are logged using the $Error variable.

# File paths
$filepaths = @(
    "D:\College\Sam_4\SYST16023 MS Powershell Scripting\Week10\Files\file1.txt",
    "D:\College\Sam_4\SYST16023 MS Powershell Scripting\Week10\Files\file2readonly.txt",
    "D:\College\Sam_4\SYST16023 MS Powershell Scripting\Week10\Files\file3.txt"
)

$logfilepath = "D:\College\Sam_4\SYST16023 MS Powershell Scripting\Week10\Files\error.log"

Clear-Content $logfilepath -ErrorAction SilentlyContinue

# Perform Read
function Read-File {
    param ([string]$filepath)
    try {
        if (Test-Path $filepath) {
            $content = Get-Content $filepath
            Write-Output "File content from $filepath:"
            Write-Output $content
        } else {
            throw "File does not exist: $filepath"
        }
    } catch {
        Write-Error "Error reading file $filepath: $_"
        $Error[0] | Out-File $logfilepath -Append
    } finally {
        Write-Output "Read operation completed for $filepath."
    }
}

foreach ($file in $filepaths) {
    Read-File -filepath $file
}

# Perform Write
function Write-File {
    param ([string]$filepath, [string]$content)
    try {
        Add-Content $filepath -Value $content -ErrorAction Stop
        Write-Output "Content appended successfully to file: $filepath"
    } catch {
        Write-Error "Error writing to file $filepath: $_"
        $Error[0] | Out-File $logfilepath -Append
    } finally {
        Write-Output "Write operation completed for $filepath."
    }
}

foreach ($file in $filepaths) {
    Write-File -filepath $file -content "New content"
}

# Perform Delete
function Delete-File {
    param ([string]$filepath)
    try {
        $confirmation = Read-Host "Are you sure you want to delete the file $filepath? (Yes/No)"
        if ($confirmation -eq 'Yes') {
            Remove-Item $filepath -ErrorAction Stop
            Write-Output "File deleted successfully: $filepath"
        } else {
            Write-Output "File deletion canceled: $filepath"
        }
    } catch {
        Write-Error "Error deleting file $filepath: $_"
        $Error[0] | Out-File $logfilepath -Append
    } finally {
        Write-Output "Delete operation completed for $filepath."
    }
}

foreach ($file in $filepaths) {
    Delete-File -filepath $file
}
```
