# Week 5 Demo Walkthrough Script

---

Hello everyone, and welcome to the Week 5 demo walkthrough. Today we're exploring decision trees—a fundamentally different approach to machine learning from anything we've seen so far. This is exciting because decision trees solve problems in a way that's both powerful and interpretable.

## Understanding Decision Trees

Let's start by understanding what makes decision trees unique. We've now seen two very different approaches to supervised learning. Week 2 introduced k-Nearest Neighbors, which makes predictions by storing all the training data and searching through it to find similar examples. Week 3 introduced linear models like Ridge and Logistic Regression, which learn a formula—a weighted combination of features—and use that formula for every prediction.

Decision trees do something completely different. They learn a **hierarchy of questions** during training. Think of it like playing 20 Questions. When you're trying to identify something, you ask a series of yes-or-no questions where each answer leads to another question, until you reach a final decision. That's exactly how decision trees work.

Let me give you a concrete example to make this clear. Imagine you're trying to classify four types of snacks: chips, ice cream, an apple, and a chocolate bar. You want to build a decision tree that can identify which snack you're looking at by asking as few questions as possible.

The tree might start with: "Does it need to be kept frozen?" This is the root question—the first split. If the answer is yes, you immediately know it's ice cream, because the other three snacks don't require freezing. So you've identified one snack and eliminated three possibilities with just one question.

Now, what if the snack doesn't need to be kept frozen? Then you know it's either chips, an apple, or a chocolate bar. So you ask a follow-up question: "Is it a whole, unprocessed food?" If yes, it's an apple. If no, you know it's either chips or chocolate bar.

For that last group—the processed snacks—you ask one more question: "Is it crunchy?" If yes, it's chips. If no, it's a chocolate bar. You've reached a final answer.

Notice the structure: you start at the root with one question that splits your data into groups. Then, for each group, you ask another question that splits it further. You keep splitting until each group contains only one type of snack. Each final group is called a leaf, and that's where you make your prediction.

The tree has learned a set of rules:
- If frozen → ice cream
- If not frozen AND whole food → apple
- If not frozen AND processed AND crunchy → chips
- If not frozen AND processed AND not crunchy → chocolate bar

Now here's the crucial part: during training, the algorithm figures out which questions to ask and in what order, completely automatically. It looks at your data and your features, and it decides: "What's the best first question to ask? What splits the data most effectively?" Then, for each branch that results from that split, it asks: "What's the best next question for this subset of the data?"

In our student data, the algorithm will look at all possible questions it could ask: "Is attendance greater than 70?" "Is homework_rate above 80?" "Is exam_avg greater than 65?" For each possible question, it calculates: "If I split the students based on this question, how well does it separate pass from fail?" It picks the question that does the best job, makes that split, and then repeats the process on each resulting group.

This recursive splitting continues until the tree reaches a stopping point—either because all the students in a group have the same outcome (pure leaf), or because we've imposed a limit like max_depth.

The beauty of decision trees is that this entire process—figuring out which questions to ask, in what order, and when to stop—happens automatically when you call fit. The algorithm builds the entire tree structure for you.

What makes this fundamentally different? kNN stores data and searches. Linear models learn a formula. Decision trees learn a hierarchy of rules. Each approach has different strengths, and understanding when to use which one is part of becoming a good data scientist.

## The Student Dataset

For this demo, we're using the same student performance dataset we've used in previous weeks. We have 300 students, each with four features: attendance percentage, homework completion rate, quiz average, and exam average. We're predicting pass or fail based on these features.

Using the same dataset helps you focus on understanding the new algorithm without having to learn a new domain. You already know what these features mean and what patterns exist in the data.

**[RUN CELL: Create the dataset]**

Running this cell, we see our 300 students split into 157 who passed and 143 who failed. The class distribution is fairly balanced, which is good for training.

## Building Your First Decision Tree

Now we're ready to build our first decision tree. We create a DecisionTreeClassifier—this is scikit-learn's decision tree class for classification, imported from sklearn.tree just like we imported Ridge from sklearn.linear_model in Week 3. We create it with default settings, which means we're not specifying any parameters. The most important default to understand: there's no max_depth limit. Without a depth limit, the tree will keep growing until all leaves are pure—meaning it can perfectly memorize the training data. Then we call fit on the training data. Let me explain what happens during that training step.

