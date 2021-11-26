import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
void main() {
  runApp(new MaterialApp(
    title: "Camera App",
    home: landingScreen(),
  ));
}
class landingScreen extends StatefulWidget {

  @override
  _landingScreenState createState() => _landingScreenState();
}

class _landingScreenState extends State<landingScreen> {
  File imageFile= File('');
  final imagePicker=ImagePicker();
  _openGallary(BuildContext context) async{
    var pic =(await imagePicker.pickImage(source: ImageSource.gallery)) ;
    this.setState(() {
      imageFile=pic as File;
    });
    Navigator.of(context).pop();
  }
  _openCamera(BuildContext context) async {
    var pic =(await imagePicker.pickImage(source: ImageSource.camera)) as File;
    this.setState(() {
      imageFile=pic as File;
    });
    Navigator.of(context).pop();
  }
  Future<void> showChoiceDialog(BuildContext context){
    return showDialog(context: context,builder: (BuildContext context){
      return AlertDialog(
        title: Text("Make a choice!"),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              GestureDetector(
                child: Text("Gallary"),
                onTap: (){
                  _openGallary(context);
                },
              ),
              Padding(padding: EdgeInsets.all(8.0),),
              GestureDetector(
                child: Text("Gallary"),
                onTap: (){
                  _openCamera(context);
                },
              ),
            ],
          ),
        ),
      );
    });
  }
  // ignore: non_constant_identifier_names
  Widget decideImageView(){
    if(imageFile==null){
      return Text("No image selected!");
    }
    else{
      Image.file(imageFile,width:400,height: 400);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Screen"),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              decideImageView(),
              ElevatedButton(onPressed:(){
                showChoiceDialog(context);
              }, child: Text("Select Image!"),)
            ],
          ),
        ),
      ),
    );
  }
}
