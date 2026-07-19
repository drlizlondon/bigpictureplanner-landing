# PRD — "Build a Business" MVP (Business Creator + Founder Session)
### v1.0 · July 2026 · builds on `docs/STRATEGY.md`

---

## 1. Summary

A free, guided AI wizard that takes someone from *business idea* to a complete **Business Pack** — developed idea, positioning, offer, website copy, and a ready-to-paste Lovable prompt — with a paid upsell to a **£150 60-minute launch session** with Liz. It is the first surface of a single platform whose core asset is the **Business Brain**: a persistent structured model of the user's business that later powers audits, Mission Control, and the AI Business Admin.

**This PRD covers the MVP only.** Audit, Mission Control, integrations, and any autonomous/agentic behaviour are out of scope (see §10).

## 2. Goals & success metrics

| Goal | Metric | Target (first 30 days) |
|---|---|---|
| Prove demand | Wizard starts | 200+ |
| Prove the experience | Wizard completion rate (start → Business Pack) | ≥ 40% |
| Prove monetisation | £150 sessions booked | 5+ |
| Build the funnel | Emails captured | ≥ 60% of completers |
| Seed the platform | Business Brains stored with full schema | 100% of completions |

## 3. Target user

**Primary:** pre-launch founder — has an idea (or several), hasn't launched, overwhelmed by where to start. Not technical. Willing to spend an evening, not a month.

**Secondary (do not optimise for, do not block):** early-stage owner rethinking their positioning/offer.

## 4. Core product principles

1. **Challenge, don't cheerlead.** At every stage the AI proposes, then pushes back with 1–2 sharp questions before refining. The experience should feel like a strategist who cares, not an autocomplete. This is the primary differentiator vs. ChatGPT.
2. **The output is a Business Pack, not a website.** The Lovable prompt is the last artefact, never the headline.
3. **Everything writes to the Business Brain schema (§8).** No free-text blobs as the source of truth.
4. **No dead ends.** Every screen has one obvious next step; the final screen's next steps are "build your site" and "book a session".

## 5. User journey & screens

