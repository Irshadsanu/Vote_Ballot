import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:vote_ballot/ProvideClass.dart';


import 'Hompage.dart';
import 'admin_home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String vId;

  if(!kIsWeb){
    await Firebase.initializeApp();
  }else{
    await Firebase.initializeApp(
        options:const FirebaseOptions(
            apiKey: "AIzaSyAMrEmJb8SbHY-rfzwCBhiTCI-amdlHHI4",
            authDomain: "evm2021-b43f4.firebaseapp.com",
            databaseURL: "https://evm2021-b43f4-default-rtdb.firebaseio.com",
            projectId: "evm2021-b43f4",
            storageBucket: "evm2021-b43f4.appspot.com",
            messagingSenderId: "985711884493",
            appId: "1:985711884493:web:2142236d9c1a34730b9184",
            measurementId: "G-TDER8BQKE7"
        )

    );
  }

  if(kIsWeb){
    setPathUrlStrategy();
    String? voterId=Uri.base.queryParameters["id"];

    if(voterId==null){
      vId="523";

      print(vId.toString()+"sdsdsdwww");


    }else{
      vId=voterId;
      print(vId.toString()+"dsssss");

    }

    runApp( MyApp(votId:vId,));


  }
  else{
    runApp( MyApp(votId: "",));
  }



}

class MyApp extends StatelessWidget {
    String votId;
   MyApp({super.key,required this.votId});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>ProviderClass())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home:   AdminHome(),
        home:   Homepage(id: votId),
      ),
    );
  }
}
