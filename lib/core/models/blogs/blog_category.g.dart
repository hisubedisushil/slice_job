// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BlogCategory _$$_BlogCategoryFromJson(Map<String, dynamic> json) =>
    _$_BlogCategory(
      id: json['id'] as String,
      parentId: json['parent_id'] as String?,
      catName: json['cat_name'] as String?,
      catSlug: json['cat_slug'] as String?,
      date: json['date'] as String?,
      status: json['status'] as String?,
      testField: json['test_field'] as String?,
    );

Map<String, dynamic> _$$_BlogCategoryToJson(_$_BlogCategory instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('parent_id', instance.parentId);
  writeNotNull('cat_name', instance.catName);
  writeNotNull('cat_slug', instance.catSlug);
  writeNotNull('date', instance.date);
  writeNotNull('status', instance.status);
  writeNotNull('test_field', instance.testField);
  return val;
}
