# Week 15 Assignment Answer Key
## Clustering Consultation — Umbrella Corporation Archive

---

### Section A: Understanding the Task

**A1 — Supervised or unsupervised?**

Expected: This is unsupervised. The student should identify that there is no target column and no labels to train toward or evaluate against. A strong answer connects this to the scenario directly — Umbrella did not label their documents, so the algorithm has nothing to learn from except the feature values themselves. A weak answer states "unsupervised" without explaining what that means or connecting it to the dataset.

**A2 — How will we know if the clustering worked?**

Expected: The student should explain that without labels, there is no accuracy score to compute. Success cannot be determined numerically in the way it can with a classifier. Results must be interpreted by examining what is actually in each cluster — reading documents, looking for patterns, and deciding whether the groupings are meaningful for the goal of understanding Umbrella's research programs. A strong answer acknowledges the qualitative nature of evaluation. A weak answer says "use the silhouette score" without recognizing its limitations, or gives no answer to what interpretation looks like.

Note: Students who mention the silhouette score here are not wrong — it is a tool — but the answer is incomplete if it does not acknowledge that a numeric score cannot tell you whether the clusters are actually useful for this goal.

**A3 — What do the cluster numbers mean?**

Expected: Cluster numbers are arbitrary labels. Cluster 0 is not better or worse than Cluster 2. The numbers only indicate membership — all documents in Cluster 0 are more similar to each other than to documents in other clusters. The numbers have no inherent meaning and cannot be interpreted without examining the documents inside each cluster. A strong answer makes both parts clear: what the numbers do mean (membership) and what they do not mean (rank, quality, or category identity).

---

### Section B: Choosing an Algorithm for the Initial Grouping

**B1 — Algorithm choice**

Acceptable answers: `KMeans` or `AgglomerativeClustering`. Either is defensible for an initial broad grouping. `DBSCAN` is a weaker choice for this specific task because the goal is to partition all 4,200 documents into a manageable number of groups, and DBSCAN may label a large portion as noise rather than assigning them to programs. If a student chooses DBSCAN, their justification must address this limitation directly to receive a passing score.

The choice itself is less important than the justification. A student who chooses `KMeans` and cannot explain what `n_clusters` controls is weaker than a student who chooses `AgglomerativeClustering` and explains the bottom-up merging process and ward linkage clearly.

**B2 — Parameter and how to choose a value**

For `KMeans`: the parameter is `n_clusters`. A strong answer explains that it controls how many groups the algorithm will produce, and that choosing a value requires some domain reasoning — the student might suggest starting with a small number (5-10) to get a broad picture of major research programs and adjusting based on whether the clusters seem coherent. For `AgglomerativeClustering`: same parameter, same reasoning. For `DBSCAN`: the parameters are `eps` and `min_samples`. A strong answer explains what each controls and why scaling should be applied before setting `eps`.

A weak answer names the parameter without explaining what it controls, or gives no guidance on how to choose a value.

**B3 — What will the output look like?**

Expected: The algorithm assigns a cluster label (an integer) to each of the 4,200 documents. The data scientist now has a column of cluster assignments alongside the feature data. The numbers themselves reveal nothing — the next step is to examine the documents within each cluster, read them, and determine whether the grouping reflects a coherent research program, a document type, or some other pattern. A strong answer addresses both parts: the technical output (cluster labels) and the interpretive work that must follow. A weak answer describes only the labels without addressing what the data scientist needs to do next.

---

### Section C: What DBSCAN Reveals

**C1 — The -1 label and its meaning in this scenario**

Expected: A label of -1 means the document was not assigned to any cluster — it is a noise point. DBSCAN determined that the document is too isolated to belong to a dense group. In the context of Umbrella's archive, a document labeled -1 could represent an isolated research note, a one-off memo, a document from a program with very few other records, or potentially something that was deliberately kept separate. A strong answer explains both the technical meaning (noise, not part of any dense cluster) and the scenario-specific interpretation (what might such a document be in an Umbrella archive). A weak answer states only that -1 means noise without any scenario connection.

**C2 — eps too small and eps too large**

Expected: When `eps` is very small, almost no points fall within each other's neighborhoods. Very few core points are identified. Most documents are labeled noise (-1). The algorithm effectively says every document is isolated. When `eps` is very large, every document falls within the neighborhood of every other document. All documents are connected into a single dense region. The algorithm assigns everything to one cluster. A strong answer explains both cases in terms of what `eps` controls (the distance threshold for neighborhood membership) and what the effect is on the result.

**C3 — Why scaling is required before DBSCAN but not before KMeans or AgglomerativeClustering**

