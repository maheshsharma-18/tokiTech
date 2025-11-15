# Copilot Instructions for tokiTech

## Current State & Goals
- Repo only contains documentation and design references for the Toki Tech staff web app; no source code, build scripts, or tests exist yet.
- Primary objective is to translate the documented MVP (multi-role school operations portal) into an implementable codebase; every new asset should be traceable back to the PRD or workflows.

## Canonical References
- `docs/prd.md` (≈1k lines) is the single source of truth for requirements: role matrix, module scope, RBAC limits, analytics expectations, localization, and OTP login flows.
- `docs/TokitechWebsite_workflows` expands those requirements into step-by-step UI journeys per role (Principal, Class Teacher, Teacher, Fleet Manager, Super Admin). Use it to clarify page sequencing and edge cases before coding.
- `docs/figma_designs/<role>/` holds PNG exports of the latest Figma screens; folders already mirror the role taxonomy and should inspire new component structure.
- `README.md` is intentionally minimal. Whenever you add runnable code, expand it with architecture notes, setup commands, and state changes mirrored here.

## Architecture & Domain Notes
- Platform is multi-tenant per school with OTP-based authentication using registered mobile numbers; user accounts map 1:1 to a tenant in MVP.
- Core modules: Attendance, Grades, Students, Teachers, Classes, Timetable, Homework, Events & Calendar, Tickets, and Fleet Management. Each module has role-specific permissions spelled out in `docs/prd.md` §4–6—mirror those in any future services or UI routes.
- Dashboards emphasize analytics tiles, class-level drilldowns, and audit trails (e.g., attendance cut-off tracking, grade approval history). Preserve these data flows when designing schemas or APIs.
- Localization (English + Telugu) and school branding (logo/name) are mandatory global UX requirements; plan i18n scaffolding from day one.

## Working Practices for New Code
- Keep repo structure role-aware: group frontend pages, backend handlers, or docs under the same role names seen in `docs/figma_designs/` to stay aligned with design assets.
- Before implementing a workflow, cross-reference `docs/prd.md` and the matching section in `docs/TokitechWebsite_workflows`; note any deviations inside commit messages and update the workflow doc if behavior changes.
- There are no default build/test commands. When introducing tooling (e.g., Next.js app, API service), document install/build/test steps in `README.md` and summarize them here so future agents can run them verbatim.
- Record any new integrations (auth providers, SMS gateways, databases) in both this file and `README.md`, including configuration expectations and secrets handling approach.

## Documentation Expectations
- Treat requirements docs as living specs: update `docs/prd.md` or add addendums if constraints shift, rather than relying on tribal knowledge.
- When adding modules, append design references (screenshot filenames or Figma links) in the relevant directory so future contributors know which visual source you implemented.
- Note open questions or assumptions at the bottom of this file so stakeholders can clarify them quickly.

Have feedback on these instructions or spot gaps? Please highlight them so we can keep this guide accurate for the next agent.