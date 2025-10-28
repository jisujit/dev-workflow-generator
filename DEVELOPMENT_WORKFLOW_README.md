# 🚀 AI Focus App - Complete Development Workflow System

## 📋 Overview

This comprehensive development workflow system provides everything you need to efficiently manage your AI Focus App development sessions. It includes startup scripts, documentation tools, session management utilities, and **IDE context generation** for seamless development continuity.

## 🎯 Quick Start (Your Go-To Reference)

### **🚀 Every Time You Open Cursor:**
```powershell
./startup-dev-session.ps1
```

### **📝 When You Finish Development:**
```powershell
./session-closeout.ps1 -SessionDescription "What you accomplished"
```

---

## 📁 Complete File Structure

### **🎯 Core Workflow Files:**
- **`DEV_STARTUP_CHEATSHEET.md`** - Quick reference guide for every session
- **`startup-dev-session.ps1`** - Complete startup workflow with IDE context
- **`session-closeout.ps1`** - Session ending with context updates
- **`project-status.ps1`** - Comprehensive project status overview
- **`update-session-docs.ps1`** - Documentation updates
- **`UTILITY_SCRIPTS_GLOSSARY.md`** - Complete script reference
- **`DEVELOPMENT_WORKFLOW_README.md`** - This master guide

### **🛠️ Utility Scripts:**
- **Environment Management**: `switch-to-dev.ps1`, `switch-to-prod.ps1`, `validate-env.ps1`, `fix-env-access.ps1`
- **Security & Monitoring**: `security-audit.ps1`, `verify-rls-status.ps1`, `force-rls-check.ps1`
- **Backup & Recovery**: `backup-stable-state.ps1`, `restore-stable-state.ps1`
- **Development Tools**: `dev-test.ps1`, `deploy.ps1`

### **📚 Documentation:**
- **`README.md`** - Updated with workflow system links
- **`ENVIRONMENT_SETUP.md`** - Environment management guide
- **`KEEPALIVE_SYSTEM_GUIDE.md`** - Keepalive system documentation
- **`DEVELOPMENT_PROGRESS.md`** - Development progress tracking
- **`DEPLOYMENT.md`** - Deployment guide

### **📄 Generated Files (Auto-Created):**
- **`IDE_CONTEXT_SUMMARY.md`** - Complete IDE context for any agentic system
- **`SESSION_SUMMARY_[date].md`** - Session summaries
- **`TODO_LIST_[date].md`** - Current TODOs
- **`SESSION_CLOSEOUT_[date].md`** - Session closeout summaries

---

## 🚀 Complete Development Workflow

### **1. Session Startup (Every Time You Open Cursor)**

#### **🎯 Option A: Full Startup (Recommended)**
```powershell
./startup-dev-session.ps1
```
**What it does:**
- ✅ Project status check
- ✅ Environment validation
- ✅ Environment switch (if needed)
- ✅ **IDE context generation** (`IDE_CONTEXT_SUMMARY.md`)
- ✅ Database status check
- ✅ Command reference
- ✅ Next steps guidance

#### **⚡ Option B: Quick Startup**
```powershell
./project-status.ps1
./validate-env.ps1
./switch-to-dev.ps1
npm run dev
```

#### **🔧 Option C: Force Development Environment**
```powershell
./startup-dev-session.ps1 -ForceDev
```

### **2. During Development**

#### **📊 Check Project Status:**
```powershell
./project-status.ps1
```

#### **🔍 Validate Environment:**
```powershell
./validate-env.ps1
```

#### **🔒 Run Security Audit:**
```powershell
./security-audit.ps1
```

#### **🗄️ Check Database Status:**
```powershell
npx supabase status
npx supabase db push
```

### **3. Session End (Every Time You Finish Development)**

#### **📝 Complete Session Closeout:**
```powershell
./session-closeout.ps1 -SessionDescription "What you accomplished"
```

#### **⚡ Quick Session End:**
```powershell
./update-session-docs.ps1
git add .
git commit -m "Session update: [description]"
git push origin main
```

---

## 🛠️ Complete Utility Scripts Reference

### **🌍 Environment Management:**
| Script | Purpose | When to Use | Command |
|--------|---------|-------------|---------|
| `switch-to-dev.ps1` | Switch to development environment | Starting development work | `./switch-to-dev.ps1` |
| `switch-to-prod.ps1` | Switch to production environment | Deploying to production | `./switch-to-prod.ps1` |
| `validate-env.ps1` | Validate current environment settings | Checking environment status | `./validate-env.ps1` |
| `fix-env-access.ps1` | Fix environment file access issues | When Cursor can't see .env files | `./fix-env-access.ps1` |

