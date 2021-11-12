<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

A wrapper to easily access [IIUM's Course Schedule](http://albiruni.iium.edu.my/myapps/StudentOnline/schedule1.php) website data.

Thank you [**@PlashSpeed-Aiman**](https://github.com/PlashSpeed-Aiman) for the [code](https://github.com/PlashSpeed-Aiman/IIUMCourseScheduleApp) foundation.

<!-- ## Features

TODO: List what your package can do. Maybe include images, gifs, or videos. -->

## Usage

First, import the package:

```dart
import 'package:albiruni/albiruni.dart';
```

Then, use it like so:

```dart
Albiruni albiruni = Albiruni(kulliyah: "ECONS", semester: 1, session: "2020/2021");
var subjects = await albiruni.fetch();
```

More example can be found in `/example` folder.

## Additional information

- [IIUM Course Schedule Portal](http://albiruni.iium.edu.my/myapps/StudentOnline/schedule1.php)
- [IIUM Schedule App](https://github.com/iqfareez/flutter_iium_schedule) (WIP)
