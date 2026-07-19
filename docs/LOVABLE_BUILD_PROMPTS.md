# Lovable Build Prompts — "Build a Business" V1
### Companion to `docs/PRD.md` v3.0. Paste these into Lovable in order.

## How to use this file

1. **Create a new Lovable project** and connect **Supabase** when prompted (Lovable does this natively).
2. Open the project's **Knowledge** (project settings) and paste in the **Project Knowledge** block below. Lovable reads this on every prompt, so you don't repeat it.
3. Paste **Prompt 1**. Let it build. Click through the result and fix anything obvious with small follow-up messages ("the input box should focus automatically", etc.) before moving on.
4. Then Prompts 2 → 3 → 4 → 5, testing between each.
5. Before Prompt 2 works end-to-end you'll need to add your **Anthropic API key** as a Supabase secret (Lovable will prompt you, name it `ANTHROPIC_API_KEY`).

**Have ready before you start:**
- Anthropic API key
- Resend API key (free tier is fine) + the "from" email address
- Your Stripe Payment Link URL for the £150 session
- Your Calendly (or Cal.com) booking URL
- Your notification email address
- Your 1–2 sentence personal note and a photo

Replace every `[PLACEHOLDER]` before pasting.

---

## Project Knowledge (paste into Lovable's Knowledge, not the chat)

```
PRODUCT: "Build a Business" — a guided conversational experience helping a
first-time founder (e.g. a mum returning to work, a freelancer, a healthcare
professional) turn an idea into a real business. The goal is CONFIDENCE.
It is free; at the end it offers a £150 live strategy session with Liz.

THE EXPERIENCE: a friendly guide, not a chatbot and not a corporate wizard.
One question at a time. Warm, encouraging, practical, plain language, zero
business jargon (never say "positioning", "ICP", "funnel" to the user — say
"who it's for", "what makes yours different"). "I don't know" is always an
acceptable answer and the guide says so early. The guide challenges the user
at most 2–3 times in the whole conversation, always kindly, always about
something specific they said, always offering an alternative, always ending
in encouragement. Never two questions in one message. Never show a step
counter. The guide is honest that it's an AI guide that Liz built.

THE CONVERSATION has an invisible 7-phase spine. The guide always knows its
current phase and what it still needs to learn, and only advances when the
phase goal is met (~18–25 guide messages total, 15–25 minutes):
1. Welcome & the idea — put them at ease; hear the idea in their own words;
   an opening confidence check-in with 3 quick-reply chips ("Just a daydream" /
   "Nervous, but serious" / "Ready — I need a push"); then the MIRROR MOMENT:
   reflect their idea back to them sharper and clearer than they said it, and
   ask "did I get that right?"
2. The person it's for — move from "everyone" to one vivid person.
3. Why you — surface their story and unfair advantage.
4. The offer — what they'll sell: format, deliverables, a first price with a
   plain-words rationale.
5. The words — business name (working name is fine), a one-liner, tone of
   voice; derive three key messages silently.
6. The website — collect the few facts the copy needs (a customer story, what
   a visitor should do); then generate full website copy using the user's own
   phrases and story.
7. The send-off — recap their arc ("an hour ago this was 'I've always wanted
   to…' — now it's a business"); a closing confidence check-in; ask "Where
   should I send your plan?" (the ONLY email ask in the product); explain
   what happens next.

REQUIRED MOMENTS (acceptance criteria): first question is about their idea,
never contact details; the mirror moment; at least two callbacks to specific
earlier details; at least one earned challenge; their own words visibly in
the website copy; the recap.

OUTPUT: a "Business Plan" — one beautiful scrolling page at /plan/{token}
(long random unguessable token, no login), also emailed. Sections: business
name masthead + one-liner; Your idea; Who it's for; Why you; Your offer
(incl. price rationale); Your words (messaging + tone); Your website (full
copy, then a copy-to-clipboard Lovable prompt with 3 steps: open lovable.dev,
paste, publish); Your first week (7-item checklist — first post-publish item:
"Send your new website to one person who believes in you" — plus an
"I published my site 🎉" button); Go further (the £150 session card).

THE £150 SESSION appears ONLY in the guide's send-off and the plan's final
card. Never on the landing screen or early in the conversation.

DESIGN: warm, calm, personal, mobile-first. This is Liz's personal brand,
not a SaaS dashboard. Generous type, soft colours, feels like a
well-designed notebook, not a tech product. The plan page should be
something a person proudly screenshots and shows their partner.
```

---

## Prompt 1 — Foundation: conversation UI + phase engine

