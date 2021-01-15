import 'dart:io';

import 'package:flutter/material.dart';
import 'package:here/models/post_model.dart';
import 'package:here/service/prefs_service.dart';
import 'package:here/service/rtdb_service.dart';
import 'package:here/service/storage_service.dart';
import 'package:image_picker/image_picker.dart';

import 'home_page.dart';
class DetailPage extends StatefulWidget {
  static const String id='detail_page';
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isLoading=false;
  var firstNController=new TextEditingController();
  var secondNController=new TextEditingController();
  var contentController=new TextEditingController();
  var dateTimeController=new TextEditingController();
  File _image;
  var picker=ImagePicker();

  Future getImage()async{
    final pickedFile=await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if(pickedFile!=null){
        _image=File(pickedFile.path);
      }else{
        print('No image selected');
      }
    });
  }

  _apiUploadImage(first,second,content,date){
    setState(() {
      isLoading=true;
    });
    StorageService.uploadImage(_image).then((img_url){
      _apiAddPost(first,second,content,date,img_url);
    });
  }
  _apiAddPost(first,second,content,date,img_url)async{
    var id=await Prefs.loadUserId();
    var post=new Post(userId: id,firstName: first,secondName: second,content: content,dateTime:date,img_url: img_url);
    await RTDBService.addPost(post).then((value)=>{_respAddPost()}).catchError((err)=>print(err));
  }
  _addPost()async{
    var first=firstNController.text.toString().trim();
    var second=secondNController.text.toString().trim();
    var content=contentController.text.toString().trim();
    var date=dateTimeController.text.toString().trim();
    if(first.isEmpty||second.isEmpty||content.isEmpty||date.isEmpty)return;
    if(_image==null)return;
    _apiUploadImage(first, second, content, date);
  }
  _respAddPost(){
    setState(() {
      isLoading=false;
    });
    Navigator.of(context).pop({'data':'done'});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon:Icon(Icons.arrow_back_ios_outlined),
            onPressed:(){
              Navigator.pop(context);
            }
        ),
        title:Text('Add Post'),
        centerTitle: true,
      ),
      body:SafeArea(
        child:Stack(
          children: [
            SingleChildScrollView(
              child:Container(
                padding:EdgeInsets.all(25),
                child:Column(
                  children:<Widget>[
                    //_imgGet
                    GestureDetector(
                      child:_imgGet(image:'assets/images/ic_insta.png'),
                      onTap:getImage,
                    ),
                    //#first name
                    _myField(text:'First Name',controller: firstNController),
                    //#second name
                    _myField(text:'Second Name',controller: secondNController),
                    //#content
                    _myField(text:'Content',controller: contentController),
                    //date
                    _myField(text:'2021-01-01',controller: dateTimeController),
                    Container(
                      width: double.infinity,
                      height: 45,
                      child:RaisedButton(
                        elevation: 0.0,
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        color:Theme.of(context).buttonColor,
                        onPressed:(){
                          _addPost();
                        },
                        child:Text('Add',style: Theme.of(context).textTheme.button.copyWith(fontSize: 17),),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if(isLoading)Center(
              child: CircularProgressIndicator(strokeWidth:8,),
            ),
          ],
        ),
      ),
    );
  }
  Container _myField({text,controller}){
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child:TextField(
        controller: controller,
        decoration:InputDecoration(
          hintText:text,
        ),
      ),
    );
  }
Container _imgGet({image}){
    return Container(
      height: 100,
      width: 100,
      child:_image!=null?Image.file(_image,fit: BoxFit.cover,):Image(
        image:AssetImage(image),
        fit: BoxFit.cover,
      ),
    );
}
}


