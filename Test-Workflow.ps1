# Test-Workflow.ps1
Write-Host "Testing workflow generator..." -ForegroundColor Cyan

$scriptDir = $PSScriptRoot
. "$scriptDir/src/analyzers/ProjectAnalyzer.ps1"

$analysis = Analyze-Project -Path "examples/react-project"

Write-Host "Project: $($analysis.ProjectName)" -ForegroundColor Green
Write-Host "Tech Stack: $($analysis.TechStack)" -ForegroundColor Green
Write-Host "Language: $($analysis.Language)" -ForegroundColor Green
