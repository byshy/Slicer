<# : chooser.bat
:: launches a File... Open sort of file chooser and outputs choice(s) to the console
:: https://stackoverflow.com/a/15885133/1683264

@echo off
setlocal

for /f "delims=" %%I in ('powershell -noprofile "iex (${%~f0} | out-string)"') do (
    echo %%~I
)
goto :EOF

: end Batch portion / begin PowerShell hybrid chimera #>

Add-Type -AssemblyName System.Windows.Forms
$f = new-object Windows.Forms.FolderBrowserDialog
$f.Description = "Please choose the folder containing the necessary files to build the apk"
$f.RootFolder = "C:\Users\byshy\Desktop"
$f.ShowNewFolderButton = $false

[void]$f.ShowDialog()
$f.SelectedPath