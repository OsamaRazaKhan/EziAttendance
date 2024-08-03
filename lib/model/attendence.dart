class Attendance {
  final int attendanceId;
  final int userId;
  final DateTime date;
  final String status;
  final bool leaveRequest;

  Attendance({
    required this.attendanceId,
    required this.userId,
    required this.date,
    required this.status,
    required this.leaveRequest,
  });

  // Factory method to create an Attendance from a Map
  factory Attendance.fromMap(Map<String, dynamic> map) {
    return Attendance(
      attendanceId: map['attendanceID'],
      userId: map['userID'],
      date: DateTime.parse(map['date']),
      status: map['status'],
      leaveRequest: map['leaveRequest'],
    );
  }

  // Method to convert Attendance to a Map
  Map<String, dynamic> toMap() {
    return {
      'AttendanceID': attendanceId,
      'UserID': userId,
      'Date': date.toIso8601String(),
      'Status': status,
      'LeaveRequest': leaveRequest ? 1 : 0,
    };
  }
}
