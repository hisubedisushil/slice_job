// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact.freezed.dart';
part 'contact.g.dart';

@freezed
class Contact with _$Contact {
  const factory Contact({
    final String? title,
    final String? contact,
    final String? phone,
    final String? address,
    final String? facebook,
    final String? twitter,
    final String? instagram,
    final String? linkedin,
    final String? youtube,
    final String? whatsapp,
    final String? telegram,
    final String? googleMap,
  }) = _Contact;

  factory Contact.fromJson(Map<String, dynamic> json) =>
      _$ContactFromJson(json);
}
