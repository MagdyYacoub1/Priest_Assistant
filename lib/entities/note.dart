import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 1)
class Note {
  @HiveField(0)
  String? content = "No Note";
  @HiveField(1)
  DateTime date;

  Note({this.content, required this.date});
}