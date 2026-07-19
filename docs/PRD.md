# PRD — "Build a Business" V1: The Guided First-Business Experience
### v2.0 · July 2026 · supersedes v1.0 · strategy in `docs/STRATEGY.md` (§0)

---

## 1. Summary

A free, conversational guided experience on Liz's personal website that helps a first-time founder turn an idea into a real business plan — concept, positioning, target customer, offer, pricing, website copy, brand messaging, a complete Lovable prompt, and a first-week launch checklist — delivered as a single beautiful **Business Plan** page. A £150 **"Build it with me"** session accelerates the same journey live with Liz.

**The objective is confidence, not automation.** The user should leave feeling that someone sat beside them and helped them think — and holding proof that their idea is real.

**Not in V1:** accounts, dashboards, audits, integrations, Mission Control, AI Business Admin, anything agentic. The Business Brain schema (§8) is populated silently as the only bridge to that future.

## 2. Goals & success metrics

| Goal | Metric | Target (first 30 days) |
|---|---|---|
| People start | Conversations begun | 100+ (warm traffic; Liz-directed) |
| People finish | Conversation → plan delivered | ≥ 50% |
| Confidence becomes action | "I published my site" confirmations | ≥ 20% of plans |
| Monetisation | £150 sessions booked | 5+ |
| Word of mouth | Plan links forwarded / referral visits | qualitative signal, tracked |

