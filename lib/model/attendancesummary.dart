class UserAttendanceSummary {
  final int userId;
  int totalPresents;
  int totalAbsents;
  int totalLeaves;

  UserAttendanceSummary({
    required this.userId,
    this.totalPresents = 0,
    this.totalAbsents = 0,
    this.totalLeaves = 0,
  });
}
