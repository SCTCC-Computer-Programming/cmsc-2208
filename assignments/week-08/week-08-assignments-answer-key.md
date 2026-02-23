# Week 8 Assignment, Answer Key

**For instructor use only.**

---

## Section A: Defining the Problem

### A1: Is this classification or regression?

**Classification.** The target variable is `failed_within_30_days` with two categories: "yes" or "no." The model predicts a category label, not a numeric value. If it were predicting something like the number of days until failure or the repair cost, it would be regression.

### A2: Identify features (X) and target (y)

**Features (X):** machine_age, vibration_level, operating_temp, hours_since_maintenance, prior_breakdowns, machine_type (six features total).

**Target (y):** failed_within_30_days ("yes" or "no").

### A3: Why does the cost asymmetry matter?

The assignment's cost structure primer lays out the reasoning. Students should demonstrate they understood it and can restate it in their own words applied to the scenario.

Missing a real failure costs ~$40,000. Pulling a machine unnecessarily costs ~$5,000/day. Because missing a failure is roughly 8 times more expensive, you would rather err on the side of pulling machines for maintenance, even if some of those pulls turn out to be unnecessary. You do not need extremely high confidence before acting. A moderate probability of failure might still warrant action because the cost of ignoring a warning and being wrong is much worse than the cost of acting on a warning and being wrong.

**What a strong answer includes:** Restates the two error types and their costs. Explains that the imbalance shifts how aggressively you act on predictions. Connects this to the idea that you would act on lower-confidence predictions rather than waiting for near-certainty. Uses their own words rather than reading the primer back.

**Common errors:** Stating the costs without explaining how they affect decision-making. Saying "you want to be really confident before pulling a machine" (this is backwards given the asymmetry). Simply restating the primer without demonstrating understanding.

---

## Section B: Choosing an Algorithm

### B1: Which algorithm and why?

**Decision tree (DecisionTreeClassifier) is the strongest recommendation.** Key reasons tied to the data:

- **Mixed feature types:** The data includes a categorical feature (machine_type: press, lathe, CNC mill). Decision trees handle categorical-like features naturally without requiring encoding.
- **Different scales:** Features range from single digits (age) to thousands (hours_since_maintenance). Decision trees do not require feature scaling because they split on one feature at a time.
- **Feature interactions:** Mechanical failure likely involves combinations of factors (e.g., old machine + high vibration). Decision trees capture interactions automatically through their hierarchy of questions.
- **Interpretability:** Rivera needs to understand the model. Decision trees produce a hierarchy of if-else rules that can be explained to a non-technical stakeholder.

**kNN is a weak choice** because it requires feature scaling (critical with these different scales), provides no insight into which features matter, and would be slow at prediction time with 1,200 records.

**Linear models are a reasonable but weaker choice** because they require feature scaling, need manual encoding for categorical features, assume linear relationships (which may not hold for mechanical failure), and cannot capture feature interactions without manual feature engineering. However, they do offer interpretability through coefficients.

**Note:** Students who recommend a decision tree with a caveat about ensemble methods (Random Forests, Gradient Boosting) for better performance show strong understanding. Students who recommend a linear model with solid justification should still receive credit if their reasoning is sound, but the data characteristics clearly favor trees.

**What a strong answer includes:** Names a specific algorithm, provides at least three justifications tied to the data characteristics mentioned in the prompt (mixed types, scales, interactions), and explains why the chosen algorithm handles each one well.

**Common errors:** Recommending an algorithm without connecting to the specific data. Listing generic advantages not tied to the scenario. Recommending kNN without addressing the scaling and interpretability problems.

### B2: Complexity parameter, overfitting, and underfitting

**For a decision tree, the key parameter is `max_depth`.** It controls the maximum number of questions the tree can ask in sequence.

**Overfitting in this context:** A tree with no depth limit memorizes the training data. It might learn overly specific rules like "if machine_age is exactly 12 and vibration_level is exactly 4.8 and operating_temp is exactly 187, predict failure." These rules fit the historical data perfectly but would not generalize to new machines. Training accuracy would be very high (possibly perfect), but test accuracy would be significantly lower. In practice, this means the system would flag machines incorrectly, either missing real failures or generating false alarms on new data it has not seen before.

