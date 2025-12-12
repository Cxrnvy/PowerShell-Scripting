#Danna Simaluisa
function Start-ProgressBar {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        $Title,
        
        [Parameter(Mandatory = $true)]
        [int]$Timer
    )
    
    for ($i = 1; $i -le $Timer; $i++) {
        Start-Sleep -Seconds 1
        $percentComplete = ($i / $Timer) * 100
        Write-Progress -Activity $Title -Status "$i seconds elapsed" -PercentComplete $percentComplete
    }
} 
Start-ProgressBar -Title "Test timeout" -Timer 30