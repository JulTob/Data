# Draft — Future predictions, odds, and useful maps

**Status:** reviewable proposal only. This is **not** a published Wiki page.

**Source destination:** an optional section following the introduction to probability on [1. Probability](https://github.com/JulTob/Data/wiki/1.-Probability), or a later dedicated page on odds. It should come **after** the basic introduction to events and complements and **before** any deeper treatment of information theory. The published Wiki remains read-only for agents.

## The point of the passage

Charles Boncelet, *Probability, Statistics, and Random Signals*, introduces stock markets, weather, sporting events, and elections as domains where forecasts are useful despite substantial uncertainty. The author of this Wiki proposes using **that prediction-and-payoff passage**, **not** the preceding Alice/Bob message example, to introduce odds.

A forecast of a future event need not make it certain. More useful is a calibrated map of how plausible each alternative is. **Odds** express the relative weight of two alternatives. When actions have different costs or payoffs, those weights help us decide whether a bet, precaution, trade, or policy is worthwhile. A favourable prediction and a favourable decision are not the same: the offered payoff matters.

## Suggested Wiki passage

### Odds: When predictions guide decisions

We make maps because we want to go somewhere we cannot yet see. Tomorrow's weather, the outcome of a match, and next week's market price have not been observed. A useful forecast does not promise to reveal the future: it helps us compare possible outcomes and act before we know which one will occur.

Suppose our model assigns a football team a 60% chance of winning. That probability describes one event on our map. The **odds in favour** compare the weight of that event with its complement:

```math
O(A) = \frac{P(A)}{P(\neg A)} = \frac{0.6}{0.4} = \frac{3}{2}.
```

We say the odds are **3 to 2 in favour**. But being more likely to win does not automatically make a bet worthwhile. A fair betting price and the actual price offered may be different. The probability helps describe what we expect; the payoff tells us whether acting on that expectation makes sense.

This is the mapmaker's problem once again. We can build different maps for different purposes, but their consequences are not arbitrary. If our probabilities are misleading, or our payoff assumptions are wrong, our strategy can fail even when individual forecasts occasionally come true.

## Technical bridge (keep optional until decision theory)

Let `p=P(A)` and let a decimal betting price `d` return `d` units in total per unit staked if `A` occurs, and zero otherwise (stake included in the returned amount). For a risk-neutral one-unit bet:

```math
\mathrm{EV}_{\mathrm{net}} = pd - 1.
```

At `p=0.6`, a decimal price of `d=2.00` would give `EV_net=+0.20` per unit staked under the model; a price of `d=1.50` would give `EV_net=-0.10`. This is an **expected value within a model**, not a guarantee of real-world profit. Taxes, margin, market movement, estimation error, risk preferences, and limits may alter the decision.

### Distinctions to protect

- **Probability:** the model's weight on an event, `p`.
- **Odds in favour:** `p/(1-p)`, event relative to its complement.
- **Odds against:** `(1-p)/p`. These may match the numeric form of **fair net payout odds** under a particular betting convention, which is a different interpretation from the odds *in favour*.
- **Quoted betting odds:** prices, which may include bookmaker margin and need not equal any objective underlying probability.
- **Profitability:** depends jointly on forecast quality, payoff, risk, and the decision rule, not solely on predicting the most probable outcome.
- **Information / surprise:** different concepts; Alice/Bob is a better bridge to entropy and evidence than to gambling odds.

### Editorial note

Do not append this wholesale to the existing introductory chapter before the author has established the meaning of events and complements. Keep the example readable and leave the expected-value formula for a later page if it would interrupt the first-principles narrative.

**Source:** Boncelet, Charles, *Probability, Statistics, and Random Signals* (Oxford University Press), introductory passage on predicting markets, weather, sports and elections, supplied directly by the user. Confirm exact edition and page before making a page-specific citation.
