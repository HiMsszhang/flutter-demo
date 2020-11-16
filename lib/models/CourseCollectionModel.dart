import 'package:json_annotation/json_annotation.dart';
part 'CourseCollectionModel.g.dart';

@JsonSerializable()
class CourseCollectionModel {
  @JsonKey(defaultValue: 0)
  int total;
  @JsonKey(name: 'per_page', defaultValue: 0)
  int perPage;
  @JsonKey(name: 'current_page', defaultValue: 0)
  int currentPage;
  @JsonKey(name: 'last_page', defaultValue: 0)
  int lastPage;
  @JsonKey(defaultValue: [])
  List<CourseCollectionItemModel> data;
  CourseCollectionModel();

  //反序列化
  factory CourseCollectionModel.fromJson(Map<String, dynamic> json) => _$CourseCollectionModelFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$CourseCollectionModelToJson(this);
}

@JsonSerializable()
class CourseCollectionItemModel {
  @JsonKey(name: 'is_buy', defaultValue: 0)
  int isBuy;
  @JsonKey(name: 'course', defaultValue: {})
  Course course;

  @JsonKey(name: 'teacher', defaultValue: {})
  Teacher teacher;

  CourseCollectionItemModel();
  //反序列化
  factory CourseCollectionItemModel.fromJson(Map<String, dynamic> json) => _$CourseCollectionItemModelFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$CourseCollectionItemModelToJson(this);

  CourseCollectionItemModel.empty();
}

@JsonSerializable()
class Course {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'course_title')
  String courseTitle;

  @JsonKey(name: 'total_hours')
  int totalHours;

  @JsonKey(name: 'learning_time')
  String learningTime;

  @JsonKey(name: 'course_difficulty')
  int courseDifficulty;

  @JsonKey(name: 'course_price')
  String coursePrice;

  @JsonKey(name: 'typeface_title')
  String typefaceTitle;

  Course();
  //反序列化
  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$CourseToJson(this);
}

@JsonSerializable()
class Teacher {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'teacher_name')
  String teacherName;

  @JsonKey(name: 'avatar')
  String avatar;

  @JsonKey(name: 'teacher_label')
  List<String> teacherLabel;
  Teacher();
  //反序列化
  factory Teacher.fromJson(Map<String, dynamic> json) => _$TeacherFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$TeacherToJson(this);
}
