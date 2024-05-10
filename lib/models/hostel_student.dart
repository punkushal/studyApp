class HostelStudent {
  final String name;
  final String phoneNumber;
  final String roomNumber;
  final String email;
  final String guardianName;
  final String guardianNumber;
  final String hostelCode;
  final String role;

  HostelStudent({
    required this.name,
    required this.phoneNumber,
    required this.roomNumber,
    required this.email,
    required this.guardianName,
    required this.guardianNumber,
    required this.hostelCode,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phoneNumber': phoneNumber,
      'roomNumber': roomNumber,
      'email': email,
      'guardianName': guardianName,
      'guardianNumber': guardianNumber,
      'hostelCode': hostelCode,
      'role': role,
    };
  }

  factory HostelStudent.fromMap(Map<String, dynamic> map) {
    return HostelStudent(
      role: map['role'] as String,
      name: map['name'] as String,
      phoneNumber: map['phoneNumber'] as String,
      roomNumber: map['roomNumber'] as String,
      email: map['email'] as String,
      guardianName: map['guardianName'] as String,
      guardianNumber: map['guardianNumber'] as String,
      hostelCode: map['hostelCode'] as String,
    );
  }
}