When we call fit, the algorithm builds the tree structure. It starts at the root—the very first question—and looks at all possible questions it could ask about all four features. For each possible question, it evaluates: "If I split the data based on this question, how well does it separate pass from fail?" It picks the question that does the best job of separating the classes.

Then, for each branch that results from that split, it repeats the process. It looks at all the students who went down the left branch and asks: "What's the best next question to separate these students?" It does the same for the right branch. This continues recursively, building deeper and deeper into the tree, until it reaches a stopping point.

By default, with no restrictions, the tree keeps growing until each leaf is "pure"—meaning all the students in that leaf have the same outcome. This creates a very detailed tree that can perfectly memorize the training data.

**[RUN CELL: Train the default tree]**

After training, we can inspect what was built. The output shows us the tree has a depth of 7 and 39 leaves. 

Tree depth tells us the longest path from the root to any leaf—the maximum number of questions the tree can ask in sequence for any student. A depth of 7 means for some students, the tree asks 7 questions before reaching a decision.

The number of leaves tells us how many final decision points exist. Each leaf represents a different outcome based on a different path through the tree. With 39 leaves, the tree has created 39 different "rules" or "paths" that students can follow to reach a prediction.

## Evaluating the Tree

Now let's look at how well this tree performs. We evaluate the model using the .score() method—the same method we used with kNN and linear models in previous weeks. For classification tasks, .score() returns accuracy: the fraction of predictions that are correct. We call tree.score() on both the training data and test data to compare performance.

**[RUN CELL: Evaluate the model]**

Training accuracy is 1.000—perfect. The tree correctly predicted every single student in the training set. Test accuracy is 0.813—about 81% correct on students the tree has never seen before.

This pattern is very common with decision trees. Perfect or near-perfect training accuracy happens because the tree can grow deep enough to memorize individual training examples. Each pure leaf essentially memorizes a small group of training students.

But notice the gap: training is 1.000, test is 0.813. That's a difference of about 0.19, which suggests some overfitting. The tree learned some details that were specific to the training set but don't generalize to new students.

This is the fundamental challenge with decision trees: they're prone to overfitting. If you let them grow without restrictions, they'll memorize training data rather than learning general patterns. This is where the max_depth parameter becomes crucial.

## Controlling Complexity with max_depth

The most important parameter for controlling decision tree complexity is max_depth. This is a parameter you pass when creating a DecisionTreeClassifier, just like we passed alpha to Ridge or C to LogisticRegression in Week 3. The max_depth parameter limits how many questions the tree can ask in sequence.

Think of it this way: max_depth=1 means the tree can only ask one question total. "Is exam_avg above 70?" Done. That's it. That's a very simple model—probably too simple. max_depth=5 means the tree can ask up to 5 questions in a row. That's more detailed, more nuanced. No depth limit means the tree can ask as many questions as needed to perfectly separate the training data—which often leads to overfitting.

The deeper you let the tree grow, the more complex it becomes. More questions means more specific rules, more detailed decision-making, but also more risk of memorizing noise in the training data.

In the demo, we train five different trees with depths 1, 2, 3, 5, and unlimited. To specify unlimited depth, we pass max_depth=None to DecisionTreeClassifier—this tells it there's no restriction. Then we compare their performance.

**[RUN CELL: max_depth comparison]**

Look at the table that's produced. This table is created by training each tree, recording its results, and organizing everything in a DataFrame so we can see the patterns clearly. Let's examine what we find.

First, notice how the number of leaves increases with depth. Depth 1 has just 2 leaves—one question creates two possible outcomes. Depth 2 has 4 leaves. Depth 5 has 24 leaves. Unlimited depth has 39 leaves. More questions means more possible paths, more possible outcomes.

Second, training accuracy generally increases with depth. Depth 1 achieves 0.791 on training. Depth 5 achieves 0.951. Unlimited depth achieves perfect 1.000. Deeper trees fit the training data better.

