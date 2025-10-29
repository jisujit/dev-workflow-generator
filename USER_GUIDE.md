# User Guide: What You Get & How to Use It

## What Happens When You Run the Tool

When you run `.\Setup-DevWorkflow.ps1 -ProjectPath .`, here's exactly what you'll see and get:

### 1. What You'll See (Console Output)

```
================================================
   Dev Workflow Generator                       
   Automated Development Workflow Setup         
================================================

Loading modules...
Project path: C:\path\to\your\project

Analyzing project...
Analysis complete: Node.js

Analysis Results:
   Project: my-react-app
   Tech Stack: Node.js
   Language: JavaScript
   Framework: React

Generating development scripts...
Generated: startup-dev-session.ps1
Generated: session-closeout.ps1
Generated: project-status.ps1

Generating documentation...
Generated: DEV_STARTUP_CHEATSHEET.md
Generated: DEVELOPMENT_WORKFLOW_README.md
Generated: IDE_CONTEXT_SUMMARY.md

================================================
   Workflow Setup Complete!                     
================================================

What You Got:
  PowerShell Scripts (.dev-workflow/):
    startup-dev-session.ps1  - Initialize your dev environment
    session-closeout.ps1     - Updates context and clean up when done coding
    project-status.ps1        - Check project health

  Documentation Files:
    DEV_STARTUP_CHEATSHEET.md     - Quick reference guide
    DEVELOPMENT_WORKFLOW_README.md - Complete workflow guide
    IDE_CONTEXT_SUMMARY.md         - AI assistant context

  Features:
    Auto-detected your Node.js project
    Tailored commands for JavaScript
    Optimized for React

Next Steps:
   1. Review the generated cheatsheet
   2. Run: .\.dev-workflow\startup-dev-session.ps1
   3. Start coding!

Would you like to see the quick start guide now? (y/n)
```

### 2. What Files You Get

After running the tool, your project will have:

```
your-project/
├── .dev-workflow/
│   ├── startup-dev-session.ps1    # Start coding
│   ├── session-closeout.ps1       # End session  
│   └── project-status.ps1         # Check status
├── DEV_STARTUP_CHEATSHEET.md      # Quick reference
├── DEVELOPMENT_WORKFLOW_README.md  # Full guide
└── IDE_CONTEXT_SUMMARY.md         # AI context
```

### 3. How You Use It

#### Daily Workflow:

**Start Coding:**
```powershell
.\.dev-workflow\startup-dev-session.ps1
```
This script:
- Checks if your dependencies are installed
- Shows your project information
- Provides commands to start your dev server
- Displays the development URL

**Check Status:**
```powershell
.\.dev-workflow\project-status.ps1
```
This script:
- Shows project information
- Displays git status
- Lists dependencies
- Shows recent commits

**End Session:**
```powershell
.\.dev-workflow\session-closeout.ps1
```
This script:
- Stops running dev servers
- Shows git status
- **Updates context documentation** with latest project state
- Reminds to commit changes
- Provides session summary

#### Quick Reference:

**DEV_STARTUP_CHEATSHEET.md** contains:
- All the commands you need
- Project-specific setup instructions
- Common tasks and shortcuts
- Environment information

## What Features You Get

### For React/Node.js Projects:
- ✅ Automatic dependency checking
- ✅ Development server commands
- ✅ Package manager detection (npm/yarn/pnpm)
- ✅ Build tool detection (Vite/Next.js/CRA)
- ✅ Testing framework integration
- ✅ Port detection and URL generation

### For Python Projects:
- ✅ Virtual environment setup
- ✅ Requirements management
- ✅ Framework detection (FastAPI/Flask/Django)
- ✅ Development server commands
- ✅ Testing integration

### For All Projects:
- ✅ Git status checking
- ✅ Session management
- ✅ Project health monitoring
- ✅ AI assistant context
- ✅ Complete documentation

## How You Know What You Have

### 1. Console Output Shows Everything
The tool clearly displays:
- What was detected in your project
- What was generated for you
- How you can use it
- Your next steps

### 2. Documentation Explains Everything
- **DEV_STARTUP_CHEATSHEET.md** - Quick reference with all your commands
- **DEVELOPMENT_WORKFLOW_README.md** - Complete guide with examples
- **IDE_CONTEXT_SUMMARY.md** - Context for your AI assistants

### 3. Scripts Are Self-Documenting
Each PowerShell script:
- Shows what it does when you run it
- Provides clear output for you
- Explains your next steps
- Shows your project information

### 4. Interactive Help
The tool asks you:
- "Would you like to see the quick start guide now? (y/n)"
- Shows help with `-ShowHelp` flag
- Provides clear error messages

## Example User Journey

1. **You run the tool:**
   ```powershell
   .\Setup-DevWorkflow.ps1 -ProjectPath .
   ```

2. **The tool analyzes your React project and shows:**
   - Detected: React with Vite
   - Generated: 3 scripts + 3 docs
   - Features: Auto-setup, dev server, testing

3. **You start coding:**
   ```powershell
   .\.dev-workflow\startup-dev-session.ps1
   ```
   - Script checks dependencies
   - Shows dev server command
   - Displays localhost URL

4. **You keep DEV_STARTUP_CHEATSHEET.md open:**
   - Has all your commands
   - Shows your project info
   - Quick reference for you

5. **You end your session:**
   ```powershell
   .\.dev-workflow\session-closeout.ps1
   ```
   - Stops servers
   - Shows git status
   - **Updates context docs** with your latest changes
   - Reminds to commit

## The Key Insight

**You don't need to learn anything new!** 

The tool:
- ✅ **Shows you exactly what you got** (console output)
- ✅ **Explains how you can use it** (documentation)
- ✅ **Provides quick reference for you** (cheatsheet)
- ✅ **Makes it obvious** (clear file names and structure)

You just run the tool, get everything you need, and start coding with your existing workflow enhanced!
