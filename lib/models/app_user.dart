import 'dart:convert';

class AppUser {
  String email;
  String? id;
  String? imageUrl;
  String userName;
  String phoneNumber;
  String address;
  bool isAdmin;
  int numOfItemInCart = 0;
  AppUser({
    required this.email,
    this.id,
    this.imageUrl,
    required this.userName,
    required this.phoneNumber,
    required this.address,
    this.isAdmin = false,
    this.numOfItemInCart = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'id': id,
      'imageUrl': imageUrl,
      'userName': userName,
      'phoneNumber': phoneNumber,
      'address': address,
      'isAdmin': isAdmin,
      'numOfItemInCart': numOfItemInCart,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      email: map['email'] ?? '',
      id: map['id'],
      imageUrl: map['imageUrl'],
      userName: map['userName'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      address: map['address'] ?? '',
      isAdmin: map['isAdmin'] ?? false,
      numOfItemInCart: map['numOfItemInCart']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source));

  AppUser copyWith({
    String? email,
    String? id,
    String? imageUrl,
    String? userName,
    String? phoneNumber,
    String? address,
    bool? isAdmin,
    int? numOfItemInCart,
  }) {
    return AppUser(
      email: email ?? this.email,
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      userName: userName ?? this.userName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      isAdmin: isAdmin ?? this.isAdmin,
      numOfItemInCart: numOfItemInCart ?? this.numOfItemInCart,
    );
  }

  @override
  String toString() {
    return 'AppUser(email: $email, id: $id, imageUrl: $imageUrl, userName: $userName, phoneNumber: $phoneNumber, address: $address, isAdmin: $isAdmin, numOfItemInCart: $numOfItemInCart)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AppUser &&
      other.email == email &&
      other.id == id &&
      other.imageUrl == imageUrl &&
      other.userName == userName &&
      other.phoneNumber == phoneNumber &&
      other.address == address &&
      other.isAdmin == isAdmin &&
      other.numOfItemInCart == numOfItemInCart;
  }

  @override
  int get hashCode {
    return email.hashCode ^
      id.hashCode ^
      imageUrl.hashCode ^
      userName.hashCode ^
      phoneNumber.hashCode ^
      address.hashCode ^
      isAdmin.hashCode ^
      numOfItemInCart.hashCode;
  }
}
