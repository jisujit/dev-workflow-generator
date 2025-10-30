# DocGenerator.ps1 - Generates development workflow documentation

. (Join-Path $PSScriptRoot "TemplateEngine.ps1")

function Generate-Documentation {
    param(
        [hashtable]$Analysis,
        [string]$OutputPath = "."
    )
    
    Write-Host "`n📄 Generating documentation..." -ForegroundColor Cyan
    
    # Generate DEV_STARTUP_CHEATSHEET.md
    $cheatsheetPath = Join-Path $OutputPath "DEV_STARTUP_CHEATSHEET.md"
    Generate-CheatSheet -Analysis $Analysis -OutputPath $cheatsheetPath
    
    # Generate DEVELOPMENT_WORKFLOW_README.md
    $workflowPath = Join-Path $OutputPath "DEVELOPMENT_WORKFLOW_README.md"
    Generate-WorkflowReadme -Analysis $Analysis -OutputPath $workflowPath
    
    # Generate IDE_CONTEXT_SUMMARY.md
    $contextPath = Join-Path $OutputPath "IDE_CONTEXT_SUMMARY.md"
    Generate-IDEContext -Analysis $Analysis -OutputPath $contextPath
    
    Write-Host "✅ Documentation generated" -ForegroundColor Green
}

function Generate-CheatSheet {
    param(
        [hashtable]$Analysis,
        [string]$OutputPath
    )
    
    $content = @"
# Development Startup Cheatsheet

**Project:** $($Analysis.ProjectName)  
**Tech Stack:** $($Analysis.TechStack) ($($Analysis.Language))  
**Generated:** $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')

---

## Quick Start

"@

    if ($Analysis.TechStack -match "Node|React|Vue|Angular") {
        $content += @"
### Setup
``````powershell
# Install dependencies
$($Analysis.PackageManager) install

# Start development server
$($Analysis.DevCommand)
``````

### Development Server
- **URL:** http://localhost:$($Analysis.Port)
- **Build Tool:** $($Analysis.BuildTool)
- **Package Manager:** $($Analysis.PackageManager)

### Common Commands
``````powershell
# Development
$($Analysis.DevCommand)

# Build for production
$($Analysis.BuildCommand)

# Run tests
$($Analysis.TestCommand)

# Install a package
$($Analysis.PackageManager) $(if ($Analysis.PackageManager -eq 'npm') {'install'} else {'add'}) <package-name>
``````

"@
    }
    elseif ($Analysis.Language -eq "Python") {
        $content += @"
### Setup
``````powershell
# Create virtual environment
python -m venv venv

# Activate virtual environment
.\venv\Scripts\Activate.ps1

# Install dependencies
pip install -r requirements.txt

# Start development server
$($Analysis.DevCommand)
``````

### Development Server
- **URL:** http://localhost:$($Analysis.Port)
- **Framework:** $($Analysis.Framework)

### Common Commands
``````powershell
# Development
$($Analysis.DevCommand)

# Run tests
$($Analysis.TestCommand)

# Install a package
pip install <package-name>

# Freeze dependencies
pip freeze > requirements.txt
``````

"@
    }
    elseif ($Analysis.Language -eq "Go") {
        $content += @"
### Setup
``````powershell
# Download dependencies
go mod download

# Start development server
$($Analysis.DevCommand)
``````

### Development Server
- **URL:** http://localhost:$($Analysis.Port)

### Common Commands
``````powershell
# Development
$($Analysis.DevCommand)

# Build
$($Analysis.BuildCommand)

# Run tests
$($Analysis.TestCommand)

# Add a dependency
go get <package-name>

# Tidy dependencies
go mod tidy
``````

"@
    }

    if ($Analysis.Database) {
        $content += @"
## Database

**Type:** $($Analysis.Database)

"@
        if ($Analysis.Database -eq "PostgreSQL") {
            $content += @"
``````powershell
# Connect to database
psql -U <username> -d <database>
``````

"@
        }
    }

    if ($Analysis.Deployment) {
        $content += @"
## Deployment

**Platform:** $($Analysis.Deployment)

"@
    }

    $content += @"
## Environment Variables

"@
    if ($Analysis.EnvFiles -and $Analysis.EnvFiles.Count -gt 0) {
        $content += @"
Environment files detected:
"@
        foreach ($envFile in $Analysis.EnvFiles) {
            $content += @"
- ``$envFile``
"@
        }
    }
    else {
        $content += @"
No environment files detected. Create a ``.env`` file if needed.
"@
    }

    $content += @"

## Git Workflow

``````powershell
# Check status
git status

# Stage changes
git add .

# Commit changes
git commit -m "Your message"

# Push changes
git push
``````

## Useful Scripts

Run these scripts from the project root:

- **Start Session:** ``.\.dev-workflow\startup-dev-session.ps1``
- **Close Session:** ``.\.dev-workflow\session-closeout.ps1``
- **Project Status:** ``.\.dev-workflow\project-status.ps1``

---

**💡 Tip:** Keep this cheatsheet open in your editor for quick reference!
"@

    Set-Content -Path $OutputPath -Value $content -Encoding UTF8
    Write-Host "✅ Generated: $OutputPath" -ForegroundColor Green
}

