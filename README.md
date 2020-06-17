# Bank-note-authenticationpredictor


#### This server:
The probability of the authentication is predicted by input parameters such as
Variance of Wavelet Transformed image, Skewness of Wavelet Transformed image, Kurtosis of Wavelet Transformed image, Entropy of image which can be obtained by Wavelet Transformation to the image of that specific bank note.
By giving these parameters as the input in the server, the random forest ML approach predicts the probability of authentic and inauthentic bank notes. 
The outcome Label X0 is for authentic and the label X1 is for inauthentic.


The dataset was built by applying a **wavelet transform** on images of banknotes to extract 4 features:

Variance, skewness, kurtosis of the wavelet transform and entropy of the image, which can be interpreted as the amount of information or randomness (which is represented by how different adjacent pixels are).
You can find further information on Wavelet on Wikipedia .

The data provided by H. Dörsken and Volker Lohweg, from the University of Applied Science of Ostwestfalen-Lippe, Germany on the UCI Machine Learning Repository,
[http://archive.ics.uci.edu/ml/datasets/banknote+authentication](http://archive.ics.uci.edu/ml/datasets/banknote+authentication),


Done by: [Subramaniam S M](https://www.linkedin.com/in/subramaniam-s-m-a01827130), 
          B.Tech Bioinformatics,
		  SASTRA University
