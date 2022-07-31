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

![pub badge](https://img.shields.io/pub/v/albiruni.svg)
[![style: lints](https://img.shields.io/badge/style-lints-4BC0F5.svg)](https://pub.dev/packages/lints)

A wrapper to easily access [IIUM's Course Schedule](https://albiruni.iium.edu.my/myapps/StudentOnline/schedule1.php) website data.

Thank you [**@PlashSpeed-Aiman**](https://github.com/PlashSpeed-Aiman) for the [code](https://github.com/PlashSpeed-Aiman/IIUMCourseScheduleApp) foundation.

## Features

- **Get a list** of subjects for ECONS kulliyyah for semester 1, 2021/2022 session:

  ```dart
  // Create albiruni instance
  Albiruni albiruni = Albiruni(semester: 1, session: "2021/2022");
  // Use methods available in the classes
  var subjects = await albiruni.fetch("ECONS");
  ```

- To **search** for a particular subject, use the `course` parameter.

  ```dart
  fetch("ECONS", course: "ECON 1140");
  ```

- Be creative. Let's say you want to **filter** the courses for **third**-year subjects only, just provide the first digit and ignore the rest.

  ```dart
  fetch("ECONS", course: "CCUB 3");
  ```

- If you receive the course code input from the user, use `.toAlbiruniFormat()` method to **properly format the string** before passing it to the function.

  ```dart
  var userInput = "ccub2621";
  fetch("CCAC", course: userInput.toAlbiruniFormat()); // formatted: CCUB 2621
  ```

- **Developing for the web** but get that CORS errors or `XMLHttpRequest` error again? Urgh. Fear no more, set `useProxy` to true. This will add a proxy layer between the client and the albiruni server.

  ```dart
  fetch("ENGIN", course: "MCTE 3271", useProxy: true);
  ```

- Want to parse the subjects' data from JSON string? We got you!

  Say you have this JSON:

  ```json
  {
    "code": "CHEN 1212",
    "sect": 1,
    "title": "THERMODYNAMICS",
    "chr": 2.0,
    "venue": null,
    "lect": [
      "DR. MOHD. FIRDAUS BIN ABD. WAHAB",
      "ASSOC. PROF. DR. NOR FADHILLAH BT. MOHAMED AZMIN"
    ],
    "dayTime": [
      { "day": 1, "startTime": "11:30", "endTime": "12:50" },
      { "day": 3, "startTime": "11:30", "endTime": "12:50" }
    ]
  }
  ```

  Parse it like follow:

  ```dart
  var data = <yourjsonstring>
  var subjects = Subject.fromJson(jsonDecode(data));
  ```

- I think that's it for the basic usage of this library, of course, you can always discover more. You can drop your inquiries in [issues](https://github.com/iqfareez/albiruni/issues) if you have any. More examples can be found in the `/example` folder.

## List of available kulliyyah (as of 31/7/2022)

|  Code   | Name                                                    |
| :-----: | ------------------------------------------------------- |
| `KAHS`  | ALLIED HEALTH SCIENCES                                  |
| ` AED`  | ARCHITECTURE                                            |
| `BRIDG` | BRIDGING PROGRAMME                                      |
| ` CFL`  | CELPAD                                                  |
| `CCAC`  | COCU                                                    |
| `DENT`  | DENTISTRY                                               |
| `EDUC`  | EDUCATION                                               |
| `ENGIN` | ENGIN                                                   |
| `ECONS` | ENMS                                                    |
| `KICT`  | ICT                                                     |
| `IHART` | INTERNATIONAL INSTITUTE FOR HALAL RESEARCH AND TRAINING |
| `IRKHS` | IRKHS                                                   |
| `IIBF`  | ISLAMIC BANKING AND FINANCE                             |
| `ISTAC` | ISTAC                                                   |
| ` KLM`  | KLM                                                     |
| `LAWS`  | LAWS                                                    |
| `MEDIC` | MEDICINE                                                |
| `NURS`  | NURSING                                                 |
| `PHARM` | PHARMACY                                                |
| ` KOS`  | SCIENCE                                                 |
| `SC4SH` | SEJAHTERA CENTRE FOR SUSTAINABILTY AND HUMANITY         |

This list of available kulliyyah might change over time, kindly refer to https://iiumschedule.iqfareez.com/docs/devs/albiruni#list-of-available-kulliyyah

## Additional information

- [IIUM Course Schedule Portal](https://albiruni.iium.edu.my/myapps/StudentOnline/schedule1.php)
- [IIUM Schedule App](https://iiumschedule.iqfareez.com)
