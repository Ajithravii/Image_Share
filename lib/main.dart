import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share/share.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Imagepicker(),
    );
  }
}
class Imagepicker extends StatefulWidget {
  const Imagepicker({super.key});

  @override
  State<Imagepicker> createState() => _ImagepickerState();
}

class _ImagepickerState extends State<Imagepicker> {
  File? _image;
  Future getimage(ImageSource source)async{
    final PickedFile=await ImagePicker().pickImage(source: source);
    setState(() {
      if(PickedFile!=null){
        _image=File(PickedFile.path);
      }else{
        print("noimage selected");
      }
    });
  }
  void Shareimage(){
    if(_image!=null){
      Share.shareFiles([_image!.path],text: "sharing image");
    }else{
      print("no image to share");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image picker"),
      ),
      body: Center(
        child: _image==null? Text("no image selected"):Image.file(_image!),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: ()=> getimage(ImageSource.camera),
            tooltip: "take a photo",
            child: Icon(Icons.camera),
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: ()=> getimage(ImageSource.gallery),
            tooltip: "upload a photo",
            child: Icon(Icons.photo_library),
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: Shareimage,
            tooltip: "share the image",
            child: Icon(Icons.share),
          ),
        ],
      ),

    );
  }
}
