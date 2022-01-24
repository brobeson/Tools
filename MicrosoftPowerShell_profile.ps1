# This script sets up the Git prompt in Windows PowerShell. It requires
# posh-git: https://github.com/dahlbyk/posh-git.
#
# Download this file to ~/Documents/WindowsPowerShell/ on a Windows system.

Import-Module posh-git
$GitPromptSettings.DefaultPromptPrefix.Text = "`n" + $(Get-Date -Format "yyyy MMMM d h:mm tt") + " "
$GitPromptSettings.DefaultPromptPrefix.ForegroundColor = "Green"
$GitPromptSettings.DefaultPromptBeforeSuffix.Text = '`n'
$GitPromptSettings.DefaultPromptSuffix.Text = ''
$GitPromptSettings.DefaultPromptPath.ForegroundColor = "Purple"
$GitPromptSettings.BeforeStatus.Text = "("
$GitPromptSettings.BeforeStatus.ForegroundColor = "White"
$GitPromptSettings.AfterStatus.Text = ")"
$GitPromptSettings.AfterStatus.ForegroundColor = "White"
