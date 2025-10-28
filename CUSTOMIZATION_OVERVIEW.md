# Project Detection & Customization Capabilities

## What the Tool Detects & Customizes

The Dev Workflow Generator automatically detects project characteristics and provides **tailored customization** for each project type.

## Detection Capabilities

### 🔍 **Project Type Detection**
- **Node.js Ecosystem**: React, Vue, Angular, Express, Fastify
- **Python**: FastAPI, Flask, Django, Jupyter
- **Go**: Standard Go modules
- **C#**: .NET projects
- **Java**: Maven, Gradle projects
- **Rust**: Cargo projects

### 🔧 **Framework & Tool Detection**
- **Build Tools**: Vite, Next.js, Create React App, Angular CLI, Webpack
- **Testing Frameworks**: Jest, Vitest, pytest, go test, xUnit
- **Package Managers**: npm, yarn, pnpm, pip, go mod
- **Databases**: PostgreSQL, MySQL, MongoDB, Redis
- **Deployment**: Docker, Vercel, Netlify, GitHub Actions

## Customization Examples

### **React Project (Vite)**
```powershell
# Generated startup script includes:
- npm install (dependency check)
- npm run dev (Vite dev server)
- http://localhost:5173 (Vite default port)
- Vitest testing commands
- React-specific file structure
```

### **Python FastAPI Project**
```powershell
# Generated startup script includes:
- python -m venv venv (virtual environment)
- pip install -r requirements.txt
- uvicorn main:app --reload (FastAPI dev server)
- http://localhost:8000 (FastAPI default port)
- pytest testing commands
```

### **Go Project**
```powershell
# Generated startup script includes:
- go mod download (dependency management)
- go run main.go (Go dev server)
- http://localhost:8080 (Go default port)
- go test ./... (Go testing)
```

## Specific Customizations

### **1. Development Commands**
Each project type gets **tailored commands**:

| Project Type | Dev Command | Build Command | Test Command |
|--------------|-------------|---------------|--------------|
| React (Vite) | `npm run dev` | `npm run build` | `npm run test` |
| Angular | `ng serve` | `ng build` | `ng test` |
| FastAPI | `uvicorn main:app --reload` | `pip install -r requirements.txt` | `pytest` |
| Go | `go run main.go` | `go build` | `go test ./...` |
| .NET | `dotnet run` | `dotnet build` | `dotnet test` |

### **2. Port Detection**
**Automatic port assignment** based on framework:

| Framework | Default Port | Detection Method |
|-----------|--------------|------------------|
| Vite | 5173 | package.json devDependencies |
| Next.js | 3000 | package.json dependencies |
| Angular | 4200 | @angular/core detection |
| FastAPI | 8000 | requirements.txt |
| Flask | 5000 | requirements.txt |
| Go | 8080 | go.mod detection |

### **3. Package Manager Detection**
**Smart package manager detection**:

| Lock File | Package Manager | Commands |
|-----------|----------------|----------|
| `package-lock.json` | npm | `npm install`, `npm run dev` |
| `yarn.lock` | yarn | `yarn install`, `yarn dev` |
| `pnpm-lock.yaml` | pnpm | `pnpm install`, `pnpm dev` |

### **4. Environment File Detection**
**Framework-specific environment files**:

| Framework | Environment Files |
|-----------|-------------------|
| React | `.env`, `.env.local`, `.env.development`, `.env.production` |
| Vue | `.env`, `.env.local` |
| Angular | `.env` |
| Python | `.env` |
| Go | `.env` |

### **5. Database Integration**
**Automatic database detection**:

```powershell
# Detects from .env files:
- DATABASE_URL=postgresql://... → PostgreSQL
- MYSQL_URL=... → MySQL  
- MONGODB_URL=... → MongoDB
- REDIS_URL=... → Redis

# Detects from docker-compose.yml:
- postgres service → PostgreSQL
- mysql service → MySQL
```

### **6. Deployment Platform Detection**
**Deployment configuration detection**:

| File | Platform | Customization |
|------|----------|---------------|
| `Dockerfile` | Docker | Docker-specific commands |
| `vercel.json` | Vercel | Vercel deployment info |
| `netlify.toml` | Netlify | Netlify deployment info |
| `.github/workflows/` | GitHub Actions | CI/CD workflow info |

## Generated Documentation Customization

### **DEV_STARTUP_CHEATSHEET.md**
**Tailored for each project type**:

**React Project:**
```markdown
### Setup
```powershell
# Install dependencies
npm install

# Start development server  
npm run dev
```

### Development Server
- **URL:** http://localhost:5173
- **Build Tool:** Vite
- **Package Manager:** npm
```

**Python Project:**
```markdown
### Setup
```powershell
# Create virtual environment
python -m venv venv

# Activate virtual environment
.\venv\Scripts\Activate.ps1

# Install dependencies
pip install -r requirements.txt

# Start development server
uvicorn main:app --reload
```

### Development Server
- **URL:** http://localhost:8000
- **Framework:** FastAPI
```

### **IDE_CONTEXT_SUMMARY.md**
**AI-assistant optimized context**:

**React Project:**
```markdown
### Project Context
- **Name:** my-react-app
- **Type:** React
- **Language:** JavaScript
- **Framework:** React
- **Build Tool:** Vite
- **Testing Framework:** Vitest

### Development Commands
```powershell
# Start development server
npm run dev

# Build for production
npm run build

# Run tests
npm run test
```

### Architecture Notes
This is a React application. Key concepts:
- Component-based architecture
- State management through hooks
- Virtual DOM for efficient rendering
- Fast development with Vite HMR
```

## The Key Benefit

**Zero Configuration Required** - The tool automatically:

1. ✅ **Detects** your exact tech stack
2. ✅ **Customizes** commands for your framework
3. ✅ **Configures** ports and URLs
4. ✅ **Identifies** package managers and tools
5. ✅ **Generates** project-specific documentation
6. ✅ **Creates** tailored development scripts

**Result**: Every project gets a **perfectly customized workflow** without any manual configuration!
