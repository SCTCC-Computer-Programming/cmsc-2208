# Week 6 Assignment — Answer Key

**For instructor use only.**

---

## Case Study 1: Predicting Employee Turnover

### Q1: This is a classification task. How can you tell?

The target variable is **turnover** with two categories: "stay" or "leave." Because the model predicts a category label (not a number), this is classification. If it were predicting a numeric value like a satisfaction score, it would be regression.

### Q2: Which model is overfitting? Which is underfitting?

- **Underfitting — Model 1 (max_depth=1):** Both training (0.72) and test (0.70) accuracy are low. The tree is too simple — asking only one question isn't enough to capture the patterns in the data.
- **Overfitting — Model 4 (max_depth=None):** Perfect training accuracy (1.00) but the lowest test accuracy (0.74). The tree memorized the training data but doesn't generalize well.
- **Model 3 (max_depth=5)** shows early signs of overfitting: training accuracy (0.93) is notably higher than test accuracy (0.80), and test accuracy is lower than Model 2.

### Q3: Which model would you recommend?

**Model 2 (max_depth=3).** It has the highest test accuracy (0.82), which means it generalizes best to new data. The gap between training (0.85) and test (0.82) accuracy is small (0.03), indicating the model is not significantly overfitting. It strikes the best balance between fitting the training data and generalizing to unseen examples.

### Q4: Feature importance interpretation

- **Most important:** satisfaction_score (0.45) — the tree relies most heavily on employee satisfaction for predicting turnover. This suggests satisfaction is the strongest driver of whether employees stay or leave.
- **Least important:** years_at_company (0.09) — tenure was barely used by the tree, suggesting it plays a minimal role in the model's decisions.
- monthly_hours (0.28) is second most important, and last_evaluation (0.18) is third.
- All values sum to 1.0, and all are non-negative.

### Q5: How does feature importance differ from coefficients?

**Feature importance only shows magnitude (how much a feature was used), not direction.** We know satisfaction_score is the most important feature (0.45), but we don't know whether higher satisfaction leads to staying or leaving.

**Coefficients show both magnitude and direction.** A positive coefficient means "as this feature increases, the prediction moves toward one class." A negative coefficient means the opposite. For example, if a linear model had a coefficient of -0.41 for satisfaction_score, we'd know that higher satisfaction is associated with being less likely to leave.

This is a key interpretability trade-off: linear models give you direction and magnitude; trees give you only magnitude.

### Q6: How max_depth controls complexity

**max_depth limits the maximum number of questions the tree can ask in sequence.** 

- **max_depth=1:** The tree asks only one question. This is very simple and can miss important patterns (underfitting).
- **max_depth=3:** The tree can ask up to 3 questions in sequence, enough to capture meaningful patterns without memorizing noise.
- **max_depth=5:** More questions allow finer-grained decisions, but the tree starts fitting noise in the training data (training accuracy climbs to 0.93 while test accuracy drops to 0.80).
- **max_depth=None:** No limit — the tree keeps splitting until every leaf is pure. This leads to perfect training accuracy (1.00) but poor generalization (0.74).

The pattern in the results shows the classic complexity trade-off: too simple → underfitting, too complex → overfitting. max_depth is the primary knob for controlling this balance, similar to how alpha controls complexity in Ridge and C controls complexity in Logistic Regression.

---

## Case Study 2: Comparing Algorithms on Customer Churn

### Q1: Which algorithm would you recommend?

**Decision Tree (max_depth=4).** It has the highest test accuracy (0.83), which is clearly better than Logistic Regression (0.76) and kNN (0.75). The train/test gap (0.88 - 0.83 = 0.05) is reasonable and doesn't indicate severe overfitting. It generalizes best to new customers.

### Q2: Coefficient vs. feature importance for tenure_months

**The Logistic Regression coefficient for tenure_months is -0.41.** The negative sign tells you the direction: as tenure_months increases, the model predicts the customer is *less* likely to churn. Longer-tenured customers tend to stay.

