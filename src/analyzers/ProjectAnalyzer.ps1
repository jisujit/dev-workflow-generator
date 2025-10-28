# ProjectAnalyzer.ps1 - Simple Working Version
function Analyze-Project {
    param([string]$Path = ".")
    
    $analysis = @{
        ProjectName = "Unknown"
        TechStack = "Unknown"
        Framework = "Unknown"
        Language = "Unknown"
        Port = ""
        DevCommand = ""
    }
    
    Write-Host "Analyzing project at: $Path" -ForegroundColor Cyan
    
    if (Test-Path "$Path/package.json") {
        $analysis.TechStack = "Node.js"
        $analysis.Language = "JavaScript"
        $analysis.DevCommand = "npm run dev"
    }
    elseif (Test-Path "$Path/requirements.txt") {
        $analysis.TechStack = "Python"
        $analysis.Language = "Python"
        $analysis.DevCommand = "python main.py"
    }
    elseif (Test-Path "$Path/go.mod") {
        $analysis.TechStack = "Go"
        $analysis.Language = "Go"
        $analysis.DevCommand = "go run main.go"
    }
    
    Write-Host "Analysis complete: $($analysis.TechStack)" -ForegroundColor Green
    return $analysis
}

# Export-ModuleMember -Function Analyze-Project