But here's the interesting part: test accuracy doesn't increase with depth. In fact, depth 1 achieves the highest test accuracy at 0.840. Depth 5 achieves 0.827. Unlimited depth drops to 0.813.

Why does depth 1 perform so well? Because this is clean, synthetic data with straightforward patterns. Asking just one question—"Is exam_avg high enough?"—captures most of the signal. The exam scores were 50% of the final grade formula, so they're the most predictive feature. One good split is enough.

This is an important teaching moment: simpler models can outperform complex ones when the data has clear patterns. The unlimited depth tree achieves perfect training accuracy but lower test accuracy because it's memorizing details that don't generalize.

Now, this pattern is specific to this clean dataset. On real-world messy data—like the Breast Cancer dataset in the textbook—you'll typically see very shallow trees underfit. Usually depths around 3 to 5 provide the best balance. But on our data, simplicity wins.

**[RUN CELL: Visualize the comparison]**

The plot shows these same patterns visually. Training accuracy increases steadily from left to right as depth increases. Test accuracy peaks at depth 1, stays strong in the middle depths, and doesn't improve with unlimited depth. This visualization makes it clear: deeper doesn't always mean better.

## Understanding Feature Importance

One of the most valuable aspects of decision trees is that they can tell you which features matter most for making predictions. This is called feature importance.

Feature importance is a number between 0 and 1 for each feature. Zero means the feature was never used in the tree. One would mean this feature alone perfectly separates the classes. Higher values mean the feature is more important. The importances always sum to 1.0.

How does the tree calculate this? It looks at each split in the tree and measures how much that split improved the predictions. Splits higher in the tree affect more students, so they tend to be more important. Splits that create better separation between classes are more important. The tree aggregates all of this across the entire structure to produce a single importance score for each feature.

In the demo, we train a tree with max_depth=5—a reasonable middle ground—and then extract its feature importances. Feature importances are stored in an attribute called feature_importances_, similar to how linear models store their learned weights in coef_ from Week 3. This attribute is automatically calculated after training and gives us one importance value per feature.

**[RUN CELL: Feature importance]**

Look at the results. exam_avg has importance 0.539—meaning about 54% of the tree's decision-making power comes from exam scores. quiz_avg has 0.247—about 25%. homework_rate has 0.163—about 16%. attendance has 0.051—just 5%.

This makes sense given how we created the data. Final scores were based on 50% exam, 30% quiz, 20% homework, and 0% attendance. The tree correctly learned that exam scores matter most, quiz scores matter moderately, homework matters somewhat, and attendance barely matters at all.

This is a huge advantage over k-Nearest Neighbors. kNN can't tell you which features are important—it just uses all of them equally. Linear models show importance through their coefficients, but the interpretation is different. Trees give you a clear ranking: here are the features that mattered most for making decisions.

One important note: tree feature importance is always positive. It tells you how much a feature matters, but not the direction. You don't know if high exam scores mean pass or fail—just that exam scores are important for the decision. Linear model coefficients give you direction—positive means as the feature increases, the prediction increases. Negative means the opposite. Both types of information are useful, just different.

**[RUN CELL: Visualize feature importance]**

The plot shows this ranking visually. exam_avg dominates with the longest bar. quiz_avg is second. homework_rate is third. attendance has the shortest bar. This makes it easy to communicate to others: "The model primarily uses exam scores to make its decisions, with quiz scores playing a supporting role."

## Comparing Decision Trees to Other Models

Now that you've worked with decision trees, let's compare them to the other algorithms we've learned.

Decision trees versus kNN: kNN is fast to train—it just stores data—but slow to predict because it has to search through all the training examples. Trees are slower to train—building the tree structure takes work—but very fast to predict because you just follow one path down the tree. kNN requires feature scaling because distances matter. Trees don't require scaling because each question looks at one feature at a time. kNN can't tell you which features are important. Trees can.

Decision trees versus linear models: Linear models learn a global formula that applies everywhere. Trees learn local rules—different rules for different regions of the feature space. Linear model decision boundaries are straight lines or planes. Tree decision boundaries are axis-parallel rectangles—they can only split based on one feature at a time, creating box-like regions. Linear models require you to specify feature interactions—like "attendance times homework_rate." Trees capture interactions automatically—if attendance is high AND homework rate is high, that's just a path through the tree. Both are interpretable but in different ways.

