$main_folder = ""
[System.Reflection.Assembly]::LoadFrom("$main_folder\Assembly\MahApps.Metro.dll")      
[System.Reflection.Assembly]::LoadFrom("$main_folder\Assembly\System.Windows.Interactivity.dll") 
[System.Reflection.Assembly]::LoadWithPartialName('presentationframework') | out-null

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
    $ok      = [MahApps.Metro.Controls.Dialogs.MessageDialogStyle]::AffirmativeAndNegative
    $result = [MahApps.Metro.Controls.Dialogs.DialogManager]::ShowModalMessageExternal($Form,"text","text",$ok)

	
})



$Form.ShowDialog() | Out-Null