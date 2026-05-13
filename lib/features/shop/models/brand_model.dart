import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String id;
  String name;
  String image;
  String coverImage;
  String description;
  bool isFeatured;
  bool isVerified;
  int productsCount;
  String contactEmail;
  String contactPhone;
  String website;
  String addressLine1;
  String addressLine2;
  String city;
  String state;
  String postalCode;
  String country;
  Map<String, String> socialLinks;

  BrandModel({
    required this.id,
    required this.image,
    required this.name,
    this.coverImage = '',
    this.description = '',
    this.isFeatured = false,
    this.isVerified = false,
    this.productsCount = 0,
    this.contactEmail = '',
    this.contactPhone = '',
    this.website = '',
    this.addressLine1 = '',
    this.addressLine2 = '',
    this.city = '',
    this.state = '',
    this.postalCode = '',
    this.country = '',
    this.socialLinks = const {},
  });

  /// Empty Helper Function
  static BrandModel empty() => BrandModel(id: '', image: '', name: '');

  /// Convert model to Json structure so that you can store data in Firebase
  toJson() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
      'CoverImage': coverImage,
      'Description': description,
      'ProductsCount': productsCount,
      'IsFeatured': isFeatured,
      'IsVerified': isVerified,
      'ContactEmail': contactEmail,
      'ContactPhone': contactPhone,
      'Website': website,
      'AddressLine1': addressLine1,
      'AddressLine2': addressLine2,
      'City': city,
      'State': state,
      'PostalCode': postalCode,
      'Country': country,
      'SocialLinks': socialLinks,
    };
  }

  /// Map Json oriented document snapshot from Firebase to UserModel
  factory BrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return BrandModel.empty();
    final socialData = data['SocialLinks'];
    return BrandModel(
      id: data['Id'] ?? '',
      name: data['Name'] ?? '',
      image: data['Image'] ?? '',
      coverImage: data['CoverImage'] ?? '',
      description: data['Description'] ?? '',
      isFeatured: data['IsFeatured'] ?? false,
      isVerified: data['IsVerified'] ?? false,
      productsCount: int.tryParse((data['ProductsCount'] ?? 0).toString()) ?? 0,
      contactEmail: data['ContactEmail'] ?? '',
      contactPhone: data['ContactPhone'] ?? '',
      website: data['Website'] ?? '',
      addressLine1: data['AddressLine1'] ?? '',
      addressLine2: data['AddressLine2'] ?? '',
      city: data['City'] ?? '',
      state: data['State'] ?? '',
      postalCode: data['PostalCode'] ?? '',
      country: data['Country'] ?? '',
      socialLinks: socialData is Map
          ? socialData.map((key, value) => MapEntry(key.toString(), (value ?? '').toString()))
          : <String, String>{},
    );
  }

  /// Map Json oriented document snapshot from Firebase to UserModel
  factory BrandModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      // Map JSON Record to the Model
      return BrandModel(
        id: document.id,
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        coverImage: data['CoverImage'] ?? '',
        description: data['Description'] ?? '',
        productsCount: int.tryParse((data['ProductsCount'] ?? 0).toString()) ?? 0,
        isFeatured: data['IsFeatured'] ?? false,
        isVerified: data['IsVerified'] ?? false,
        contactEmail: data['ContactEmail'] ?? '',
        contactPhone: data['ContactPhone'] ?? '',
        website: data['Website'] ?? '',
        addressLine1: data['AddressLine1'] ?? '',
        addressLine2: data['AddressLine2'] ?? '',
        city: data['City'] ?? '',
        state: data['State'] ?? '',
        postalCode: data['PostalCode'] ?? '',
        country: data['Country'] ?? '',
        socialLinks: data['SocialLinks'] is Map
            ? (data['SocialLinks'] as Map).map((key, value) => MapEntry(key.toString(), (value ?? '').toString()))
            : <String, String>{},
      );
    } else {
      return BrandModel.empty();
    }
  }
}
