class UserProfile {
  final int? id;
  final String firstname;
  final String middlename;
  final String lastname;
  final DateTime dob;
  final String gender;
  final String email;
  final String phone;
  final String address;
  final String city;
  final String state;
  final String nin;
  final String citizenshipStatus;
  final String userId;

  UserProfile({
    this.id,
    required this.firstname,
    required this.middlename,
    required this.lastname,
    required this.dob,
    required this.gender,
    required this.email,
    required this.phone,
    required this.address,
    required this.city,
    required this.state,
    required this.nin,
    required this.citizenshipStatus,
    required this.userId,
  });

  UserProfile.fromJson(json)
    : id = json['id'],
      firstname = json['firstname'],
      middlename = json['middlename'],
      lastname = json['lastname'],
      dob = DateTime.parse(json['dob']),
      gender = json['gender'],
      email = json['email'],
      phone = json['phone'],
      address = json['address'],
      city = json['city'],
      state = json['state'],
      nin = json['nin'],
      citizenshipStatus = json['citizenship_status'],
      userId = json['user_id'];

  // return UserProfile(
  //   id: json['id'],
  //   email: json['email'],
  //   firstname: json['firstname'],
  //   middlename: json['middlename'],
  //   lastname: json['lastname'],
  //   dob: DateTime.parse(json['dob']),
  //   gender: json['gender'],
  //   phone: json['phone'],
  //   address: json['address'],
  //   city: json['city'],
  //   state: json['state'],
  //   nin: json['nin'],
  //   citizenshipStatus: json['citizenship_status'],
  //   userId: json['user_id'],
  // );
  Map<String, dynamic> toJson(
    String firstname,
    String middlename,
    String lastname,
    dynamic dob,
    String gender,
    String email,
    String phone,
    String address,
    String city,
    String state,
    String nin,
    String citizenshipStatus,
    String userId,
  ) => {
    'firstname': firstname,
    'middlename': middlename,
    'lastname': lastname,
    'dob': dob.toIso8601String(),
    'gender': gender,
    'email': email,
    'phone': phone,
    'address': address,
    'city': city,
    'state': state,
    'nin': nin,
    'citizenship_status': citizenshipStatus,
    'user_id': userId,
  };
}