### 5.1 Landing section ("Build a Business")
Lives inside Liz's personal site. Hero: the two doors from strategy — MVP enables only Door A.
- Headline (e.g. "Turn your idea into a real business — this week.")
- Sub: what the wizard produces (the Business Pack), ~15 minutes, free.
- Primary CTA: **Start free** → wizard. Secondary CTA: **Work with me — £150 launch session** → session page.
- Social proof/credibility strip (Liz's bio, past work).

### 5.2 Wizard — Stage 0: Intake (no signup required to start)
One question per screen, progress indicator, back navigation, answers persisted locally until account creation. Questions:

1. What's your idea, in your own words? (long text)
2. Who is it for? (long text)
3. What problem does it solve for them? (long text)
4. Why you? What's your unfair advantage — skills, experience, audience, obsession? (long text)
5. How do you imagine making money? (select: one-off purchase / subscription / service·time / marketplace·commission / not sure)
6. What could someone pay for a good solution to this problem today? (select ranges / not sure)
7. Who else solves this now, and what do people do instead? (long text, optional)
8. How much time can you give this per week? (select: <5h / 5–15h / 15–30h / full-time)
9. What does success look like in 12 months? (select: side income / replace salary / build a company / not sure)
10. What's your first name, and what should we call the business for now? (short text; working name optional)

### 5.3 Wizard — Stages 1–4: develop → position → offer → copy
Each stage follows the same **propose → challenge → refine** loop:

- **Propose:** AI generates the stage output from the Brain so far.
- **Challenge:** AI asks 1–2 pointed questions exposing the weakest assumption (e.g. "You've said 'everyone with a dog' — a premium service can't serve everyone. Urban professionals who feel guilty at work, or rural owners with working dogs?"). User answers or clicks "keep as is".
- **Refine:** AI regenerates incorporating the answer. User can edit any field inline before continuing.
- Each stage ends with an explicit **"Lock it in"** action that writes to the Brain.

| Stage | Output written to Brain |
|---|---|
| 1. Idea development | Sharpened one-sentence idea, target customer, problem, differentiation, risks/assumptions (top 3), viability note (honest, incl. "this is crowded/weak because…") |
| 2. Positioning | Category, audience definition, key differentiator, positioning statement, 3 message pillars, tone of voice |
| 3. Offer | Offer name, deliverables/format, price + rationale, guarantee/risk-reversal, primary CTA |
| 4. Website copy | Hero (headline, sub, CTA), problem section, solution section, offer section, about/founder section, FAQ (5), footer CTA |

**Signup gate:** placed after Stage 1's first "Propose" (they've seen real value, they're invested). Email + password or magic link. All prior answers migrate into the account.

### 5.4 Results — the Business Pack
A workspace page (persistent, revisitable) with tabs:
1. **Idea** · 2. **Positioning** · 3. **Offer** · 4. **Website copy** · 5. **Website prompt** · 6. **Next steps**

Each tab: rendered content, inline edit, "regenerate with feedback" (one round per field), copy button. **Website prompt** tab: the generated Lovable prompt (§7) in a copy-friendly block with 3-step instructions ("Open lovable.dev → paste → publish"). **Next steps** tab: 7-day launch checklist + prominent £150 session card.

### 5.5 Session page (Option B — £150)
- What happens in the 60 minutes (challenge the idea, refine positioning/offer, build the first website together, leave live).
- Who it's for / not for. Liz's credibility.
- **Book & pay:** Stripe Payment Link (£150) → on success, redirect to Calendly (or Cal.com) booking. No custom booking/payments build in MVP.
- If the user has a Business Pack, the confirmation notes their pack will be reviewed before the call (manual for MVP; admin view §5.7).

### 5.6 Dashboard
Signed-in home: list of the user's businesses (Brains) with status (in progress / pack complete), "Start another idea", session CTA.

### 5.7 Admin (Liz only)
Table of all users/Brains: email, business name, stage reached, created date, pack link (read-only), session-booked flag (manual toggle for MVP). Basic funnel counts (starts, completions, emails, per stage drop-off).

## 6. AI pipeline requirements

- Each stage is a **separate prompt template** (versioned config, not hard-coded), receiving: the full Business Brain JSON + the stage instruction + Liz's methodology notes (editable system context).
- The **challenge step is mandatory** in stages 1–3, optional in 4. Challenges must reference the user's actual answers, never be generic.
- Tone: warm, direct, expert. Explicitly instructed to disagree when the input is weak, and to say *why*.
- Output contract: every generation returns structured JSON matching the Brain schema fields for that stage (validate; retry once on parse failure; graceful error UI on second failure).
- Model calls go through a single provider-agnostic function (`generate(stage, brain, userInput)`) so the rebuild can swap providers trivially. Default: latest Claude model via API.
- Latency: streaming output or a staged progress indicator; no silent spinner > 3s.

## 7. Lovable prompt generator (the final artefact)

Generates ONE self-contained prompt containing:
1. Business context paragraph (from Brain: idea, audience, positioning).
2. Full page structure with the **exact copy from Stage 4** embedded verbatim (hero, problem, solution, offer, about, FAQ, footer).
3. Design direction derived from tone of voice (palette mood, typography feel, imagery guidance) — descriptive, not prescriptive hex values.
4. Functional requirements: single landing page, email capture form, CTA to the offer, mobile responsive, fast.
5. Explicit instruction to Lovable: build exactly this copy, don't rewrite it.

Acceptance: pasting the prompt into Lovable unmodified yields a coherent single-page site with the user's copy intact.

## 8. Business Brain schema (canonical — survives the rebuild)

```jsonc
{
  "brain_id": "uuid",
  "owner": { "user_id": "uuid", "email": "string", "first_name": "string" },
  "meta": { "created_at": "iso", "updated_at": "iso", "stage_reached": "intake|idea|positioning|offer|copy|complete", "source": "creator" },
  "intake": { "raw_answers": [{ "question_id": "string", "answer": "string" }] },
  "identity": { "working_name": "string", "one_liner": "string", "category": "string" },
  "customer": { "target_description": "string", "problem": "string", "alternatives": "string" },
  "founder": { "unfair_advantage": "string", "time_per_week": "string", "ambition_12mo": "string" },
  "positioning": { "statement": "string", "differentiator": "string", "message_pillars": ["string"], "tone_of_voice": "string" },
  "offer": { "name": "string", "deliverables": ["string"], "price": "string", "price_rationale": "string", "risk_reversal": "string", "primary_cta": "string" },
  "website": { "hero": {}, "problem": {}, "solution": {}, "offer_section": {}, "about": {}, "faq": [], "footer_cta": {}, "lovable_prompt": "string" },
  "assessment": { "risks": ["string"], "viability_note": "string" },
  "history": [{ "at": "iso", "stage": "string", "event": "proposed|challenged|user_edit|locked", "summary": "string" }],
  "future": { "audit": null, "metrics": null, "actions": null }  // reserved for Door B / Mission Control / Admin
}
```

`history` and `future` exist from day one even though the MVP barely uses them — they are what make the Brain an accumulating asset rather than a form submission.

## 9. Architecture (platform-agnostic)

- **Client:** SPA/SSR web app — landing, wizard, workspace, dashboard, admin. No framework mandated; Lovable's default is fine for the prototype.
- **API layer:** thin backend exposing: auth, `brains` CRUD, `generate(stage)` orchestration, admin queries. All AI calls server-side (never expose keys client-side).
- **Orchestration:** prompt templates + methodology context stored as versioned config/data, not code.
- **Storage:** Postgres (Lovable prototype: Supabase). Tables: `users`, `brains` (JSONB column holding the schema in §8), `events` (analytics). The JSONB-first design is deliberate: the rebuild migrates by copying rows.
- **Auth:** email magic link or email+password. Nothing social for MVP.
- **Payments/booking:** Stripe Payment Link + Calendly. Zero custom code.
- **Analytics:** event log (wizard_start, stage_locked, signup, pack_complete, prompt_copied, session_click, session_paid-manual) to the `events` table + any page analytics.

## 10. Out of scope (MVP)

- Website URL audit (next release), GA/GSC/tool integrations, Mission Control brief, subscriptions/recurring billing, any drafting/acting "Admin" behaviour, teams, custom booking, mobile apps, standalone domain/brand.

## 11. Risks & mitigations

| Risk | Mitigation |
|---|---|
| Output feels like generic ChatGPT | Mandatory challenge loop; Liz's methodology in system context; honest viability notes |
| Users grab the website prompt and vanish | Pack framing; signup gate before full outputs; 7-day checklist + email follow-up |
| Lovable prompt renders badly | Acceptance-test the generator against Lovable weekly; keep instructions explicit |
| Wizard fatigue (10 questions + 4 stages) | One question per screen; visible progress; "not sure" allowed everywhere; ~15 min total |
| Prototype data model drifts from schema | §8 is canonical; Lovable is instructed to store exactly this JSON |

## 12. Build order for Lovable

1. Landing section + session page (Stripe/Calendly links live) — *revenue possible on day 1*.
2. Wizard intake (Stage 0) + local persistence.
3. Generation pipeline Stage 1 with challenge loop + signup gate.
4. Stages 2–4 + Business Pack workspace.
5. Lovable prompt generator + Next Steps tab.
6. Dashboard + admin + event logging.
