// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Contact _$$_ContactFromJson(Map<String, dynamic> json) => _$_Contact(
      title: json['title'] as String?,
      contact: json['contact'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      facebook: json['facebook'] as String?,
      twitter: json['twitter'] as String?,
      instagram: json['instagram'] as String?,
      linkedin: json['linkedin'] as String?,
      youtube: json['youtube'] as String?,
      whatsapp: json['whatsapp'] as String?,
      telegram: json['telegram'] as String?,
      googleMap: json['google_map'] as String?,
    );

Map<String, dynamic> _$$_ContactToJson(_$_Contact instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('contact', instance.contact);
  writeNotNull('phone', instance.phone);
  writeNotNull('address', instance.address);
  writeNotNull('facebook', instance.facebook);
  writeNotNull('twitter', instance.twitter);
  writeNotNull('instagram', instance.instagram);
  writeNotNull('linkedin', instance.linkedin);
  writeNotNull('youtube', instance.youtube);
  writeNotNull('whatsapp', instance.whatsapp);
  writeNotNull('telegram', instance.telegram);
  writeNotNull('google_map', instance.googleMap);
  return val;
}
