# Generic Development Workflow Generator - Implementation Plan

## 🎯 Project Vision

A PowerShell-based tool that analyzes any repository, detects the project type, and automatically generates a complete development workflow system tailored to that project's tech stack.

## 📋 Core Objectives

1. **Analyze Repository**: Read codebase, identify project type and tech stack
2. **Generate Workflow**: Create development workflow scripts and documentation
3. **IDE/AI Ready**: Provide complete context for agentic development environments
4. **Multi-Language Support**: Support common languages and frameworks
5. **Data/ML Support**: Extend to data science and ML platforms (optional)

---

## 🚀 MVP Scope (Phase 1)

### **Supported Tech Stacks:**

#### **Web Development:**
- ✅ React (with Vite, Create React App, Next.js)
- ✅ Vue.js (with Vite, Nuxt.js)
- ✅ Angular
- ✅ Node.js (Express, Fastify, etc.)
- ✅ TypeScript projects

#### **Backend:**
- ✅ Python (FastAPI, Flask, Django)
- ✅ Go (Go modules, standard projects)
- ✅ .NET (C# projects)
- ✅ Java (Maven, Gradle)

#### **Data Science / ML (Phase 2):**
- 🔄 Python with Jupyter notebooks
- 🔄 R projects
- 🔄 Databricks notebooks and projects
- 🔄 ML frameworks (scikit-learn, TensorFlow, PyTorch)

---

## 🏗️ Architecture Overview

### **1. Project Analyzer**
Detects project type by analyzing:
- `package.json` (Node.js, React, Vue, Angular)
- `requirements.txt` / `pyproject.toml` (Python)
- `go.mod` (Go)
- `Cargo.toml` (Rust)
- `*.csproj` (C#)
- `pom.xml` / `build.gradle` (Java)
- Project structure patterns

### **2. Tech Stack Detection**
Identifies:
- **Language**: JavaScript, TypeScript, Python, Go, C#, Java, Rust
- **Framework**: React, Vue, Angular, Express, FastAPI, Flask, Django
- **Build Tool**: Vite, Webpack, npm, yarn, pip, go
- **Testing**: Jest, Vitest, pytest, go test
- **Database**: Supabase, PostgreSQL, MongoDB, MySQL
- **Deployment**: Docker, Vercel, Netlify, AWS, Azure

### **3. Template Engine**
- Variable substitution (`{{PROJECT_NAME}}`, `{{TECH_STACK}}`)
- Conditional sections (if Python, include Python-specific commands)
- Template inheritance (base templates + tech-specific)
- Multi-file generation

### **4. Workflow Generator**
Generates:
- `startup-dev-session.ps1` - Tailored to project type
- `session-closeout.ps1` - With project-specific context
- `project-status.ps1` - Customized commands
- `DEV_STARTUP_CHEATSHEET.md` - Project-specific guide
- `DEVELOPMENT_WORKFLOW_README.md` - Complete documentation
- `IDE_CONTEXT_SUMMARY.md` - Auto-generated context

---

## 📁 Project Structure

```
dev-workflow-generator/
├── src/
│   ├── analyzers/
│   │   ├── ProjectAnalyzer.ps1        # Main analyzer
│   │   ├── NodeAnalyzer.ps1           # Node.js detection
│   │   ├── PythonAnalyzer.ps1         # Python detection
│   │   ├── GoAnalyzer.ps1             # Go detection
│   │   ├── DotNetAnalyzer.ps1         # .NET detection
│   │   └── JavaAnalyzer.ps1           # Java detection
│   ├── generators/
│   │   ├── ScriptGenerator.ps1         # Generate scripts
│   │   ├── DocGenerator.ps1            # Generate docs
│   │   └── TemplateEngine.ps1         # Template processor
│   ├── templates/
│   │   ├── scripts/
│   │   │   ├── startup-dev-session.ps1.template
│   │   │   ├── session-closeout.ps1.template
│   │   │   └── project-status.ps1.template
│   │   └── docs/
│   │       ├── DEV_STARTUP_CHEATSHEET.md.template
│   │       └── DEVELOPMENT_WORKFLOW_README.md.template
│   └── config/
│       ├── tech-stacks.json            # Tech stack definitions
│       └── detection-rules.json        # Detection patterns
├── tests/
│   ├── test-react-app/
│   ├── test-python-api/
│   ├── test-go-service/
│   └── test-databricks/                # For Phase 2
├── examples/
│   ├── react-project/
│   ├── python-api/
│   └── go-service/
├── Setup-DevWorkflow.ps1                # Main entry point
├── README.md
└── LICENSE
```

---

## 🔍 Detection Logic

### **Node.js Projects:**
```powershell
# Detect package.json
if (Test-Path "package.json") {
    $packageJson = Get-Content "package.json" | ConvertFrom-Json
    
    # Check for React
    if ($packageJson.dependencies.react -or $packageJson.devDependencies.react) {
        $techStack = "React"
        # Check for Vite, Next.js, CRA
    }
    
    # Check for Vue
    if ($packageJson.dependencies.vue) {
        $techStack = "Vue.js"
    }
    
    # Check for Angular
    if ($packageJson.dependencies."@angular/core") {
        $techStack = "Angular"
    }
    
    # Pure Node.js
    if (-not $techStack) {
        $techStack = "Node.js"
    }
}
```

### **Python Projects:**
```powershell
# Detect requirements.txt or pyproject.toml
if (Test-Path "requirements.txt") {
    $requirements = Get-Content "requirements.txt"
    
    # Check for FastAPI
    if ($requirements -match "fastapi") {
        $framework = "FastAPI"
    }
    
    # Check for Flask
    if ($requirements -match "flask") {
        $framework = "Flask"
    }
    
    # Check for Django
    if ($requirements -match "django") {
        $framework = "Django"
    }
    
    # Check for Jupyter (data science)
    if ($requirements -match "jupyter|notebook") {
        $projectType = "DataScience"
    }
}
```

### **Go Projects:**
```powershell
# Detect go.mod
if (Test-Path "go.mod") {
    $techStack = "Go"
    # Parse go.mod for module name, dependencies
}
```

### **Databricks Projects (Phase 2):**
```powershell
# Detect Databricks-specific files
if (Test-Path ".databricks" -or Test-Path "databricks.yml") {
    $projectType = "Databricks"
    # Look for notebook files, cluster configs
}
```

---

## 🎯 Generation Process

### **Step 1: Analyze**
```powershell
$analysis = Analyze-Project -Path "."
# Returns: { techStack, framework, buildTool, testing, database, deployment }
```

### **Step 2: Generate Scripts**
```powershell
Generate-Scripts -Analysis $analysis -OutputPath ".dev-workflow"
# Creates: startup-dev-session.ps1, session-closeout.ps1, etc.
```

### **Step 3: Generate Documentation**
```powershell
Generate-Documentation -Analysis $analysis -OutputPath "."
# Creates: DEV_STARTUP_CHEATSHEET.md, DEVELOPMENT_WORKFLOW_README.md, etc.
```

### **Step 4: Generate IDE Context**
```powershell
Generate-IDEContext -Analysis $analysis -OutputPath "."
# Creates: IDE_CONTEXT_SUMMARY.md with complete project context
```

---

## 📊 Tech Stack Configuration

### **React Project Example:**
```json
{
  "techStack": "React",
  "buildTool": "Vite",
  "devCommand": "npm run dev",
  "buildCommand": "npm run build",
  "testCommand": "npm run test",
  "port": 5173,
  "files": ["src/", "public/", "package.json"],
  "envFiles": [".env", ".env.local"]
}
```

### **Python FastAPI Example:**
```json
{
  "techStack": "Python",
  "framework": "FastAPI",
  "devCommand": "uvicorn main:app --reload",
  "testCommand": "pytest",
  "port": 8000,
  "files": ["main.py", "requirements.txt"],
  "envFiles": [".env"]
}
```

### **Go Project Example:**
```json
{
  "techStack": "Go",
  "devCommand": "go run main.go",
  "testCommand": "go test ./...",
  "buildCommand": "go build",
  "files": ["main.go", "go.mod", "go.sum"]
}
```

---

## 🔄 Data Science / ML Support (Phase 2)

### **Jupyter Notebooks:**
- Detect `.ipynb` files
- Generate notebook-specific workflows
- Include data analysis commands
- Environment management (conda, venv)

### **Databricks:**
- Detect Databricks project structure
- Generate Databricks CLI commands
- Include notebook execution workflows
- Cluster management commands

### **R Projects:**
- Detect `DESCRIPTION` file or `.R` files
- Generate R-specific workflows
- Include RStudio integration
- Package management commands

---

## 🚀 Implementation Phases

### **Phase 1: MVP (Weeks 1-3)**
- ✅ Core analyzer for Node.js, Python, Go
- ✅ Basic template engine
- ✅ Script generation (startup, closeout, status)
- ✅ Documentation generation
- ✅ Support 3-5 tech stacks

### **Phase 2: Expansion (Weeks 4-6)**
- ✅ Add more tech stacks (Vue, Angular, .NET, Java)
- ✅ Enhanced project detection
- ✅ Database integration detection
- ✅ Deployment detection
- ✅ Improved template engine

### **Phase 3: Data Science (Weeks 7-10)**
- ✅ Jupyter notebook support
- ✅ Databricks integration
- ✅ R project support
- ✅ ML framework detection
- ✅ Data-specific workflows

---

## 💡 Key Features

### **1. Intelligent Detection**
- Multi-file analysis
- Dependency scanning
- Structure pattern matching
- Configuration file detection

### **2. Context-Aware Generation**
- Tailored commands for each tech stack
- Environment-specific instructions
- Framework-specific best practices
- Project type-specific workflows

### **3. IDE/AI Ready**
- Complete project context
- Tech stack awareness
- Command references
- Session continuity

### **4. Extensible**
- Plugin system for new tech stacks
- Template customization
- Configuration overrides
- Hook system for custom actions

---

## 🎯 Success Criteria

- ✅ Detect project type automatically (95%+ accuracy)
- ✅ Generate workflow in < 30 seconds
- ✅ Support 5+ tech stacks in MVP
- ✅ Work with existing projects (non-destructive)
- ✅ Generate complete documentation
- ✅ IDE context ready immediately

---

## 📝 Next Steps

1. **Create repo**: `dev-workflow-generator`
2. **Build core analyzer**: Node.js, Python, Go detection
3. **Create template engine**: Variable substitution, conditionals
4. **Generate scripts**: startup, closeout, status
5. **Test with real projects**: React, Python API, Go service
6. **Iterate and refine**: Based on real-world usage

---

**Ready to build the MVP!** 🚀
