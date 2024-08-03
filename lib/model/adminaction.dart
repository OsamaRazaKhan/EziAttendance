class AdminAction {
  final int actionId;
  final int adminId;
  final String actionType;
  final DateTime actionDate;
  final int targetUserId;

  AdminAction({
    required this.actionId,
    required this.adminId,
    required this.actionType,
    required this.actionDate,
    required this.targetUserId,
  });

  // Factory method to create an AdminAction from a Map
  factory AdminAction.fromMap(Map<String, dynamic> map) {
    return AdminAction(
      actionId: map['ActionID'],
      adminId: map['AdminID'],
      actionType: map['ActionType'],
      actionDate: DateTime.parse(map['ActionDate']),
      targetUserId: map['TargetUserID'],
    );
  }

  // Method to convert AdminAction to a Map
  Map<String, dynamic> toMap() {
    return {
      'ActionID': actionId,
      'AdminID': adminId,
      'ActionType': actionType,
      'ActionDate': actionDate.toIso8601String(),
      'TargetUserID': targetUserId,
    };
  }
}
