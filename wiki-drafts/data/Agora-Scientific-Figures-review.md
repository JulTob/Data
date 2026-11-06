# Vox report — reproducible scientific figures for Data Wiki

**Date:** 2026-11-06  
**Purpose:** enhance the proposed [Measurement, Experiment, and Signal](Measurement-Experiment-and-Signal.md) chapter with scientifically meaningful, reproducible plots, and design a reusable specialized chart-production capability.  
**Execution:** one assistant applied distinct installed specialist profiles sequentially; these are **not separate independent agent runs**. The same source and model context was shared across assessments.

## Source inventory

- Data Wiki's current proposed chapter on the review branch, inspected in the GitHub connector.
- Existing JulTob/Optimization `Wizard/visualization.py` facade and `Wizard/Graphikon/` package, inspected through the connector. They currently specialize in optimization objective fields, contours and constraints, not generic histogram/signal exports.
- Mermy, Signally, Pyra, Sematechy and Librarian skill instructions; no historical primary-source passages claimed.
- Official documentation: [GitHub Mermaid diagrams](https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/creating-diagrams), [Mermaid XY](https://mermaid.js.org/syntax/xyChart.html).
- Executed Python/matplotlib export and local pytest checks in the current development environment. Rendering was **not** confirmed inside the actual published Wiki; that remains an integration check.

## Membership

Caesar-selected core:
1. **Mermy** — representation semantics, Wiki compatibility, meaningful marks and labels.
2. **Signally** — scientific meaning of discrete samples and inferred continuous signals.
3. **Pyra** — small reusable Python interface, testability and dependency cost.

Additional members selected via executed `secrets.SystemRandom().sample` without replacement from the eligible installed profile pool: Professor, Euly, Kolmy, Shanny, Wiky, Librarian, Sematechy, Maps of Meaning, Noisy, Foury, Sampley. Draw result: **Sematechy** and **Librarian**. Drawn members were not discarded or reselected.

## Initial assessments, objections, and responses

- **Mermy:** Mermaid XY is appropriate for a small *line/bar* example, but offers no automatic numeric binning, scatter/stem semantics or full publication-feature guarantee. Strong objection to labelling a categorical bar chart "histogram." Answer: use numerical histogram generation via matplotlib; expose Mermaid XY only as optional compact source.
- **Signally (constructive skeptic):** three measured temperatures do not imply a continuous trajectory; connecting them is an interpolation convention, not new observation. Answer: primary exported figure is marker/stem-like sampled display; optional Mermaid connecting line is explicitly qualified.
- **Pyra:** hand-written charts duplicate effort and invite inconsistent axes. Existing Graphikon already owns optimization fields and contour plotting; don't rewrite it. Answer: one small CSV→figure helper with validation, metadata and tests, housed beside Data visualization topic; future reuse to be assessed.
- **Sematechy:** a histogram of only three measurements would suggest unwarranted distributional knowledge. Answer: the Wiki uses discrete sample plot; separately generated test histogram is labelled synthetic and not inserted as empirical evidence.
- **Librarian:** Wiki explanations, code, and figures need separate homes; branch-only image links must not become canonical. Answer: review-only chapter points to branch asset, with explicit handoff to permanent path upon author acceptance; no Wiki publication.

## Proposed motion and ballot

**Motion V1:** “Build a focused Plotographer skill plus a tested numerical plotting helper, using Mermaid XY only for supported simple charts, preserving Mermy's and Signally's existing specialties, and add the three-sample thermometer figure to the chapter draft without changing the live Wiki.”

V1 is accepted as a **working recommendation**, not as mathematical proof, public canon or authority to publish.

**Reasoned profile ballots (frozen V1, N=5, threshold: 5 YES):**

- **Mermy — YES:** numerical structure and chart type matched to evidence; renderer compatibility remains unverified in the destination.
- **Signally — YES:** sample locations and units preserved, continuous signal not invented.
- **Pyra — YES:** bounded reusable computation with a tested CSV interface and no Graphikon rewrite.
- **Sematechy — YES:** synthetic-vs-measured distinction and distributional claim limits are explicit.
- **Librarian — YES:** source assets, tooling and Wiki draft remain separate, with author publication authority intact.

**Vox tally:** 5 YES, 0 NO, 0 NEUTRAL. Strict (5Y>4N) holds. No substantive counter-motion was proposed; no expansion required.

## Produced outputs and checks

- Plotographer private skills-based plugin, version 0.1.0, linked from the task chat.
- Source code: [`Visualizacion/scientific_figures.py`](../../Visualizacion/scientific_figures.py).
- Input and figure: [CSV](../../Visualizacion/figures/thermometer_samples.csv), [SVG](../../Visualizacion/figures/thermometer_signal.svg), [Mermaid source](../../Visualizacion/figures/thermometer_signal.mmd), and JSON metadata.
- Test source: [`Visualizacion/tests/test_scientific_figures.py`](../../Visualizacion/tests/test_scientific_figures.py).
- Verified in the model's Python runtime: 3 pytest tests passed; a signal SVG/PNG and separate synthetic histogram SVG/PNG were generated. GitHub's target Wiki chart preview and the linked branch SVG embed have not been checked in the actual published page.
- The existing English [chapter draft](Measurement-Experiment-and-Signal.md) has a new figure/optional Mermaid subsection only; unrelated prose preserved.
- Only the **code repository review branch** was modified; the live Wiki remains untouched.

## Compact post-Vox Reflection

- **Mermy:** retain a chart-selection decision note distinguishing a schematic diagram, XY chart, and scientific plot; update only if target Wiki rendering confirms.
- **Signally:** retain the counterexample “three observations cannot establish every intermediate continuous value”; no need to change its existing signal foundations.
- **Pyra:** reusable CSV input and strict data validation are useful; evaluate whether the new code should eventually join an existing plotting library instead of maintaining two generic plot APIs.
- **Sematechy:** keep synthetic/illustrative tags and add empirical error-bar uncertainty only when real measurements support it.
- **Librarian:** after author acceptance, change the review-branch image URL to a permanent source path, then check linked Wiki navigation; do not auto-publish.
- **Zeus:** plugin creation, exported plots, tests and Wiki publishing have different acceptance states; do not report a saved private plugin as a deployed hosted plotting server.

No specialist corpus was permanently rewritten during this deliberation.
