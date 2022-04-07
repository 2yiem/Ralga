import 'dart:convert';
class Chapters {
  String id;
  String text;


  Chapters(this.id, this.text);

  Chapters.fromJson(Map json)
        :id=json['id'],
        text=json['text'];
  Map toJson(){
    return{
    'id':id,
    'text':text,
    };
  }

}
