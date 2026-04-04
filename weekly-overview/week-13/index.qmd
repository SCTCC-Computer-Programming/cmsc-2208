# Week 13 Guide
## Chapter 3: Dimensionality Reduction Application

Week 12 introduced dimensionality reduction and `PCA` from `sklearn.decomposition`. You saw how correlated features create redundancy in a dataset, how PCA finds directions of maximum variance and re-expresses samples in terms of those directions, why scaling is required before PCA, how the fit-on-training rule applies to the `PCA` object exactly as it applies to scalers, and how to interpret `explained_variance_ratio_` when choosing how many components to retain. This week you apply those concepts in a new context.

The assignment puts you in the role of a consultant advising a data scientist at a game studio. Each task draws directly on what you built in Week 12.

**Week 13 Assignment:**

- Here is the link to the **[Week 13 assignments page](../../assignments/week-13/index.qmd)**.

## What you need to be ready to apply

**Why correlated features motivate dimensionality reduction.** You should be able to look at a set of features, identify which ones are likely to overlap in what they measure, and explain why that redundancy is a problem worth addressing before training. You should also be able to distinguish this clearly from the scale problem that scaling addresses. These are two different problems with two different solutions.

**The fit-on-training rule applied to PCA.** You applied this rule to scalers in Week 10. Here it applies to a second object in the preprocessing sequence. You should be able to explain what `PCA` learns during fit, how that is different from what a scaler learns, and what goes wrong when the rule is violated for either object.

**Reading `explained_variance_ratio_` and choosing `n_components`.** You should be able to interpret a full explained variance table, reason about where meaningful variance ends and noise begins, and make a defensible recommendation for how many components to retain. You should be able to explain the tradeoff you are accepting and push back on a recommendation that does not hold up to scrutiny.

**Why fewer components can outperform more features, and what comes next.** You should be able to explain the mechanism behind cases where a kNN model on PCA-reduced data outperforms a model on all scaled features. You should also know what t-SNE offers for visualization and why it cannot serve as a preprocessing step, and what `inverse_transform` does when a data scientist needs to understand what the components represent.

## Week 13 tasks

1. Review your **Week 12 demo notebook and textbook reading** (Chapter 3, pages 140--165) as needed before working through the assignment.
2. Read through the **[Week 13 assignment](../../assignments/week-13/index.qmd)** carefully, including the full scenario and all four sections, before recording.
3. Record and submit your **video** addressing all four sections.
