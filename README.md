# Dev Workflow Generator

🚀 **Solving Context Loss in AI-Assisted Development**

**The Problem:** When coding with AI assistants (agentic or non-agentic), every new chat session loses context. You repeatedly explain your tech stack, project setup, and workflow—breaking your flow state and reducing productivity.

**The Solution:** Dev Workflow Generator creates **persistent development context** that bridges every coding session. Run it once per project, and every AI conversation—whether with ChatGPT, GitHub Copilot, Cursor AI, or any assistant—immediately understands your environment.

**“One-time setup. Two quick scripts per session. Seamless continuity.”**

Looking for the step-by-step? See the full [User Guide](USER_GUIDE.md).

## Features

### 🔄 **Session Continuity & Context Management**

**For AI-Assisted Developers:**
- ✅ **IDE_CONTEXT_SUMMARY.md** - Complete project context for every new AI chat
- ✅ **Persistent documentation** that bridges agentic and non-agentic sessions
- ✅ **Zero repeated explanations** - AI assistants understand your environment immediately
- ✅ **Maintains flow state** by eliminating context setup friction

**For Smooth Development Workflow:**
- ✅ **startup-dev-session.ps1** - Quick session initialization
- ✅ **session-closeout.ps1** - Updates context and clean session transitions
- ✅ **project-status.ps1** - Instant project health checks
- ✅ **DEV_STARTUP_CHEATSHEET.md** - Always-available command reference

### 🤖 **Intelligent Automation**

- **Auto-detects** 8+ tech stacks (React, Vue, Angular, Python, Go, C#, Java, Rust)
- **Identifies** frameworks, build tools, testing frameworks automatically
- **Customizes** commands, ports, and workflows for your exact setup
- **Detects** databases, deployment configs, and environment files

## System Requirements

**Operating Systems:**
- ✅ **Windows** (PowerShell 5.1+ or PowerShell Core 6+)
- ✅ **macOS** (PowerShell Core 6+)
- ✅ **Linux** (PowerShell Core 6+)

**PowerShell:**
- Windows PowerShell 5.1+ (Windows only)
- PowerShell Core 6+ (Cross-platform)

**Prerequisite:**
- Clone this repo locally: `git clone https://github.com/jisujit/dev-workflow-generator.git`

**Note:** Execution policy issues are automatically handled - no admin rights or manual configuration needed! The scripts adjust policy only for the current session (safe and automatic).

## Quick Start

### Installation

```powershell
# Clone the repository
git clone https://github.com/jisujit/dev-workflow-generator.git
cd dev-workflow-generator
```

### Install PowerShell Core (macOS/Linux)

**macOS:**
```bash
brew install powershell
```

**Linux (Ubuntu/Debian):**
```bash
# Download and install PowerShell Core
wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt-get update
sudo apt-get install -y powershell
```

### Usage

Generate a workflow for any project:

**Windows:**
```powershell
# Run from the dev-workflow-generator directory (where you cloned https://github.com/jisujit/dev-workflow-generator.git)
.\Setup-DevWorkflow.ps1 -ProjectPath path/to/your/project
```

**macOS/Linux:**
```bash
# Run with PowerShell Core
pwsh ./Setup-DevWorkflow.ps1 -ProjectPath path/to/your/project
```

**Cross-platform:**
```powershell
# From any directory
path/to/dev-workflow-generator/Setup-DevWorkflow.ps1 -ProjectPath .
```

#### Auto-open IDE context (enabled by default)
The startup script automatically opens `IDE_CONTEXT_SUMMARY.md` when a session begins, so you can easily reference it in your AI chat.

This is **enabled by default** - no setup needed! If you want to disable it:
```powershell
$env:DEVWF_OPEN_CONTEXT = '0'
.\.dev-workflow\startup-dev-session.ps1
```

### Options

```powershell
-ProjectPath   # Path to the project (default: current directory)
-Force         # Regenerate workflow even if it exists
-SkipScripts   # Skip script generation
-SkipDocs      # Skip documentation generation
```

## Why This Matters

### The AI Coding Context Problem

Every developer using AI assistants experiences this cycle:

1. **Start new chat** → Explain project context
2. **Get help** → Code with AI assistant
3. **End chat** → Context is lost
4. **Start new chat** → Explain everything again
5. **Repeat** → Momentum lost, productivity drops

### How Dev Workflow Generator Solves It

**Traditional Workflow:**
```
Chat 1: "I'm working on a React app with Vite, TypeScript, and Vitest..."
Chat 2: "I'm working on a React app with Vite, TypeScript, and Vitest..."
Chat 3: "I'm working on a React app with Vite, TypeScript, and Vitest..."
```

**With Dev Workflow Generator:**
```
Setup once: Run .\Setup-DevWorkflow.ps1
Chat 1: AI reads IDE_CONTEXT_SUMMARY.md → Immediate understanding
Chat 2: AI reads IDE_CONTEXT_SUMMARY.md → Immediate understanding  
Chat 3: AI reads IDE_CONTEXT_SUMMARY.md → Immediate understanding
```

### Smooth Workflow Management

The tool sets up a **simple, efficient process** for managing your development workflow:

- ✅ **Start sessions instantly** - No setup friction
- ✅ **Maintain context** - Documentation bridges all sessions
- ✅ **Quick references** - Cheatsheet always available
- ✅ **Clean transitions** - Session closeout updates context for next session
- ✅ **Status checks** - Instant project health visibility

**Result:** You stay in flow state, AI assistants stay in context, and your development workflow runs smoothly without interruption.

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

### For AI-Assisted Developers (Primary Use Case)
- **Eliminate context loss** between AI chat sessions (agentic and non-agentic)
- **Bridge conversations** with persistent project context
- **Maintain flow state** - no interruptions to re-explain your setup
- **Optimized for:** ChatGPT, GitHub Copilot, Cursor AI, Claude, and any AI assistant
- **Works with:** Both agentic (autonomous) and non-agentic (chat-based) AI coding

### For Individual Developers
- **Smooth workflow management** - simple, efficient development process
- **Quick project setup** - instant workflow configuration
- **Consistent practices** across all your projects
- **Always-ready reference** - cheatsheet for instant commands

### For Teams
- **Standardize onboarding** - new developers get complete project context
- **Share workflows** - consistent development practices
- **Document conventions** - project-specific guidelines
- **Reduce context switch** - team members stay aligned

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

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Credits

Created by Sujit Gangadharan

Inspired by the need for consistent development workflows across diverse tech stacks.

---

**Made with ❤️ for developers who love automation**