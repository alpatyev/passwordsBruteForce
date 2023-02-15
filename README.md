# passwordsBruteForce
Unusual homework from MobDevFactory. Here, password guessing on the background thread, provided that the UI does not freeze.

Here are a couple of screenshots:
![guessed](https://user-images.githubusercontent.com/118742566/219163873-2d36a730-4e74-4925-99a1-f0ee8c48e539.png)
![guessing](https://user-images.githubusercontent.com/118742566/219163964-4151d9ed-2259-499f-8bdc-229c9ed19987.png)

Details:
1. Made according to the MVP design pattern. With builder for individual scene.
2. IU layout is simple with NSLayoutConstraints in order not to pull dependencies from frameworks into the project.
3. iOS 13 and above but later I will add support for previous.
4. The while loop runs asynchronously with .utility priority, but can be made even lower so that the CPU does not strain at all.
