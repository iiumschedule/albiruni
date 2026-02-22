import 'package:albiruni/albiruni.dart';
import 'package:albiruni/src/util/parse_albiruni_html.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

/// Albiruni scrapper.
///
/// Base code are ported from https://github.com/PlashSpeed-Aiman/IIUMCourseScheduleApp
class Albiruni {
  /// a.k.a year.
  ///
  /// Example: "2020/2021", "2021/2022", etc.
  ///
  /// Refer to: http://albiruni.iium.edu.my/myapps/StudentOnline/schedule1.php
  String session;

  /// Example: 1, 2, 3
  ///
  /// Some kuliiyah may not have semester 3.
  int semester;

  /// Short version of session
  ///
  /// Example: "20/21" etc.
  late String sesShort;

  /// Study grade [ug] for Undergraduate, [pg] for Postgraduate
  late StudyGrad studyGrade;

  late final String _basicParams;

  // Instantiate Albiruni object
  Albiruni({
    required this.semester,
    required this.session,
    this.studyGrade = StudyGrad.ug,
  }) : super() {
    _basicParams =
        "?action=view&sem=$semester&ses=$session&ctype=${studyGrade == StudyGrad.ug ? "<" : ">="}";
    sesShort =
        '${session.split('/').first.substring(2)}/${session.split('/').last.substring(2)}';
  }

  final _baseUrl = 'albiruni.iium.edu.my/myapps/StudentOnline/schedule1.php';

  /// Fetch a list of subjects for the given [kulliyah].
  ///
  /// See list of [kulliyah] here: https://iiumschedule.iqfareez.com/docs/devs/albiruni#list-of-available-kulliyyah (Look at column "keys")
  ///
  /// [course] is optional. Example: "AAD 3190", "MCTE 3312". The 4 digit number can be omitted. Example: "EECE".
  ///
  /// One page holds about 50 entries. Navigate to the next page using the [page] parameter. Default is `1`.
  ///
  /// Returns a Records of list of [Subject] and total pages.
  Future<(List<Subject>, int)> fetch(String kulliyah,
      {String? course, int page = 1}) async {
    if (course != null) {
      course.replaceFirst(' ', '+').toUpperCase();
    } else {
      course = '';
    }
    var extraParams = "&kuly=$kulliyah&view=${page * 50}&course=$course";

    var finalUrl = 'https://$_baseUrl$_basicParams$extraParams';
    // print('Query URL: $finalUrl');

    var res = await http.get(Uri.parse(finalUrl));
    return parseAlbiruniHtml(res.body);
  }

  /// Check if subject on the current scope (kulliyah, semester & session) is available.
  ///
  /// Return `true` if there is atleast one subject in the current scope.
  Future<bool> preflight(String kulliyah) async {
    var firstPage = "&view=50";
    var kull = "&kuly=$kulliyah";
    var res = await http
        .get(Uri.parse('https://$_baseUrl$_basicParams$kull$firstPage'));
    var document = parse(res.body);
    var elements = document.getElementsByTagName("tbody");

    // Just like in fetch()
    try {
      elements = elements[1].children;
    } on RangeError {
      return false;
    }

    // If no error, consider the is a data
    return true;
  }
}
