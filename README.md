
[![flib build](https://github.com/ZuYun/winloading/actions/workflows/flibbuild.yml/badge.svg)](https://github.com/ZuYun/winloading/actions/workflows/flibbuild.yml) [![lib web](https://github.com/ZuYun/winloading/actions/workflows/flibweb.yml/badge.svg)](https://github.com/ZuYun/winloading/actions/workflows/flibweb.yml)    [![publish](https://github.com/ZuYun/winloading/actions/workflows/publish.yml/badge.svg)](https://github.com/ZuYun/winloading/actions/workflows/publish.yml)

# what is it

[![online](https://img.shields.io/badge/online-test-green)](https://zuyun.github.io/winloading/#/)

https://user-images.githubusercontent.com/9412501/159002380-329fb171-c993-4373-b5e1-ad28fe05e7d4.mp4

https://user-images.githubusercontent.com/9412501/159002392-f00afe4a-dcb9-4081-bc52-417f4f2b281d.mp4

# how to use
[![pub](https://img.shields.io/badge/pub-v0.0.2-green)](https://pub.dev/packages/winloading)
```dart
Center(
  child: View3D.me(),
)
```
## customization

```dart

const WinLoading({
    this.color = Colors.white,
    this.radius = 3,
    this.gap = 0.04,
    this.amount = 5,
    this.width = 60,
    this.height = 60,
    this.duration = const Duration(milliseconds: 7200),
    this.cubic = const Cubic(.21, .6, .59, .8),
    Key? key,
})

```