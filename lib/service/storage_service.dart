
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService{
  static final _storage=FirebaseStorage.instance.ref();
  static final folder="post_images";
  static Future<String> uploadImage(File _image)async{
   String img_name='image_'+DateTime.now().toString();
   StorageReference fireStoreRef=_storage.child(folder).child(img_name);
   StorageUploadTask uploadTask=fireStoreRef.putFile(_image);
   StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
   if(taskSnapshot!=null){
     final String downloadUrl=await taskSnapshot.ref.getDownloadURL();
     print(downloadUrl);
     return downloadUrl;
   }
   return null;
  }
}