**Underfitting in this context:** A tree with max_depth=1 asks only one question (maybe "is hours_since_maintenance greater than 3000?"). One question cannot capture the multiple factors that contribute to machine failure. Both training and test accuracy would be low because the model is too simple to learn the patterns. Rivera's system would miss many real failures because it only looks at one factor.

**What a strong answer includes:** Names the correct parameter (max_depth for trees, or the equivalent for their chosen algorithm). Explains what it controls. Describes overfitting and underfitting using the machine failure scenario rather than generic definitions. Mentions the pattern of comparing training vs. test accuracy to diagnose both.

**Common errors:** Defining overfitting/underfitting generically without connecting to the scenario. Saying "max_depth controls complexity" without explaining what that means (number of questions in sequence). Confusing which direction of the parameter leads to which problem.

---

## Section C: Prediction Confidence with Probabilities

### C1: Why is a label alone not enough?

The basic prediction method (`.predict()`) returns only "yes" or "no" for each machine. It does not tell you how confident the model is in that prediction. Two machines can both be predicted as "yes" (likely to fail), but one might be a near-certain failure while the other is barely over the decision boundary.

Rivera needs to prioritize. With 200 machines and limited maintenance capacity, he cannot pull every flagged machine at once. Without confidence information, a borderline "yes" and a strong "yes" look identical, and Rivera has no way to decide which machines to address first.

**What a strong answer includes:** Names `.predict()` as the method that returns labels. Explains that it hides confidence. Gives a concrete reason why Rivera needs more than labels (prioritization, limited capacity, different situations require different responses).

**Common errors:** Saying `.predict()` gives confidence information. Not connecting to Rivera's practical situation.

### C2: What is predict_proba and how would Rivera use it?

The method is **`predict_proba`**. For a binary problem, it returns two probabilities for each machine: P(no) and P(yes). These values are between 0 and 1 and sum to 1.0 across the row. The column order matches the **`classes_`** attribute of the trained model.

Rivera could use these probabilities to create a tiered action plan:

- Machines with very high failure probability (e.g., above 85-90%) get pulled immediately for preventive maintenance.
- Machines with moderate probability (e.g., 60-80%) get increased monitoring or scheduled for maintenance during the next available window.
- Machines with low probability (e.g., below 50%) continue running normally.

The specific thresholds would depend on Rivera's capacity and budget, but the key point is that probabilities turn a flat list of "yes" flags into a ranked priority list.

**What a strong answer includes:** Names `predict_proba`. Describes the output shape (two columns for binary). Explains that values are probabilities between 0 and 1 that sum to 1.0. Mentions `classes_` for determining column order. Provides a concrete example of how Rivera could use tiered thresholds.

**Common errors:** Confusing `predict_proba` output with `decision_function` output. Not explaining what the two columns represent. Giving a vague answer about "it shows confidence" without describing the actual output format.

### C3: Machine A (91%) vs. Machine B (54%)

**Machine A (91% failure probability):** The model is very confident this machine will fail. Rivera should prioritize pulling this machine for maintenance. High-confidence predictions tend to be much more accurate than uncertain ones.

**Machine B (54% failure probability):** The model is barely more confident in "yes" than "no." This is essentially a coin flip. The prediction is unreliable.

However, given the cost asymmetry from the assignment primer and Section A, Machine B might still warrant action. Missing a real failure ($40,000) is 8 times worse than an unnecessary pull ($5,000). Even at 54% probability, the expected cost of ignoring a potential failure may exceed the cost of pulling the machine. Rivera might flag Machine B for increased monitoring or schedule maintenance during a planned downtime window rather than an immediate pull.

**What a strong answer includes:** Clear distinction between the two confidence levels. Recognition that Machine A is a clear action item. Thoughtful reasoning about Machine B that connects back to the cost asymmetry rather than simply dismissing it as "uncertain, so ignore it." Does not need to be mathematically precise, just demonstrates the reasoning.

