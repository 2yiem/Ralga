import 'dart:convert';
class Chapters {
  String id;
  String text;
  String articles_count;


  Chapters(this.id, this.text, this.articles_count);

  Chapters.fromJson(Map json)
        :id=json['id'],
        text=json['text'],
        articles_count=json['articles_count'];
  Map toJson(){
    return{
    'id':id,
    'text':text,
    'articles_count':articles_count,
    };
  }

}
