### jKMeans by xulihang
### 12/01/2020
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/125091/)

This is a wrapper of this KMeans implementation: <https://github.com/eugenp/tutorials/blob/master/algorithms-miscellaneous-3/src/main/java/com/baeldung/algorithms/kmeans/KMeans.java>  
  
KMeans is an unsupervised machine learning algorithm.  
  
I have used it to detect the dominants color of a image: [Detect dominant colors of images](https://www.b4x.com/android/forum/threads/detect-dominant-colors-of-images.114547/#content)  
  
I used the built-in KMeans class in weka in this project. But since weka is GPL licensed, I cannot distribute it without open source my app. It should not be difficult to implement KMeans in B4X, but as I found the existing java code. I decided to make a wrapper.