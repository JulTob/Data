# Proposed minimal corrections to 1. Probability

**Status:** draft for review only; the actual Wiki is read-only to agents.
**Live target:** https://github.com/JulTob/Data/wiki/1.-Probability
**Inspected:** 6 November 2026, published page showing 21 revisions at the time of review.
**Objective:** preserve the mapmaking metaphor, designed representation with objective consequences, chess analogy, choice of *plausible*, playlist and Alice/Bob.

## 1. Zero probability

**Anchor:** Under "Probability: Mapping the Unknown", find "An event assigned probability zero is not necessarily impossible." Retain it. Replace the following two sentences:

> Within that model, the event receives zero probability weight. We may call it _implausible under the model_, but this does not necessarily exclude it from the space of possible outcomes.

**Reason:** A singleton can be in an atomless continuous sample space and have probability zero.

## 2. Prediction and validation

**Anchor:** Under "From Data to Uncertainty", replace the paragraph from "Probability measures how plausible outcomes are..." to "We validate our models, also called theories, through experiments."

> Probability assigns weights to events within a model, and these weights can guide predictions. When a model's predictions repeatedly agree with relevant observations, this supports its usefulness, but does not prove that the model is true. We test a model not only by whether it predicts an outcome correctly, but also by how well its stated probabilities agree with observed patterns over repeated trials.

**Reason:** repeated correct categorical guesses are not sufficient to establish accurate probabilistic predictions. Also, models and scientific theories are not synonyms.

Replace "Not to describing the world..." with:

> We do not attempt to reproduce the whole world. We use probability to describe how events fit our selected model of it.

## 3. Sample-space language and probability bounds

**Anchor:** paragraph beginning "By convention, probabilities are real numbers between 0 and 1."

> A probability model assigns each event a number between 0 and 1. A probability of 0 gives the event no weight, while a probability of 1 makes it certain __within the model__, not necessarily an observed fact.

Preserve the bounds equation.

**Anchor:** paragraph beginning "Our model also requires to ponder 'all considerable events'."

> We first decide what outcomes the model can distinguish. Together, these form a __sample space__, written $\Omega$. We need not list every detail of reality: we need to specify the possible answers relevant to our question. An __event__ is a set of such outcomes.

Preserve $P(\Omega)=1$.

**Anchor:** "In this analogy your map is inside Ω."

> In this analogy, $\Omega$ contains the admissible answers to our question. The probability model is the map that assigns weights to events drawn from those answers.

## 4. Keep the playlist, finish the example

Move the existing "An outcome is a single point on our map of possibilities..." paragraph and its two formulas **to immediately after the playlist table and before "Let A mean..."**, so the concept is defined before the union formula.

Tighten that paragraph only if desired:

> An __outcome__ is one result of our Shuffle, such as "I Want to Break Free". An __event__ is a group of outcomes defined by a question: the event "a song by Queen" contains {"Bohemian Rhapsody", "I Want to Break Free"}. We choose those questions when designing our model. Once a result is observed, whether it belongs to an event follows from the definitions we chose.

```math
\omega\in\Omega,\qquad A\subseteq\Omega
```

Keep the current artists and genres, filling the Year column using the **earliest album/track release**, not the later single release:
- Bohemian Rhapsody: **1975**
- In the End: **2000** (album *Hybrid Theory*; single issued 2001)
- I Want to Break Free: **1984**
- Mamma Mia: **1975**
- Wake Me Up: **2013**
- Lose Yourself: **2002**

Keep $A$ = rock and $B$ = released before 2000; change the following "Classic Rock" to **Rock** to match the definition.

Before using numerical probabilities, add:

> For this example, suppose Shuffle gives each of the six tracks the same chance of playing next.

After the already-correct formula for the union:

> Here, $A$ contains three rock tracks, $B$ contains three songs released before 2000, and $A\cap B$ contains two songs: both Queen tracks. Thus, under our equally likely Shuffle model:

```math
P(A\cup B)=\frac36+\frac36-\frac26=\frac46=\frac23.
```

> The union formula does not require independence.

**Check:** $A$ = {Bohemian Rhapsody, In the End, I Want to Break Free}; $B$ = {Bohemian Rhapsody, I Want to Break Free, Mamma Mia}. The union has four tracks. Actual app shuffle policies may not be uniform.

## 5. Alice and Bob — time vs information

The existing Alice/Bob paragraphs already explain that an event can have happened while Bob is still uncertain. **Keep them**. Replace only the final paragraph starting "That is why we can't say a single coin toss..." because its unconditional claim that $P(\mathrm{Heads})=1$ conflicts with Bob's information state.

> Once Alice reliably observes heads, she can update her model using that observation. The probability of heads __conditional on her observation__ becomes one. Bob, without that observation, may still assign one-half under a fair-coin model. The outcome did not change: only the information available to each observer did.

```math
P(H\mid \text{observed }H)=1
```

> Probability does not simply describe what has not yet happened. It helps us reason about what we do not yet know.

## Out of scope

Do not turn this introduction into a chapter on Bayes, odds, betting, entropy or density. Those can remain linked later drafts. Leave the opening "Probability measures our opinion of the world" and the chess/mapmaker analogies intact.

## Source and review notes

- Source page: https://github.com/JulTob/Data/wiki/1.-Probability (read on 2026-11-06)
- Year checks: https://www.officialcharts.com/songs/queen-bohemian-rhapsody/ ; https://www.officialcharts.com/songs/queen-i-want-to-break-free/ ; https://abbasite.com/discography/ ; https://linkinpedia.com/wiki/Hybrid_Theory ; https://www.officialcharts.com/songs/avicii-wake-me-up/ ; https://musicbrainz.org/release-group/88df7110-f219-3821-83b8-56443eaa34c3
- The page may change again; compare the latest Wiki revision before manually merging.
- This branch file is a proposed patch, not a published Wiki page.
