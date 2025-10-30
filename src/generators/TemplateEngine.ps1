# TemplateEngine.ps1 - Template processing with variable substitution and conditionals

function Process-Template {
    param(
        [string]$TemplatePath,
        [hashtable]$Variables,
        [string]$OutputPath
    )

    Write-Host "Processing template: $TemplatePath" -ForegroundColor Cyan

    if (-not (Test-Path $TemplatePath)) {
        Write-Host "Template not found: $TemplatePath" -ForegroundColor Red
        return $false
    }

    $templateContent = Get-Content -Path $TemplatePath -Raw

    $processed = Apply-VariableSubstitution -Content $templateContent -Variables $Variables
    $processed = Process-Conditionals -Content $processed -Variables $Variables

    $outputDir = Split-Path $OutputPath -Parent
    if ($outputDir -and -not (Test-Path $outputDir)) {
        New-Item -Path $outputDir -ItemType Directory -Force | Out-Null
    }

    Set-Content -Path $OutputPath -Value $processed -Encoding UTF8
    Write-Host "Generated: $OutputPath" -ForegroundColor Green
    return $true
}

function Apply-VariableSubstitution {
    param(
        [string]$Content,
        [hashtable]$Variables
    )

    $result = $Content
    foreach ($key in $Variables.Keys) {
        $pattern = "{{$key}}"
        $value = $Variables[$key]
        if ($null -eq $value) { $value = "" }
        $result = $result.Replace($pattern, [string]$value)
    }
    return $result
}

function Process-Conditionals {
    param(
        [string]$Content,
        [hashtable]$Variables
    )

    $result = $Content

    # {{#if NAME}}...{{/if}}
    $ifPattern = '{{#if\s+(\w+)}}(.*?){{/if}}'
    $matches = [regex]::Matches($result, $ifPattern, [System.Text.RegularExpressions.RegexOptions]::Singleline)
    foreach ($m in $matches) {
        $cond = $m.Groups[1].Value
        $block = $m.Groups[2].Value
        $full = $m.Value
        if ($Variables.ContainsKey($cond) -and $Variables[$cond]) {
            $result = $result.Replace($full, $block)
        } else {
            $result = $result.Replace($full, "")
        }
    }

    # {{#unless NAME}}...{{/unless}}
    $unlessPattern = '{{#unless\s+(\w+)}}(.*?){{/unless}}'
    $matches = [regex]::Matches($result, $unlessPattern, [System.Text.RegularExpressions.RegexOptions]::Singleline)
    foreach ($m in $matches) {
        $cond = $m.Groups[1].Value
        $block = $m.Groups[2].Value
        $full = $m.Value
        if (-not ($Variables.ContainsKey($cond) -and $Variables[$cond])) {
            $result = $result.Replace($full, $block)
        } else {
            $result = $result.Replace($full, "")
        }
    }

    return $result
}

function Get-TemplateVariables {
    param([hashtable]$Analysis)

    $vars = @{
        PROJECT_NAME   = $Analysis.ProjectName
        TECH_STACK     = $Analysis.TechStack
        FRAMEWORK      = $Analysis.Framework
        LANGUAGE       = $Analysis.Language
        BUILD_TOOL     = $Analysis.BuildTool
        TESTING        = $Analysis.Testing
        DATABASE       = $Analysis.Database
        DEPLOYMENT     = $Analysis.Deployment
        PORT           = $Analysis.Port
        DEV_COMMAND    = $Analysis.DevCommand
        BUILD_COMMAND  = $Analysis.BuildCommand
        TEST_COMMAND   = $Analysis.TestCommand
        PACKAGE_MANAGER= $Analysis.PackageManager
        PROJECT_TYPE   = $Analysis.ProjectType
    }

    $vars.HAS_DATABASE  = [bool]($Analysis.Database)
    $vars.HAS_DEPLOYMENT= [bool]($Analysis.Deployment)
    $vars.HAS_TESTING   = [bool]($Analysis.Testing)
    $vars.IS_NODE       = ($Analysis.TechStack -match 'Node|React|Vue|Angular')
    $vars.IS_PYTHON     = ($Analysis.Language -eq 'Python')
    $vars.IS_GO         = ($Analysis.Language -eq 'Go')

    return $vars
}

# Export-ModuleMember intentionally omitted (dot-sourced)
