# Week 3 Demo Walkthrough Script

---

Hello everyone, and welcome to the Week 3 demo walkthrough. Today we're going to explore linear models—specifically Ridge Regression and Logistic Regression. This is a substantial shift from what we did last week with k-Nearest Neighbors, so let's start by understanding what makes linear models different.

## Understanding Linear Models

Last week, kNN made predictions by storing all the training data and searching through it to find similar examples. Linear models work completely differently. Instead of storing data, they **learn a formula**—a weighted combination of features—during training, and then use that same formula for every prediction.

Here's the key idea: imagine you're predicting a student's final score based on their homework, quiz, and exam grades. A linear model would learn a formula like this: predicted_score equals w1 times homework, plus w2 times quiz, plus w3 times exam, plus some constant. Those w values—the weights—are what the model learns during training.

The training process tries many different combinations of weights to see which ones give the most accurate predictions. It might try w1 equals 0.1, w2 equals 0.1, w3 equals 0.1, and find that predictions are terrible. Then it tries different values, keeps adjusting, until it finds the combination that minimizes prediction errors. This happens automatically when you call the fit method—you don't manually search for weights.

What makes this fundamentally different from kNN? Linear models learn a formula while kNN stores data. Linear models have a real training phase where they solve for optimal weights, while kNN just stores data. Linear models use the same formula for everyone, while kNN looks at nearby neighbors. And crucially, linear models can tell you which features matter by showing you the learned weights—kNN can't do that.

In this demo, we'll work with two specific linear models: Ridge Regression for predicting numbers, and Logistic Regression for predicting categories.

## Ridge Regression Setup

Let's start with Ridge Regression. Ridge is for regression tasks—predicting numeric values like final scores. The prediction formula has a weight for each feature, and those weights get multiplied by the feature values and added together, along with an intercept.

The way weights work is straightforward: larger absolute values mean that feature has more impact on predictions. If the weight for quiz average is 0.5 and the weight for attendance is 0.1, then quiz average has five times more influence. A weight of zero means that feature doesn't matter. Negative weights mean as the feature increases, the prediction decreases.

Ridge uses something called **regularization**, which means it prefers smaller weights. Why does this matter? When weights get very large, the model becomes overly sensitive to small changes in the data. It's like the difference between a recipe that says "add exactly 247 grains of salt" versus "add a pinch of salt." The first is overly precise and fragile; the second is more robust. Ridge tries to keep weights modest, which helps prevent overfitting.

The **alpha parameter** controls how large the weights can be. Small alpha allows large weights—the model can be very sensitive to each feature, which might fit your training data perfectly but fail on new data. Large alpha forces weights to stay small—the model is less sensitive to any single factor, more stable, and generalizes better. For this demo, we're using alpha equals 1.0, which is scikit-learn's default and represents moderate regularization.

Now, when we evaluate Ridge, we use a metric called **R-squared**, or R². The score method returns this automatically. R² ranges from 0 to 1 and tells us how much of the variation in the data our model explains. 1.0 means perfect predictions. 0.5 means okay predictions—the model captures some patterns but misses others. 0.0 means the model is no better than just guessing the average every time. We want both training and test R² to be reasonably high and close together.

## Creating the Student Dataset

For this demo, we're creating a synthetic dataset of 300 students. Each student has four features: attendance percentage, homework completion rate, quiz average, and exam average. We calculate a final score based on a weighted combination: 20% homework, 30% quiz, 50% exam. Notice we're not using attendance in the formula—this is intentional, because we want to see if the model figures this out.

We also add some random noise to the final scores to represent unpredictable factors—maybe a student had a headache during the exam, or got lucky on multiple choice, or studied extra hard one week. This makes our data more realistic.

We also create a pass-fail label based on whether the final score is 70 or above. We'll use this later for Logistic Regression, but for now we're focusing on predicting the numeric final score.

**[RUN CELL: Create the dataset]**

Let me run this cell now. You can see the output shows we have 300 students with 4 features, and the first few rows of the dataset are displayed.

After creating the data, we split it into features and target. X is our four input columns—attendance, homework rate, quiz average, exam average. y is what we're trying to predict—the final score. Then we split both X and y into training and test sets: 75% for training (about 225 students), 25% for testing (about 75 students). This is the same train-test framework we used with kNN.

**[RUN CELL: Prepare the data]**

