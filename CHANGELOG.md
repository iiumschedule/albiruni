## 1.2.4

- :bug: Fixed another bug related to parsing subject day & time. Refer [#1 (Comment)](https://github.com/iqfareez/albiruni/issues/1#issuecomment-1470978605)

## 1.2.3

- :bug: Fixed issue where albiruni cannot parse some day format. Refer [#1 (Comment)](https://github.com/iqfareez/albiruni/issues/1#issuecomment-1469333334)

## 1.2.2

- :arrow_up: Bump [intl](https://pub.dev/packages/intl) to `^0.18.0`
- :memo: Add some dartdoc

## 1.2.1

- :bug: Fixed the parser to parse days like `MTWTHF` and `MTWTH`. Refer [#1](https://github.com/iqfareez/albiruni/issues/1).
- :white_check_mark: Add more tests

## 1.2.0

- :sparkles: Added support for fetching **postgraduate** studies. Just set the `studyGrade` parameter in `Albiruni` to `StudyGrade.pg`.

## 1.1.7

- :wrench: Hide internal classes. eg: `TempDayTime`
- :white_check_mark: Add test files

## 1.1.6

- :truck: Migrate proxy server to another provider. This is due to Heroku is planned to [end its free plan](https://blog.heroku.com/next-chapter) that were use to host the [cors-anywhere](https://github.com/Rob--W/cors-anywhere) proxy instance.
- :memo: Changed to MIT license
- :coffee: Added funding

## 1.1.5

- :memo: Update README to provide a clearer documentation.

## 1.1.4

- :bug: Fix `sesShort` formatting that wrongly return semester value.

## 1.1.3

- :pencil2: Rename Albiruni parameter `semShort` to `sesShort`.

## 1.1.2

- :boom: **BREAKING CHANGES** - `.read` (on **DayTime**) and `.data` (on **Subject**) getter is removed. Added `.toString()` overrides on both.
- Added `.toJson()` and `.fromJson()` on both **Subject** and **DayTime** class.

## 1.1.0

- :boom: **BREAKING CHANGES** - Kuliyyah parameter now is seperated from the albiruni constructor.
  - Before:
  ```dart
  var albiruni = Albiruni(kulliyah: "AED", semester: 2, session: "2021/2022");
  var subjects = await albiruni.fetch();
  ```
  - After:
  ```dart
  var albiruni = Albiruni(semester: 2, session: "2021/2022");
  var subjects = await albiruni.fetch("AED");
  ```

## 1.0.2

- :see_no_evil: When fetching subject, you now can set **`useProxy`** to `true`. This will proxy the connection from albiruni origin site. Useful when dealing with CORS error in web application.
- :children_crossing: Exposes **`DayTime`** class.
- :sparkles: Introduce String extension method **`toAlbiruniFormat()`**. Useful to properly format a user input. _Eg: It will convert `nurc2411` to `NURC 2411`._
- :goal_net: Added `Exception` type
  - **`EmptyBodyException`**. Usually happen when subject is not offered for the kuliyyah/session semester. _Eg: You search for `MECH 2344` in Semester 3, but course is only available in long semester. Therefore, error is thrown._
  - **`NoSubjectsException`**. Usually happens when `page` is over it total pages.
- :sparkles: For `Subject` object:
  - Added **`.semShort`** value. A short version of year session. _Eg: `2021/2022` will be `21/22`._
  - **`.dayTime`** now will be return a sorted session according to its day. _Ie: Monday should come first and so on._
- :memo: Update docs.

## 1.0.0

- :tada: Initial release.
