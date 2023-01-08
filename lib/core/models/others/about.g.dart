// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'about.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_About _$$_AboutFromJson(Map<String, dynamic> json) => _$_About(
      id: json['id'] as String?,
      category: json['category'] as String?,
      postTitle: json['post_title'] as String?,
      postDesc: json['post_desc'] as String?,
      updatedBy: json['updated_by'] as String?,
      updatedDate: json['updated_date'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$$_AboutToJson(_$_About instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('category', instance.category);
  writeNotNull('post_title', instance.postTitle);
  writeNotNull('post_desc', instance.postDesc);
  writeNotNull('updated_by', instance.updatedBy);
  writeNotNull('updated_date', instance.updatedDate);
  writeNotNull('status', instance.status);
  return val;
}
