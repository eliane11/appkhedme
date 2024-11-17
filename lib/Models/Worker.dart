class KhedmeWorker {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String address;
  final String role;
  final String serviceType;
  final double? rating; // This can be nullable
  final bool availability; // Consider using bool for availability
  final DateTime createdAt;
  final DateTime updatedAt;

  KhedmeWorker({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.address,
    required this.role,
    required this.serviceType,
    this.rating,
    required this.availability,
    required this.createdAt,
    required this.updatedAt,
  });

  // Function to create an instance from JSON
  factory KhedmeWorker.fromJson(Map<String, dynamic> json) {
    return KhedmeWorker(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      role: json['role'],
      serviceType: json['service_type'],
      rating: json['rating'] != null ? json['rating'].toDouble() : null,
      availability: json['availability'] == 1,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
