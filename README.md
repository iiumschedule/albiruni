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

[![Dart](https://img.shields.io/badge/dart-%230175C2.svg?logo=dart&logoColor=white)](https://dart.dev/)
[![pub badge](https://img.shields.io/pub/v/albiruni.svg)](https://pub.dev/packages/albiruni)
[![style: lints](https://img.shields.io/badge/style-lints-4BC0F5.svg)](https://pub.dev/packages/lints)

A wrapper to easily access [IIUM's Course Schedule](https://albiruni.iium.edu.my/myapps/StudentOnline/schedule1.php) website data.

Thank you [**@PlashSpeed-Aiman**](https://github.com/PlashSpeed-Aiman) for the [code](https://github.com/PlashSpeed-Aiman/IIUMCourseScheduleApp) foundation.

## Get Started

1. Run `dart pub get`
2. Start development. Make sure to update/add the test file if needed. Run `dart test` to run test suite.

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/iiumschedule/albiruni)

## Features

### Get a list of subjects offered

Fetch of subjects for Kuliyyah of Economics for semester 1, 2021/2022 session:

```dart
// Create albiruni instance
Albiruni albiruni = Albiruni(semester: 1, session: "2021/2022");
// Use methods available in the classes
var (subjects, totalPage) = await albiruni.fetch("ECONS");
```

Supports both Undergraduate and Postgraduate studies. Pass the `StudyGrade.ug` (default) or `StudyGrade.pg`.

```dart
Albiruni(semester: 1, session: "2022/2023", studyGrade: StudyGrad.pg);
```

### Search for specific subjects in a kulliyyah

Put the subject course code in the `course` parameter. The subject must be Albiruni-formatted, e.g. `ABDC 1234` (see [albiruni-formatted](#albiruni-formatted)).

```dart
fetch("ECONS", course: "ECON 1140");
```

Here's some trick. Let's say you want to **filter** the courses for **third**-year subjects only, just provide the first digit and ignore the rest.

```dart
fetch("CCAC", course: "CCUB 3");
```

### Albiruni-formatted

The course code **must** be in the following format: `ABCD 1234`. The first four characters are the subject code, and the last four characters are the subject number. The space is required. _In some cases, the course code format might be different but generally, it will look like this._

Lucky for you, `.toAlbiruniFormat()` extension method will properly format the string for you. Useful when you're receiving input from the users etc.

```dart
var userInput = "ccub2621";
fetch("CCAC", course: userInput.toAlbiruniFormat()); // formatted: CCUB 2621
```

### JSON

Parse subject data from JSON to Dart object, use `fromJson()` constructor.

Example JSON:

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

Parse it like following:

```dart
var data = <yourjsonstring>
var subjects = Subject.fromJson(jsonDecode(data));
```

Similarly, you can convert Dart object to JSON using `toJson()` method.

I think that's it for the basic usage of this library, of course, you can always discover more. You can drop your inquiries in [issues](https://github.com/iqfareez/albiruni/issues) if you have any. More examples can be found in the `/example` folder.

## Common issues

- XMLHttpRequest error or CORS error

  Usually occurs if you're developing for the web. Set `useProxy` flag to **true**. This will add a proxy layer between the client and the albiruni server.

  ```dart
  fetch("ENGIN", course: "MCTE 3271", useProxy: true);
  ```

- HandshakeException: [CERTIFICATE_VERIFY_FAILED](https://github.com/iqfareez/iium_schedule/issues/10) error.

  This happens when the albiruni server has some [certificate issues](https://github.com/iqfareez/iium_schedule/issues/10#issuecomment-1086550494). Some clients might reject the requests. If you're in development, try [this answer from SO](https://stackoverflow.com/a/61312927/13617136).

## List of available kulliyyah (as of 7 August 2024)

|  Code   | Name                                                    |
| :-----: | ------------------------------------------------------- |
| `IRKHS` | AHAS KIRKHS                                             |
| `KAHS`  | ALLIED HEALTH SCIENCES                                  |
|  `AED`  | ARCHITECTURE                                            |
| `BRIDG` | BRIDGING PROGRAMME                                      |
|  `CFL`  | CELPAD                                                  |
| `CCAC`  | COCU                                                    |
| `DENT`  | DENTISTRY                                               |
| `EDUC`  | EDUCATION                                               |
| `ENGIN` | ENGIN                                                   |
| `ECONS` | ENMS                                                    |
| `KICT`  | ICT                                                     |
| `IHART` | INTERNATIONAL INSTITUTE FOR HALAL RESEARCH AND TRAINING |
| `IIBF`  | ISLAMIC BANKING AND FINANCE                             |
| `ISTAC` | ISTAC                                                   |
|  `KLM`  | KSTCL KLM                                               |
| `LAWS`  | LAWS                                                    |
| `MEDIC` | MEDICINE                                                |
| `NURS`  | NURSING                                                 |
| `PHARM` | PHARMACY                                                |
| `PLNET` | PLANETARY SURVIVAL FOR SUSTAINABLE WELL-BEING           |
|  `KOS`  | SCIENCE                                                 |
| `SC4SH` | SEJAHTERA CENTRE FOR SUSTAINABILTY AND HUMANITY         |

This list of available kulliyyah might change over time, kindly refer to https://iiumschedule.iqfareez.com/docs/devs/albiruni#list-of-available-kulliyyah

## Related information

- [IIUM Course Schedule Portal](https://albiruni.iium.edu.my/myapps/StudentOnline/schedule1.php)
- [IIUM Schedule App](https://iiumschedule.iqfareez.com)
- Experimental: [albiruni-api](https://github.com/iqfareez/albiruni-api)