function Generate-WorkflowReadme {
    param(
        [hashtable]$Analysis,
        [string]$OutputPath
    )
    
    $content = @"
# Development Workflow Documentation

## Project Overview

- **Name:** $($Analysis.ProjectName)
- **Type:** $($Analysis.TechStack)
- **Language:** $($Analysis.Language)
- **Framework:** $($Analysis.Framework)
- **Build Tool:** $($Analysis.BuildTool)

## Development Workflow

This project uses an automated development workflow system to streamline your development experience.

### Getting Started

1. **Initial Setup**
   
   Run the startup script to initialize your development environment:
   ``````powershell
   .\.dev-workflow\startup-dev-session.ps1
   ``````

2. **Development**
   
   Start coding! The development server will be available at http://localhost:$($Analysis.Port)

3. **Testing**
   
   Run tests with:
   ``````powershell
   $($Analysis.TestCommand)
   ``````

4. **Session Closeout**
   
   When you're done, run the closeout script:
   ``````powershell
   .\.dev-workflow\session-closeout.ps1
   ``````

### Workflow Scripts

#### startup-dev-session.ps1
- Checks project dependencies
- Sets up environment
- Provides development server commands
- Displays project information

#### session-closeout.ps1
- Stops running development servers
- Shows git status
- Updates context documentation with latest project state
- Reminds you to commit changes
- Generates session summary

#### project-status.ps1
- Displays project information
- Shows git status
- Lists dependencies
- Checks environment configuration

## Project Structure

"@

    if ($Analysis.TechStack -match "Node|React|Vue|Angular") {
        $content += @"
``````
project/
├── src/                 # Source code
├── public/              # Public assets
├── node_modules/        # Dependencies
├── package.json         # Project configuration
├── .env                 # Environment variables
└── .dev-workflow/       # Development scripts
``````

"@
    }
    elseif ($Analysis.Language -eq "Python") {
        $content += @"
``````
project/
├── src/                 # Source code
├── venv/                # Virtual environment
├── requirements.txt     # Dependencies
├── .env                 # Environment variables
└── .dev-workflow/       # Development scripts
``````

"@
    }
    elseif ($Analysis.Language -eq "Go") {
        $content += @"
``````
project/
├── main.go              # Main application
├── go.mod               # Module definition
├── go.sum               # Dependencies
└── .dev-workflow/       # Development scripts
``````

"@
    }

    $content += @"

## Common Tasks

### Installing Dependencies

"@

    if ($Analysis.TechStack -match "Node|React|Vue|Angular") {
        $content += @"
``````powershell
$($Analysis.PackageManager) $(if ($Analysis.PackageManager -eq 'npm') {'install'} else {'add'}) <package-name>
``````

"@
    }
    elseif ($Analysis.Language -eq "Python") {
        $content += @"
``````powershell
pip install <package-name>
pip freeze > requirements.txt
``````

"@
    }
    elseif ($Analysis.Language -eq "Go") {
        $content += @"
``````powershell
go get <package-name>
go mod tidy
``````

"@
    }

    $content += @"
### Running Tests

``````powershell
$($Analysis.TestCommand)
``````

### Building for Production

``````powershell
$($Analysis.BuildCommand)
``````

## IDE Integration

This workflow is optimized for use with modern IDEs and AI-assisted development tools:

- **VS Code:** Use the integrated terminal to run workflow scripts
- **GitHub Copilot:** Context is automatically available through generated documentation
- **Cursor AI:** The IDE_CONTEXT_SUMMARY.md provides complete project context

## Best Practices

1. **Always start with the startup script** to ensure environment is configured
2. **Run tests before committing** to catch issues early
3. **Use the closeout script** to update context and ensure clean session transitions
4. **Keep environment files updated** with new configuration variables
5. **Commit frequently** with descriptive messages

## Troubleshooting

### Development Server Won't Start

"@

    if ($Analysis.TechStack -match "Node|React|Vue|Angular") {
        $content += @"
1. Ensure dependencies are installed: ``$($Analysis.PackageManager) install``
2. Check if port $($Analysis.Port) is already in use
3. Clear node_modules and reinstall

"@
    }
    elseif ($Analysis.Language -eq "Python") {
        $content += @"
1. Ensure virtual environment is activated
2. Reinstall dependencies: ``pip install -r requirements.txt``
3. Check if port $($Analysis.Port) is already in use

"@
    }

    $content += @"
### Tests Failing

1. Ensure all dependencies are up to date
2. Check environment variables are set correctly
3. Review test output for specific errors

## Additional Resources

- **Project-specific documentation:** Check the ``docs/`` directory
- **Framework documentation:** Refer to official $($Analysis.Framework) docs
- **Community support:** Search Stack Overflow or GitHub issues

---

**Generated by dev-workflow-generator**  
**Date:** $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
"@

    Set-Content -Path $OutputPath -Value $content -Encoding UTF8
    Write-Host "✅ Generated: $OutputPath" -ForegroundColor Green
}