Expected: DBSCAN uses distance to determine whether two points are neighbors — if the distance between them is less than or equal to `eps`, they are neighbors. Without scaling, features with large numeric ranges (like `document_length`, which ranges from 120 to 9,400) will dominate the distance calculation. `technical_term_density` (0.02 to 0.61) would contribute almost nothing. `eps` would effectively be calibrated to document length and would be nearly meaningless for the other features. Scaling puts all features on the same scale so that `eps` has a consistent meaning across all 18 features.

`KMeans` also uses distance, so scaling is beneficial for `KMeans` as well — a strong student may note this. The question is whether they can explain why DBSCAN is particularly sensitive to it given the explicit `eps` threshold. `AgglomerativeClustering` with ward linkage also uses distance internally, so scaling helps there too. The key point the question is testing is whether the student understands the relationship between `eps` and feature scale.

Note: A student who says KMeans does not use distance is incorrect. KMeans assigns each point to the nearest cluster center, which is a distance calculation. The question is specifically about why the `eps` parameter in DBSCAN makes scale especially consequential.

---

### Section D: Evaluating the Results

**D1 — What the silhouette score measures**

Expected: The silhouette score measures how well each point fits its assigned cluster compared to other clusters. Cohesion is how close a point is to the other points in its own cluster — a point that is tightly packed with its cluster members has high cohesion. Separation is how far a point is from the points in the nearest other cluster — a point that is clearly separated from neighboring clusters has high separation. The overall score combines both: a high score means points are close to their own cluster and far from others. A weak answer defines the score range without explaining what cohesion and separation mean concretely.

**D2 — Does a higher silhouette score for KMeans mean it found better clusters?**

Expected: No. The silhouette score measures compactness. `KMeans` is designed to produce compact, blob-shaped clusters — that is what it optimizes for. The silhouette score rewards exactly what `KMeans` produces, regardless of whether those clusters reflect meaningful structure in the data. `DBSCAN` can find clusters of arbitrary shape that may be more meaningful for this goal, but those clusters may not be compact. A strong answer explains why the metric systematically favors `KMeans` and why that does not make `KMeans` the better algorithm for this scenario. A weak answer simply agrees that a higher score means better clusters, or disagrees without explaining why.

**D3 — What to do in addition to the silhouette score**

Expected: Examine the actual documents in each cluster. Look at a sample of documents from each group and ask whether they share characteristics that suggest a common research program, topic area, or document type. A numeric score cannot tell you whether Cluster 2 contains virology research or administrative memos — only reading the documents can answer that. A strong answer connects the qualitative examination to the specific goal: understanding Umbrella's research programs. A weak answer says "look at the data" without explaining what to look for or why a numeric score is insufficient.

---

### Section E: New Documents Arrive

**E1 — Which algorithms support predict?**

Expected: `KMeans` supports `predict`. After fitting, new documents can be assigned to whichever cluster center they are closest to using the centers learned during training. `AgglomerativeClustering` and `DBSCAN` do not support `predict`. Agglomerative clustering builds a hierarchy from the specific points it was given — there is no rule for placing a new point in a hierarchy that was built without it. DBSCAN identifies dense regions in the original data — a new point cannot be assessed against density thresholds that were established without it. A strong answer names all three algorithms correctly and explains why the two without `predict` cannot make the assignment, not just that they cannot.

**E2 — Practical consequences and options**

Expected: Without `predict`, the data scientist cannot simply assign the 300 new documents to the existing clusters if they used `AgglomerativeClustering` or `DBSCAN`. One option is to rerun the algorithm on the full 4,500-document dataset. The tradeoff is that the cluster assignments from the first run may change — clusters may merge, split, or shift — which means the initial analysis and the new analysis are not directly comparable. Another option is to use `KMeans` specifically for new document assignment even if a different algorithm was used for the initial grouping, using the cluster centers from a parallel `KMeans` run as reference points. A third option is to manually examine the 300 new documents and assign them based on content similarity to the established clusters.

A strong answer acknowledges the tradeoff of rerunning — that consistency with the original analysis is lost — and identifies at least one other path. A weak answer only states "rerun the algorithm" without addressing the tradeoff.

---

### Grading Notes

**Questions where student answers can legitimately vary:**
- B1: `KMeans` and `AgglomerativeClustering` are both acceptable. `DBSCAN` is acceptable only with a strong justification that addresses its noise classification behavior.
- B2: The specific value suggested for `n_clusters` does not matter. The reasoning about how to approach the choice does.
- D3: Any answer that calls for examining actual document content is on the right track. The specific method (sampling, reading cluster centroids, reviewing outliers) can vary.
- E2: Multiple valid paths exist. The tradeoff discussion matters more than which option the student selects.

**Assignment-level fail conditions:**
- Student cannot distinguish supervised from unsupervised learning
- Student believes cluster numbers have inherent meaning
- Student believes a higher silhouette score definitively means better clustering