When should you use decision trees? When features are on different scales and you don't want to standardize. When you have a mix of numeric and categorical features. When you need a model you can explain to non-technical stakeholders—you can literally draw the tree and show the decision path. When feature interactions matter and you want the model to find them automatically. When interpretability is important.

When should you use other models? When you need the absolute best accuracy, you'll often turn to ensembles of trees—Random Forests or Gradient Boosting—which we'll read about in the textbook. When you have high-dimensional sparse data like text, linear models often work better. When you have very little training data, simpler models like linear models might generalize better than complex trees.

## Key Takeaways

Let me summarize the key concepts from this demo.

First, decision trees learn a hierarchy of if-else questions during training, then follow that path to make predictions. This is fundamentally different from storing data like kNN or learning a formula like linear models.

Second, the max_depth parameter controls tree complexity. Deeper trees can ask more questions, creating more detailed decision-making but also more risk of overfitting. On this clean dataset, depth 1 actually performed best, but that's unusual—typically you'd use moderate depths like 3 to 5.

Third, feature importance shows which features the tree used most for making decisions. This provides valuable insight into what drives predictions.

Fourth, trees don't require feature scaling, unlike kNN and linear models. Each question looks at one feature independently, so the scale doesn't matter.

Fifth, on clean synthetic data, trees may not show obvious overfitting patterns. Real-world messy data—like the examples in the textbook—typically shows more dramatic overfitting with deep trees.

Sixth, trees are easy to interpret but can overfit on complex data without proper depth limits. Finding the right depth is a balance between capturing patterns and avoiding memorization.

## The Challenge with Single Decision Trees

Here's the fundamental challenge: single decision trees tend to overfit on complex, noisy data. When you have real-world data with lots of uncertainty and random variation, trees often memorize training examples rather than learning general patterns.

On our clean student data, this isn't a major problem. The relationships are straightforward—high exam scores generally mean passing—so the tree can learn useful rules without too much overfitting. But on datasets like medical diagnosis with lots of noise and uncertainty, customer behavior with many random factors, or image classification with high-dimensional complex patterns, single trees often struggle.

This is where ensembles come in.

## What's in the Textbook

The textbook introduces solutions to this overfitting problem. The most important are ensemble methods—techniques that combine many trees to create more powerful models.

Random Forests build hundreds of trees, each slightly different. Each tree sees a random subset of the data and a random subset of the features. Then they average all the predictions. The result is much more robust and much less prone to overfitting. Random Forests are currently among the most widely used machine learning methods in practice.

Gradient Boosting builds trees one at a time in a serial manner. Each new tree focuses specifically on correcting the mistakes of the previous trees. The result often achieves the best performance, but requires more careful tuning of parameters.

Both of these ensemble methods keep all the benefits of trees—no scaling needed, can handle mixed feature types, interpretable through feature importance—while dramatically reducing overfitting.

The textbook also covers tree visualization using graphviz, so you can actually see the tree structure with all its questions and branches. It covers additional complexity control parameters like max_leaf_nodes and min_samples_split—different ways to prevent overfitting. It covers DecisionTreeRegressor for predicting numbers instead of categories. And it shows clear overfitting examples using the Breast Cancer and make_moons datasets where unlimited depth clearly fails.

## Closing

That wraps up the Week 5 demo walkthrough. You've seen how decision trees learn hierarchies of questions, how max_depth controls complexity, how feature importance reveals what matters for predictions, and how trees compare to the other algorithms we've learned.

The key conceptual shift is understanding that trees partition the feature space into rectangular regions through a series of questions, rather than storing data or learning a global formula. Each approach—kNN, linear models, and trees—solves the same prediction problem but in fundamentally different ways.

Take your time working through the demo code yourself. Run each cell, look at the outputs, especially the max_depth comparison table and the feature importance rankings. Make sure the patterns make sense to you. The textbook will extend these concepts to Random Forests and Gradient Boosting, which fix the overfitting problem and often become your go-to algorithms in practice.

Good luck with the materials, and I'll see you in Week 6.