Running this cell, we see we have 225 students in the training set and 75 in the test set.

## Training Ridge Regression

Now we're ready to train our Ridge model. We create a Ridge object with alpha equals 1.0, then call fit on the training data. This is where the learning happens—the model finds the optimal weights.

After training, we evaluate the model on both training and test sets by calling the score method. For Ridge Regression, the score method automatically calculates R² for us. We call ridge.score with X_train and y_train to see how well the model fits the training data, then call ridge.score again with X_test and y_test to see how well it performs on new data it hasn't seen before. This gives us two R² values—one for training, one for testing.

**[RUN CELL: Train Ridge model]**

Let me run this and look at what we get.

Training R² is 0.791. That means the model explains about 79% of the variation in the training data. That's pretty good—it's capturing most of the patterns. Test R² is 0.776, explaining about 78% of the variation in the test data. Again, pretty good. More importantly, notice these two scores are very close together—the difference is only 0.015. This tells us the model is generalizing well. If training R² were much higher than test R², that would indicate overfitting.

Now let's look at what the model learned. The learned weights are 0.034 for attendance, 0.196 for homework rate, 0.299 for quiz average, and 0.504 for exam average. Compare these to our true formula: we used 0.2 for homework, 0.3 for quiz, 0.5 for exam. The model learned weights that are very close to reality. The homework weight is 0.196 versus our true 0.2. Quiz is 0.299 versus 0.3. Exam is 0.504 versus 0.5. It correctly figured out the pattern.

What about attendance? We didn't use attendance in the formula at all, yet the model gave it a small weight of 0.034. This happens because Ridge finds small correlations in the data. Even though attendance doesn't directly affect final scores in our formula, there might be slight random correlations in this particular dataset. Ridge keeps the weight small because of regularization, but doesn't eliminate it entirely.

The intercept is negative 2.90. Think of the intercept as the starting point or baseline of your predictions. It's what the model would predict if all the features were zero. But more practically, it adjusts the overall prediction up or down to match the scale of your data.

Here's why we need it: when the model multiplies features by weights and adds them up, that weighted sum might naturally fall in the range of, say, 50 to 90. But if our actual final scores range from 40 to 100, the intercept shifts everything up or down to align with reality. In this case, the negative 2.90 adjusts predictions slightly downward. It gets added to every prediction to ensure the model's outputs are calibrated to the scale of the final scores.

So what does this tell us? The model is working well. It learned weights that closely match the true relationship, and it performs similarly on training and test data. No overfitting.

## Logistic Regression for Classification

Now let's shift to Logistic Regression. Despite the name containing "regression," Logistic Regression is actually for classification—predicting categories. In our case, we're predicting pass or fail based on the same four features.

Logistic Regression works similarly to Ridge in that it learns weights for each feature and combines them in a formula. But instead of outputting the weighted sum directly as a prediction, it converts that sum into a probability between 0 and 1. If the probability is above 0.5, it predicts pass. Otherwise, it predicts fail.

The key differences from Ridge: Ridge predicts numbers, Logistic predicts categories. Ridge uses R² as its metric, Logistic uses accuracy—the percentage of correct predictions. Ridge outputs the weighted sum directly, Logistic converts it to a probability first.

Logistic has a parameter called **C** that controls regularization, similar to Ridge's alpha. But—and this is important—C works in the opposite direction. Small C means strong regularization and small weights. Large C means weak regularization and larger weights. This is backwards from alpha. Higher alpha meant more regularization, but higher C means less regularization. This takes practice to remember.

For this demo, we're using C equals 1.0, the default, which represents moderate regularization.

## Setting Up for Classification

We use the same dataset and the same four features, but this time our target is the pass-fail label instead of the numeric final score. We split the data the same way: 75% training, 25% test.

Remember that our final scores were based on 20% homework, 30% quiz, 50% exam. Students pass if their final score is 70 or above. So exam scores matter most for passing, quizzes matter moderately, homework matters least, and attendance doesn't matter at all because it wasn't in the formula.

A well-trained Logistic Regression model should learn weights that reflect this. Exam should get the largest weight, quiz should be moderate, homework should be small, and attendance should be near zero.

**[RUN CELL: Prepare classification data]**

Running this cell, we again see 225 students in training, 75 in test.

## Training Logistic Regression