function Generate-IDEContext {
    param(
        [hashtable]$Analysis,
        [string]$OutputPath
    )
    
    $content = @"
# IDE Context Summary

**Generated:** $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')

## Project Context

This document provides complete context for AI-assisted development tools.

### Project Information

- **Name:** $($Analysis.ProjectName)
- **Type:** $($Analysis.ProjectType)
- **Tech Stack:** $($Analysis.TechStack)
- **Language:** $($Analysis.Language)
- **Framework:** $($Analysis.Framework)
- **Build Tool:** $($Analysis.BuildTool)
$(if ($Analysis.Testing) {"- **Testing Framework:** $($Analysis.Testing)"})
$(if ($Analysis.Database) {"- **Database:** $($Analysis.Database)"})
$(if ($Analysis.Deployment) {"- **Deployment:** $($Analysis.Deployment)"})

### Development Commands

``````powershell
# Start development server
$($Analysis.DevCommand)

# Build for production
$($Analysis.BuildCommand)

# Run tests
$($Analysis.TestCommand)
``````

### Project Configuration

"@

    if ($Analysis.TechStack -match "Node|React|Vue|Angular") {
        $content += @"
- **Package Manager:** $($Analysis.PackageManager)
- **Development Port:** $($Analysis.Port)
- **Build Tool:** $($Analysis.BuildTool)

"@
    }

    $content += @"
### Environment

"@

    if ($Analysis.EnvFiles -and $Analysis.EnvFiles.Count -gt 0) {
        $content += @"
Environment files:
"@
        foreach ($envFile in $Analysis.EnvFiles) {
            $content += @"
- ``$envFile``
"@
        }
    }

    $content += @"

### Architecture Notes

"@

    if ($Analysis.TechStack -eq "React") {
        $content += @"
This is a React application. Key concepts:
- Component-based architecture
- State management through hooks
- Virtual DOM for efficient rendering
- $(if ($Analysis.BuildTool -eq 'Vite') {'Fast development with Vite HMR'} elseif ($Analysis.BuildTool -eq 'Next.js') {'Server-side rendering with Next.js'} else {'Standard React development'})

"@
    }
    elseif ($Analysis.Framework -eq "FastAPI") {
        $content += @"
This is a FastAPI application. Key concepts:
- Async request handling
- Automatic API documentation (Swagger/OpenAPI)
- Type hints and Pydantic models
- High performance Python web framework

"@
    }
    elseif ($Analysis.Language -eq "Go") {
        $content += @"
This is a Go application. Key concepts:
- Compiled, statically typed language
- Goroutines for concurrency
- Simple and efficient standard library
- Fast compilation and execution

"@
    }

    $content += @"
### Development Workflow

1. **Session Start:** Run ``.\.dev-workflow\startup-dev-session.ps1``
2. **Development:** Code with hot-reload enabled
3. **Testing:** Run ``$($Analysis.TestCommand)`` before committing
4. **Session End:** Run ``.\.dev-workflow\session-closeout.ps1``

### Quick Reference

**File Structure:**
- Source code is in the main project directory
- Development scripts are in ``.dev-workflow/``
- Documentation is in the project root

**Common Patterns:**
$(if ($Analysis.TechStack -match "Node|React|Vue|Angular") {
"- Import statements follow ES6 module syntax
- Use async/await for asynchronous operations
- Follow component-based architecture"
} elseif ($Analysis.Language -eq "Python") {
"- Follow PEP 8 style guidelines
- Use type hints for better IDE support
- Async functions with async/await"
} elseif ($Analysis.Language -eq "Go") {
"- Package-based organization
- Error handling with explicit returns
- Interface-based design"
})

---

**For AI Assistants:**  
This project uses $($Analysis.TechStack) with $($Analysis.Language). When providing code suggestions, follow the conventions and patterns typical for this stack. The development server runs on port $($Analysis.Port) and uses $($Analysis.DevCommand) for local development.

---

## Recent Session Context

*This section is automatically updated when you run `session-closeout.ps1` to maintain continuity between AI chat sessions.*

*No recent session data yet. Run `session-closeout.ps1` to capture your work context for the next session.*
"@

    Set-Content -Path $OutputPath -Value $content -Encoding UTF8
    Write-Host "✅ Generated: $OutputPath" -ForegroundColor Green
}

# Export-ModuleMember -Function Generate-Documentation, Generate-CheatSheet, Generate-WorkflowReadme, Generate-IDEContext
