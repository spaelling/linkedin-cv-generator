# npm install to get gulp up and running - assuming node.js is already installed
npm install

# ser PowerShell variables
$TargetFolder = 'C:\Users\spael\Downloads\Basic_LinkedInDataExport_07-05-2023'
$OutputDirectory = '.\output'
$TemplateFile = ".\src\templates\template-01.md.ps1"

# Load LinkedIn data exported files
. ".\src\load-data.ps1"
# render the template file
. "$TemplateFile"
# create folder if it does not exist
$null = New-Item -ItemType Directory -Force -Path $OutputDirectory
# output to markdown
$Template | Out-File -FilePath "$OutputDirectory\cv.md" -Force

# run build task
npx gulp 'Build Markdown CV'

# open generated html file in MS edge
&'C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe' @((Resolve-Path -Path ".\output\cv.html").Path)