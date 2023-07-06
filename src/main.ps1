$TargetFolder = 'C:\Users\spael\Downloads\Basic_LinkedInDataExport_07-05-2023'
$OutputPath = '..\output\cv.md'
$TemplateFile = ".\templates\template-01.md.ps1"

# Load LinkedIn data exported files
. ".\load-data.ps1"
# load the template file
. "$TemplateFile"

$Template | Out-File -FilePath $OutputPath -Force