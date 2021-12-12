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

![badge](https://img.shields.io/pub/v/albiruni.svg)

A wrapper to easily access [IIUM's Course Schedule](https://albiruni.iium.edu.my/myapps/StudentOnline/schedule1.php) website data.

Thank you [**@PlashSpeed-Aiman**](https://github.com/PlashSpeed-Aiman) for the [code](https://github.com/PlashSpeed-Aiman/IIUMCourseScheduleApp) foundation.

## Features

<!-- TODO: List what your package can do. Maybe include images, gifs, or videos. -->

- Get a list of subjects for ECONS kulliyyah for semester 1, 2020/2021 session:

  ```dart
  // Create albiruni instance
  Albiruni albiruni = Albiruni(kulliyah: "ECONS", semester: 1, session: "2020/2021");
  // Use methods available in the classes
  var subjects = await albiruni.fetch();
  ```

- To filter/search for a particular subject, use the `course` parameter.

  ```dart
  fetch(course: "ECON 1140");
  ```

- Be creative. Let say you want to filter the courses for third year subjects only.

  ```dart
  fetch(course: "CCUB 3");
  ```

- If you receiving input from user, it is recommended to use `.toAlbiruniFormat()` method.

  ```dart
  userInput = "ccub2621";
  fetch(course: userInput.toAlbiruniFormat());
  ```

- Get that `XMLHttpRequest` again? Urgh. Fear no more, set `useProxy` to true. (Implemented using [cors-anywhere](https://github.com/Rob--W/cors-anywhere))

  ```dart
  fetch(course: "MCTE 3271", useProxy: true);
  ```

- I think that's it for the basic usage of this library, of course, you can always discover more. You can drop your enquiries in [issues](https://github.com/iqfareez/albiruni/issues) if you have any.

More example can be found in `/example` folder.

<!-- Letak table berkenaan parameters -->

## Additional information

- [IIUM Course Schedule Portal](http://albiruni.iium.edu.my/myapps/StudentOnline/schedule1.php)
- [IIUM Schedule App](https://github.com/iqfareez/flutter_iium_schedule) (WIP)
