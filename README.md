## NumberCountingAnimation

- A simple flutter counting animation widget.
    
    ![Screen_Recording_20240314_113116-ezgif com-video-to-gif-converter](https://github.com/Shik1266/CountingAnimation/assets/53571368/eb8b3042-f793-456f-987f-e8342029d5a1)
    

## Installing

Add this to your package’s pubspec.yaml file:

```kotlin
dependencies:
  number_counting_animation: ^1.0.2
```

## CountingAnimation

| type | name | description | default |
| --- | --- | --- | --- |
| String | value | show value | - |
| TextStyle | textStyle | text style | - |
| bool | useChar | value have non-animation character | false |
| int | scrollCount | total amount of play to scroll animation | 40 |
| Duration | singleScrollDuration | duration for each scroll animation | 50ms |
| Duration | lastDuration | duration for last animation | 50ms |
| Color | bgColor | widget back ground color | transparent |
| bool | useRefresh | restart animation when value changed | true |

## How to use

🔗[Example Link](https://pub.dev/packages/number_counting_animation/example)

```dart
 CountingAnimation(
              value: '12,345',
              textStyle: const TextStyle(
                color: Colors.blue,
                fontSize: 20,
              ),
              useChar: true,
              scrollCount: 10,
              singleScollDuration: const Duration(milliseconds: 200),
              lastDuration: const Duration(milliseconds: 1000),
            ),
```
