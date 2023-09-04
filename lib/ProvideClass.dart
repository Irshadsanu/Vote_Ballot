import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vote_ballot/ModeList.dart';
import 'package:firebase_database/firebase_database.dart';


class ProviderClass extends ChangeNotifier{


  TextEditingController PartyName = TextEditingController();
  TextEditingController PartyPosition = TextEditingController();
  TextEditingController PartyId = TextEditingController();


  final DatabaseReference mRoot = FirebaseDatabase.instance.ref();
  Reference ref = FirebaseStorage.instance.ref("ItemImages");
  Color iconColor = const Color(0xff5E1A19);
  Color readyColor = Colors.green;
  int coloredIconIndex = -1;



  List<modelist> voteLists = [];

  // final List<modelist> Candidate=[
  //
  //     modelist(
  //        "",
  //         "",
  //         "1",
  //     ),
  //    modelist(
  //         "",
  //        "",
  //        "2",
  //    ),
  //    modelist(
  //        'assets/lotus.png',
  //        "ಆನಂದ್ ಗೌಡ",
  //        "3",
  //     ),
  //    modelist(
  //         "",
  //         "",
  //         "4",
  //     ),
  //    modelist(
  //         "",
  //         "",
  //         "5",
  //
  //     ),
  //    modelist(
  //         "",
  //         "",
  //         "6",
  //     ),
  //    modelist(
  //         "",
  //         "",
  //         "7",
  //     ),
  //    modelist(
  //         "",
  //         "",
  //         "8",
  //     ),
  //    modelist(
  //         "",
  //         "",
  //         "9",
  //     ),
  //    modelist(
  //         "",
  //         "",
  //         "10",
  //     ),
  //
  //
  // ];



  File? pickedImage;
  File? pickedImage1;
  final ImagePicker picker = ImagePicker();
  final ImagePicker picker1 = ImagePicker();


  imageFromGallery() async {

    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 15);
    if (pickedFile != null) {
      pickedImage = File(pickedFile.path);
      print(pickedImage);

    } else {

    }


    notifyListeners();
  }
imageFromGallery1() async {

    final pickedFile1 = await picker1.pickImage(source: ImageSource.gallery, imageQuality: 15);
    if (pickedFile1 != null) {
      pickedImage1 = File(pickedFile1.path);
      print(pickedImage1);

    } else {

    }


    notifyListeners();
  }


   void changeColor() {
     readyColor = Colors.red;
     // iconColor = Colors.red;
     notifyListeners();
   }
   void IIndex (int index){
     coloredIconIndex = index;
   }

   void resetColor() {
     iconColor = Color(0xff5E1A19);
     readyColor = Colors.green;
     // notifyListeners();
   }


   bool statusadd = false;
   
   Future<void> addData(BuildContext context) async {
     statusadd = true;
     String ID = DateTime.now().millisecondsSinceEpoch.toString();
     HashMap<String, Object> map = HashMap();
     if (pickedImage != null) {
       ref = FirebaseStorage.instance.ref().child("${ID}symbol");

       await ref.putFile(pickedImage!).whenComplete(() async {
         await ref.getDownloadURL().then((value) {
           map['symbol'] = value;

           notifyListeners();
         });
       });



     }else{}

     if(pickedImage1 != null){
       ref = FirebaseStorage.instance.ref().child("${ID}photo");

       await ref.putFile(pickedImage1!).whenComplete(() async {
         await ref.getDownloadURL().then((value1) {
           map['photo'] = value1;

           notifyListeners();
         });
       });
     }else{}



     map["id"]=PartyId.text;
     map["Name"] = PartyName.text;
     map["position"] = PartyPosition.text;


     mRoot.child("Lock").child(PartyId.text).child("evm").set(map);

     statusadd =false;
     notifyListeners();

     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
       content: Text('Successfully uploaded'),
       duration: Duration(seconds: 1),
     ));

     // clearfields();
     notifyListeners();

   }



   void clearfields(){
    PartyName.text = '';
    PartyId.text ='';
    PartyPosition.text = '';
    pickedImage1 = null ;
    pickedImage = null ;
    shareLinks = '';

    notifyListeners();
   }



   String position = '';
   String symbol = '';
   String Name = '';
   String photo = '';




void getData(String id){
    mRoot.child('Lock').child(id).child('evm').once().then((value){
      if(value.snapshot.exists){
        Map<dynamic, dynamic> map = value.snapshot.value as Map;


        // voteLists.add(
        //   modelist(
        //       map['position'].toString(),
        //       map['photo'].toString(),
        //       map['symbol'].toString(),
        //       map['Name'].toString(),
        //       map['id'].toString()
        //   )
        // );

        position = map['position'].toString();
        symbol = map['symbol'].toString();
        Name = map['Name'].toString();
        photo = map['photo'].toString();

        notifyListeners();
      }

    });
}


String shareLinks = '';


   Future<String>createDynamicLink(bool short,String Id,String Photo,String name) async {
print(Photo);

    String linkMessage;
    bool _isCreatingLink = false;
    FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
    print("GGGGGGGGG");
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://evm2021.page.link',
      link: Uri.parse('https://voteballot.web.app/?id=$Id'),
      // androidParameters: const AndroidParameters(
      //   packageName: "com.example.vote_ballot",
      //   minimumVersion: 1,
      // ),
      socialMetaTagParameters: SocialMetaTagParameters(
          description:
          "$name \nModel Vote Ballot",

          imageUrl: Uri.parse(Photo)),
    );

    Uri url;

    if (short) {
      final ShortDynamicLink shortLink =
      await dynamicLinks.buildShortLink(parameters);
      url = shortLink.shortUrl;
    } else {
      url = await dynamicLinks.buildLink(parameters);
    }
    linkMessage=url.toString();
    shareLinks =linkMessage;
notifyListeners();
photo = '';
    print(linkMessage+"kmkmkmkmkmkmm");
    return linkMessage;

  }




   Future<void>initDynamicLink(BuildContext context,String id) async {

      print(id);
    FirebaseDynamicLinks.instance.onLink.listen((PendingDynamicLinkData dynamicLinkData) {
      final Uri deepLink=dynamicLinkData.link;
      var isNews=deepLink.pathSegments.contains("news");
      if (isNews){
        print('isNews showing');

        id=deepLink.queryParameters["id"].toString() ;
      }

      if(deepLink!=null){

        print('isNews deepLink');

        try {

        }catch(e){
          print(e.toString()+"jjjjjjjjjjjjjjjjjj");
        }
      }
      else{
        return null;
      }
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
    notifyListeners();


    //    final PendingDynamicLinkData data = FirebaseDynamicLinks.instance.getInitialLink() as PendingDynamicLinkData;
    //    final Uri deepLink = data.link;
    //
    //    var isNews = deepLink.pathSegments.contains("news");
    //    if(isNews){
    //       itemList.id = deepLink.queryParameters["id"].toString();
    //
    //       if(deepLink!= null){
    //         try{
    //           print("hegvdhhhuuhhyhhhhhhhhhhhh");
    //           Navigator.push(context, MaterialPageRoute(builder: (context) =>
    //               OpenNewsScreen(itemlist: itemList)));
    //
    //         }catch(e){
    //           print(e);
    //         }
    //       }
    //    }
    //
    //
  }




}







