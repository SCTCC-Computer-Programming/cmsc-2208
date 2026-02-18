# Week 7 Overview Video Script

---

Hello everyone, and welcome to Week 7 of Introduction to Machine Learning with Python.

This week is special because it's our last week with Chapter 2. You've spent the past several weeks building up a toolkit of supervised learning algorithms: kNN (kay-en-en), linear models, and decision trees. Each one makes predictions differently, but they all share the same workflow: fit, predict, score.

Every time you've used a classifier, you've called .predict() (dot predict) and gotten a label back, or called .score() (dot score) and gotten an accuracy number. Those tools tell you what the model predicts and how often it's right overall. But they don't tell you how confident the model is about any individual prediction, and that turns out to matter quite a bit.

Imagine you're predicting whether students will pass or fail, and you get two fail predictions. One student has a 95% probability of failing. The other has a 52% probability of failing. Both get the same label from .predict(), but they're completely different situations. If you're deciding who needs extra support, you'd want to know which predictions are strong and which are basically coin flips.

This week gives you the tools to see that difference. You'll learn two methods that go beyond .predict() to reveal that confidence: predict_proba (predict probe-uh) and decision_function (decision function). predict_proba gives you probabilities for each class, values between 0 and 1 that are straightforward to interpret. decision_function gives you raw confidence scores on an arbitrary scale, which are less intuitive but available on more classifiers.

Let me walk you through the materials for this week.

The textbook reading covers pages 119 through 128, the Uncertainty Estimates from Classifiers section. Read through the Chapter 2 Summary and Outlook as well, since this is our last week with this chapter. The textbook uses GradientBoostingClassifier (gradient boosting classifier) for its examples and extends everything to multiclass problems with three or more classes. It also introduces the concept of calibration, which is whether a model's reported confidence actually matches how often it's correct.

The demo applies predict_proba and decision_function to LogisticRegression (logistic regression) on the student performance dataset you've been using since Week 3. It walks through what each method returns, how the outputs connect to .predict(), and then uses confidence levels to show that high-confidence predictions are much more accurate than uncertain ones. One thing to note: the last section of the demo uses a NumPy (num-pee) technique called boolean indexing to filter arrays by conditions. The demo includes a full explanation of how boolean indexing works before the code that uses it, so read through that carefully if it's new to you.

The quiz covers predict_proba, decision_function, how they compare, and when you'd use one over the other. It also covers calibration and multiclass extensions from the textbook. Multiple choice, matching, and multi-select questions, same format as previous weeks.

As you work through the materials, there are a few concepts I want you to focus on. Pay close attention to what predict_proba and decision_function each return and how their outputs differ. They both measure confidence, but they express it in very different ways, and understanding those differences will help you know when to use one over the other. The demo walks through both side by side, so take your time comparing them.

Also pay attention to the connection between confidence and accuracy. The demo breaks students into confidence tiers, and you'll see that the pattern is clear: when the model is very confident, it's almost always right, but when it's near 50/50, it's barely better than guessing. This is the practical payoff of uncertainty estimates.

Since this is our last week with Chapter 2, it's worth stepping back to see how far you've come. You started with kNN in Week 2, a simple algorithm that stores data and finds similar examples. You moved to linear models in Weeks 3 and 4, learning about weighted formulas, regularization, and interpreting coefficients. Then decision trees in Weeks 5 and 6, with their hierarchy of questions, max_depth (max depth) for complexity control, and feature importance. Now this week, you've added the ability to assess how much you should trust each individual prediction. That's a complete supervised learning toolkit.

Looking ahead, Chapter 3 shifts to unsupervised learning and preprocessing. The big change is that there are no labels. Instead of predicting outcomes, you'll be finding structure in data, things like clustering and dimensionality reduction, and learning how to prepare data properly before feeding it to models. The supervised learning skills you've built don't go away. They're the foundation that everything else builds on.

Alright, so for this week: read the Uncertainty Estimates section and the Chapter 2 Summary, work through the Week 7 demo, and complete the quiz. This is the capstone of Chapter 2, and it ties together everything you've learned about how classifiers work.

That's it for the Week 7 overview. Go ahead and get started with the materials.
