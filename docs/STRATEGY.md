# Product Strategy — "Build a Business" Platform
### Founding CPO review, July 2026

This document challenges and restructures the four-product portfolio (Business Creator, Business Auditor, Mission Control, AI Business Admin) before any PRD work. The PRD that follows from this strategy is in `docs/PRD.md`.

> **Revision note (v2):** §0 below supersedes parts of this document for Version 1. The platform analysis (§1–§10) remains the long-term architecture; §0 corrects what Version 1 actually is. `docs/PRD.md` now specs V1 only.

---

## 0. The V1 correction — from platform to first experience

The original MVP in this document was still Version 3 thinking wearing Version 1 clothes: a wizard with stages, a tabbed workspace, accounts, a dashboard, an admin panel. Product-shaped, not person-shaped.

**Version 1 is not a platform. It is the best possible first experience for someone building their first business.** It lives inside Liz's personal website as a capability ("Build a Business"), fed by warm traffic Liz directs personally from talks, networking and events.

**The user** is a first-time founder: a mum returning to work, a freelancer, a healthcare professional, someone with an idea and no confidence. **The scarce resource is confidence — not automation, not dashboards, not AI.** The outputs (concept, positioning, offer, pricing, copy, Lovable prompt, launch checklist) are *evidence* of the confidence, not the product.

**The promise:** "Let's build your business." The website is one output, never the headline.

**The experience:** a friendly guide — one warm question at a time, encouraging, practical, occasionally (never constantly) challenging. Not a chatbot, not a consultant, not a corporate flow. Two design rules resolve the tensions in this brief:

1. **Honest about the AI, personal in framing.** Users will know it's AI; hiding it would break trust. Frame it as *"a guide I built"* — Liz's methodology, delivered by an assistant, with Liz one click away.
2. **A conversation with a spine.** Freeform chat wanders and can't guarantee the promised complete plan. The guide has an invisible phase structure underneath (it always knows what it still needs to learn) while presenting as natural conversation on the surface.

**Commercial model:** free complete guided experience; £150 "Build it with me" session that *accelerates* the same journey (refine together, challenge together, leave with a polished published site) rather than being a different product.

