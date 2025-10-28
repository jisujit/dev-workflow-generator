# Test-Full-Workflow.ps1
Write-Host "Testing full workflow generator..." -ForegroundColor Cyan

$scriptDir = $PSScriptRoot
. "$scriptDir/src/analyzers/ProjectAnalyzer.ps1"
. "$scriptDir/src/generators/TemplateEngine.ps1"
. "$scriptDir/src/generators/ScriptGenerator.ps1"
. "$scriptDir/src/generators/DocGenerator.ps1"

$projectPath = "examples/react-project"

Write-Host "Analyzing project..." -ForegroundColor Cyan
$analysis = Analyze-Project -Path $projectPath

Write-Host "Project: $($analysis.ProjectName)" -ForegroundColor Green
Write-Host "Tech Stack: $($analysis.TechStack)" -ForegroundColor Green

Write-Host ""
Write-Host "Generating scripts..." -ForegroundColor Cyan
Generate-DevelopmentScripts -Analysis $analysis -OutputPath "$projectPath/.dev-workflow"

Write-Host ""
Write-Host "Generating documentation..." -ForegroundColor Cyan
Generate-Documentation -Analysis $analysis -OutputPath $projectPath

Write-Host ""
Write-Host "Done!" -ForegroundColor Green
