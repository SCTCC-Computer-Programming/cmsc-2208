# Week 10 Actual Outputs

Captured from executed `week-10-demo.ipynb`. Use these to verify prose explanations match actual output values.

## Cell 1: Load wine dataset

```
Dataset shape: (178, 13)
Number of classes: 3
Class names: ['class_0' 'class_1' 'class_2']

Class distribution:
  class_0: 59 samples
  class_1: 71 samples
  class_2: 48 samples
```

```
   alcohol  malic_acid   ash  alcalinity_of_ash  magnesium  total_phenols  \
0    14.23        1.71  2.43               15.6      127.0           2.80   
1    13.20        1.78  2.14               11.2      100.0           2.65   
2    13.16        2.36  2.67               18.6      101.0           2.80   
3    14.37        1.95  2.50               16.8      113.0           3.85   
4    13.24        2.59  2.87               21.0      118.0           2.80   

   flavanoids  nonflavanoid_phenols  proanthocyanins  color_intensity   hue  \
0        3.06                  0.28             2.29             5.64  1.04   
1        2.76                  0.26             1.28             4.38  1.05   
2        3.24                  0.30             2.81             5.68  1.03   
3        3.49                  0.24             2.18             7.80  0.86   
4        2.69                  0.39             1.82             4.32  1.04   

   od280/od315_of_diluted_wines  proline  wine_class  
0                          3.92   1065.0           0  
1                          3.40   1050.0           0  
2                          3.17   1185.0           0  
3                          3.45   1480.0           0  
4                          2.93    735.0           0  
```

## Cell 2: Feature range table

```
Feature ranges in the Wine dataset:

Feature                                  Min      Max    Range
---------------------------------------------------------------
alcohol                               11.030   14.830    3.800
malic_acid                             0.740    5.800    5.060
ash                                    1.360    3.230    1.870
alcalinity_of_ash                     10.600   30.000   19.400
magnesium                             70.000  162.000   92.000
total_phenols                          0.980    3.880    2.900
flavanoids                             0.340    5.080    4.740
nonflavanoid_phenols                   0.130    0.660    0.530
proanthocyanins                        0.410    3.580    3.170
color_intensity                        1.280   13.000   11.720
hue                                    0.480    1.710    1.230
od280/od315_of_diluted_wines           1.270    4.000    2.730
proline                              278.000 1680.000 1402.000
```

## Cell 3: kNN on unscaled data

```
Training set: 133 samples
Test set:     45 samples

kNN accuracy on unscaled data (n_neighbors=5):
  Training accuracy: 0.767
  Test accuracy:     0.711
```

## Cell 4: StandardScaler fit/transform

```
Selected feature statistics after StandardScaler (training data):

Feature                                 Mean      Std      Min      Max
-----------------------------------------------------------------------
proline                               0.0000   1.0038   -1.521    2.630
nonflavanoid_phenols                 -0.0000   1.0038   -1.847    2.345
alcohol                               0.0000   1.0038   -2.350    2.246
```

## Cell 5: kNN on StandardScaler data

```
kNN accuracy after StandardScaler (n_neighbors=5):
  Training accuracy: 0.977
  Test accuracy:     0.956
```

## Cell 6: MinMaxScaler fit/transform

```
Selected feature ranges after MinMaxScaler (training data):

Feature                                  Min      Max
-------------------------------------------------------
proline                                0.000    1.000
nonflavanoid_phenols                   0.000    1.000
alcohol                                0.000    1.000
```

## Cell 7: kNN on MinMaxScaler data

```
kNN accuracy after MinMaxScaler (n_neighbors=5):
  Training accuracy: 0.977
  Test accuracy:     0.933
```

## Cell 8: Fit-on-training demonstration

```
Correct workflow:
  Scaler fitted on: 133 training samples
  Training set transformed using training mean/std
  Test set transformed using the same training mean/std

What the scaler learned from training data (first 3 features):
  alcohol             : mean=12.973, std=0.827
  malic_acid          : mean=2.387, std=1.095
  ash                 : mean=2.362, std=0.280
```

## Cell 9: Before/after visualization (plot — no text output)

*(matplotlib plot — no text output)*