**What V1 explicitly cuts** (from this document's original MVP): accounts/login (the plan is delivered to a private tokenized link by email), the tabbed workspace (replaced by a single beautiful Business Plan page), the dashboard, the admin panel (replaced by a completion email to Liz — which doubles as session-prep pipeline), multiple businesses per user, the mid-flow signup gate (email is asked for conversationally near the end), and Door B / the URL mini-audit (deferred until V1 proves itself).

**What V1 keeps invisibly:** the Business Brain schema (§8 of the PRD), populated silently by the conversation. Business Brain, Mission Control and AI Business Admin remain the long-term architecture (§1–§10 below) — they disappear into the background for V1 and become natural evolutions once someone has actually built a business.

**Simplest possible sequence:** Day 0 — the "Build a Business" page with the £150 session bookable goes live before any software exists (Liz already delivers this session in person; every one run before launch is training data for the guide's prompts). Days 1–4 — the guided conversation itself, now small enough to build in days.

---

---

## 1. The core verdict

**You don't have four products. You have one product observed at four moments in a customer's life — plus one genuinely load-bearing asset you haven't named yet.**

That asset is the **Business Brain**: a persistent, structured, accumulating model of one specific business — its positioning, offer, customers, metrics, decisions, and history. Every one of your four ideas is either a way of *populating* that brain or a way of *acting on* it:

| Idea | What it really is |
|---|---|
| Business Creator | Populates the brain from zero (an idea) |
| Business Auditor | Populates the brain from an existing business (URL + data) |
| Mission Control | Keeps the brain current and reads it back weekly |
| AI Business Admin | Acts on the brain with increasing autonomy |

Once you see this, the strategy simplifies dramatically: **one platform, one data model, two entry doors, one escalator.**

---

## 2. Critique of the current thinking

### 2.1 Auditor and Mission Control are the same product

An audit is not a product; it is **Mission Control's day one**. Both require identical plumbing (connect website, GA, Search Console; analyse; output prioritised recommendations). The only difference is frequency: the Auditor runs once, Mission Control runs forever. Shipping them separately means building the same connectors, the same analysis engine, and the same recommendations UI twice, then confusing customers about which to buy.

**Decision: merge them.** The audit is the free/cheap onboarding moment of Mission Control — the "wow" that converts a visitor into a subscriber.

### 2.2 Mission Control and AI Business Admin are the same product at different trust levels

Mission Control *tells* you what to do. Admin *does* it. That is not a product boundary — it's an **autonomy slider**:

1. **Observe** — here's what's happening (Mission Control today)
2. **Recommend** — here's what to do about it
3. **Draft** — I've written the reply / the post / the fix; approve it
4. **Act** — I did it; here's the log

Every serious AI agent product is walking this same ladder. Treating Admin as a separate product would mean rebuilding context, memory, and integrations that Mission Control already owns. Admin is **Mission Control v3**, unlocked one capability at a time as trust and engineering maturity allow.

### 2.3 Business Creator serves a different customer — be honest about why it exists

Pre-launch founders are, commercially, the **worst segment in SaaS**: no revenue, extreme price sensitivity, high abandonment, and most of their businesses will die. A free idea-to-website flow is also the most commoditised thing on this list — ChatGPT + Lovable already does 80% of it.

So why keep it? Three real reasons:

1. **It's your audience-fit funnel.** A personal brand that says "I'll help you build a business" naturally attracts pre-launch people. Turning that traffic away is waste.
2. **The £150 session is the smartest line in the whole brief.** Revenue from day one, zero build cost, and every session is user research that trains your product instincts (and eventually your prompts).
3. **It seeds Business Brains.** Every completed wizard is a structured business context that makes the *rest* of the platform instantly valuable if that business launches.

**Decision: keep Creator, but as a door and a lead magnet — not as a product you invest in beyond the MVP.** Its job is (a) email capture, (b) £150 session bookings, (c) brain-seeding.

### 2.4 The linear journey is a marketing narrative, not an architecture

Idea → Creator → Launch → Audit → Mission Control → Admin is seductive, but as a *funnel* it's wrong for two reasons:

- **Time constant.** A business created today won't need Mission Control for months. If existing businesses must enter "at the top", you wait a year for revenue while your best-paying segment (operating businesses) bounces off a funnel built for dreamers.
- **Your most valuable customers enter in the middle.** An established business owner should land, paste their URL, and get an audit in minutes — never seeing the Creator at all.

**Decision: the journey is a story you tell on the landing page ("wherever you are, from idea to operations"). The product has two independent doors that converge on the same brain:**

- **Door A — "Start a business"** (pre-launch → Creator wizard)
- **Door B — "Grow your business"** (operating → instant audit → Mission Control)

### 2.5 "The website is not the product" — correct, and it's a trap anyway

If the free tier's climax is "paste this into Lovable and get a website", users will file you under *website generators* and churn the moment the site exists. The framing must be: **the output is a Business Pack** (idea, positioning, offer, copy, launch plan — *and* a website prompt). The website is one artefact of the pack. This also protects you when Lovable inevitably ships its own "describe your business" wizard.

---

## 3. Duplications identified

1. **Connector layer** (website, GA, GSC, tools) — specced twice (Auditor + Mission Control). Build once.
2. **Analysis → prioritised recommendations engine** — specced twice. Build once; run it once (audit) or on a schedule (Mission Control).
3. **Business understanding/context** — implicitly specced four times. This is the Business Brain; build it first, as the schema everything reads and writes.
4. **"Suggesting priorities"** appears in Auditor, Mission Control, *and* Admin. One recommendations system, three consumption modes.

---

## 4. One platform or multiple products?

**One platform. Two doors. One escalator. One human layer.**

```
                    ┌──────────────────────────────┐
                    │        BUSINESS BRAIN         │
                    │  (structured, persistent      │
                    │   model of one business)      │
                    └──────────────────────────────┘
                        ▲                    ▲
        Door A          │                    │          Door B
  ┌──────────────┐      │                    │     ┌──────────────┐
  │   CREATOR    │──────┘                    └─────│    AUDIT     │
  │ idea → pack  │   populates from zero          │ URL → findings│
  └──────────────┘                                 └──────────────┘
                                                          │
                                              converts into
                                                          ▼
                    ┌──────────────────────────────┐
                    │       MISSION CONTROL         │  ← the subscription
                    │  weekly brief · priorities    │
                    │  autonomy ladder:             │
                    │  observe → recommend →        │
                    │  draft → act  (= "Admin")     │
                    └──────────────────────────────┘

  Human layer (Liz): £150 launch session · audit debrief · advisory tier
```

The **human layer is a feature of the platform**, not a side hustle: it's your differentiation, your day-one revenue, and your research loop. Long term, if the platform spins out as a standalone company, the human layer becomes a marketplace/expert tier — the architecture doesn't change.

---

## 5. Customer journey (first visit → long-term subscription)

**Door B (the money path):**
1. Land on "Build a Business" section of your site.
2. Paste your website URL — **no signup** — get a free mini-audit in ~60 seconds (3 findings + a teaser of what's behind signup). This is the magic moment.
3. Sign up (email) to unlock the full audit → first Business Brain created.
4. Connect GA / Search Console → audit deepens with real data.
5. Offer: **Mission Control subscription** — weekly brief ("what's working, what isn't, do these 3 things this week").
6. Over months, autonomy ladder unlocks: drafted replies, drafted content, executed fixes → the "AI Business Admin" experience, as an upgrade tier.
7. At any point: book time with Liz (audit debrief, strategy session) — paid.

**Door A (the audience path):**
1. Land on "Build a Business" → "I have an idea".
2. Free wizard: answer questions → AI challenges and develops the idea → positioning → offer → website copy → Lovable prompt. Email required to save/export.
3. Upsell throughout and at the end: **£150 launch session** with Liz.
4. When they launch, their brain already exists → they re-enter through Door B with zero cold start.

**Retention logic:** the longer a brain accumulates (decisions, metrics history, drafted work), the more expensive it is to leave. That, not any single feature, is the subscription's gravity.

---

## 6. MVP vs deferred

| Ship now (days) | Ship next (weeks) | Defer (months+) |
|---|---|---|
| Creator wizard (free, staged, challenging) | Scrape-only mini-audit (URL in, findings out — no OAuth) | GA / GSC / tool integrations |
| Business Pack output incl. Lovable prompt | Full audit behind signup | Mission Control weekly brief + subscription billing |
| £150 session booking (Stripe link + Calendly) | Email nurture from captured leads | Autonomy ladder / Admin (drafting, acting) |
| Email capture + saved workspace | | Email/task/project integrations |
| | | Standalone brand spin-out |

**Explicitly deferred: AI Business Admin.** It is the most differentiated part of the vision and the correct north star — and it is 12+ months of trust, security, and integration engineering away. It must not shape the MVP beyond one requirement: *everything writes to the Business Brain schema from day one*, so the Admin has memory to act on when it arrives.

---

## 7. Why pay instead of ChatGPT + Lovable?

Be brutally honest: for a one-shot "turn my idea into a website", ChatGPT + Lovable *is* good enough. You win on what a chat window structurally cannot do:

1. **Persistent structured memory.** ChatGPT forgets; the Business Brain accumulates. Week 40's advice knows what happened in weeks 1–39.
2. **Connected live data.** ChatGPT doesn't watch your analytics. Mission Control's recommendations are grounded in *your* numbers, automatically, weekly.
3. **Proactivity.** ChatGPT answers when asked. Mission Control shows up every Monday with "here's what changed and what to do." The blank prompt box is your enemy; the weekly brief is your moat against it.
4. **Opinionated methodology.** ChatGPT agrees with everyone. Your product *challenges* — the wizard pushes back on weak ideas the way a strategist would, using your frameworks. That's a design choice most AI products are too timid to make, and it's the product-shaped version of *you*.
5. **A human escalation path.** No other AI tool ends with "book an hour with the person who built this methodology."

## 8. The true competitive advantage

Sequenced honestly:

- **Now:** *Liz.* The personal brand, the methodology, and the paid human sessions. Nobody can copy that, and it converts before any software exists.
- **12 months:** *The accumulated Business Brains.* Switching costs from months of context, plus proprietary insight into what actually helps small businesses grow.
- **Long term:** *The autonomy ladder executed safely.* "The first employee you hire is an AI that already knows your whole business" — Creator and Mission Control are how it comes to know it.

The four-product framing obscured this. The one-platform framing makes it legible: **you are building an AI that knows one business better than anyone but its owner — and the four "products" are just the moments it proves it.**

## 9. Simplest launchable version (days)

**The Creator wizard + the £150 session.** Rationale:

- Zero integrations, zero OAuth, zero data plumbing — it's a staged prompt chain with a nice UI. Lovable can prototype it in a day or two.
- It matches your existing Option A/B spec almost exactly, so no rework.
- It generates revenue (sessions) and leads (emails) immediately.
- It starts the Business Brain corpus from day one.

The scrape-only mini-audit is the *second* release (a week later), because it opens Door B for the better-paying segment — but it needs a scraping/analysis pipeline the wizard doesn't.

## 10. Notes on the build-twice plan (Lovable → rebuild)

The prototype is disposable; **the data model is not.** Two rules for the PRD:

1. The **Business Brain JSON schema is canonical** and defined in the PRD, not improvised by Lovable. The rebuild imports the same records.
2. All business logic lives in **prompt templates and the schema**, not in Lovable-generated code. The rebuild then re-implements plumbing, not thinking.

→ Continue to `docs/PRD.md`.
