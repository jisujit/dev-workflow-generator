# test-analyzer.ps1
Import-Module "./ProjectAnalyzer.ps1"

# Test from project root (two levels up)
$projectRoot = Join-Path $PSScriptRoot "../.."
$analysis = Analyze-Project -Path $projectRoot
Write-Host "Project Analysis:" -ForegroundColor Green
Write-Host "Tech Stack: $($analysis.TechStack)" -ForegroundColor White
Write-Host "Framework: $($analysis.Framework)" -ForegroundColor White
Write-Host "Project Name: $($analysis.ProjectName)" -ForegroundColor White
Write-Host "Language: $($analysis.Language)" -ForegroundColor White
Write-Host "Build Tool: $($analysis.BuildTool)" -ForegroundColor White
Write-Host "Testing: $($analysis.Testing)" -ForegroundColor White
Write-Host "Database: $($analysis.Database)" -ForegroundColor White
Write-Host "Deployment: $($analysis.Deployment)" -ForegroundColor White
Write-Host "Port: $($analysis.Port)" -ForegroundColor White
Write-Host "Dev Command: $($analysis.DevCommand)" -ForegroundColor White