"Confidence" is operationalised as: *did they publish, and did they tell someone?* Both are measured (the checklist's publish button; the share prompt).

## 3. Target user

Someone who has never started a business: a mum returning to work, a freelancer, a healthcare professional, someone with an idea but no confidence. Non-technical. Nervous. Arriving warm — usually because Liz told them personally to come here.

**Design consequence:** zero jargon ("positioning", "ICP", "funnel" never appear in the user-facing experience — the guide says "who it's for", "what makes yours different"), zero friction before value, and no vocabulary that implies they should already know things.

## 4. Product principles

1. **Confidence is the product.** Every design decision is tested against: does this make a nervous first-timer feel more capable, or less?
2. **A guide beside them, not a form in front of them.** One question at a time, warm, in plain language. Never two questions in one message. Never a visible "Step 3 of 9".
3. **Honest about the AI, personal in framing.** Introduced as "a guide Liz built". No pretending to be human; no cold "AI assistant" framing either.
4. **Encourage by default; challenge sparingly.** Maximum 2–3 gentle challenges per conversation, each specific to what the user actually said, each ending in encouragement. One honest pushback proves the praise is real; constant pushback intimidates.
5. **"I don't know" is always a valid answer.** The guide says so early, and responds to uncertainty by offering suggestions to react to ("want me to have a go, and you tell me what feels right?").
6. **The plan is the artefact; the website is one section of it.** The Lovable prompt is never the headline.
7. **Conversation on the surface, spine underneath.** The guide always knows which phase it's in and what it still needs to learn; the user only ever experiences a natural conversation.

## 5. Experience specification

### 5.1 Entry: "Build a Business" page (on Liz's site)

- Navigation item on the personal website: **Build a Business**.
- Hero: the promise — *"Let's build your business."* Sub: for people who've always wanted to start something; free; about 20 minutes; you'll leave with a real plan and a website ready to launch.
- Liz's personal note (photo, 2–3 sentences: why she built this, honest mention that a guide she built will walk you through it).
- Primary CTA: **Start — it's free**. Secondary: **Build it with me — £150** (§5.5).
- No email, no signup, no barrier before the conversation.

### 5.2 The conversation

A single full-screen conversational UI. The guide speaks first. One question per message. Short quick-reply chips where they lower effort (e.g. "How much time can you give this each week?"), free text everywhere else. An always-visible, gentle reassurance line: *"No wrong answers — 'I'm not sure' is always fine."*

**Invisible spine — seven phases.** Each phase has a goal, the Brain fields it must fill, and permitted conversational moves. The guide moves on when the phase goal is met, not after a fixed question count. Total target: 15–25 minutes, roughly 18–25 guide messages.

| Phase | Goal | Fills (Brain §8) |
|---|---|---|
| 1. Welcome & the idea | Put them at ease; hear the idea in their own words; **mirror moment** (§5.3) | `intake`, `identity.one_liner` (draft) |
| 2. The person it's for | Get from "everyone" to one vivid person; likely site of challenge #1 | `customer.*` |
| 3. Why you | Surface their story and unfair advantage — they usually can't see it themselves | `founder.*` |
| 4. The offer | Shape what they'll actually sell: format, deliverable, first price with rationale | `offer.*` |
| 5. The words | Business name (or working name), one-liner, tone; message pillars derived silently | `identity.*`, `positioning.*` |
| 6. The website | Confirm the few facts copy needs (a favourite customer story, what visitors should do); copy itself is generated, not dictated | `website.*` |
| 7. The send-off | Recap what they've built (their arc, reflected back); ask where to send the plan; set up what happens next | `owner.email`, plan delivery |

**Email capture** happens only in phase 7, conversationally: *"I've put your whole plan together. Where should I send it?"* — a human question at the moment of maximum earned trust, not a gate.

### 5.3 Required delight moments (acceptance criteria, not aspirations)

1. **First 30 seconds are about them.** The first question is about their idea — never contact details.
2. **The mirror moment (phase 1).** After hearing the idea, the guide reflects it back sharper than they said it: *"So — [their idea, elevated, in one clean sentence]. Did I get that right?"* This is the moment they decide to stay.
3. **Callbacks.** At least twice, the guide references a specific earlier detail (*"you said you spent ten years in nursing — that belongs on your About page"*). Proof of listening.
4. **One earned challenge.** At least one specific, kind pushback with a reason and a proposed alternative, ending in encouragement.
5. **Their words in the copy.** Website copy visibly contains their story and phrases, not template text.
6. **The recap (phase 7).** Before delivery, the guide narrates their arc: *"An hour ago this was 'I've always wanted to…'. Now you have [name], for [person], offering [offer] at [price]. That's a business."*

### 5.4 The Business Plan (output)

A single, beautiful, scrolling page at a private tokenized URL (`/plan/{token}`), also emailed. **No login.** Designed to be screenshotted and shown to a partner with pride.

Sections, in order:
1. **[Business name]** — masthead with the one-liner.
2. **Your idea** — the concept, sharpened.
3. **Who it's for** — the vivid customer description.
4. **Why you** — their story as an asset.
5. **Your offer** — what, format, price, and the price rationale in plain words.
6. **Your words** — messaging: one-liner, three key messages, tone.
7. **Your website** — the full copy (hero, problem, solution, offer, about, FAQ, footer), then the **Lovable prompt** in a copy-friendly block with three plain steps ("Open lovable.dev → paste → publish"). Prompt spec unchanged from v1 (§7).
8. **Your first week** — a 7-item practical launch checklist. Item 1 after publishing: *"Send your new website to one person who believes in you."* Includes an **"I published my site 🎉"** button (logs the confirmation; triggers a congratulations email from Liz's address).
9. **Go further** — the £150 session card: *"Want to do the next round of this together?"*

The plan link is deliberately forwardable — a friend who receives it lands on Liz's branded experience with its own "Start yours free" CTA.

### 5.5 "Build it with me" — £150 session page

- What happens in the 60 minutes: refine the business together, sharpen who it's for, improve the offer, challenge what needs challenging, and leave with a polished website ready to publish. Framed as **an acceleration of the free experience** — same journey, faster and with Liz.
- Who it's for / not for. Liz's credibility, warmly.
- **Book & pay:** Stripe Payment Link (£150) → redirect to Calendly/Cal.com. Zero custom booking code.
- If a Business Plan token is present (arriving from a plan page), it's attached to the booking notes so Liz reads the plan before the call.
- **This page ships on day 0, before the conversation exists.**

### 5.6 Liz's view (no admin UI in V1)

On every completed conversation, an email to Liz: user's name, business name, one-liner, plan link, and a 3-line summary flagging where they seemed most and least confident. This is the funnel review, the session-prep pipeline, and the trigger for optional one-line personal follow-ups — V1 volumes make a dashboard unnecessary.

## 6. AI pipeline requirements

- **One conversation engine, phase-aware.** System context = Liz's methodology + tone rules (§4) + current phase goal + Business Brain so far. The engine both converses and **extracts**: after each user message, it updates Brain fields (structured extraction, not free-text accumulation).
- **Phase-completion check** decides advance/stay; a phase may not be skipped with its required fields empty (the spine guarantees a complete plan).
- **Challenge budget** enforced in prompt logic: 2–3 per conversation, only where the user's actual input is weak, always with a proposed alternative.
- **Generation moments:** website copy, Lovable prompt, checklist and plan assembly are discrete generation calls at phase 6–7, validated against the schema (retry once on parse failure; graceful apology + Liz-notification on second failure — never a dead end for the user).
- Provider-agnostic call layer as before (`generate(...)` / `converse(...)`); all calls server-side; default latest Claude model.
- Latency: streamed responses; typing indicator; no silent wait > 3s.
- Abandoned conversations with a captured email (rare, since email is late): none in V1 — abandonment before phase 7 simply expires with the anonymous session after 7 days.

## 7. Lovable prompt generator

Unchanged from v1.0: one self-contained prompt with business context, full page structure embedding the phase-6 copy verbatim, design direction derived from tone, functional requirements (single page, email capture, CTA, responsive), and the explicit instruction not to rewrite the copy. Acceptance: pasted unmodified into Lovable, yields a coherent site with the user's copy intact.

## 8. Business Brain schema (canonical — unchanged, populated silently)

The schema from PRD v1.0 §8 stands verbatim, with `meta.source: "creator"` and one addition:

```jsonc
"confidence": {
  "self_reported_start": "string|null",   // how they described their confidence early on, if surfaced
  "published_site": false,
  "published_at": null,
  "shared_plan": false
}
```

The conversation engine writes to this schema as its extraction target. `history` records phase transitions and challenges issued. `future` remains reserved for audit/Mission Control/Admin. **This schema, not the Lovable code, is what survives the rebuild.**

## 9. Architecture (platform-agnostic)

- **Client:** the Build a Business page, conversation UI, plan page, session page. Mobile-first — this audience is on phones in the evening.
- **API:** anonymous conversation sessions (server-held state), `converse` endpoint, plan assembly + tokenized delivery, email send (plan to user; summary to Liz), event logging. **No auth system.** Plan tokens are long-random, unguessable, non-expiring.
- **Storage:** Postgres/Supabase — `conversations` (session state), `brains` (JSONB, schema §8), `events`. Anonymous sessions expire after 7 days if no email was captured.
- **Email:** transactional provider (Resend or similar); plan email + Liz notification + publish-congratulations.
- **Payments/booking:** Stripe Payment Link + Calendly. No custom code.
- **Events:** `conversation_start`, `phase_advanced`, `challenge_issued`, `email_captured`, `plan_delivered`, `plan_viewed`, `prompt_copied`, `published_confirmed`, `plan_forward_visit`, `session_click`, `session_booked` (manual for V1).

## 10. Out of scope (V1)

Accounts/login, dashboards (user or admin), URL audits, GA/GSC/tool integrations, Mission Control, subscriptions, AI Business Admin or any drafting/acting behaviour, multiple businesses per user, teams, custom booking/payments, standalone brand/domain.

## 11. Risks & mitigations

| Risk | Mitigation |
|---|---|
| Conversation wanders; user leaves without a complete plan | Invisible spine with per-phase required fields; no phase skips |
| Guide feels like a chatbot | Mirror moment, callbacks, and challenge budget as hard acceptance criteria; Liz reviews transcripts weekly and tunes the methodology context |
| Free plan is so complete the session feels redundant | Session framed as acceleration with Liz personally; session card appears at the moment of momentum (end of plan) |
| Users grab the Lovable prompt and vanish | Plan framing (prompt is section 7 of 9); email captured before delivery; checklist + congratulations loop |
| Tone drifts intimidating or sycophantic | Tone rules in versioned methodology context; challenge budget; explicit "never two questions at once" rule |
| Plan link privacy | Unguessable tokens; no indexing; forwarding is a feature, not a leak — nothing sensitive beyond what the user chose to share |

## 12. Build order

1. **Day 0:** Build a Business page + £150 session page with live Stripe/Calendly — revenue and validation before any software.
2. Conversation UI + phase engine (phases 1–3) with extraction into the Brain.
3. Phases 4–7 + email capture + plan assembly.
4. Business Plan page + Lovable prompt generator + delivery emails (user + Liz).
5. Publish confirmation loop + event logging.
6. Transcript review pass with Liz; tune methodology context; launch to warm traffic.
