# 🚀 AI Focus App - Development Startup Cheatsheet

## 📋 Quick Start Checklist (Run Every Time You Open Cursor)

### **Step 1: Environment Status Check**
```powershell
# Check current environment
./validate-env.ps1

# If you need to switch environments:
./switch-to-dev.ps1    # For development work
./switch-to-prod.ps1   # For production work
```

### **Step 2: Project Status Overview**
```powershell
# Get project status summary
./project-status.ps1

# Check recent changes
git log --oneline -10

# Check for any pending migrations
npx supabase migration list
```

### **Step 3: Database Status**
```powershell
# Check Supabase connection
npx supabase status

# Verify database is up to date
npx supabase db push
```

### **Step 4: Start Development**
```powershell
# For development work
npm run dev

# For testing with Docker
./dev-test.ps1
```

---

## 🎯 Environment Quick Reference

### **Development Environment:**
- **Supabase**: `ai-focus-app-dev` (vcxfwxrnrskvsgqxqrsz)
- **Stripe**: TEST mode (pk_test_...)
- **Email**: All emails → gsujit@gmail.com
- **Admin**: admin123

### **Production Environment:**
- **Supabase**: `ai-focus-app-prod` (fvazftacytreklsmmbcr)
- **Stripe**: LIVE mode (pk_live_...)
- **Email**: Real recipients
- **Admin**: ath@rvaL0kam

---

## 📊 Current Project Status

### **✅ Completed Features:**
- Service Status Management
- UI Updates with shadcn-ui
- Session Deletion Logic
- Email Notifications (Resend)
- Admin Authentication
- WCAG 2.1 AA Accessibility Compliance
- Security Issues Fixed (RLS, Function Security)
- Keepalive System (GitHub Actions)

### **🔄 Active Systems:**
- **Keepalive**: Production (2:00 AM UTC) + Development (2:30 AM UTC)
- **Email Notifications**: Professional HTML emails via Resend
- **Security**: RLS enabled on all tables, function security fixed

---

## 🛠️ Utility Scripts Reference

### **Environment Management:**
- `./switch-to-dev.ps1` - Switch to development environment
- `./switch-to-prod.ps1` - Switch to production environment
- `./validate-env.ps1` - Validate current environment settings
- `./fix-env-access.ps1` - Fix environment file access issues

### **Database Management:**
- `npx supabase db push` - Apply migrations to database
- `npx supabase migration list` - List applied migrations
- `npx supabase status` - Check Supabase connection

### **Development & Testing:**
- `npm run dev` - Start development server
- `npm run build:dev` - Build for development
- `npm run build:prod` - Build for production
- `./dev-test.ps1` - Test with Docker (development)
- `./deploy.ps1` - Deploy to production

### **Security & Monitoring:**
- `./security-audit.ps1` - Run security audit
- `./verify-rls-status.ps1` - Check RLS status
- `./test-rls-direct.ps1` - Test RLS functionality

### **Backup & Recovery:**
- `./backup-stable-state.ps1` - Create comprehensive backup
- `./restore-stable-state.ps1` - Restore from backup

---

## 📝 Session Closeout Checklist

### **Before Ending Development Session:**

1. **Update Documentation:**
   ```powershell
   ./update-session-docs.ps1
   ```

2. **Commit Changes:**
   ```powershell
   git add .
   git commit -m "Session update: [brief description]"
   git push origin main
   ```

3. **Update TODO List:**
   ```powershell
   ./update-todos.ps1
   ```

4. **Create Session Summary:**
   ```powershell
   ./create-session-summary.ps1
   ```

---

## 🎯 Next Steps & TODOs

### **High Priority:**
- [ ] Review and optimize slow database queries
- [ ] Remove hardcoded secrets from components
- [ ] Test keepalive system end-to-end

### **Medium Priority:**
- [ ] Add more comprehensive error handling
- [ ] Implement additional accessibility features
- [ ] Create user documentation

### **Low Priority:**
- [ ] Performance optimization
- [ ] Additional testing scenarios
- [ ] Documentation improvements

---

## 🚨 Important Notes

### **Security:**
- Never commit `.env` files
- Always use environment-specific configurations
- Test security changes in development first

### **Database:**
- Always backup before major changes
- Test migrations in development first
- Monitor keepalive system status

### **Deployment:**
- Verify environment before deployment
- Test in development environment first
- Monitor production after deployment

---

## 📞 Quick Help

### **Common Issues:**
- **Environment issues**: Run `./validate-env.ps1`
- **Database issues**: Run `npx supabase db push`
- **Build issues**: Check environment variables
- **Security issues**: Run `./security-audit.ps1`

### **Emergency Contacts:**
- **Supabase Dashboard**: Check project status
- **GitHub Actions**: Monitor keepalive system
- **Email Notifications**: Check for system alerts

---

**Remember: Always start with environment validation and end with documentation updates!** 🚀
