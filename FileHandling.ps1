# This script performs various file operations and demonstrates error handling using try/catch/finally.
# Errors encountered during execution are logged using the $Error variable.

#File paths
$filepaths = @("D:\College\Sam_4\SYST16023 MS Powershell Scripting\Week10\Files\file1.txt", "D:\College\Sam_4\SYST16023 MS Powershell Scripting\Week10\Files\file2readonly.txt", "D:\College\Sam_4\SYST16023 MS Powershell Scripting\Week10\Files\file3.txt")

$logfilepath = "D:\College\Sam_4\SYST16023 MS Powershell Scripting\Week10\Files\error.log"

Clear-Content $logfilepath -ErrorAction SilentlyContinue

#Perform Read.
function Read-File {
    param ([string]$filepath)
    try{
        if(Test-Path $filepath) {
            $content = Get-Content $filepath
            Write-Output "File content form $filepath :"
            Write-Output $content

        } else {
            throw "File does not exist: $filepath"
        }
    } catch {
        Write-Error "Error reading file $filepath : $_"
        $Error[0] | Out-File $logfilepath -Append
    } finally {
        Write-Output "Read operation completed for $filepath."
    }
    
}



foreach ($file in $filePaths) {
    Read-File -filePath $file
}


#Perform write.
function Write-File {
    param ([string]$filepath, [string]$content)
    try {
        Add-Content $filepath -Value $content -ErrorAction Stop
        Write-Output "File written successfully: $filepath"
    } catch {
        Write-Error "Error writing to file $filepath : $_"
        $Error[0] | Out-File $logFilepath -Append
    } finally {
        Write-Output "Write operation completed for $filepath."
    }
}

foreach ($file in $filepaths) {
    Write-File -filepath $file -content "New content"
}

# Perform Delete.
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
        Write-Error "Error deleting file $filepath : $_"
        $Error[0] | Out-File $logFilepath -Append
    } finally {
        Write-Output "Delete operation completed for $filepath."
    }
}

foreach ($file in $filepaths) {
    Delete-File -filepath $file
}