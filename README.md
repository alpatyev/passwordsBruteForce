
# passwordsBruteForce
Unusual homework from MobDevFactory. Here, password guessing on the background thread, provided that the UI does not freeze.

Here are a couple of screenshots:

<p style="text-align: center;"><img src="https://user-images.githubusercontent.com/118742566/219163964-4151d9ed-2259-499f-8bdc-229c9ed19987.png" width="300" /><img src="https://user-images.githubusercontent.com/118742566/219163873-2d36a730-4e74-4925-99a1-f0ee8c48e539.png" width="300" /></p>


Details:
1. Made according to the MVP design pattern. With builder for individual scene.
2. IU layout is simple with NSLayoutConstraints in order not to pull dependencies from frameworks into the project.
3. iOS 13 and above but later I will add support for previous.
4. The while loop runs asynchronously with .utility priority, but can be made even lower so that the CPU does not strain at all.


How it works:

https://user-images.githubusercontent.com/118742566/219180336-7cbb5b3c-d8bc-4941-98ab-0d7993b74676.mov
