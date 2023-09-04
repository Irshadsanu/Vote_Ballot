import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vote_ballot/Hompage.dart';
import 'package:vote_ballot/ProvideClass.dart';

class Vpat extends StatefulWidget {
  String id;
   Vpat({Key? key,required this.id}) : super(key: key);

  @override
  State<Vpat> createState() => _VpatState();
}

class _VpatState extends State<Vpat> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  bool _isVisible = false;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync:this, duration: const Duration(seconds: 8));

    _animation = Tween<Offset>(begin: Offset.zero, end: const Offset(0,1))
        .animate(_controller);

    Timer(const Duration(seconds: 8),
          ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context)=> Homepage(id:widget.id,)),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    _controller.forward();

    return Scaffold(
      body: Center(
        child: Stack(children: [

          Positioned(
            left: 82,
            top: 180,
            child: SlideTransition(
                position: _animation,
               child: Container(
                 padding: const EdgeInsets.only(bottom: 35),
                 // width: 250,
                 //  height: 200,
                // color: Colors.brown,
                  child: Consumer<ProviderClass>(
                    builder: (context,value,child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                           Text(value.Name,style: const TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                           Text(value.position,style: const TextStyle(fontWeight: FontWeight.bold),),
                          SizedBox(
                              height: 40,width: 60,
                              child: Image.network(value.symbol,scale:23 ),)
                        ],
                      );
                    }
                  ),)
                ),
          ),
            Image.asset("assets/vvpat.png"),
        ],
      ),
      ));
  }
}
