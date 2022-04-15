import 'dart:convert';

class Category {
  String id;
  String title;
  String chapters_count;

  Category(this.id, this.title, this.chapters_count);

  Category.fromJson(Map json)
      : id = json['id'],
        title = json['title'],
        chapters_count = json['chapters_count'];
  Map toJson() {
    return {
      'id': id,
      'title': title,
      'chapters_count': chapters_count,
    };
  }
}
