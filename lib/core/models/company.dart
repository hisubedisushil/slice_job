import 'package:slice_job/core/models/job.dart';

class Company {
  final String id;
  final String? name;
  final String? address;
  final String? logo;
  final List<Job> jobs;
  final String? phone;
  final String? email;
  final String? website;
  final String? description;
  final String? shortDesc;
  final String? info;

  Company({
    required this.id,
    this.name,
    this.address,
    this.logo,
    this.jobs = const [],
    this.phone,
    this.email,
    this.website,
    this.description,
    this.shortDesc,
    this.info,
  });

  static Company? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    final logo = (json['photo'] ?? json['image']) as String;
    return Company(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      logo: logo,
      jobs: (json['jobs'] as List<dynamic>?)
              ?.map((e) => Job.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      phone: json['phone'] as String,
      email: json['email'] as String,
      website: json['website'] as String,
      description: json['description'] as String,
      shortDesc: json['shortDesc'] as String,
      info: json['info'] as String,
    );
  }

  static Map<String, dynamic>? toJson(Company? instance) {
    if (instance == null) return null;
    return <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'photo': instance.logo,
      'image': instance.logo,
      'jobs': instance.jobs,
      'phone': instance.phone,
      'email': instance.email,
      'website': instance.website,
      'description': instance.description,
      'shortDesc': instance.shortDesc,
      'info': instance.info,
    };
  }
}
