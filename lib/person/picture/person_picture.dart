import 'dart:io';

import 'package:flutter/material.dart';

import 'package:gift_planner/main.dart';
import 'package:gift_planner/person/picture/take_picture_widget.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class PersonPicture extends StatefulWidget {
  final int personId;
  PersonPicture({@required this.personId});

  @override
  _PersonPictureState createState() => _PersonPictureState();
}

class _PersonPictureState extends State<PersonPicture> {
  File image;

  @override
  void initState() { 
    super.initState();
    initImage();
  }

  Future<void> initImage() async {
    final path = join(
      (await getApplicationDocumentsDirectory()).path,
      'person${widget.personId}.png',
    );
    final file = File(path);
    if (file.existsSync()){
      setState(() {
        image = file;
      });
    }
  }

  void setImage(File newImage){
    setState(() {
      image = newImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(150),
            color: Theme.of(context).primaryColor,
          ),
          child: CircleAvatar(
              radius: 50,
              backgroundImage: image?.existsSync() == true
                  ? Image.memory(
                      image.readAsBytesSync(),
                      fit: BoxFit.fill,
                    ).image
                  : null,
              child: image?.existsSync() != true
                  ? Icon(Icons.person)
                  : null),
        ),
        Positioned(
          child: GestureDetector(
            child: Icon(Icons.photo_camera),
            onTap: () async {
              File newImage = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TakePictureWidget(personId: widget.personId,),
                ),
              );
              setImage(newImage);
            },
          ),
          right: 0,
          bottom: 0,
        ),
      ],
    );
  }
}