
<#
This template will certainly not result in a markdown file that will pass a linter. 
But as long as it renders into something that looks nice, we dont care!
#>

$Websites = $_cv_Profile.Websites.Replace('[', '').Replace(']', '').Split(',') | ForEach-Object { $_.replace('PERSONAL:', '') }

$Template = @"
<link rel="stylesheet" href="/css/air.css">

# $($_cv_Profile.'First Name') $($_cv_Profile.'Last Name')
_$($_cv_Profile.'Headline')_

## About
$($_cv_Profile.'Summary'.Replace('  ', "`n`n"))

$(
  if($Websites.Length -gt 0)
  {
    $Websites
  }
)

## Experience

$(
  foreach ($position in $_cv_Positions) {

"### $($position.Title), $($position.'Company Name')`n"
"$($position.'Started On')-$($position.'Finished On')`n`n"
"$($position.Description.Replace('  ', "\`n"))"
"`n`n"
  }
)
## Licenses & Certifications

$(
  foreach ($cert in $_cv_Certifications) {
" - $($cert.Name), $($cert.Authority) $(if($cert.'Finished On'){"($($cert.'Finished On'))"})`n"
  }
)
## Projects
$(
  foreach ($project in $_cv_Projects) {

"### $($project.Title)`n"
"$($project.'Started On')-$($project.'Finished On')`n`n"
"$($project.Description.Replace('  ', "\`n"))"
"`n`n"
  }
)

## Recommendations

$_cv_Recommendations_Received

$(
  foreach ($recomendation in $_cv_Recommendations_Received) {
" - $($recomendation.Text) - *$($recomendation.'First Name') $($recomendation.'Last Name'), $($recomendation.'Company'), $($recomendation.'Job Title')*`n"
  }
)

## Languages

$(
  foreach ($lang in $_cv_Languages) {
" - $($lang.Name), $($lang.Proficiency)`n"
  }
)

CV generated using [github.com/spaelling/linked-cv-generator](https://github.com/spaelling/linked-cv-generator)
"@