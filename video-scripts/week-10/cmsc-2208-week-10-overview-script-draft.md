# Week 10 Overview Video Script

---

Hello everyone, and welcome to Week 10 of Introduction to Machine Learning with Python.

Week 8 closed out Chapter 2 and gave you a preview of where we were heading. This week we start Chapter 3, and the first topic is preprocessing and scaling.

Every workflow you have used so far in this course starts the same way: split your data, fit a model on the training set, evaluate it on the test set. Preprocessing is a step that happens before any of that. Before you hand your data to a model, you may need to prepare it, and that preparation is its own step with its own rules. It does not involve a target column. It does not make predictions. It only looks at your features and transforms them so that the model you are about to train can work with them more effectively. You will notice that the scaler uses the same fit pattern you have seen with classifiers, but what it learns during fit is not how to make predictions. It learns statistics about your features so it can transform them into a more useful form. That is what makes preprocessing unsupervised: no labels involved, just the feature data.

This week focuses on one specific kind of preprocessing: scaling. Scaling adjusts the numeric range of your features before training. The reason it matters comes down to how some algorithms measure similarity. kNN makes every prediction by measuring how similar a new data point is to examples in the training set, and that similarity is based on distance across all your features. The problem is that distance is affected by the numeric range of each feature. If some features happen to use much larger numbers than others, those features end up driving every comparison, not because they are more important, but just because their values are bigger. The other features barely factor in. Scaling corrects that imbalance before the algorithm ever sees the data.

The demo walks through this problem using the Wine dataset, a built-in scikit-learn dataset with 13 chemical measurements that span dramatically different numeric ranges. We are using it instead of the student performance data because those scale differences are large enough that you can directly measure the accuracy cost of ignoring them. You will apply two scalers, StandardScaler (standard scaler) and MinMaxScaler (min max scaler), and compare what each one does. Both follow the same three-step workflow: create the scaler, fit it on training data, then transform both sets. The fit step is where the scaler learns what it needs from the training data, and that leads to the most important concept this week.

The scaler must always be fit on training data only. If you fit it on the full dataset before splitting, you are letting the test set influence how your training data gets prepared. Your model ends up looking more accurate than it actually is because the evaluation is no longer clean. The demo shows exactly what the scaler stores during fit and what goes wrong when that rule is broken.

The textbook picks up where the demo leaves off and introduces two additional scalers. RobustScaler (robust scaler) is designed for datasets with outliers. Instead of using the mean and standard deviation, it uses the median and quartiles, which are not pulled off center the way the mean can be when extreme values are present. Normalizer (normalizer) works differently from all three others because it scales each row rather than each column, which matters when the direction of a data point is more important than its magnitude.

For this week: read Chapter 3 pages 131 through 139, work through the Week 10 demo, and complete the quiz.

That is it for the Week 10 overview.
