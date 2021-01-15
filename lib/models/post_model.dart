class Post{
  String firstName;
  String secondName;
  String content;
  String img_url;
  String userId;
  String dateTime;
  Post({this.firstName,this.secondName,this.img_url,this.content,this.userId,this.dateTime});
  Post.fromJson(Map<String,dynamic> json):
        this.firstName=json['firstName'],
        this.secondName=json['secondName'],
        this.content=json['content'],
        this.img_url=json['img_url'],
        this.userId=json['userId'],
        this.dateTime=json['dateTime'];


  Map<String,dynamic> toJson(){
    return {
      'firstName':this.firstName,
      'secondName':this.secondName,
      'content':this.content,
      'img_url':this.img_url,
      'dateTime':this.dateTime,
      'userId':this.userId,
    };
  }
}