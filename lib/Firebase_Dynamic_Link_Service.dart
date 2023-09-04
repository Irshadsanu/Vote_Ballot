import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

class FirebaseDynamicLinkService{




  static Future<String>createDynamicLink(bool short,String Id) async {

    String linkMessage;
    bool _isCreatingLink = false;
    FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
    print("GGGGGGGGG");
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://evm2021.page.link',
      link: Uri.parse('https://voteballot.web.app/?id=$Id'),
      androidParameters: const AndroidParameters(
        packageName: "com.example.vote_ballot",
        minimumVersion: 1,
      ),
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

    print(linkMessage+"kmkmkmkmkmkmm");
    return linkMessage;


  }


  static Future<void>initDynamicLink(BuildContext context,String id) async {

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