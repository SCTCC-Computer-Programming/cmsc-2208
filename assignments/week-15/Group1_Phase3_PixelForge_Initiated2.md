# PixelForge Studios — Second Initiated Communication to Group 1 (Phase 3)

---

From: PixelForge Studios
Subject: Something We Need to Talk Through

Hello,

We are following up on our last message, which we have not heard back on yet. We wanted to flag a second issue that came up this week as well.

One of our programmers was looking through the Phase 2 materials you submitted and had a question we could not answer ourselves. Your design has players submitting bug reports and feature requests directly through a GitHub repository. He pointed out that for players to create issues on a GitHub repo, that repo would need to be public.

We looked into this and realized we are not comfortable with that. A public repo means anyone can see our code, our internal issue history, our development discussions, and whatever bugs are sitting open at any given time. That includes bugs we have not patched yet, which is exactly the kind of thing we would not want public before a fix is out. It also means people could see the internal back and forth on feature decisions, which is not something we want players reading.

We understand the intent was to make it easy for players to submit reports, and we appreciate that. But we need to understand how this works without exposing everything we are doing internally. This feels like something that needs to be resolved before the design goes any further.

We are still waiting to hear back on the developer workload question from our last message as well.

Let us know.

Best,
PixelForge Studios

---

# Instructor Notes (do not send)

## Purpose and Framing

This is the second client-initiated communication to Group 1, sent because no response was received to the first. The escalation is natural and realistic — a client who has flagged one concern and received no response would follow up, and would be more direct in tone the second time.

The public repository issue is drawn directly from Group 1's Phase 2 use case descriptions, which state explicitly that players submit bug reports and feature requests by creating issues on a GitHub repository, and that players can create issues on the repo. This requires the repository to be public, which directly contradicts PixelForge's confirmed access control requirements.

## The Specific Gap This Targets

Group 1's Phase 2 design routes public player submissions through a public GitHub repository. Their confirmed access requirements state that external playtesters should not be able to see the internal bug list or discussions, and that internal information should be protected from public access. A public GitHub repository makes the codebase, all open issues, all closed issues, development discussions, and internal comments visible to anyone.

This creates friction across multiple Phase 3 deliverables:

Part 1 — Their interface requirements need to distinguish between a public-facing intake mechanism and the internal system. How players submit reports without seeing internal content needs to be specified.

Part 2 — Their data model needs to address how public submissions are received and filtered before entering the internal system. The current design flows directly from player submission into GitHub Issues with no separation.

Part 3 — Their architecture needs to address whether they maintain separate public and private repositories, use a different intake mechanism for public submissions, or handle the separation at the Google Forms/Apps Script layer rather than directly in GitHub.

Part 4 Security — A public GitHub repository has implications for the security levels they need to address in Part 4D.

## What a Strong Response Looks Like

A strong response acknowledges both outstanding concerns, asks clarifying questions if needed to scope the public/private separation problem, and does not simply promise that it will be fixed without demonstrating they understand why it is a problem. A weak response addresses only the newer concern and ignores the developer workload issue, or treats this as a simple configuration fix without recognizing the design implications.

## Tone Note

This email is noticeably more direct than the first. PixelForge explicitly references the unanswered prior message and closes without the usual warm closing. This is appropriate given that a client who has raised two concerns and heard nothing would be less patient the second time. The tone should be maintained in any response PixelForge sends to Group 1's reply, calibrated to how substantively they address both issues.

## Consistency Note

This concern is fully consistent with the access control structure confirmed throughout the engagement. PixelForge has repeatedly stated that external playtesters should not be able to see internal bugs or discussions, and that internal information should be protected. The public repository issue is a direct consequence of Group 1's design choice, not a new constraint being introduced.
