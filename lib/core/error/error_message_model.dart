import 'package:equatable/equatable.dart';

class ErrorMessageModel extends Equatable {
  final String? message;

  const ErrorMessageModel({this.message});

  factory ErrorMessageModel.fromJson(Map<String, dynamic> json) =>
      ErrorMessageModel(message: json['message']);

  @override
  List<Object?> get props => [message];
}
