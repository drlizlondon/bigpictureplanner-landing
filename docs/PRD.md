# PRD — "Build a Business" V1: The Guided Conversation Widget
### v3.0 · July 2026 · supersedes v2.0 · strategy in `docs/STRATEGY.md` (§0)

---

## 1. What V1 is

A guided conversational experience **embedded in Liz's personal website**, built entirely in Lovable. It has exactly four jobs:

1. **Help someone build a business** — a warm, one-question-at-a-time conversation that takes a first-time founder from "I have an idea" to a shaped, priced, named business.
2. **Produce a beautiful Business Plan** — a single scrolling page at a private link, emailed to them.
3. **Generate a Lovable prompt** — one section of the plan; paste it, get a website.
4. **Offer the £150 strategy session as the natural next step** — at the end, never before.

**The software is the MVP.** The hypothesis under test is not "will people pay Liz" (known: yes). It is: **can an AI-guided conversation genuinely build enough confidence for someone to launch?** Every scope decision below serves measuring that.

**Not in V1:** accounts, login, dashboards, subscriptions, admin UI, audits, integrations, Mission Control, AI Business Admin. The Business Brain schema (§7) is populated silently as the only bridge to the long-term vision.

## 2. The validation instrument

Since confidence is the hypothesis, V1 measures it directly, woven into the conversation so it never feels like a survey:

- **Opening pulse (phase 1):** early in the welcome, a natural check-in with chips — *"Before we start — honestly, how does the idea feel right now?"* → `Just a daydream` / `Nervous, but serious` / `Ready — I need a push`.
- **Closing pulse (phase 7):** in the send-off, after the recap — *"And now — how does it feel?"* → free text plus chips.
- **Behavioural truth:** the plan page's **"I published my site 🎉"** button, and the £150 session booking. Stated confidence is a signal; publishing is the proof.
- **Transcript review:** every completed conversation emails Liz a summary + transcript link. Weekly review of where conversations sag, where challenges land badly, where confidence visibly turns — this is the product's tuning loop and the real research output of V1.

Success in 30 days of warm traffic: ≥50% of started conversations reach a delivered plan; ≥20% of plans confirm "published"; opening→closing pulse shifts positive in the clear majority; 5+ sessions booked *from the plan's next-step card*.

## 3. Target user & tone

Unchanged from v2.0: a first-time founder (mum returning to work, freelancer, healthcare professional, someone with an idea and no confidence), non-technical, nervous, arriving warm because Liz sent them. Zero jargon, zero friction before value, "I don't know" always valid, encourage by default, **2–3 earned challenges maximum**, never two questions in one message, never a visible step counter.

## 4. The experience

### 4.1 Embedding: an invitation, not a chat bubble

**No corner chat-bubble launcher** — that reads as customer support, the opposite of "someone sitting beside you." Instead:

- The **Build a Business** section of Liz's site contains an **inline conversation card, already started**: the guide's first message is visible on page load — *"So — what's the idea? Tell me in your own words. Messy is fine."* — above a real input box. Zero clicks between arriving and answering.
- On first user input, the card expands: full-screen takeover on mobile, a generous focused panel on desktop. Site navigation recedes; the conversation becomes the room.
- Above the card, only the promise and one line from Liz: *"Let's build your business. I built this guide to walk you through it — I'm at the end of it if you want me. — Liz"*
- **Resume without accounts:** a session token in localStorage; returning within 7 days re-opens the conversation where it left off, with a warm re-greeting that recalls their idea.

### 4.2 The conversation spine (unchanged from v2.0, restated)

Invisible seven-phase structure; the guide always knows what it still needs and moves on when the phase goal is met (~18–25 guide messages, 15–25 minutes):

1. **Welcome & the idea** — at ease; idea in their words; opening pulse; **mirror moment** (idea reflected back sharper than they said it).
2. **The person it's for** — from "everyone" to one vivid person; likely site of challenge #1.
3. **Why you** — their story and unfair advantage, which they usually can't see.
4. **The offer** — what they'll sell: format, deliverable, first price with plain-words rationale.
5. **The words** — name (working name fine), one-liner, tone; message pillars derived silently.
6. **The website** — the few facts copy needs (a customer story, what a visitor should do); copy generated, not dictated.
7. **The send-off** — recap of their arc (*"an hour ago this was 'I've always wanted to…' — now it's a business"*); closing pulse; *"Where should I send your plan?"* (the only email ask, at maximum earned trust); what happens next.

**Required delight moments** carry over as acceptance criteria: first 30 seconds about their idea; the mirror moment; explicit permission to be unsure; ≥2 callbacks to earlier details; ≥1 kind, specific challenge with an alternative offered; their own phrases visibly in the copy; the recap.

