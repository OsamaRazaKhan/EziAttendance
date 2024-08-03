class Grade {
  final int gradeId;
  final int userId;
  final String grade;
  final int totalDaysAttended;
  final DateTime gradePeriodStartDate;
  final DateTime gradePeriodEndDate;

  Grade({
    required this.gradeId,
    required this.userId,
    required this.grade,
    required this.totalDaysAttended,
    required this.gradePeriodStartDate,
    required this.gradePeriodEndDate,
  });

  // Factory method to create a Grade from a Map
  factory Grade.fromMap(Map<String, dynamic> map) {
    return Grade(
      gradeId: map['GradeID'],
      userId: map['UserID'],
      grade: map['Grade'],
      totalDaysAttended: map['TotalDaysAttended'],
      gradePeriodStartDate: DateTime.parse(map['GradePeriodStartDate']),
      gradePeriodEndDate: DateTime.parse(map['GradePeriodEndDate']),
    );
  }

  // Method to convert Grade to a Map
  Map<String, dynamic> toMap() {
    return {
      'GradeID': gradeId,
      'UserID': userId,
      'Grade': grade,
      'TotalDaysAttended': totalDaysAttended,
      'GradePeriodStartDate': gradePeriodStartDate.toIso8601String(),
      'GradePeriodEndDate': gradePeriodEndDate.toIso8601String(),
    };
  }
}
