import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:open_file/open_file.dart';
import 'package:priest_assistant/entities/confessor.dart';
import 'package:priest_assistant/entities/confessor_utilities.dart';
import 'package:priest_assistant/translations/locale_keys.g.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:path_provider/path_provider.dart';

class AppUtilities {
  static Future<OpenResult> exportExcelFile([bool isRTL = false]) async {
    Iterable<Confessor> confessors = ConfessorUtilities.getAllConfessors();
    // Create a new Excel document.
    final Workbook workbook = new Workbook();
    //Accessing worksheet via index.
    final Worksheet sheet = workbook.worksheets[0];
    sheet.name = LocaleKeys.main_sheet.tr();
    sheet.isRightToLeft = isRTL;
    //create style
    final Style goodStyle = workbook.styles.add('goodStyle');
    goodStyle.backColor = '#66BB6A'; // deep green color
    final Style lateStyle = workbook.styles.add('lateStyle');
    lateStyle.backColor = '#EF5350'; // deep red color
    final Style notesNameStyle = workbook.styles.add('notesNameStyle');
    notesNameStyle.vAlign = VAlignType.center;
    notesNameStyle.hAlign = HAlignType.center;
    final Style notesDateStyle = workbook.styles.add('notesDateStyle');
    notesDateStyle.hAlign = HAlignType.center;
    notesDateStyle.numberFormat = 'm/d/yyyy';

    // Save the document.
    sheet.getRangeByName('A1').setText(LocaleKeys.full_name.tr());
    sheet.getRangeByName('B1').setText(LocaleKeys.last_confession_date.tr());
    sheet.getRangeByName('C1').setText(LocaleKeys.status.tr());
    sheet.getRangeByName('D1').setText(LocaleKeys.confessions.tr());
    sheet.getRangeByName('E1').setText(LocaleKeys.phone_number.tr());
    sheet.getRangeByName('F1').setText(LocaleKeys.email_address.tr());
    sheet.getRangeByName('G1').setText(LocaleKeys.address.tr());
    //sheet.getRangeByName('H1').setText("Confessor name");

    //populate all rows
    for (int i = 0; i < confessors.length; i++) {
      sheet.getRangeByIndex(i + 2, 1).setText(
          confessors.elementAt(i).fName + ' ' + confessors.elementAt(i).lName);
      sheet
          .getRangeByIndex(i + 2, 2)
          .setDateTime(confessors.elementAt(i).lastConfessDate);
      bool isLate = confessors.elementAt(i).isLate();
      sheet.getRangeByIndex(i + 2, 3).setText(
          isLate ? LocaleKeys.late_status.tr() : LocaleKeys.good_status.tr());
      sheet.getRangeByIndex(i + 2, 3).cellStyle =
          isLate ? lateStyle : goodStyle;
      sheet
          .getRangeByIndex(i + 2, 4)
          .setNumber(confessors.elementAt(i).prevConfessions.toDouble());
      sheet.getRangeByIndex(i + 2, 5).setText(confessors.elementAt(i).phone);
      sheet.getRangeByIndex(i + 2, 6).setText(confessors.elementAt(i).email);
      sheet.getRangeByIndex(i + 2, 7).setText(confessors.elementAt(i).address);
    }
    //Range range = sheet.getRangeByName('A:G');
    // Auto-Fit column the range
    //range.autoFitColumns();

    final Worksheet notesSheet =
        workbook.worksheets.addWithName(LocaleKeys.notes_sheet.tr());
    notesSheet.isRightToLeft = isRTL;

    //populate all rows
    for (int i = 0, j = 1; i < confessors.length; i++, j = j + 2) {
      // merge two cells
      notesSheet.getRangeByIndex(j, 1, j + 1).merge();
      notesSheet.getRangeByIndex(j, 1).cellStyle = notesNameStyle;
      notesSheet.getRangeByIndex(j, 1).setText(
          confessors.elementAt(i).fName + ' ' + confessors.elementAt(i).lName);
      //populate all notes
      for (int l = 0; l < confessors.elementAt(i).notes.length; l++) {
        notesSheet
            .getRangeByIndex(j, l + 2)
            .setDateTime(confessors.elementAt(i).notes[l].date);
        notesSheet.getRangeByIndex(j, l + 2).cellStyle = notesDateStyle;
        notesSheet
            .getRangeByIndex(j + 1, l + 2)
            .setText(confessors.elementAt(i).notes[l].content);
      }
    }
    // Auto-Fit columns
    for (int i = 1; i < 20; i++) {
      sheet.autoFitColumn(i);
      notesSheet.autoFitColumn(i);
    }

    final List<int> bytes = workbook.saveAsStream();
    //Dispose the workbook.
    workbook.dispose();
    Directory? directory = await getApplicationDocumentsDirectory();
    File file = File('${directory.path}/AddingTextNddfsberDateTime.xlsx');
    file.writeAsBytes(bytes, flush: true);
    final OpenResult openResult = await OpenFile.open(file.path);
    //print(openResult.message);
    return openResult;
  }
}