We create a Logistic Regression object with C equals 1.0, set max_iter to 1000 to give it enough time to find optimal weights, and call fit on the training data. Then we evaluate on both training and test sets.

After training, we use the score method to evaluate the model. For Logistic Regression, the score method automatically calculates accuracy for us—the percentage of predictions that are correct. We call logreg.score with X_train_class and y_train_class to see how well the model classifies the training data, then call logreg.score again with X_test_class and y_test_class to see how well it performs on new data. This gives us two accuracy values—one for training, one for testing.

**[RUN CELL: Train Logistic Regression model]**

Let me run this cell and examine the results.

Training accuracy is 0.867—the model correctly predicted pass or fail for about 87% of training students. Test accuracy is 0.907—about 91% of test students. Both are pretty good, and notice the test accuracy is actually slightly higher than training accuracy. This is unusual but can happen with smaller datasets. It suggests we're definitely not overfitting.

Now let's examine the learned weights. The four weights are negative 0.007 for attendance, 0.059 for homework rate, 0.101 for quiz average, and 0.190 for exam average.

Look at the pattern: exam average has the largest weight at 0.190. This makes sense because exams were worth 50% of the final score. Quiz average has the second largest weight at 0.101, matching its 30% contribution. Homework rate has a smaller weight at 0.059, matching its 20% contribution. And attendance has a weight very close to zero at negative 0.007, which makes sense because we didn't use attendance when creating final scores.

The model correctly learned which features actually matter for predicting pass or fail. The relative magnitudes of the weights—exam much larger than quiz, quiz larger than homework, attendance near zero—match the true importance of these features.

The intercept is negative 24.03. This is a fairly large negative number, and what it does is shift the decision boundary. It means the weighted sum needs to be fairly positive—above 24 or so—before the model predicts "pass" with high confidence. This is just the model calibrating its predictions to match the data.

## Summary and Key Takeaways

We've now worked with three supervised learning algorithms: kNN from last week, and Ridge and Logistic Regression from this week.

In this demo, we focused on the basic workflow: how to train these models with default parameters, how to interpret the output—R² scores for Ridge, accuracy for Logistic, and the learned weights for both—and how both models show feature importance through their weights, which kNN cannot do.

Let's compare the complexity parameters across all three algorithms. kNN uses n_neighbors to control complexity—large k means simpler model, small k means more complex. Ridge uses alpha—large alpha means simpler, small alpha means more complex. Logistic uses C—and here's where it flips—small C means simpler, large C means more complex. Ridge's alpha and Logistic's C work in opposite directions. This takes practice to internalize.

Here are the key takeaways. First, all three algorithms use the same workflow: split data into train and test, train the model, evaluate performance. The framework is consistent even though the algorithms are different.

Second, Ridge and Logistic learn weights that show which features are important. kNN doesn't give you this insight.

Third, Ridge is for predicting numbers—regression. Logistic is for predicting categories—classification. Use the right tool for the task.

Fourth, default parameters like alpha equals 1.0 and C equals 1.0 often work well for initial exploration. You don't need to tune parameters right away.

Fifth, you can examine learned weights to understand what the model thinks is important. In both our examples, the models learned weights that matched the true patterns in the data.

## What's in the Textbook

This demo showed you the basic workflow for Ridge and Logistic Regression using default parameters. The textbook covers important topics we didn't demonstrate here.

Parameter tuning: how to systematically try different values of alpha and C to find the best model for your data.

Overfitting and underfitting: concrete examples showing what happens when regularization is too weak or too strong.

Learning curves: visualizations showing how model performance changes as you vary parameters or add more training data.

Lasso Regression: another regularized linear model that uses L1 regularization instead of L2. The key difference is Lasso can drive some coefficients exactly to zero, effectively removing features. This is useful when you expect only a few features to be important.

And guidance on when to use each model: detailed comparisons between Linear Regression, Ridge, and Lasso.

## Closing

Alright, that wraps up the Week 3 demo walkthrough. You've seen how linear models learn formulas instead of storing data, how regularization prevents overfitting, how to interpret R² and accuracy scores, and how to understand feature importance through learned weights.

Take your time working through the demo code yourself. Run each cell, look at the outputs, make sure the numbers make sense. The textbook will extend these concepts to variations like Lasso and ElasticNet, but once you understand Ridge and Logistic, those extensions will make sense—they're all variations on the same theme.

Good luck with the materials, and I'll see you in Week 4.
