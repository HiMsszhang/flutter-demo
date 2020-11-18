import 'package:json_annotation/json_annotation.dart';

part 'MineCourseModel.g.dart';

@JsonSerializable()
class MineCourseModel {
  @JsonKey(defaultValue: 0)
  int total;
  @JsonKey(defaultValue: 0)
  int perPage;
  @JsonKey(defaultValue: 0, name: 'current_page')
  int currentPage;
  @JsonKey(defaultValue: 0, name: 'last_page')
  int lastPage;
  @JsonKey(defaultValue: [])
  List<MineCourseListModel> data;

  MineCourseModel();

  factory MineCourseModel.fromJson(Map<String, dynamic> json) => _$MineCourseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MineCourseModelToJson(this);

  // 命名构造函数
  MineCourseModel.empty();
}

@JsonSerializable()
class MineCourseListModel {
  @JsonKey(name: 'course_id', defaultValue: 0)
  int courseId;
  @JsonKey(name: 'order_price', defaultValue: '')
  String orderPrice;
  @JsonKey(name: 'course_title', defaultValue: '')
  String courseTitle;
  @JsonKey(name: 'typeface_title', defaultValue: '')
  String typefaceTitle;
  @JsonKey(name: 'total_hours', defaultValue: 0)
  num totalHours;
  @JsonKey(name: 'course_difficulty', defaultValue: 0)
  num courseDifficulty;
  @JsonKey(name: 'learning_time', defaultValue: '')
  String learningTime;
  @JsonKey(name: 'teacher_name', defaultValue: '')
  String teacherName;
  @JsonKey(name: 'avatar', defaultValue: '')
  String avatar;
  @JsonKey(defaultValue: 0)
  num status;
  @JsonKey(name: 'opening_time', defaultValue: '')
  String openingTime;
  MineCourseListModel();

  factory MineCourseListModel.fromJson(Map<String, dynamic> json) => _$MineCourseListModelFromJson(json);

  Map<String, dynamic> toJson() => _$MineCourseListModelToJson(this);

  // 命名构造函数
  MineCourseListModel.empty();
}
