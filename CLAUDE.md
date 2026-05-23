# Git Workflow — ALWAYS Follow This

**Always work directly on `main`. No exceptions.**

- Never create branches
- Never create pull requests
- Always: `git add` → `git commit` → `git push origin main`
- Every push must go to `origin main` so Netlify deploys to Production (not Deploy Preview)

Before every commit, verify you are on main:
```
git branch   # must show: * main
```

If not on main, switch immediately: `git checkout main`
