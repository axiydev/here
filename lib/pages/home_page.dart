import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:here/models/post_model.dart';
import 'package:here/service/auth_service.dart';
import 'package:here/service/prefs_service.dart';
import 'package:here/service/rtdb_service.dart';

import 'detail_page.dart';

class HomePage extends StatefulWidget{
  static const String id='home_page';
  @override
  _HomePageState createState()=>_HomePageState();
}
class _HomePageState extends State<HomePage>{
  List<Post> lt=new List();
  @override
  void initState(){
    super.initState();
    _apiGetPosts();
  }
  Future _openDetail()async{
    var result=await Navigator.of(context).push(new MaterialPageRoute(
      builder:(BuildContext context){
        return new DetailPage();
      }
    ));

    if(result!=null && result.containsKey('data')){
      _apiGetPosts();
    }
  }
  _apiGetPosts()async{
    var id=await Prefs.loadUserId();
    RTDBService.getPosts(id).then((post)=>{_loadPosts(post)}).catchError((err)=>print('THIS IS ERROR1'));
  }
  _loadPosts(post)async{
    setState(() {
      lt=post.toList();
    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text('All Posts',style: Theme.of(context).textTheme.headline6,),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: ()async{
              AuthService.signOutUser(context);
            },
            icon:Icon(Icons.logout),
          ),
        ],
      ),
      body:Container(
        padding: EdgeInsets.all(20),
        //#ListView
        child: _myWidget(),
      ),
      floatingActionButton:FloatingActionButton(
        child:Icon(Icons.add),
        onPressed:(){
          _openDetail();
        },
      ),
    );

  }
  ListView _myWidget(){
    return ListView.builder(
      itemCount: lt.length,
      itemBuilder: (ctx,index){
        return _itemsWidget(lt[index]);
      },
    );
  }
  Container _itemsWidget(Post post){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom:20),
      child:RichText(
        textAlign: TextAlign.start,
        text:TextSpan(
          text:'${post.firstName} ${post.secondName}\n',
          style:Theme.of(context).textTheme.headline1.copyWith(
              fontSize: 27,
              letterSpacing: 0.5,
              height:1.3,
              fontWeight: FontWeight.w400
          ),
          children: [
            TextSpan(
              text: '${post.dateTime.toString().substring(0,10)}\n',
              style:Theme.of(context).textTheme.headline3.copyWith(
                fontSize: 15,
              ),
            ),
            TextSpan(
              text:'${post.content}',
              style: Theme.of(context).textTheme.headline2.copyWith(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

}