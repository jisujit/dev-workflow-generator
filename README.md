# Dev Workflow Generator

🚀 **Automated Development Workflow Setup for Any Project**

A PowerShell-based tool that analyzes any repository, detects the project type, and automatically generates a complete development workflow system tailored to that project's tech stack.

## Features

✨ **Intelligent Project Detection**
- Automatically detects: Node.js, React, Vue, Angular, Python, Go, C#, Java, Rust
- Identifies frameworks, build tools, testing frameworks
- Detects databases and deployment configurations

📝 **Auto-Generated Documentation**
- **DEV_STARTUP_CHEATSHEET.md** - Quick reference guide
- **DEVELOPMENT_WORKFLOW_README.md** - Complete workflow documentation
- **IDE_CONTEXT_SUMMARY.md** - Context for AI-assisted development

🔧 **Development Scripts**
- **startup-dev-session.ps1** - Initialize your development environment
- **session-closeout.ps1** - Clean session transitions
- **project-status.ps1** - Project health check

## Quick Start

### Installation

```powershell
# Clone the repository
git clone https://github.com/yourusername/dev-workflow-generator.git
cd dev-workflow-generator
```

### Usage

Generate a workflow for any project:

```powershell
# Run from the dev-workflow-generator directory
.\Setup-DevWorkflow.ps1 -ProjectPath path/to/your/project
```

Or from any directory:

```powershell
path/to/dev-workflow-generator/Setup-DevWorkflow.ps1 -ProjectPath .
```

### Options

```powershell
-ProjectPath   # Path to the project (default: current directory)
-Force         # Regenerate workflow even if it exists
-SkipScripts   # Skip script generation
-SkipDocs      # Skip documentation generation
```

## Supported Tech Stacks

### Web Development
- ✅ React (Vite, Next.js, Create React App)
- ✅ Vue.js (Vite, Nuxt.js)
- ✅ Angular
- ✅ Node.js (Express, Fastify)

### Backend
- ✅ Python (FastAPI, Flask, Django)
- ✅ Go
- ✅ .NET (C#)
- ✅ Java (Maven, Gradle)
- ✅ Rust

### Databases
- PostgreSQL
- MySQL
- MongoDB
- Redis

### Deployment
- Docker
- Vercel
- Netlify
- GitHub Actions

## Example Workflows

### React Project

```powershell
.\Setup-DevWorkflow.ps1 -ProjectPath path/to/react-app
```

This generates:
- Development scripts optimized for React
- Vite/Next.js specific commands
- TypeScript detection
- Jest/Vitest testing setup

### Python Project

```powershell
.\Setup-DevWorkflow.ps1 -ProjectPath path/to/python-api
```

This generates:
- Virtual environment setup
- FastAPI/Flask/Django specific workflows
- pytest integration
- Requirements management

## Generated Structure

After running the tool, your project will have:

```
your-project/
├── .dev-workflow/
│   ├── startup-dev-session.ps1    # Session initialization
│   ├── session-closeout.ps1       # Session cleanup
│   └── project-status.ps1         # Status checker
├── DEV_STARTUP_CHEATSHEET.md      # Quick reference
├── DEVELOPMENT_WORKFLOW_README.md  # Full documentation
└── IDE_CONTEXT_SUMMARY.md         # AI assistant context
```

## How It Works

1. **Analysis**: Scans your project structure and configuration files
2. **Detection**: Identifies tech stack, frameworks, and tools
3. **Generation**: Creates tailored scripts and documentation
4. **Optimization**: Customizes workflow for your specific setup

## Use Cases

### For Individual Developers
- Quick setup for new projects
- Consistent workflow across projects
- AI-assisted development with context

### For Teams
- Standardize onboarding process
- Document project conventions
- Share development best practices

### For AI-Assisted Development
- Provides complete project context
- Optimized for GitHub Copilot, Cursor AI
- Maintains context across sessions

## Architecture

```
dev-workflow-generator/
├── src/
│   ├── analyzers/
│   │   └── ProjectAnalyzer.ps1      # Project detection
│   ├── generators/
│   │   ├── TemplateEngine.ps1       # Template processing
│   │   ├── ScriptGenerator.ps1       # Script generation
│   │   └── DocGenerator.ps1         # Documentation generation
│   ├── config/
│   │   └── tech-stacks.json         # Tech stack definitions
│   └── templates/
│       ├── scripts/                  # Script templates
│       └── docs/                     # Doc templates
├── examples/                         # Example projects
├── tests/                           # Test projects
└── Setup-DevWorkflow.ps1            # Main entry point
```

## Configuration

Customize tech stack detection in `src/config/tech-stacks.json`:

```json
{
  "react": {
    "name": "React",
    "detection": ["package.json", "react"],
    "defaultPort": 5173,
    "scripts": {
      "dev": "npm run dev",
      "build": "npm run build"
    }
  }
}
```

## Roadmap

### Phase 1 (Current)
- ✅ Core analyzer
- ✅ Template engine
- ✅ Script generation
- ✅ Documentation generation
- ✅ Support for 5+ tech stacks

### Phase 2 (Planned)
- Enhanced database integration
- CI/CD workflow generation
- Docker configuration generation
- Team collaboration features

### Phase 3 (Future)
- Jupyter notebook support
- Databricks integration
- ML framework detection
- Custom plugin system

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

MIT License - see LICENSE file for details

## Credits

Created by [Your Name]

Inspired by the need for consistent development workflows across diverse tech stacks.

---

**Made with ❤️ for developers who love automation**