**Common errors:** Treating both machines the same because `.predict()` returned "yes" for both. Saying Machine B should be ignored because the model is uncertain (this ignores the cost asymmetry). Not connecting back to Section A or the cost primer.

---

## Section D: Raw Confidence Scores

### D1: What is decision_function and how is it different?

The method is **`decision_function`**. For binary classification, it returns a **single raw score per sample** (not two values like `predict_proba`).

**Key differences from `predict_proba`:**

- **Scale:** `predict_proba` returns values bounded between 0 and 1 with a direct interpretation as probabilities. `decision_function` returns values on an arbitrary, unbounded scale. Scores can be any number, positive or negative.
- **Format:** `predict_proba` returns two values per sample (one per class). `decision_function` returns one value per sample in binary classification.
- **Interpretation:** A `predict_proba` value of 0.83 directly means "83% chance of this class." A `decision_function` score of 3.7 means the model is confident, but the number itself does not have a direct probability interpretation.
- **Sign convention:** Positive `decision_function` values favor the positive class (the second entry in `classes_`), negative values favor the negative class (the first entry in `classes_`). Values near zero indicate uncertainty.

**What a strong answer includes:** Names `decision_function`. States that it returns one value per sample (not two) for binary classification. Explains that the scale is unbounded and arbitrary, unlike bounded probabilities. Explains the sign convention (positive/negative maps to classes). Notes that values near zero mean uncertainty.

**Common errors:** Saying `decision_function` returns two values per sample in binary classification (it returns one). Saying the scores are probabilities. Not explaining the sign convention. Confusing which direction (positive/negative) maps to which class.

### D2: When might decision_function be your only option?

Some classifiers do not support `predict_proba` and only provide `decision_function`. The textbook example is **`LinearSVC`** (Linear Support Vector Classifier). If you trained a LinearSVC model, `decision_function` would be the only way to get confidence information from the classifier.

**What a strong answer includes:** Explains that not all classifiers support `predict_proba`. Names LinearSVC as the specific example.

**Common errors:** Saying all classifiers support both methods. Not being able to name a specific classifier that only supports `decision_function`.

**Note:** This is a detail from the Week 7 overview and textbook reading. Students who cannot name LinearSVC specifically but explain the general principle (some classifiers only support one method) still demonstrate partial understanding.

---

## Section E: Explaining the Model to Rivera

### E1: What tools does your chosen algorithm provide?

For a decision tree, the tool is **`feature_importances_`** (accessed as an attribute of the trained model). It returns a value between 0 and 1 for each feature, with all values summing to 1.0. Higher values mean the tree relied more heavily on that feature for making decisions.

For Rivera, this might show something like: "hours_since_maintenance and prior_breakdowns are the two most important factors the model uses when predicting failures. machine_age is moderately important. machine_type has low importance."

**The important limitation:** Feature importance shows only *how much* each feature contributed to decisions, not *in which direction*. We can tell Rivera that vibration_level is important, but feature importance alone does not tell us whether higher vibration leads to more failures or fewer failures. (In this domain the direction might seem obvious, but the model does not explicitly report it through feature importance.)

**What a strong answer includes:** Names `feature_importances_`. Explains what the values mean (0 to 1, sum to 1.0, higher means more used). Gives a concrete example relevant to the scenario. Clearly states the limitation about direction.

**Common errors:** Saying feature importance shows which features increase or decrease failure risk (it does not show direction). Confusing feature importance with coefficients. Not naming the specific scikit-learn attribute.

### E2: What can your algorithm's tools not show?

**The missing information is direction.** Feature importance (from trees) tells you that a feature was used heavily for decisions but does not tell you whether higher values of that feature are associated with more failures or fewer failures.

**Linear models (such as Logistic Regression) provide this.** Their coefficients (`coef_`) show both magnitude and direction. A positive coefficient for hours_since_maintenance would mean more hours since last maintenance is associated with higher predicted probability of failure. A negative coefficient would mean the opposite.

This is the key contrast: feature importance gives *how much*, coefficients give *how much and which direction*.

**If a student chose a linear model in Section B:** They should recognize that coefficients already provide direction, and note that the missing piece is the ability to capture feature interactions automatically (which trees can do). Either direction of comparison demonstrates understanding of the trade-off.

