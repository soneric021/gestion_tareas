import 'package:hive_flutter/adapters.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class TodoModel extends HiveObject {
  int? id;
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? description;
  @HiveField(2)
  String? limit;
  @HiveField(3)
  bool isCompleted = false;

  TodoModel({
    this.id,
    required this.title,
    this.description,
    this.limit,
    this.isCompleted = false
  });

  void  updateIsCompleted(){
    isCompleted = !isCompleted; 
  }
  
  void updateFields(Map<dynamic, dynamic> input){
      if(input["title"] != null) title = input["title"];
      if(input["description"] != null) description = input["description"];
      if(input["limit"] != null) limit = input["limit"]; 
  }

  factory TodoModel.fromJson(int key, Map<dynamic, dynamic> json) => TodoModel( id:key, title: json["title"], description: json["description"], limit: json["limit"], isCompleted: json["isCompleted"]);

  Map<dynamic, dynamic> toJson() => {
    'title': title,
    'description': description,
    'limit': limit,
    'isCompleted':isCompleted
  };
}
