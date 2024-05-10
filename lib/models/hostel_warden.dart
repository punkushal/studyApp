class HostelWarden {
  final String userId;
  final String fullName;
  final String email;
  final String password;
  final String hostelName;
  final String hostelLocation;
  final String profileImage;
  final String phoneNumber;
  String role = "warden";

  HostelWarden({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.password,
    required this.hostelName,
    required this.hostelLocation,
    required this.profileImage,
    required this.phoneNumber,
    required String role,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'hostelName': hostelName,
      'hostelLocation': hostelLocation,
      'password': password,
      'profileImage': profileImage,
      'role': role
    };
  }

  factory HostelWarden.fromMap(Map<String, dynamic> map) {
    return HostelWarden(
      role: map['role'] as String? ?? '',
      password: map['password'] as String? ?? '',
      phoneNumber: map['phoneNumber'] as String? ?? '',
      hostelName: map['hostelName'] as String? ?? '',
      fullName: map['fullName'] as String? ?? '',
      profileImage: map['profileImage'] as String? ?? '',
      userId: map['userId'] as String? ?? '',
      email: map['email'] as String? ?? '',
      hostelLocation: map['hostelLocation'] as String? ?? '',
    );
  }
}
