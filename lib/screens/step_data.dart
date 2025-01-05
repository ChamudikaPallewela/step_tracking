import 'package:hive/hive.dart';
part 'step_data.g.dart';

@HiveType(typeId: 0)
class StepData {
  @HiveField(0)
  final DateTime date;

  @HiveField(1)
  final int steps;

  StepData({required this.date, required this.steps});
}