### **📊 Project Status Scripts:**
| Script | Purpose | When to Use | Command |
|--------|---------|-------------|---------|
| `project-status.ps1` | Get comprehensive project overview | Starting development session | `./project-status.ps1` |
| `update-session-docs.ps1` | Update all documentation | Ending development session | `./update-session-docs.ps1` |

### **🗄️ Database Management Scripts:**
| Script | Purpose | When to Use | Command |
|--------|---------|-------------|---------|
| `npx supabase db push` | Apply migrations to database | After creating new migrations | `npx supabase db push` |
| `npx supabase migration list` | List applied migrations | Checking migration status | `npx supabase migration list` |
| `npx supabase status` | Check Supabase connection | Verifying database connectivity | `npx supabase status` |

### **🔒 Security & Monitoring Scripts:**
| Script | Purpose | When to Use | Command |
|--------|---------|-------------|---------|
| `security-audit.ps1` | Run comprehensive security audit | Before deployment | `./security-audit.ps1` |
| `verify-rls-status.ps1` | Check RLS status | After database changes | `./verify-rls-status.ps1` |
| `test-rls-direct.ps1` | Test RLS functionality | Troubleshooting RLS issues | `./test-rls-direct.ps1` |
| `force-rls-check.ps1` | Force RLS status check | Debugging RLS problems | `./force-rls-check.ps1` |

### **💻 Development & Testing Scripts:**
| Script | Purpose | When to Use | Command |
|--------|---------|-------------|---------|
| `npm run dev` | Start development server | Local development | `npm run dev` |
| `npm run build:dev` | Build for development | Testing development build | `npm run build:dev` |
| `npm run build:prod` | Build for production | Production deployment | `npm run build:prod` |
| `./dev-test.ps1` | Test with Docker (development) | Testing development environment | `./dev-test.ps1` |
| `./deploy.ps1` | Deploy to production | Production deployment | `./deploy.ps1` |

### **💾 Backup & Recovery Scripts:**
| Script | Purpose | When to Use | Command |
|--------|---------|-------------|---------|
| `backup-stable-state.ps1` | Create comprehensive backup | Before major changes | `./backup-stable-state.ps1` |
| `restore-stable-state.ps1` | Restore from backup | After system issues | `./restore-stable-state.ps1` |

---

## 🌍 Environment Quick Reference

### **🌱 Development Environment:**
- **Supabase**: `ai-focus-app-dev` (vcxfwxrnrskvsgqxqrsz)
- **Stripe**: TEST mode (pk_test_...)
- **Email**: All emails → gsujit@gmail.com
- **Admin**: admin123
- **URL**: http://localhost:5173

### **🚀 Production Environment:**
- **Supabase**: `ai-focus-app-prod` (fvazftacytreklsmmbcr)
- **Stripe**: LIVE mode (pk_live_...)
- **Email**: Real recipients
- **Admin**: ath@rvaL0kam
- **URL**: https://ai-focus.org

---

## 📊 Current Project Status

### **✅ Completed Features:**
- ✅ Service Status Management (active/inactive/coming soon)
- ✅ Session Management (create/update/delete with refunds)
- ✅ Training Registration with Stripe payments
- ✅ Email Notifications (Resend integration)
- ✅ Admin Authentication & Dashboard
- ✅ WCAG 2.1 AA Accessibility Compliance
- ✅ Security: RLS enabled, function security fixed
- ✅ Keepalive System: GitHub Actions (15-day intervals)

### **🔄 Active Systems:**
- **Keepalive**: Production (2:00 AM UTC) + Development (2:30 AM UTC)
- **Email Notifications**: Professional HTML emails via Resend
- **Security**: RLS enabled on all tables, function security fixed
- **Monitoring**: GitHub Actions with email notifications

### **📋 Current TODOs & Next Steps:**
- [ ] Review and optimize slow database queries
- [ ] Remove hardcoded secrets from components
- [ ] Test keepalive system end-to-end
- [ ] Add more comprehensive error handling
- [ ] Implement additional accessibility features

---

## 🎯 IDE Context System

