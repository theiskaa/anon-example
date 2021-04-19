import 'package:flutter/widgets.dart';

class UserModel {
  final String id;

  const UserModel({
    @required this.id,
  }) : assert(id != null);

  static const empty = UserModel(id: '');

  UserModel.fromJson(Map<String, String> json) : this.id = json['id'];

  Map<String, dynamic> toJson() => {'id': id};
}
