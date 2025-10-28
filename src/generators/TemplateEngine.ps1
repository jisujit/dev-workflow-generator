# TemplateEngine.ps1 - Template processing with variable substitution and conditionals

function Process-Template {
    param(
        [string]$TemplatePath,
        [hashtable]$Variables,
        [string]$OutputPath
    )
    
    Write-Host "📝 Processing template: $TemplatePath" -ForegroundColor Cyan
    
    if (-not (Test-Path $TemplatePath)) {
        Write-Host "❌ Template not found: $TemplatePath" -ForegroundColor Red
        return $false
    }
    
    # Read template content
    $templateContent = Get-Content $TemplatePath -Raw
    
    # Process template with variable substitution
    $processedContent = Apply-VariableSubstitution -Content $templateContent -Variables $Variables
    
    # Process conditional blocks
    $processedContent = Process-Conditionals -Content $processedContent -Variables $Variables
    
    # Write output
    $outputDir = Split-Path $OutputPath -Parent
    if ($outputDir -and -not (Test-Path $outputDir)) {
        New-Item -Path $outputDir -ItemType Directory -Force | Out-Null
    }
    
    Set-Content -Path $OutputPath -Value $processedContent -Encoding UTF8
    Write-Host "✅ Generated: $OutputPath" -ForegroundColor Green
    
    return $true
}

function Apply-VariableSubstitution {
    param(
        [string]$Content,
        [hashtable]$Variables
    )
    
    $result = $Content
    
    # Replace all {{VARIABLE_NAME}} patterns
    foreach ($key in $Variables.Keys) {
        $pattern = "{{$key}}"
        $value = $Variables[$key]
        if ($null -eq $value) {
            $value = ""
        }
        $result = $result.Replace($pattern, $value)
    }
    
    return $result
}

function Process-Conditionals {
    param(
        [string]$Content,
        [hashtable]$Variables
    )
    
    $result = $Content
    
    # Process {{#if CONDITION}} ... {{/if}} blocks
    $ifPattern = '{{#if\s+(\w+)}}(.*?){{/if}}'
    $matches = [regex]::Matches($result, $ifPattern, [System.Text.RegularExpressions.RegexOptions]::Singleline)
    
    foreach ($match in $matches) {
        $condition = $match.Groups[1].Value
        $block = $match.Groups[2].Value
        $fullMatch = $match.Groups[0].Value
        
        # Check if condition is true (variable exists and is not empty)
        if ($Variables.ContainsKey($condition) -and $Variables[$condition]) {
            # Keep the block content
            $result = $result.Replace($fullMatch, $block)
        }
        else {
            # Remove the entire block
            $result = $result.Replace($fullMatch, "")
        }
    }
    
    # Process {{#unless CONDITION}} ... {{/unless}} blocks
    $unlessPattern = '{{#unless\s+(\w+)}}(.*?){{/unless}}'
    $matches = [regex]::Matches($result, $unlessPattern, [System.Text.RegularExpressions.RegexOptions]::Singleline)
    
    foreach ($match in $matches) {
        $condition = $match.Groups[1].Value
        $block = $match.Groups[2].Value
        $fullMatch = $match.Groups[0].Value
        
        # Check if condition is false (variable doesn't exist or is empty)
        if (-not ($Variables.ContainsKey($condition) -and $Variables[$condition])) {
            # Keep the block content
            $result = $result.Replace($fullMatch, $block)
        }
        else {
            # Remove the entire block
            $result = $result.Replace($fullMatch, "")
        }
    }
    
    return $result
}

function Get-TemplateVariables {
    param([hashtable]$Analysis)
    
    # Convert analysis hashtable to template variables
    $variables = @{
        PROJECT_NAME = $Analysis.ProjectName
        TECH_STACK = $Analysis.TechStack
        FRAMEWORK = $Analysis.Framework
        LANGUAGE = $Analysis.Language
        BUILD_TOOL = $Analysis.BuildTool
        TESTING = $Analysis.Testing
        DATABASE = $Analysis.Database
        DEPLOYMENT = $Analysis.Deployment
        PORT = $Analysis.Port
        DEV_COMMAND = $Analysis.DevCommand
        BUILD_COMMAND = $Analysis.BuildCommand
        TEST_COMMAND = $Analysis.TestCommand
        PACKAGE_MANAGER = $Analysis.PackageManager
        PROJECT_TYPE = $Analysis.ProjectType
    }
    
    # Add conditional flags
    $variables.HAS_DATABASE = if ($Analysis.Database) { $true } else { $false }
    $variables.HAS_DEPLOYMENT = if ($Analysis.Deployment) { $true } else { $false }
    $variables.HAS_TESTING = if ($Analysis.Testing) { $true } else { $false }
    $variables.IS_NODE = if ($Analysis.TechStack -match "Node|React|Vue|Angular") { $true } else { $false }
    $variables.IS_PYTHON = if ($Analysis.Language -eq "Python") { $true } else { $false }
    $variables.IS_GO = if ($Analysis.Language -eq "Go") { $true } else { $false }
    
    return $variables
}

# Export-ModuleMember -Function Process-Template, Apply-VariableSubstitution, Process-Conditionals, Get-TemplateVariables
