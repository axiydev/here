class Post{
  String firstName;
  String secondName;
  String content;
  String userId;
  String dateTime;
  Post({this.firstName,this.secondName,this.content,this.userId,this.dateTime});
  Post.fromJson(Map<String,dynamic> json):
        this.firstName=json['firstName'],
        this.secondName=json['secondName'],
        this.content=json['content'],
        this.userId=json['userId'],
        this.dateTime=json['dateTime'];


  Map<String,dynamic> toJson(){
    return {
      'firstName':this.firstName,
      'secondName':this.secondName,
      'content':this.content,
      'dateTime':this.dateTime,
      'userId':this.userId,
    };
  }
}