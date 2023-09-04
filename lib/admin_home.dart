import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'Firebase_Dynamic_Link_Service.dart';
import 'ProvideClass.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({Key? key}) : super(key: key);

  // @override
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.brown,
        elevation: 0,
        centerTitle: true,
        title: const Text("Voting Ballot Admin",style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25
        )),
      ),
      body:Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          width: width,
          // height: height/1.54,
          decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(15),
                color: Colors.grey.shade300
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10,),
                Consumer<ProviderClass>(
                    builder: (context,value,child) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: value.PartyName ,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter Party Name',
                            labelText: 'Name'
                        ),
                        validator: (text){
                          if(text==null||text.isEmpty){
                            return 'Name is required Field';
                          }else{
                            return null;
                          }
                        },
                      ),
                    );
                  }
                ),
                Consumer<ProviderClass>(
                    builder: (context,value,child) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: value.PartyId ,
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter Party Id',
                            labelText: 'Id'
                        ),
                        validator: (text){
                          if(text==null||text.isEmpty){
                            return 'Id is required Field';
                          }else{
                            return null;
                          }
                        },
                      ),
                    );
                  }
                ),
                Consumer<ProviderClass>(
                  builder: (context,value,child) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        maxLength: 2,
                        keyboardType: TextInputType.number,
                        controller:value.PartyPosition,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter Position',
                            labelText: 'Position'
                        ),
                        validator: (text){
                          if(text==null||text.isEmpty){
                            return 'Position is required Field';
                          }else{
                            return null;
                          }
                        },
                      ),
                    );
                  }
                ),
                Consumer<ProviderClass>(
                    builder: (context,value,child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            value.imageFromGallery1();
                          },
                          child: Container(
                            width: width/2.5,
                            height: 150,
                            decoration:BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white
                            ),
                            child: Consumer<ProviderClass>(
                                builder: (context,value1,child) {
                                return value1.pickedImage1 == null ? Column(
                                  children: [
                                    const SizedBox(height: 10,),
                                     Text("Photo",style: TextStyle(
                                        color: Colors.grey.shade500,fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 30,),
                                    Image.asset("assets/img_14.png"),
                                  ],
                                ):ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.file(value1.pickedImage1 as File,
                                      fit: BoxFit.fill,));
                              }
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            value.imageFromGallery();
                          },
                          child: Container(
                            width: width/2.5,
                            height: 150,
                            decoration:BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white
                            ),
                            child:  Consumer<ProviderClass>(
                              builder: (context,value1,child) {
                                return value1.pickedImage == null ? Column(
                                  children: [
                                    const SizedBox(height: 10,),
                                      Text("Symbol",style: TextStyle(
                                          color: Colors.grey.shade500,fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 30,),
                                    Image.asset("assets/img_14.png"),
                                  ],
                                ):ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                    child: Image.file(value1.pickedImage as File,
                                      fit: BoxFit.fill,));
                              }
                            ),
                          ),
                        )
                      ],
                    );
                  }
                ),

                Consumer<ProviderClass>(
                    builder: (context,value,child) {
                    return InkWell(
                      onTap: () {
                        value.addData(context);
                        // Future.delayed(const Duration(seconds:3), () async {
                        // value.clearfields();
                        value.getData(value.PartyId.text);
                        // });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 50),
                        height: 40,
                         decoration: BoxDecoration(
                           color: Colors.brown,
                           borderRadius: BorderRadius.circular(25)
                         ),
                        child:  Center(child:value.statusadd ? const CircularProgressIndicator(color: Colors.white,strokeWidth: 4.2,): const Text("Add Details",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))),
                      ),
                    );
                  }
                ),

                Consumer<ProviderClass>(
                    builder: (context,value,child) {
                    return InkWell(
                      onTap: () {
                        print(value.photo+"jhfbcjhfbcjhbhjcbf");
                        print(value.PartyName.text+"jhfbcjhfbcjhbhjcbf");

                        value.createDynamicLink(true,value.PartyId.text,value.photo,value.PartyName.text);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 50),
                        height: 40,
                         decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(25)
                         ),
                        child:  Center(child: Text("Generate Link",
                            style: TextStyle(fontSize: 18,color: Colors.green.shade900,
                                fontWeight: FontWeight.bold))),
                      ),
                    );
                  }
                ),
                Consumer<ProviderClass>(
                    builder: (context,value,child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(value.shareLinks),
                        IconButton(onPressed: (){
                          Clipboard.setData(ClipboardData(text:value.shareLinks)).then((_){
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              backgroundColor: Colors.white,
                              content: Text("Copied ID !",style: TextStyle(color:Colors.black),),
                            ));
                            });
                        }, icon: const Icon(Icons.copy_outlined)),
                        IconButton(onPressed: (){
                          // value.initDynamicLink(context,value.PartyId.text);
                        }, icon: const Icon(Icons.share))
                      ],
                    );
                  }
                ),
                Consumer<ProviderClass>(
                    builder: (context,value,child) {
                     return Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: IconButton(icon: const Icon(Icons.refresh,size: 35),
                        onPressed: (){
                          value.clearfields();
                        }),
                      ),
                );
                   }
                 ),
                const SizedBox(height: 10,)
              ],
            ),
          ),
        ),
      )
    );
  }
}
