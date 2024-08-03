class LeaveRequest {
  final int leaveRequestId;
  final int userId;
  final DateTime requestDate;
  final DateTime leaveDate;
  final String reason;
  final String status;

  LeaveRequest({
    required this.leaveRequestId,
    required this.userId,
    required this.requestDate,
    required this.leaveDate,
    required this.reason,
    required this.status,
  });

  // Factory method to create a LeaveRequest from a Map
  factory LeaveRequest.fromMap(Map<String, dynamic> map) {
    return LeaveRequest(
      leaveRequestId: map['leaveRequestID'],
      userId: map['userID'],
      requestDate: DateTime.parse(map['requestDate']),
      leaveDate: DateTime.parse(map['leaveDate']),
      reason: map['reason'],
      status: map['status'],
    );
  }

  // Method to convert LeaveRequest to a Map
  Map<String, dynamic> toMap() {
    return {
      'leaveRequestID': leaveRequestId,
      'userID': userId,
      'requestDate': requestDate.toIso8601String(),
      'leaveDate': leaveDate.toIso8601String(),
      'reason': reason,
      'status': status,
    };
  }
}
