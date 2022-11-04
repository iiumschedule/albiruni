import 'package:albiruni/albiruni.dart';
import 'package:albiruni/src/util/parse_albiruni_html.dart';
import 'package:html/dom.dart';
import 'package:test/test.dart';

void main() {
  test('Test parser (HTML to Albiruni object)', () async {
    String rawResponse = '''
<html>
<head>
<title>Course Schedule</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="cslip.css" type="text/css">
</head>
<SCRIPT LANGUAGE="JavaScript">
<!--
function correct() {
x=document.cari
if (x.course.value != "") {
  x.course.value = x.course.value.toUpperCase()
  x.course.value = x.course.value.replace(" ","");

  spacepos = x.course.value.search(/[0-9]/)
  //alert(spacepos)
  if (x.course.value.length < 9 ) {
         //if (x.course.value.indexOf(" ") == -1 ){
         //   spacepos = (x.course.value.length)-(x.course.value.substr(x.course.value.length-1,1) != "A"? 4 : 5)
            x.course.value = x.course.value.substr(0,(spacepos == -1?x.course.value.length:spacepos)) + (spacepos == -1?"":" ") + (spacepos==-1?"":x.course.value.substr(spacepos)) 
        // }
  }
}
}
function set_sem() {
x=document.cari;

if (x.sem.value == 3) {
   	x.ses.value = "2021/2022";
   }
else if (x.sem.value == 1) {
   	x.ses.value = "2022/2023";
  }
else {
   	x.ses.value = "2021/2022";
  }
  
return true;
}



function form_submit(action) {
x=document.cari
if (action == "view") {
   x.action.value = "view"
   x.submit();
}
else {
   x.action.value = ""
   x.submit();
}
}

// -->
</SCRIPT>
</head>

<body bgcolor="#FFFFFF">

<table width="100%" border="0">
  <tr valign="top">
    <td width="27%">Fri, 04 Nov 2022 11:21 </td>
    <td width="48%" align="center">INTERNATIONAL ISLAMIC UNIVERSITY MALAYSIA</td>
    <td width="25%">&nbsp;</td>
  </tr>
  <tr>
    <td width="27%">&nbsp;</td>
    <td width="48%" align="center">COURSE SCHEDULE</td>
    <td width="25%">&nbsp;</td>
  </tr>
  <tr>
    <td width="27%">&nbsp;</td>
    <td width="48%" align="center">SESSION 2022/2023, 1</td>
    <td width="25%">&nbsp;</td>
  </tr>
</table>
<br>
<br>
<table width="100%" border="0" cellspacing="1" bgcolor=#cccccc>
  <tr align=right>
   <td colspan=5><B>1</B>&nbsp;&nbsp;<a href="schedule1.php?action=view&view=100&kuly=ENGIN&tot_pages=12&ctype=<&course=&sem=1&ses=2022/2023">2</a>&nbsp;&nbsp;<a href="schedule1.php?action=view&view=150&kuly=ENGIN&tot_pages=12&ctype=<&course=&sem=1&ses=2022/2023">3</a>&nbsp;&nbsp;<a href="schedule1.php?action=view&view=200&kuly=ENGIN&tot_pages=12&ctype=<&course=&sem=1&ses=2022/2023">4</a>&nbsp;&nbsp;<a href="schedule1.php?action=view&view=250&kuly=ENGIN&tot_pages=12&ctype=<&course=&sem=1&ses=2022/2023">5</a>&nbsp;&nbsp;<a href="schedule1.php?action=view&view=300&kuly=ENGIN&tot_pages=12&ctype=<&course=&sem=1&ses=2022/2023">6</a>&nbsp;&nbsp;<a href="schedule1.php?action=view&view=350&kuly=ENGIN&tot_pages=12&ctype=<&course=&sem=1&ses=2022/2023">7</a>&nbsp;&nbsp;<a href="schedule1.php?action=view&view=400&kuly=ENGIN&tot_pages=12&ctype=<&course=&sem=1&ses=2022/2023">8</a>&nbsp;&nbsp;<a href="schedule1.php?action=view&view=450&kuly=ENGIN&tot_pages=12&ctype=<&course=&sem=1&ses=2022/2023">9</a>&nbsp;&nbsp;<a href="schedule1.php?action=view&view=500&kuly=ENGIN&tot_pages=12&ctype=<&course=&sem=1&ses=2022/2023">10</a>&nbsp;&nbsp;<a href="schedule1.php?action=view&view=550&kuly=ENGIN&tot_pages=12&ctype=<&course=&sem=1&ses=2022/2023">11</a>&nbsp;&nbsp;<a href="schedule1.php?action=view&view=600&kuly=ENGIN&tot_pages=12&ctype=<&course=&sem=1&ses=2022/2023">12</a>&nbsp;&nbsp;<a href="schedule1.php?action=view&view=100&kuly=ENGIN&tot_pages=12&ctype=<&course=&sem=1&ses=2022/2023">NEXT</a>&nbsp;&nbsp;
   </td>
  </tr>
  <tr valign="bottom" bgcolor=#f5f5f5> 
    <td width="9%"><b> Code</b></td>
    <td width="3%"><b>Sect</b></td>
    <td width="25%"><b>Title</b></td>
    <td width="3%"><b>Chr</b></td>
    <td width="60%" align="left" valign="bottom">
        <table width="100%" cellpadding="0" cellspacing="0" border="0">
           <tr valign="bottom">
             <td width="10%" align="left"><b>Day</b></td>
             <td width="20%" align="left"><b>Time</b></td>
             <td width="25%" align="left"><b>Venue</b></td> 
             <td width="45%" align="left"><b>Lecturer</b></td> 
           </tr>
		</table>
	</td>
  </tr>

              <tr bgcolor=ddddf5 valign="top">
                <td width="9%" align="left"  >AERO 1121</td>
                <td width="3%" align="left" >1</td>
                <td width="25%" align="left" >INTRODUCTION TO AEROSPACE ENGINEERING</td>
                <td width="3%" align="left"  >1</td>
                <td width="60%" align="left" valign="top">
                 <table  width="100%" cellpadding="0" cellspacing="0" border="0">
                  <tr  valign="top">
                   <td width="10%" align="left">THUR</td>
                   <td width="20%" align="left">2 - 2.50 PM</td>
                   <td width="25%" align="left">ENG LRM E0-1-15</td>
                   <td width="45%" align="left">DR. AMELDA DIANNE BINTI ANDAN</td>
                  </tr>
                </table>
                </td>
              </tr>
              <tr bgcolor=f5f5f5 valign="top">
                <td width="9%" align="left"  >AERO 1322</td>
                <td width="3%" align="left" >1</td>
                <td width="25%" align="left" >THERMAL SCIENCES</td>
                <td width="3%" align="left"  >3</td>
                <td width="60%" align="left" valign="top">
                 <table  width="100%" cellpadding="0" cellspacing="0" border="0">
                  <tr  valign="top">
                   <td width="10%" align="left">M-W</td>
                   <td width="20%" align="left">11.30 - 12.50 AM</td>
                   <td width="25%" align="left">ENG LRM E1-3-19</td>
                   <td width="45%" align="left">TS. DR. MUHAMMAD HANAFI BIN AZAMI</td>
                  </tr>
                </table>
                </td>
              </tr>
              <tr bgcolor=ddddf5 valign="top">
                <td width="9%" align="left"  >AERO 2128</td>
                <td width="3%" align="left" >1</td>
                <td width="25%" align="left" >AEROSPACE ENGINEERING LAB 1</td>
                <td width="3%" align="left"  >1</td>
                <td width="60%" align="left" valign="top">
                 <table  width="100%" cellpadding="0" cellspacing="0" border="0">
                  <tr  valign="top">
                   <td width="10%" align="left">TUE</td>
                   <td width="20%" align="left">8.30 - 11.20 AM</td>
                   <td width="25%" align="left">-</td>
                   <td width="45%" align="left">DR. DWI PEBRIANTI</td>
                  </tr>
                  <tr  valign="top">
                   <td width="10%" align="left">TUE</td>
                   <td width="20%" align="left">8.30 - 11.20 AM</td>
                   <td width="25%" align="left">-</td>
                   <td width="45%" align="left">TO BE DETERMINED</td>
                  </tr>
                  <tr  valign="top">
                   <td width="10%" align="left">TUE</td>
                   <td width="20%" align="left">8.30 - 11.20 AM</td>
                   <td width="25%" align="left">-</td>
                   <td width="45%" align="left"></td>
                  </tr>
                </table>
                </td>
              </tr>
              <tr bgcolor=ddddf5 valign="top">
                <td width="9%" align="left"  >CHEN 1311</td>
                <td width="3%" align="left" >1</td>
                <td width="25%" align="left" >MATERIAL SCIENCES FOR CHEMICAL ENGINEERS</td>
                <td width="3%" align="left"  >3</td>
                <td width="60%" align="left" valign="top">
                 <table  width="100%" cellpadding="0" cellspacing="0" border="0">
                  <tr  valign="top">
                   <td width="10%" align="left">M-W</td>
                   <td width="20%" align="left">10 - 11.20 AM</td>
                   <td width="25%" align="left">ENG LRM E1-4-16</td>
                   <td width="45%" align="left">DR. WAN MOHD FAZLI BIN WAN NAWAWI</td>
                  </tr>
                </table>
                </td>
              </tr>
              <tr bgcolor=f5f5f5 valign="top">
                <td width="9%" align="left"  >CHEN 1311</td>
                <td width="3%" align="left" >2</td>
                <td width="25%" align="left" >MATERIAL SCIENCES FOR CHEMICAL ENGINEERS</td>
                <td width="3%" align="left"  >3</td>
                <td width="60%" align="left" valign="top">
                 <table  width="100%" cellpadding="0" cellspacing="0" border="0">
                  <tr  valign="top">
                   <td width="10%" align="left">M-W</td>
                   <td width="20%" align="left">2 - 3.20 PM</td>
                   <td width="25%" align="left">ENG LRM E2-4-7</td>
                   <td width="45%" align="left">DR. YUSILAWATI BINTI AHMAD NOR</td>
                  </tr>
                </table>
                </td>
              </tr><tr valign=middle>
  <td colspan=5><table width="100%" bgcolor=#cccccc >
      <tr>
        <form name="cari" method=post action="schedule1.php">
          <td width="80%"><input type=text name=course value="" size=10 maxlength=10 onChange="correct()">
            <input type=hidden Name=action value=view>
            <input type=hidden Name=kuly value="ENGIN" >
            <input type=hidden Name=ctype value="<">
            <input type=hidden Name=ses value="2022/2023">
            <input type=hidden Name=sem value="1">
            <input type=button name=search value="Search Course" onClick="form_submit('view')">
            <input type=button name=newsearch value="New Search" onClick="form_submit('')"></td>
          <td  width="20%" align=right><B>1</B>&nbsp;&nbsp;<a href="schedule1.php?action=view&view=100&kuly=ENGIN&tot_pages=12&ctype=<&course=&sem=1&ses=2022/2023">2</a>&nbsp;&nbsp;<a href="schedule1.php?action=view&view=150&kuly=ENGIN&tot_pages=12&ctype=<&course=&sem=1&ses=2022/2023">3</a>&nbsp;&nbsp;<a href="schedule1.php?action=view&view=200&kuly=ENGIN&tot_pages=12&ctype=<&course=&sem=1&ses=2022/2023">4</a>&nbsp;&nbsp;<a href="schedule1.php?action=view&view=250&kuly=ENGIN&tot_pages=12&ctype=<&course=&sem=1&ses=2022/2023">5</a>&nbsp;&nbsp;<a href="schedule1.php?action=view&view=300&kuly=ENGIN&tot_pages=12&ctype=<&course=&sem=1&ses=2022/2023">6</a>&nbsp;&nbsp;<a href="schedule1.php?action=view&view=350&kuly=ENGIN&tot_pages=12&ctype=<&course=&sem=1&ses=2022/2023">7</a>&nbsp;&nbsp;<a href="schedule1.php?action=view&view=400&kuly=ENGIN&tot_pages=12&ctype=<&course=&sem=1&ses=2022/2023">8</a>&nbsp;&nbsp;<a href="schedule1.php?action=view&view=450&kuly=ENGIN&tot_pages=12&ctype=<&course=&sem=1&ses=2022/2023">9</a>&nbsp;&nbsp;<a href="schedule1.php?action=view&view=500&kuly=ENGIN&tot_pages=12&ctype=<&course=&sem=1&ses=2022/2023">10</a>&nbsp;&nbsp;<a href="schedule1.php?action=view&view=550&kuly=ENGIN&tot_pages=12&ctype=<&course=&sem=1&ses=2022/2023">11</a>&nbsp;&nbsp;<a href="schedule1.php?action=view&view=600&kuly=ENGIN&tot_pages=12&ctype=<&course=&sem=1&ses=2022/2023">12</a>&nbsp;&nbsp;<a href="schedule1.php?action=view&view=100&kuly=ENGIN&tot_pages=12&ctype=<&course=&sem=1&ses=2022/2023">NEXT</a>&nbsp;&nbsp;</td>
        </form>
      </tr>
    </table></td>
</tr>
</table>
</body>
</html>
''';
    var res = parseAlbiruniHtml(rawResponse);
    expect(res.length, 5);
  });

  test('Parse Subject from HTML element (Multiple lecturers, no venue)', () {
    // from ENGINE 2022/2023 Semester 1
    var rawElement = Element.html('''
 <tr bgcolor=f5f5f5 valign="top">
                <td width="9%" align="left"  >BTEN 3183</td>
                <td width="3%" align="left" >2</td>
                <td width="25%" align="left" >BIOTECHNOLOGY ENGINEERING LAB III</td>
                <td width="3%" align="left"  >1</td>
                <td width="60%" align="left" valign="top">
                 <table  width="100%" cellpadding="0" cellspacing="0" border="0">
                  <tr  valign="top">
                   <td width="10%" align="left">WED</td>
                   <td width="20%" align="left">2 - 4.50 PM</td>
                   <td width="25%" align="left">-</td>
                   <td width="45%" align="left">DR. FAZIA ADYANI BINTI AHMAD FUAD</td>
                  </tr>
                  <tr  valign="top">
                   <td width="10%" align="left">WED</td>
                   <td width="20%" align="left">2 - 4.50 PM</td>
                   <td width="25%" align="left">-</td>
                   <td width="45%" align="left">DR. MOHD. FIRDAUS BIN ABD. WAHAB</td>
                  </tr>
                </table>
                </td>
              </tr>
''');

    var subject = parseSubject(rawElement);
    // print(subject);
    // print(subject.dayTime.first);
    expect(subject.code, 'BTEN 3183');
    expect(subject.title, 'BIOTECHNOLOGY ENGINEERING LAB III');
    expect(subject.chr, 1.0);
    expect(subject.sect, 2);
    expect(
        subject.lect,
        containsAll([
          'DR. FAZIA ADYANI BINTI AHMAD FUAD',
          'DR. MOHD. FIRDAUS BIN ABD. WAHAB'
        ]));
    expect(subject.venue, null);
    expect(subject.dayTime,
        containsAll([DayTime(day: 3, startTime: '14:00', endTime: '16:50')]));
  });

  test('Parse Subject from HTML element (Multiple days)', () {
    // from KICT 2022/2023 Semester 1
    var rawElement = Element.html('''
</tr>
              <tr bgcolor=ddddf5 valign="top">
                <td width="9%" align="left"  >CSCI 4347</td>
                <td width="3%" align="left" >1</td>
                <td width="25%" align="left" >BRAIN COMPUTATIONAL ANALYTICS</td>
                <td width="3%" align="left"  >3</td>
                <td width="60%" align="left" valign="top">
                 <table  width="100%" cellpadding="0" cellspacing="0" border="0">
                  <tr  valign="top">
                   <td width="10%" align="left">T-TH</td>
                   <td width="20%" align="left">3.30 - 4.50 PM</td>
                   <td width="25%" align="left">ICT LR 19 LEVEL 4C</td>
                   <td width="45%" align="left">DR. NORZALIZA BINTI MD NOR</td>
                  </tr>
                </table>
                </td>
              </tr>
''');

    var subject = parseSubject(rawElement);
    // print(subject);
    // print(subject.dayTime.first);
    expect(subject.code, 'CSCI 4347');
    expect(subject.title, 'BRAIN COMPUTATIONAL ANALYTICS');
    expect(subject.chr, 3.0);
    expect(subject.sect, 1);
    expect(subject.lect, containsAll(['DR. NORZALIZA BINTI MD NOR']));
    expect(subject.venue, 'ICT LR 19 LEVEL 4C');
    expect(
        subject.dayTime,
        containsAll([
          DayTime(day: 2, startTime: '15:30', endTime: '16:50'),
          DayTime(day: 4, startTime: '15:30', endTime: '16:50')
        ]));
  });

  test('Parse Subject from HTML element (Multiple days with tuto time)', () {
    // from KICT 2022/2023 Semester 1
    var rawElement = Element.html('''
<tr bgcolor=ddddf5 valign="top">
                <td width="9%" align="left"  >INFO 1303</td>
                <td width="3%" align="left" >2</td>
                <td width="25%" align="left" >DATABASE SYSTEMS</td>
                <td width="3%" align="left"  >3</td>
                <td width="60%" align="left" valign="top">
                 <table  width="100%" cellpadding="0" cellspacing="0" border="0">
                  <tr  valign="top">
                   <td width="10%" align="left">M-W</td>
                   <td width="20%" align="left">10 - 11.20 AM</td>
                   <td width="25%" align="left">ICT LR 9 LEVEL 2C</td>
                   <td width="45%" align="left">DR. ATIKAH BALQIS BINTI BASRI</td>
                  </tr>
                  <tr  valign="top">
                   <td width="10%" align="left">MON</td>
                   <td width="20%" align="left">5 - 6.50 PM</td>
                   <td width="25%" align="left">-</td>
                   <td width="45%" align="left">TUTOR</td>
                  </tr>
                </table>
                </td>
              </tr>
''');

    var subject = parseSubject(rawElement);
    // print(subject);
    // print(subject.dayTime.first);
    expect(subject.code, 'INFO 1303');
    expect(subject.title, 'DATABASE SYSTEMS');
    expect(subject.chr, 3.0);
    expect(subject.sect, 2);
    expect(
        subject.lect, containsAll(['DR. ATIKAH BALQIS BINTI BASRI', 'TUTOR']));
    expect(subject.venue, 'ICT LR 9 LEVEL 2C');
    expect(
        subject.dayTime,
        containsAll([
          DayTime(day: 1, startTime: '10:00', endTime: '11:20'),
          DayTime(day: 1, startTime: '17:00', endTime: '18:50'),
          DayTime(day: 3, startTime: '10:00', endTime: '11:20'),
        ]));
  });
}
