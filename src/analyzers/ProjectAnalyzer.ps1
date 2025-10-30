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

        try {
            $pkg = Get-Content -Raw -Path (Join-Path $Path 'package.json') | ConvertFrom-Json
            if ($pkg.name) { $analysis.ProjectName = [string]$pkg.name }

            $depNames = @()
            if ($pkg.dependencies) { $depNames += @($pkg.dependencies.PSObject.Properties.Name) }
            if ($pkg.devDependencies) { $depNames += @($pkg.devDependencies.PSObject.Properties.Name) }

            $hasReact = ($depNames -contains 'react') -or ($depNames -contains '@vitejs/plugin-react')
            $hasVite = ($depNames -contains 'vite') -or ($pkg.scripts -and $pkg.scripts.dev -match 'vite')

            if ($hasReact -and $hasVite) { $analysis.Framework = 'React + Vite'; $analysis.Port = '5173' }
            elseif ($hasReact) { $analysis.Framework = 'React' }
            elseif ($hasVite) { $analysis.Framework = 'Vite'; $analysis.Port = '5173' }
        } catch {
            # ignore parse errors; keep simple defaults
        }
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