### **📄 IDE_CONTEXT_SUMMARY.md Features:**
- **Project Overview**: Complete tech stack and purpose
- **Environment Status**: Current environment with all details
- **Git Status**: Branch, changes, recent commits
- **Session Summary**: Last session accomplishments
- **Project Structure**: Key files and their purposes
- **Current Features**: All implemented features
- **Active Systems**: Keepalive, email, security
- **TODOs**: Current tasks and next steps
- **Development Commands**: Quick reference
- **Important URLs**: All relevant links

### **🔄 Context Updates:**
- **Startup**: Generated fresh context every session
- **Closeout**: Updated with session accomplishments
- **Continuity**: Never lose context between sessions

---

## 🚨 Important Notes

### **🔒 Security:**
- Never commit `.env` files
- Always use environment-specific configurations
- Test security changes in development first
- Run security audit before deployment

### **🗄️ Database:**
- Always backup before major changes
- Test migrations in development first
- Monitor keepalive system status
- Check RLS status after changes

### **🚀 Deployment:**
- Verify environment before deployment
- Test in development environment first
- Monitor production after deployment
- Use proper environment switching

---

## 📞 Troubleshooting

### **🔧 Common Issues:**

#### **Environment Issues:**
```powershell
./validate-env.ps1
./fix-env-access.ps1
./switch-to-dev.ps1
```

#### **Database Issues:**
```powershell
npx supabase status
npx supabase db push
./verify-rls-status.ps1
```

#### **Build Issues:**
```powershell
./validate-env.ps1
npm run build:dev
./dev-test.ps1
```

#### **Security Issues:**
```powershell
./security-audit.ps1
./verify-rls-status.ps1
./test-rls-direct.ps1
```

### **🚨 Emergency Contacts:**
- **Supabase Dashboard**: Check project status
- **GitHub Actions**: Monitor keepalive system
- **Email Notifications**: Check for system alerts

---

## 🎉 Success Metrics

### **✅ Session Startup Success:**
- ✅ Environment validated
- ✅ Project status checked
- ✅ Development environment active
- ✅ Database connected
- ✅ **IDE context generated**
- ✅ Commands available

### **✅ Session End Success:**
- ✅ Documentation updated
- ✅ Changes committed
- ✅ Session summary created
- ✅ **IDE context updated**
- ✅ Next steps planned

### **✅ Overall Project Health:**
- ✅ Security issues resolved
- ✅ Keepalive system active
- ✅ Environment management working
- ✅ Documentation current
- ✅ **IDE context system working**

---

## 🚀 Quick Commands Summary

### **🚀 Start Development:**
```powershell
./startup-dev-session.ps1
npm run dev
```

### **📊 Check Status:**
```powershell
./project-status.ps1
./validate-env.ps1
```

### **📝 End Session:**
```powershell
./session-closeout.ps1 -SessionDescription "What you accomplished"
```

### **🔧 Emergency Reset:**
```powershell
./fix-env-access.ps1
./switch-to-dev.ps1
./validate-env.ps1
```

---

## 🎯 Key Benefits

### **🔄 Session Continuity:**
- **Never lose context** between sessions
- **IDE context** always current
- **Session summaries** preserved
- **TODOs** tracked and updated

### **🤖 IDE/AI Ready:**
- **Complete context** for any agentic system
- **Environment awareness** built-in
- **Project state** always known
- **Next steps** clearly defined

### **⚡ Efficiency:**
- **One command** startup
- **One command** closeout
- **Automated** documentation
- **Streamlined** workflow

---

## 📚 Documentation Links

- **[DEV_STARTUP_CHEATSHEET.md](DEV_STARTUP_CHEATSHEAT.md)** - Quick reference guide
- **[UTILITY_SCRIPTS_GLOSSARY.md](UTILITY_SCRIPTS_GLOSSARY.md)** - Complete script reference
- **[ENVIRONMENT_SETUP.md](ENVIRONMENT_SETUP.md)** - Environment management guide
- **[KEEPALIVE_SYSTEM_GUIDE.md](KEEPALIVE_SYSTEM_GUIDE.md)** - Keepalive system documentation
- **[DEVELOPMENT_PROGRESS.md](DEVELOPMENT_PROGRESS.md)** - Development progress tracking

---

**🎯 Remember: Always start with `./startup-dev-session.ps1` and end with `./session-closeout.ps1`!**

**🚀 Happy coding with complete context and seamless workflow!**