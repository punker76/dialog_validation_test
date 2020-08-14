$main_folder = "."

[System.Reflection.Assembly]::LoadWithPartialName('presentationframework') | out-null

foreach ($file in (Get-ChildItem "$main_folder\assembly\" -File *.dll)) {
    Add-Type -Path $file.PSPath
}

function LoadXml ($global:filename)
{
    $XamlLoader=(New-Object System.Xml.XmlDocument)
    $XamlLoader.Load($filename)
    return $XamlLoader
}

# Load MainWindow
$XamlMainWindow=LoadXml("$main_folder\Testing_GUI.xaml")
$Reader=(New-Object System.Xml.XmlNodeReader $XamlMainWindow)
$Form=[Windows.Markup.XamlReader]::Load($Reader)

$Cliquez = $Form.findname("Cliquez")

# $Cliquez.Add_Click({
# $OKetCancel = [MahApps.Metro.Controls.Dialogs.MessageDialogStyle]::AffirmativeAndNegative
# $Resultat = [MahApps.Metro.Controls.Dialogs.DialogManager]::ShowModalMessageExternal($Form,"Hey all","Do you want to continue  ?",$OKetCancel)
# If($Resultat -eq "Affirmative")
	# {
		# [MahApps.Metro.Controls.Dialogs.DialogManager]::ShowMessageAsync($Form, "Hey", "You clicked on OK")			
	# }
# Else
	# {
		# [MahApps.Metro.Controls.Dialogs.DialogManager]::ShowMessageAsync($Form, "Hey", "You clicked on Cancel")			
	# }
# })

$Cliquez.Add_Click({
	$Settings = [MahApps.Metro.Controls.Dialogs.LoginDialogSettings]::new()
	# $Settings.ColorScheme              = "Accented"
    $Settings.DialogMessageFontSize    = "14"
	$Settings.DialogTitleFontSize      = "16"
	$Settings.NegativeButtonVisibility = "Visible"
    $Settings.DialogResultOnCancel     = "Canceled"
    $Settings.UsernameWatermark        = "Username..."
    $Settings.PasswordWatermark        = "Password..."
    $Settings.UsernameCharacterCasing  = "Normal"
    $Settings.DefaultButtonFocus       = "Affirmative"
    $Settings.EnablePasswordPreview    = "True"
	$ok       = [MahApps.Metro.Controls.Dialogs.MessageDialogStyle]::AffirmativeAndNegative
    # $result   = [MahApps.Metro.Controls.Dialogs.DialogManager]::ShowModalMessageExternal($Form, "Test", "...42", $ok)
    $result   = [MahApps.Metro.Controls.Dialogs.DialogManager]::ShowModalLoginExternal($Form, "Test", "...42", $Settings)
})

$Form.ShowDialog() | Out-Null