**The Decision Tree feature importance for tenure_months is 0.31.** This tells you tenure_months is the second most important feature — the tree used it heavily for making decisions. But importance doesn't tell you the direction. You can't determine from 0.31 alone whether longer tenure makes churn more or less likely.

**Key insight:** Coefficients give you both *how much* and *which direction*. Feature importance gives you only *how much*.

### Q3: Why can't kNN tell you which features matter?

kNN makes predictions by finding the k nearest training examples and taking a vote. It stores data and searches — it doesn't learn any internal representation like weights, coefficients, or a tree structure. Because there are no learned parameters to inspect, there is no way to determine which features contributed most to a prediction. kNN is a "black box" in terms of feature contribution — it just looks at everything equally when calculating distances.

### Q4: Practical trade-offs beyond test accuracy

Students could mention several valid trade-offs:

- **Interpretability:** Decision trees can be visualized and explained as a series of rules. This could matter if the telecom company needs to explain to customers *why* they were flagged. Logistic Regression coefficients are also interpretable (direction + magnitude). kNN offers no interpretability.
- **Feature scaling:** kNN and Logistic Regression require feature scaling (standardization). Decision trees do not. If features are on very different scales (monthly_charges in dollars vs. contract_length in months), trees are more convenient.
- **Feature interactions:** Trees capture interactions automatically (e.g., high charges AND short tenure → churn). Linear models would need manually engineered interaction features.
- **Prediction speed:** kNN is slow at prediction time (searches all training data). Trees and Logistic Regression are fast.
- **Robustness:** Single decision trees can be unstable — small changes in data can produce very different trees. Ensemble methods (Random Forests, Gradient Boosting) address this.

---

## Video Section D: When to Use Decision Trees (Scenario C)

### Q1: Would a decision tree be a good starting point? Why or why not?

**Yes, a decision tree would be a strong starting point for this problem.** Key reasons:

- **Mixed feature types:** The data includes both numeric vitals (blood pressure, heart rate) and categorical diagnoses (diabetes, heart disease). Decision trees handle mixed types naturally without requiring encoding or scaling.
- **No feature scaling needed:** With 50 features on very different scales (heart rate in bpm, age in years, binary diagnosis flags), not needing to standardize is a practical advantage.
- **Interpretability:** Clinical staff need to understand *why* the model flags patients. A decision tree produces a hierarchy of if-else rules that can be explained to non-technical medical staff (e.g., "if length of stay > 7 days AND prior admissions > 2 AND diabetic, flag for readmission risk").
- **Feature interactions:** Medical risk often involves interactions (e.g., high blood pressure combined with diabetes is riskier than either alone). Trees capture these automatically.

**Caveat:** A single decision tree may overfit with 50 features. In practice, ensemble methods like Random Forests or Gradient Boosting would likely perform better while retaining the tree-based advantages.

### Q2: Advantages over kNN and linear models for this problem

**Over kNN:**
- Trees don't require feature scaling (critical with 50 features on different scales)
- Trees provide feature importance (know which vitals/diagnoses matter most)
- Trees are faster at prediction time (important in a clinical setting)
- kNN would be very slow with 5,000 patients and 50 features

**Over linear models:**
- Trees handle mixed numeric/categorical features without encoding
- Trees capture feature interactions automatically (medical risk factors often interact)
- Trees don't assume a linear relationship between features and readmission risk
- Tree decision paths may be more intuitive for clinical staff than a weighted formula

---

## Video Rubric Quick Reference

**Strong responses should demonstrate:**
- Correct identification of overfitting/underfitting from training vs. test scores
- Clear reasoning for model selection based on test accuracy
- Accurate interpretation of feature importance (including the limitation of no direction)
- Understanding of how coefficients differ from importance (direction + magnitude vs. magnitude only)
- Concrete, specific references to the case study data (not generic answers)
- Clear explanation of when trees are advantageous over other algorithms

**Common errors to watch for:**
- Confusing training accuracy with test accuracy when recommending a model
- Claiming feature importance shows direction (it does not)
- Saying kNN learns weights or coefficients
- Not connecting max_depth to the overfitting/underfitting pattern in the data
- Generic "trees are better" claims without specific reasoning tied to the scenario
