if (-not (Test-Path -Path $TargetFolder -ErrorAction Stop)) {
    throw "Target folder '$TargetFolder' not found"
}

$CsvFiles = Get-ChildItem -Path $TargetFolder -Filter "*.csv" | Where-Object { $_.Name -ne "Ad_Targeting.csv" }

foreach ($CsvFile in $CsvFiles) {
    $VariableName = "_cv_$($CsvFile.Name.Replace('.csv',''))"
    try {
        $Value = Import-Csv -Path $CsvFile.FullName        
    }
    catch {
        Write-Error "Failed to import CSV $($CsvFile.FullName)"
    }
    Set-Variable -Name $VariableName -Value $Value
    $Value = $null
}

# dates are strings in the format <month_shortname year>
function Add-DateTimes {
    [CmdletBinding()]
    param (
        [array]$Data,
        $VariableName,
        $DateTimeVariableName
    )
    foreach ($item in $Data) {
        # could be the date string is empty
        if ($item.$VariableName) {
            [DateTime]$Value = new-object DateTime
            try {
                if (-not [DateTime]::tryParse($item.$VariableName, [ref]$Value)) {
                    # for projects the date is sometimes just the year
                    $Value = [System.DateTime]::ParseExact($item.$VariableName, "yyyy", $null)
                }
            }
            catch {
                Write-Warning "Failed to parse '$($item.$VariableName)'"
                $item
                # $Value = ''
            }
            $item = $item | Add-Member -MemberType NoteProperty -Name $DateTimeVariableName -Value $Value -Force
        }
    }
}

# sort certifications by date, nulls last
Add-DateTimes -Data $_cv_Certifications -VariableName "Finished On" -DateTimeVariableName "FinishedOn"
$_cv_Certifications = $_cv_Certifications | Sort-Object -Property FinishedOn, Name -Descending
# sort projects by date
Add-DateTimes -Data $_cv_Projects -VariableName "Started On" -DateTimeVariableName "StartedOn"
$_cv_Projects = $_cv_Projects | Sort-Object -Property StartedOn, Title -Descending
# only include visible recomendations
$_cv_Recommendations_Received = $_cv_Recommendations_Received | Where-Object { $_.Status -eq "VISIBLE" }
#
Add-DateTimes -Data $_cv_Positions -VariableName "Started On" -DateTimeVariableName "StartedOn"
$_cv_Positions = $_cv_Positions | Sort-Object -Property StartedOn, Title -Descending | ForEach-Object {
    # if there is no finshed date, then set the value to 'Current'
    if ([string]::IsNullOrEmpty($_.'Finished On')) {
        $_.'Finished On' = 'Current'
    }
    $_
}
