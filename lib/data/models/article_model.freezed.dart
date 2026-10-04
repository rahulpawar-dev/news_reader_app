// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'article_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ArticleModel {

 String get id; String get title; String? get description; String? get url; String? get urlToImage; String? get publishedAt; String? get sourceName; bool get isBookmarked;
/// Create a copy of ArticleModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArticleModelCopyWith<ArticleModel> get copyWith => _$ArticleModelCopyWithImpl<ArticleModel>(this as ArticleModel, _$identity);

  /// Serializes this ArticleModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ArticleModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArticleModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.url, _this.url) || other.url == _this.url)&&(identical(other.urlToImage, _this.urlToImage) || other.urlToImage == _this.urlToImage)&&(identical(other.publishedAt, _this.publishedAt) || other.publishedAt == _this.publishedAt)&&(identical(other.sourceName, _this.sourceName) || other.sourceName == _this.sourceName)&&(identical(other.isBookmarked, _this.isBookmarked) || other.isBookmarked == _this.isBookmarked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ArticleModel;
  return Object.hash(runtimeType,_this.id,_this.title,_this.description,_this.url,_this.urlToImage,_this.publishedAt,_this.sourceName,_this.isBookmarked);
}

@override
String toString() {
  final _this = this as ArticleModel;
  return 'ArticleModel(id: ${_this.id}, title: ${_this.title}, description: ${_this.description}, url: ${_this.url}, urlToImage: ${_this.urlToImage}, publishedAt: ${_this.publishedAt}, sourceName: ${_this.sourceName}, isBookmarked: ${_this.isBookmarked})';
}


}

/// @nodoc
abstract mixin class $ArticleModelCopyWith<$Res>  {
  factory $ArticleModelCopyWith(ArticleModel value, $Res Function(ArticleModel) _then) = _$ArticleModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? description, String? url, String? urlToImage, String? publishedAt, String? sourceName, bool isBookmarked
});




}
/// @nodoc
class _$ArticleModelCopyWithImpl<$Res>
    implements $ArticleModelCopyWith<$Res> {
  _$ArticleModelCopyWithImpl(this._self, this._then);

  final ArticleModel _self;
  final $Res Function(ArticleModel) _then;

/// Create a copy of ArticleModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? url = freezed,Object? urlToImage = freezed,Object? publishedAt = freezed,Object? sourceName = freezed,Object? isBookmarked = null,}) {
  return _then(ArticleModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,urlToImage: freezed == urlToImage ? _self.urlToImage : urlToImage // ignore: cast_nullable_to_non_nullable
as String?,publishedAt: freezed == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as String?,sourceName: freezed == sourceName ? _self.sourceName : sourceName // ignore: cast_nullable_to_non_nullable
as String?,isBookmarked: null == isBookmarked ? _self.isBookmarked : isBookmarked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ArticleModel].
extension ArticleModelPatterns on ArticleModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArticleModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArticleModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArticleModel value)  $default,){
final _that = this;
switch (_that) {
case _ArticleModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArticleModel value)?  $default,){
final _that = this;
switch (_that) {
case _ArticleModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? description,  String? url,  String? urlToImage,  String? publishedAt,  String? sourceName,  bool isBookmarked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArticleModel() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.url,_that.urlToImage,_that.publishedAt,_that.sourceName,_that.isBookmarked);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? description,  String? url,  String? urlToImage,  String? publishedAt,  String? sourceName,  bool isBookmarked)  $default,) {final _that = this;
switch (_that) {
case _ArticleModel():
return $default(_that.id,_that.title,_that.description,_that.url,_that.urlToImage,_that.publishedAt,_that.sourceName,_that.isBookmarked);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? description,  String? url,  String? urlToImage,  String? publishedAt,  String? sourceName,  bool isBookmarked)?  $default,) {final _that = this;
switch (_that) {
case _ArticleModel() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.url,_that.urlToImage,_that.publishedAt,_that.sourceName,_that.isBookmarked);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ArticleModel implements ArticleModel {
  const _ArticleModel({required this.id, required this.title, required this.description, required this.url, required this.urlToImage, required this.publishedAt, required this.sourceName, this.isBookmarked = false});
  factory _ArticleModel.fromJson(Map<String, dynamic> json) => _$ArticleModelFromJson(json);

@override final  String id;
@override final  String title;
@override final  String? description;
@override final  String? url;
@override final  String? urlToImage;
@override final  String? publishedAt;
@override final  String? sourceName;
@override@JsonKey() final  bool isBookmarked;

/// Create a copy of ArticleModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArticleModelCopyWith<_ArticleModel> get copyWith => __$ArticleModelCopyWithImpl<_ArticleModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ArticleModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArticleModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.url, url) || other.url == url)&&(identical(other.urlToImage, urlToImage) || other.urlToImage == urlToImage)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.sourceName, sourceName) || other.sourceName == sourceName)&&(identical(other.isBookmarked, isBookmarked) || other.isBookmarked == isBookmarked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,description,url,urlToImage,publishedAt,sourceName,isBookmarked);
}

@override
String toString() {
    return 'ArticleModel(id: $id, title: $title, description: $description, url: $url, urlToImage: $urlToImage, publishedAt: $publishedAt, sourceName: $sourceName, isBookmarked: $isBookmarked)';
}


}

/// @nodoc
abstract mixin class _$ArticleModelCopyWith<$Res> implements $ArticleModelCopyWith<$Res> {
  factory _$ArticleModelCopyWith(_ArticleModel value, $Res Function(_ArticleModel) _then) = __$ArticleModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? description, String? url, String? urlToImage, String? publishedAt, String? sourceName, bool isBookmarked
});




}
/// @nodoc
class __$ArticleModelCopyWithImpl<$Res>
    implements _$ArticleModelCopyWith<$Res> {
  __$ArticleModelCopyWithImpl(this._self, this._then);

  final _ArticleModel _self;
  final $Res Function(_ArticleModel) _then;

/// Create a copy of ArticleModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? url = freezed,Object? urlToImage = freezed,Object? publishedAt = freezed,Object? sourceName = freezed,Object? isBookmarked = null,}) {
  return _then(_ArticleModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,urlToImage: freezed == urlToImage ? _self.urlToImage : urlToImage // ignore: cast_nullable_to_non_nullable
as String?,publishedAt: freezed == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as String?,sourceName: freezed == sourceName ? _self.sourceName : sourceName // ignore: cast_nullable_to_non_nullable
as String?,isBookmarked: null == isBookmarked ? _self.isBookmarked : isBookmarked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


