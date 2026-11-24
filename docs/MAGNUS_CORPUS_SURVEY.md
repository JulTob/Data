# Magnus Corpus — Repo Survey

*A survey of the current state of [`JulTob/Data`](https://github.com/JulTob/Data), read against a proposed evolution into a "Magnus Corpus": a curious‑teen path from zero to data scientist, covering data science beyond pure statistics (information theory, fuzzy numbers, signals and systems, advanced math/engineering), published on GitHub Pages with executable, editable code embedded in the book.*

This document is a survey only. It proposes no rewrites of book content.

---

## 1. Repo tree at a glance

Top level of the working tree (`main`):

```
Data/
├── _quarto.yml                     # site generator config (Quarto book)
├── index.qmd                       # book front page
├── README.md                       # 3 lines: title + live URL
│
├── sample-space/                   # Part: "Sample Space" (7 chapters, English)
│   ├── index.qmd
│   ├── maps-and-reality.qmd
│   ├── randomness-and-pattern.qmd
│   ├── types.qmd
│   ├── outcomes-and-events.qmd
│   ├── finite-and-infinite.qmd
│   └── kolmogorov.qmd
│
├── statistics/                     # Part: "Statistics"
│   ├── index.qmd
│   ├── statistical-thinking.qmd
│   ├── variation.qmd
│   ├── uncertainty.qmd
│   ├── statistical-modeling.qmd
│   ├── statistical-methods.qmd
│   └── distributions/
│       ├── index.qmd
│       ├── normal.qmd
│       ├── student.qmd
│       ├── lognormal.qmd
│       ├── pareto.qmd
│       ├── binomial.qmd
│       └── poisson.qmd            # (present but NOT listed in _quarto.yml)
│
├── .github/workflows/pages.yml     # single workflow: build + deploy to Pages
│
│  # -- legacy / unwired course material (not part of the book) --
├── Analysis_Guide.ipynb            # notebooks at repo root
├── Charts.ipynb
├── GaussianCalculator.ipynb
├── P4_Analisis_Completa.ipynb
├── P4_Analisis-Wind.ipynb
├── SQL.ipynb
├── Visualizacion.ipynb
├── Analisis/Analisis_P3.ipynb
├── Markov/Problema_1.ipynb
├── Visualizacion/U4_2_2_…_Geoespacial.ipynb
├── PD/Practica2.txt   PD/HR/*.csv
├── DataBases/data.sqlite  DataBases/*.md  DataBases/JulioToboso-PracticaSQL.ipynb
├── CSVs/*.csv
├── RData/EPA_2026T1 (1).RData
└── libs/Signal.py                  # small custom Signal class (probability signals)
```

Missing / referenced-but-absent:

- `_quarto.yml` lists `sample/sampling.qmd`. Neither the `sample/` directory nor the file exists. The most recent CI run (`Rename sample.qmd to sampling.qmd in chapters`, 2026‑09‑14) **failed** on `ERROR: Book chapter 'sample/sampling.qmd' not found`, so the live site at <https://jultob.github.io/Data/> is served from the previous successful build. This is the first bug to fix before anything else is added.
- `statistics/distributions/poisson.qmd` exists on disk but is not listed in `_quarto.yml`, so it does not appear in the book's TOC even when the build succeeds.
- There is no `docs/`, no `_config.yml`, no `mkdocs.yml`, no `book.toml`, no `package.json` — the project is a pure Quarto book.

---

## 2. Existing content — topics, depth, audience, language

**Language.** Book chapters (`.qmd`) are in English. The unwired notebooks and data (`Analisis/`, `Visualizacion/`, `PD/`, `DataBases/`, `CSVs/`, `RData/`) are in Spanish and appear to be coursework artefacts from UMH classes ("Fund. de Bases de Datos", "Prácticas") rather than book chapters.

**Register.** The prose is essayistic and philosophical — closer to a "philosophy of measurement" than a textbook. Headings often lead with a symbolic marker (🏵 for a core idea, 🔰 for a beginner cue, 💡 for exploration). Formulas are set in LaTeX inline math. Diagrams are Mermaid.

**Structure (as declared in `_quarto.yml`).**

| Part | Chapter | Lines | Feel |
|---|---|---:|---|
| — | `index.qmd` | ~40 | Overture: "data is the trace the world leaves." |
| Sample | `sample/sampling.qmd` | **missing** | Referenced but absent — breaks CI. |
| Sample Space | `sample-space/index.qmd` | 57 | Why possibilities before probabilities. |
| " | `maps-and-reality.qmd` | 92 | Models leave things out on purpose. |
| " | `randomness-and-pattern.qmd` | 107 | Order at scale from disorder at a point. |
| " | `types.qmd` | 127 | Sets need types; a soft intro to structure. |
| " | `outcomes-and-events.qmd` | 111 | Distinguishing an outcome from a set of outcomes. |
| " | `finite-and-infinite.qmd` | 114 | Countable vs continuous sample spaces. |
| " | `kolmogorov.qmd` | 187 | The triple $(\Omega, \mathcal{A}, \mathbb{P})$. |
| Statistics | `statistics/index.qmd` | 61 | Statistics as reading traces after the fact. |
| " | `statistical-thinking.qmd` | 209 | Framing questions before formulas. |
| " | `variation.qmd` | 273 | Variation as first-class citizen. |
| " | `uncertainty.qmd` | 213 | Kinds of uncertainty. |
| " | `distributions/index.qmd` | 382 | Distributions as shapes of possibility (has 1 python block). |
| " | `distributions/normal.qmd` | 213 | |
| " | `distributions/student.qmd` | 204 | |
| " | `distributions/lognormal.qmd` | 183 | |
| " | `distributions/pareto.qmd` | 190 | |
| " | `distributions/binomial.qmd` | 235 | |
| " | `distributions/poisson.qmd` | 548 | Present, unlisted; ends with a python check block. |
| " | `statistical-modeling.qmd` | 306 | |
| " | `statistical-methods.qmd` | 297 | |

**Depth.** The prose is thoughtful but assumes some mathematical maturity by the end of the Sample Space part (sigma‑algebras, countable vs uncountable, measure). This is fine for an "elevated" reader; it is *not* a zero‑to‑hero staircase for a curious teen yet. The philosophical framing is a real asset — it is much better than typical intro material — but the missing rungs (from arithmetic to sets, from sets to measure, from measure to inference) will need to be added, not replaced.

**Audience today.** A motivated undergraduate or a self‑studying reader who already accepts abstraction. Not yet a 14‑ to 17‑year‑old with no prior probability.

**Coverage today.** Sample spaces, events, a handful of named distributions, general statements about modelling and methods. There is nothing yet on: information theory, entropy, fuzzy sets/numbers, signals and systems, Fourier/Laplace, linear algebra, calculus, optimisation, causal inference, computation, data cleaning, SQL, visualisation-as-craft, machine learning, or applied engineering. (Some of these live as loose Spanish notebooks at the repo root, but are not part of the rendered book.)

---

## 3. How publishing works today

**Generator.** [Quarto](https://quarto.org) in `book` project type.

```1:12:_quarto.yml
project:
  type: book
  output-dir: _book

book:
  title: "Data"
  author: "Julio Toboso"
  chapters:
    - index.qmd
    - part: "Sample"
      chapters:
        - sample/sampling.qmd
```

Output goes to `_book/` (HTML), theme is `lux`, code copy is on, code folds are shown by default.

**Deploy pipeline.** A single workflow `.github/workflows/pages.yml`:

1. Installs Python + `numpy matplotlib ipywidgets jupyter nbformat pandas plotly` (needed so `{python}` blocks execute at render time).
2. `actions/checkout@v4`.
3. `quarto-dev/quarto-actions/setup@v2`.
4. `quarto render` — this produces `_book/`.
5. `actions/upload-pages-artifact@v4` with `path: _book`.
6. A second job `deploy` runs `actions/deploy-pages@v4`.

So GitHub Pages is configured in **"GitHub Actions" source** mode (not the classic `docs/` or `gh-pages` branch mode). The site is <https://jultob.github.io/Data/>.

**Two small workflow smells.**

- The `Install Python dependencies` step appears twice under different names; the first one runs before checkout, so it operates on an empty workdir — harmless but confusing.
- Node 20 deprecation warnings from `actions/checkout@v4` in the log; nothing broken yet but worth noting.

**Current build status.** Red. The 2026‑09‑14 push introduced `sample/sampling.qmd` into the TOC without creating the file, and Quarto errors out. The live site is a stale successful build.

**Execution semantics.** `_quarto.yml` sets `execute: execute-notebooks: auto`. That key is not a documented Quarto option — the standard controls are `execute.freeze` and `execute.enabled`. In practice Quarto is defaulting: `{python}` cells run at render time and their outputs (e.g. Plotly figures) are baked into the static HTML. **Readers cannot edit or re‑execute code in the browser.**

---

## 4. Existing interactive / executable code features

Short answer: **almost none, and none client‑side.**

- **Static Plotly figures.** `statistics/distributions/index.qmd` has one `{python}` block that renders a Plotly figure of a histogram converging to a density. The block is executed at build time; the reader sees an interactive Plotly *chart* (hover, zoom) but cannot change the code, the sample size, or the seed.
- **Static Python check.** `statistics/distributions/poisson.qmd` has a `{python}` block that computes a single Poisson probability. Output is inlined.
- **Mermaid diagrams.** Several `{mermaid}` blocks in Poisson and a few other files — rendered as static SVG.
- **No Thebe, no JupyterLite, no Pyodide, no Observable/OJS runtime, no Colab / Binder / Codecademy‑style embeds, no live REPL.**
- **No `launch in Colab` badges** on the loose root‑level `.ipynb` files.
- **No exercise or auto‑grading harness.**

The word "interactive" in the current book refers only to Plotly's hover/zoom, not to code the reader can run or rewrite.

---

## 5. Gaps vs. the "Magnus Corpus" vision

Grouped by concern, with the CI blocker first.

**Blockers.**

1. Broken chapter reference in `_quarto.yml` (`sample/sampling.qmd`) — CI has been failing since 2026‑09‑14; deploys are frozen. Must be fixed before any additive work matters.
2. Orphan file `statistics/distributions/poisson.qmd` not listed in the TOC.

**Curriculum reach.**

3. No on‑ramp for a curious teen: nothing on numbers, arithmetic, algebra as symbol‑pushing, functions, or plots as a way of thinking.
4. No **information theory** (entropy, mutual information, coding, KL, cross‑entropy).
5. No **fuzzy numbers / fuzzy logic** (membership functions, t‑norms, α‑cuts).
6. No **signals and systems** (sampling, aliasing, LTI, convolution, transforms). `libs/Signal.py` is a small probability‑signal class but not tied into the book.
7. No **linear algebra**, **calculus refresher**, **optimisation**, or **numerical methods** chapters.
8. No **causal inference**, **experimental design**, **Bayesian reasoning** past a passing mention, or **ML** (regression, trees, neural nets, embeddings).
9. No **data engineering** thread: files, formats, tidy data, SQL as a language, joins, cleaning, missingness, unit checks. SQL and DB material exists in Spanish notebooks but is unlinked.
10. No **visualisation-as-craft** chapter (grammar of graphics, encodings, honest charts).
11. No **project chapters** (mini investigations end‑to‑end from question to conclusion).

**Pedagogy & interactivity.**

12. Code in the book is currently *read‑only*. The stated goal ("code‑in‑the‑book, Colab/Codecademy‑style execute + rewrite") requires a client‑side runtime or a one‑click "open in Colab/Binder" affordance. Neither exists.
13. No exercises with checks, no hints/reveals, no per‑chapter "try this" scaffolds beyond prose prompts.
14. No glossary, no index, no cross‑references between the philosophical prose and the operational code.
15. No consistent difficulty markers or prerequisites metadata per chapter (the 🔰/🏵/💡 markers are used but not formalised).

**Site / project hygiene.**

16. README is 3 lines. There is no contributor guide, no style guide for chapter prose, no plan document, no license file.
17. The Spanish notebooks and datasets at the repo root are valuable raw material but they are unsorted; over time they should either move into an `archive/` folder or be reworked into chapter datasets in a `data/` folder.
18. `_quarto.yml`'s `execute-notebooks: auto` line is not a real Quarto key; it should be replaced with `execute: freeze: auto` (or explicit per‑file `freeze`) so that CI stops re‑executing everything on every push.
19. The Pages workflow installs Python packages before `actions/checkout`; the duplicated step should be collapsed.

---

## 6. Recommended tech options for interactive code + book (fit to this stack)

The book already renders through Quarto. That is the anchor. The three options below preserve that anchor and add client‑side execution and/or one‑click hosted execution.

### Option A — Quarto + Pyodide via a client-side runtime (Quarto Live / `quarto-pyodide`)

**What.** A Quarto extension turns `{pyodide}` (or `{pyodide-python}`) blocks into editable, runnable cells that execute in the reader's browser via [Pyodide](https://pyodide.org). No server. First‑cell click downloads the interpreter (~10–30 MB depending on packages), subsequent cells are instant.

**Pros.**
- Zero infrastructure. Still just a static site on GitHub Pages.
- Reader can *edit and rerun* — this is the Codecademy‑style rewrite the vision asks for.
- Plays natively with Quarto; no second toolchain.
- Works offline once the page is loaded.

**Cons.**
- Initial load is heavy; must lazy‑load and warn.
- Not every Python package is available in Pyodide (most numeric stack is, but heavy ML frameworks are limited).
- Debugging is per-browser.

**Effort.** Small. Add the extension, replace some `{python}` blocks with `{pyodide}`, add a first‑page "warm up" note. First real chapter with live code could ship without touching the deploy pipeline.

### Option B — Quarto + Thebe/Binder (server‑backed live cells)

**What.** [Thebe](https://thebe.readthedocs.io) turns code cells into live cells backed by a Binder kernel or a self‑hosted JupyterHub. `{python}` blocks stay the same in source; a small JS include makes them executable.

**Pros.**
- Real CPython — every package works.
- Same source cells serve both static and live views.
- Cleanly integrates with existing `{python}` blocks.

**Cons.**
- Binder cold-starts are slow and sometimes unavailable; not a great first impression for a teen reader.
- Requires an image spec (`requirements.txt` / `environment.yml`) in the repo.
- Session state is per‑visit; not ideal for "rewrite and revisit".

**Effort.** Small–medium. Add Thebe includes and a Binder config. Ongoing reliability cost.

### Option C — Static book + "Open in Colab" affordance per chapter

**What.** Keep the book static. For each chapter that has code, generate a paired `.ipynb` (either hand‑maintained or via `quarto convert`) into a `notebooks/` folder and put an "Open in Colab" badge at the top of that chapter. Colab handles execution and rewrite in a familiar environment.

**Pros.**
- Zero runtime cost. Zero maintenance beyond keeping the paired notebook honest.
- Colab is the environment most self‑learners will already recognise.
- Preserves the current build pipeline exactly.

**Cons.**
- Sends the reader out of the book to run code — breaks flow. Not Codecademy‑style rewrite in place.
- Two artefacts per chapter (the `.qmd` and the `.ipynb`) drift unless generation is automated.

**Effort.** Very small.

**Recommendation.** Do **Option A (Pyodide via Quarto Live)** as the primary code-in-the-book experience, with **Option C (Colab badges)** as the escape hatch for chapters that need the full Python ecosystem or a longer, messier exploration. Skip Option B unless a specific chapter forces it — Binder cold starts are the wrong first impression for a teen audience.

---

## 7. Proposed first curriculum spine (zero → data scientist)

The current book is strong on Part II (sample spaces) and starting on Part III (statistics). The spine below keeps that material and folds it into a larger arc so a curious teen can enter at Part 0 and grow into it.

**Part 0 — Before there is data.**
Numbers as counting. Numbers as measurement. Precision, unit, error. Scales (nominal, ordinal, interval, ratio). What a table is. What a plot is. First plots by hand, then in code.

**Part 1 — Reading the world.**
Observation vs. experiment. Sampling. Bias. Variation. Signal and noise (first, informal pass). Data literacy: what a chart hides, what a number omits. *(A rewritten `sample/sampling.qmd` lives here.)*

**Part 2 — The shape of possibility.**
Sets and types. Sample spaces. Outcomes and events. Randomness and pattern. Finite vs. infinite. Kolmogorov's triple. *(This is essentially the current `sample-space/` part, unchanged in spirit.)*

**Part 3 — Statistics as listening.**
Statistical thinking. Variation as a first‑class subject. Kinds of uncertainty. Distributions as shapes of possibility (normal, Student, log‑normal, Pareto, binomial, Poisson). Modelling. Methods. Estimation, confidence, hypothesis, honest reporting. *(This absorbs the current `statistics/` part and finally lists Poisson in the TOC.)*

**Part 4 — Information.**
Entropy. Surprise as a quantity. Mutual information. Coding and compression as a lens on data. KL divergence and cross‑entropy as "cost of a wrong story". This is the bridge from statistics to modern data science.

**Part 5 — Fuzzy things.**
Fuzzy sets and membership. Fuzzy numbers and arithmetic. When "roughly" is more honest than a point estimate. A first look at possibility vs. probability.

**Part 6 — Signals and systems.**
A signal as a function of time. Sampling and aliasing. Filters, convolution, LTI. Fourier as a change of basis you can hear. Why this matters for sensors, audio, and any time‑indexed data. *(`libs/Signal.py` seeds this part.)*

**Part 7 — Math for data (just in time).**
Linear algebra as geometry of data. A little calculus, chosen for what appears elsewhere in the book. Optimisation as "walk downhill". Numerical care.

**Part 8 — Data engineering, honestly.**
Files, formats, tidy data. SQL as a language, not a chore. Joins and shape changes. Missingness. Reproducibility. *(The Spanish `PD/HR/` and `DataBases/` material rewritten in English here.)*

**Part 9 — Visualisation as craft.**
Encodings. Grammar of graphics. Small multiples. Honest charts. Redesign exercises.

**Part 10 — Learning from data.**
Regression as a first model. Trees and their intuitions. Regularisation. Cross‑validation. A first neural network, small and legible. Where each method's assumptions come from — and break.

**Part 11 — Cause, effect, and design.**
Correlation is not causation, said properly. Experiments. Confounding. A gentle first look at DAGs. When to stop believing a fit.

**Part 12 — Projects.**
Three end‑to‑end mini investigations at increasing ambition. Each one uses only tools introduced earlier. Each one ends with an honest limitations section.

Every chapter gets: prerequisites, a difficulty marker (🔰/🏵/🧗), one or two "run and rewrite" cells (Pyodide), one exercise with a hidden hint and a hidden solution, and a "further reading" tail.

---

## Appendix — Micro‑checklist for the very next PR after this survey

- Fix `_quarto.yml`: either create `sample/sampling.qmd` (matching the existing prose voice) or remove the entry, so CI turns green.
- List `statistics/distributions/poisson.qmd` under the Statistics → Distributions chapters in `_quarto.yml`.
- Replace `execute-notebooks: auto` with a real Quarto execute key (`execute: freeze: auto` is the usual choice for books with heavy code).
- Collapse the duplicated `Install Python dependencies` step in `pages.yml` and move it after `actions/checkout`.
- Decide on Option A / B / C above and add one live‑code chapter as the pilot.

Nothing else is required to unblock forward motion.