**What a strong answer includes:** Identifies direction as the missing information. Names a specific algorithm from Chapter 2 that provides it (linear models / Logistic Regression). Explains what coefficients show that importance does not (sign/direction). Uses a feature from the scenario as an example.

**Common errors:** Saying both tools show the same thing. Claiming trees show direction. Not naming a specific algorithm. Giving a vague answer without using the scenario's features.

### E3: The uncertain machine (near 50/50)

**Recommendation: Pull the machine for maintenance** (or at minimum, increase monitoring and schedule maintenance at the earliest available window).

The reasoning connects back to Section A and the cost asymmetry primer. If the machine fails and was not maintained, the cost is ~$40,000. If the machine is pulled unnecessarily, the cost is ~$5,000. Even though the model is essentially uncertain (50/50 means it has no strong evidence either way), the consequences of being wrong in one direction are far more severe than in the other.

A 50/50 prediction means the model cannot distinguish whether this machine will fail or not. In the absence of strong evidence, the safe decision is to act, because inaction carries 8 times the risk.

**This is the capstone question.** It ties together uncertainty estimates (Section C), cost asymmetry (Section A and the primer), and practical decision-making. A student who gets this right has demonstrated they can synthesize across the full Chapter 2 toolkit.

**What a strong answer includes:** A clear recommendation (pull or increase monitoring). Explicit connection to the cost asymmetry with specific dollar figures. Recognition that 50/50 means the model is genuinely uncertain. Reasoning that the asymmetric costs favor action over inaction even when confidence is low.

**Common errors:** Saying "the model is uncertain, so do nothing" (ignores cost asymmetry). Saying "run more data" or "train a better model" without addressing what Rivera should do right now. Not connecting back to Section A or the primer.

---

## Video Rubric Quick Reference

**Strong responses should demonstrate:**

- Correct identification of classification vs. regression from the problem description
- Algorithm recommendation with specific justification tied to the data characteristics (not generic)
- Accurate description of the complexity parameter and its connection to overfitting/underfitting in context
- Clear explanation of `predict_proba` output (shape, values, interpretation) and how it enables better decisions
- Correct identification and description of `decision_function` including how it differs from `predict_proba`
- Accurate description of `feature_importances_` including the direction limitation
- Clear contrast between feature importance and coefficients
- Consistent connection of the cost asymmetry to decision-making throughout (Sections A, C, and E)
- Use of correct technical terminology while explaining concepts clearly

**Common errors to watch for:**

- Claiming feature importance shows direction (it does not)
- Recommending kNN without addressing the scaling and interpretability problems
- Defining overfitting/underfitting generically without connecting to the machine failure context
- Saying `.predict()` gives confidence information (it does not)
- Treating the 50/50 machine as "ignore it" without considering cost asymmetry
- Confusing `predict_proba` output with `decision_function` output
- Not knowing that `decision_function` returns unbounded scores, not probabilities
- Saying `decision_function` returns two values per sample in binary classification (it returns one)
- Saying "you want to be really confident before pulling a machine" (backwards given the cost asymmetry)

---

## Grading Note: Concepts Covered vs. Not Directly Tested

This assignment tests practical application of the full Chapter 2 toolkit. The following concepts from Week 7 are covered implicitly or through application but are not directly asked about by name:

- **Calibration:** The assignment tests the practical implication (high-confidence predictions are more trustworthy, tiered decision-making) but does not ask students to define or name calibration. A student who mentions calibration in their C2 or C3 response shows deeper understanding.
- **Multiclass extension:** The assignment uses a binary problem. Students are not asked how `predict_proba` or `decision_function` behave with three or more classes. This is textbook-only content.
- **`classes_` attribute:** Not explicitly asked for, but a strong C2 answer would mention checking `classes_` to know which column is which.
- **Positive class / negative class terminology:** Not explicitly tested, but would naturally appear in a strong D1 answer about the sign convention.

These omissions are intentional. The capstone tests whether students can apply concepts to a realistic problem, not whether they can recite definitions.