```
Build the core of "Build a Business" (see Knowledge).

PAGES
1. Landing page: the promise "Let's build your business.", a short personal
   note from Liz with photo placeholder ("[LIZ'S PERSONAL NOTE]"), and an
   inline conversation card that is ALREADY STARTED — the guide's first
   message is visible on load: "So — what's the idea? Tell me in your own
   words. Messy is fine." with a real text input directly beneath it. No
   chat-bubble launcher, no signup, no email ask. When the user sends their
   first message, the conversation expands to full-screen on mobile and a
   focused centered panel on desktop.
2. The conversation view: guide messages and user messages, a typing
   indicator, streamed-in guide responses if possible, quick-reply chips when
   the current guide message defines them, and a small persistent reassurance
   line: "No wrong answers — 'I'm not sure' is always fine."

BACKEND (Supabase)
- Tables:
  - conversations: id, session_token (random, also stored in localStorage so
    a returning visitor resumes within 7 days), phase, messages (jsonb),
    created_at, updated_at
  - brains: id, conversation_id, data (jsonb), created_at, updated_at
  - events: id, conversation_id, name, payload (jsonb), created_at
  - prompt_config: id, key, content (text) — seed it with a row
    key='methodology' containing the tone and phase rules from Knowledge, so
    Liz can edit the guide's behaviour without code changes
- Edge function `converse`: receives session_token + user message. It loads
  the conversation, the brain, and prompt_config, calls the Anthropic API
  (model: claude-sonnet-5, key from secret ANTHROPIC_API_KEY) with a system
  prompt assembled from: methodology config + current phase goal + the brain
  JSON so far. The model must return JSON: { reply, chips (optional),
  brain_updates (fields extracted from the user's message), phase_complete
  (boolean) }. Apply brain_updates to the brain, advance the phase when
  phase_complete, store everything, return the reply + chips to the client.
  If the model output fails to parse, retry once, then return a graceful
  apology asking the user to rephrase.
- The brain jsonb starts from this exact structure and the engine fills it in:
  { identity: {working_name, one_liner, category},
    customer: {target_description, problem, alternatives},
    founder: {unfair_advantage, time_per_week, ambition_12mo, story},
    positioning: {statement, differentiator, message_pillars, tone_of_voice},
    offer: {name, deliverables, price, price_rationale, primary_cta},
    website: {}, assessment: {risks, viability_note},
    confidence: {opening_pulse, closing_pulse, published_site: false},
    history: [] }
- Log events: conversation_start, pulse_opening, phase_advanced.

Implement phases 1–3 fully (welcome/idea with opening pulse chips and the
mirror moment; the person it's for; why you). Phases 4–7 come next.
```

## Prompt 2 — Phases 4–7, email capture, plan generation

```
Extend the conversation through phases 4–7 as defined in Knowledge (the
offer; the words; the website; the send-off with recap, closing pulse chips,
and the single email ask "Where should I send your plan?").

When phase 6 completes, a generation step in the `converse` edge function
produces full website copy as structured JSON into brain.website: hero
{headline, subheadline, cta}, problem, solution, offer_section, about, faq
(5 Q&As), footer_cta — written warmly, in the user's own phrases where
possible, no template filler.

When the user provides their email in phase 7:
- Validate it, store it on the conversation.
- Edge function `assemble-plan`: generates the remaining artefacts into the
  brain — (a) the Lovable prompt: ONE self-contained prompt that embeds the
  website copy VERBATIM, describes a single responsive landing page with an
  email capture form and the offer CTA, gives design direction derived from
  the brain's tone_of_voice, and explicitly instructs Lovable not to rewrite
  the copy; (b) a practical 7-item first-week launch checklist, item 1 after
  publishing: "Send your new website to one person who believes in you."
- Create a plan record with a 32+ character random URL token.
- The guide's final message links to the plan and says it's also been emailed.

Log events: challenge_issued (whenever the guide challenges), email_captured,
pulse_closing, plan_delivered.
```

## Prompt 3 — The Business Plan page

```
Build the /plan/{token} page: a single, beautiful, mobile-first scrolling
page rendering the brain, with the exact sections and order defined in
Knowledge (masthead → idea → who it's for → why you → offer → words →
website incl. copy-to-clipboard Lovable prompt with the 3 steps → first week
checklist with the "I published my site 🎉" button → the £150 session card).

- No login; the token is the access. Add noindex meta.
- The Lovable prompt block needs a prominent one-click copy button; log
  prompt_copied.
- "I published my site 🎉" sets brain.confidence.published_site = true, logs
  published_confirmed, and shows a warm congratulations state.
- The session card links to [STRIPE PAYMENT LINK URL] and mentions booking
  happens right after payment; append ?plan={token} where possible. Log
  session_click.
- A quiet footer: "Made with Build a Business — start yours free" linking to
  the landing page (this is the forwarded-plan referral path). Log
  plan_viewed with a referrer flag.
```

## Prompt 4 — Emails

```
Add transactional email via Resend (secret RESEND_API_KEY, from
[FROM EMAIL ADDRESS]):

1. Plan delivery (to the user, on plan creation): warm, short, from Liz's
   voice, subject like "Your plan for [business name] 🎉", one button to the
   plan, one line about the £150 session.
2. Liz notification (to [LIZ'S EMAIL], on every completed conversation):
   user name, business name, one-liner, opening → closing pulse, plan link,
   and a 3-line AI-written note on where the user seemed most and least
   confident. Include a link to view the full transcript (simple internal
   route protected by a token only this email contains).
3. Publish congratulations (to the user, when they click "I published"):
   genuinely celebratory, two sentences, reminder of checklist item 1 and a
   soft session mention.
```

## Prompt 5 — Polish pass

```
Polish pass against the acceptance criteria in Knowledge:
- Verify the required moments occur in a full test conversation: mirror
  moment, two callbacks, one earned challenge, user's phrases in the copy,
  the recap. Tune the methodology prompt_config if any are missing.
- Resume flow: returning within 7 days re-opens mid-conversation with a warm
  re-greeting that recalls the idea; expired/new visitors start fresh.
- Mobile: full-screen conversation, keyboard doesn't cover the input, plan
  page reads beautifully on a phone.
- Empty/edge states: model failure apology, invalid plan token page, email
  validation.
- Sub-3-second perceived response via streaming or typing indicator.
```

---

## After it's built

1. Run 3–5 full conversations yourself with real (or realistic) ideas. Edit the `methodology` row in `prompt_config` until the tone is genuinely *you* — this matters more than any feature.
2. Paste a generated Lovable prompt into a fresh Lovable project and confirm it produces a decent site with the copy intact. Tune the prompt-generator wording if not.
3. Embed on your personal site: link the "Build a Business" nav item to the app's URL (full-screen handoff — simplest and best on mobile), or iframe the landing section on desktop if you want it inline.
4. Send the first 10 warm people, read every transcript, tune weekly.
```
