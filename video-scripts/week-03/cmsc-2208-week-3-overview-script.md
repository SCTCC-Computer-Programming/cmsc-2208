# Week 3 Overview Video Script

------

Hello everyone, and welcome to Week 3 of Introduction to Machine Learning with Python.

Last week, you learned about k-Nearest Neighbors, which makes predictions by finding similar examples in the training data. kNN is intuitive and powerful, but it has limitations—it stores all the training data, it can be slow with large datasets, and it can't tell you which features actually matter for making predictions.

This week, we're shifting to a completely different approach: **linear models**. Instead of storing data and searching through it, linear models learn a formula—a weighted combination of features—and use that formula to make predictions. This is a fundamental shift in how we think about machine learning.

## What You'll Learn This Week

The core idea behind linear models is simple: each feature gets a weight that shows how much it contributes to the prediction. If you're predicting a student's final grade, the model might learn that exam scores matter more than homework scores by giving the exam feature a larger weight. During training, the model automatically figures out what those weights should be.

But there's a challenge: if we let the model learn any weights it wants, it might create very large weights that fit the training data perfectly but fail on new data. That's overfitting. So linear models use something called **regularization** to keep the weights reasonable. The key parameters—alpha for Ridge Regression and C for Logistic Regression—control how much regularization to apply.

Here's what can be confusing at first: these parameters work in opposite directions. Larger alpha means more regularization, which means a simpler model. But larger C means less regularization, which means a more complex model. This takes some practice to internalize, so pay attention to this when you work through the demo.

## Your Week 3 Tasks

Let me walk you through what you need to do this week.

**First**, you'll read Chapter 2, pages 45 through 70. This section covers linear models for both regression and classification. You'll encounter several algorithms: Ridge Regression, Lasso, LogisticRegression, LinearSVC, and Naive Bayes. Don't feel like you need to master all of these from the reading alone—the demo will help clarify the core concepts.

**Second**, work through the Week 3 demo. The demo focuses on two specific algorithms: Ridge Regression for predicting numeric values, and Logistic Regression for predicting categories. I've chosen these two because once you understand how they work, the other linear models become much easier to grasp. They're all variations on the same theme.

In the demo, you'll train models with default parameters, interpret the performance scores—R² for regression and accuracy for classification—and examine the learned weights to see which features the model thinks are important. The demo walks you through the code step by step with detailed explanations, so take your time with it.

Here's an important point about the relationship between the demo and the textbook: The demo gives you hands-on experience with the core workflow and concepts. The textbook then extends those concepts to show you variations. For example, once you understand Ridge Regression and L2 regularization from the demo, you'll be able to understand Lasso and L1 regularization from the textbook reading—it's the same idea with a different penalty. The demo provides the foundation; the textbook shows you the variations.

**Third**, you'll complete the Week 3 D2L quiz. The quiz covers concepts from both the demo and the textbook reading: how linear models make predictions, what regularization does, how to interpret different parameters, and when to use different types of models. There are multiple choice questions, some multi-select questions, and a few matching questions. The quiz is designed to check your conceptual understanding, not to test memorization.

## Key Concepts to Focus On

As you work through the materials this week, here are the key concepts I want you to focus on.

**First**, understand what makes linear models fundamentally different from kNN. Linear models learn a formula during training; kNN stores data and searches through it. This difference has real implications for speed, interpretability, and how the models handle high-dimensional data.

**Second**, understand regularization. It's not just a technical detail—it's a core concept that appears everywhere in machine learning. Regularization is how we prevent models from overfitting by constraining their complexity. For linear models, that means keeping the weights from getting too large.

**Third**, understand the difference between L1 and L2 regularization. L2 shrinks all the weights but keeps them all in the model. L1 can drive some weights exactly to zero, effectively removing features. This difference matters when you're deciding which model to use.

**Fourth**, pay attention to how we evaluate these models using the same train-test framework you learned with kNN. We're using different algorithms, but the evaluation approach stays consistent: train on the training set, evaluate on the test set, and look for signs of overfitting or underfitting.

## A Note About This Week

This is a reading and comprehension week. There are no coding submissions, no screenshots to upload—just the quiz. The emphasis is on building a solid conceptual foundation. Linear models are one of the most widely used families of algorithms in practice, and they're the basis for more advanced techniques you'll encounter later. It's worth taking the time to really understand how they work.

If you find yourself confused by any of the concepts, go back to the demo and work through it again. The demo is designed to make the abstract concepts concrete by showing you actual code and actual results. Sometimes seeing the numbers and the output makes things click that didn't make sense when you were just reading about them.

## Wrapping Up

So to summarize: Read Chapter 2, pages 45 through 70. Work through the Week 3 demo, focusing on Ridge Regression and Logistic Regression. Then complete the D2L quiz to demonstrate your understanding.

Linear models are a major shift from kNN, but once you understand the core ideas—weighted formulas, regularization, and complexity control—you'll see that all the variations follow the same principles. The demo gives you the foundation, and the textbook shows you the extensions.

Alright, that's it for the Week 3 overview. Go ahead and dive into the materials, and I'll see you in the demo walkthrough video.