### 4.3 The Business Plan

A single beautiful scrolling page at `/plan/{token}` (long-random, unguessable, non-expiring), emailed on completion. Designed to be screenshotted with pride and forwarded — a friend who receives it sees a gentle "Start yours free" footer.

Sections: **1.** [Business name] masthead + one-liner · **2.** Your idea · **3.** Who it's for · **4.** Why you · **5.** Your offer (with price rationale in plain words) · **6.** Your words (messaging + tone) · **7.** Your website — full copy, then the **Lovable prompt** in a copy block with three steps ("Open lovable.dev → paste → publish") · **8.** Your first week — 7-item checklist; first post-publish item: *"Send your new website to one person who believes in you"*; the **"I published my site 🎉"** button (logs it; triggers a congratulations email) · **9.** **Go further** — the £150 session card.

### 4.4 The £150 session — natural next step only

The session appears in exactly two places, both *after* the free experience has delivered: the guide's send-off message and the plan's final card. Framing: *"Want to do the next round together? A live hour with me — we'll pressure-test everything you just built and finish with your site polished and published."* Stripe Payment Link → Calendly redirect; the plan token rides along in the booking notes so Liz reads the plan before the call. No custom payments or booking code. **The session does not appear on the landing card or early in the conversation** — leading with it would undercut the free promise and contaminate the validation.

### 4.5 Liz's view

No admin UI. Per completed conversation, one email to Liz: name, business name, one-liner, opening→closing pulse, plan link, transcript link, and a 3-line note on where they seemed most/least confident. Enables the one-line personal follow-up that is, at V1 volume, the best referral engine.

## 5. Lovable prompt generator

Unchanged: one self-contained prompt embedding the phase-6 copy verbatim, design direction from tone, single landing page with email capture + CTA, responsive, and the instruction not to rewrite the copy. Acceptance: pasted unmodified, Lovable yields a coherent site with the user's copy intact.

## 6. AI pipeline

- One phase-aware conversation engine: system context = Liz's methodology + tone rules + current phase goal + Brain-so-far. After each user message it converses **and** extracts structured fields into the Brain.
- Phase-completion gates guarantee a complete plan; challenge budget enforced in prompt logic.
- Discrete generation calls at phases 6–7 (copy, prompt, checklist, plan assembly), schema-validated; retry once, then graceful apology + Liz notification — never a dead end.
- All model calls server-side behind one provider-agnostic function; streamed responses; typing indicator; no silent wait >3s.

## 7. Business Brain schema

Canonical schema from v2.0 §8 stands verbatim (including the `confidence` block, now holding both pulses). Populated silently; `history` records phases and challenges; `future` reserved. **The schema and the methodology/prompt templates are what survive the rebuild — the Lovable code is disposable.**

## 8. Implementation scope — Lovable builds everything

One Lovable project (with Supabase), embedded into the personal site. Platform-agnostic shape, concrete V1 mapping:

| Piece | V1 implementation |
|---|---|
| App | Single Lovable project: conversation UI, `/plan/{token}` page, minimal landing wrapper |
| Embedding | The personal site's "Build a Business" section embeds the Lovable app (iframe/embed snippet, or links straight into it full-screen). The experience must be self-contained so the host site needs one line |
| AI calls | Supabase Edge Functions: `converse`, `assemble-plan`. API key in Supabase secrets — never client-side |
| Data | Supabase Postgres: `conversations` (session state, localStorage token), `brains` (JSONB, §7), `events`. Anonymous sessions expire after 7 days |
| Email | Edge function via Resend (or similar): plan delivery, Liz notification, publish congratulations |
| Payments/booking | Stripe Payment Link + Calendly links. Zero custom code |
| Events | `conversation_start`, `pulse_opening`, `phase_advanced`, `challenge_issued`, `email_captured`, `plan_delivered`, `plan_viewed`, `prompt_copied`, `pulse_closing`, `published_confirmed`, `plan_forward_visit`, `session_click` |
| Config | Methodology/tone context and per-phase prompts stored as editable data (Supabase table or config file), not buried in code — Liz tunes weekly without redeploying logic |

**Build order:** ① conversation UI + phase engine (phases 1–3) with extraction → ② phases 4–7 + pulses + email capture → ③ plan page + Lovable prompt + delivery emails → ④ publish loop, session cards, events → ⑤ embed on the personal site, transcript-review pass with Liz, open to warm traffic.

## 9. Risks

Carried from v2.0 (spine vs. wander; chatbot feel; prompt-grab-and-vanish; tone drift; token privacy) plus one new: **iframe embedding degrades the mobile experience** (keyboard/viewport issues). Mitigation: on mobile, the embed hands off to the full-screen app URL rather than conversing inside the frame — same experience, no iframe fragility.
