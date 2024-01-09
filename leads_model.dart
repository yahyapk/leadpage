import 'data.dart';

class LeadsModel {
  bool? success;
  Data? data;
  String? message;
  dynamic errors;

  LeadsModel({this.success, this.data, this.message, this.errors});

  factory LeadsModel.fromJson(Map<String, dynamic> json) => LeadsModel(
        success: json['success'] as bool?,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
        message: json['message'] as String?,
        errors: json['errors'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': data?.toJson(),
        'message': message,
        'errors': errors,
      };
}
