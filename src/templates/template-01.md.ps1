$Template = @"
# Your Name
## About
Write a brief introduction about yourself, highlighting your skills, achievements and goals.

## Experience
List your relevant work experience in reverse chronological order, with the most recent one first. Include the job title, company name, location, and dates of employment. Use bullet points to describe your main responsibilities and accomplishments.

- Job Title, Company Name, Location (Month Year - Month Year)
  - Responsibility or accomplishment 1
  - Responsibility or accomplishment 2
  - Responsibility or accomplishment 3

- Job Title, Company Name, Location (Month Year - Month Year)
  - Responsibility or accomplishment 1
  - Responsibility or accomplishment 2
  - Responsibility or accomplishment 3

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
Include one or two quotes from people who can vouch for your work quality, performance or character. Include their name, title, and affiliation.

- "Quote from a recommender." - Name, Title, Affiliation
- "Quote from a recommender." - Name, Title, Affiliation

## Languages
List the languages that you can speak, read or write. Indicate your level of proficiency using terms such as native, fluent, proficient, intermediate or basic.

- Language: Level of proficiency
- Language: Level of proficiency

CV generated using [github.com/spaelling/linked-cv-generator](https://github.com/spaelling/linked-cv-generator)
"@