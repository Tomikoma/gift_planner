import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class PersonIcon extends StatefulWidget {
  final int personId;
  const PersonIcon({this.personId});

  @override
  _PersonIconState createState() => _PersonIconState();
}

class _PersonIconState extends State<PersonIcon> {
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
    if (file.existsSync()) {
      setState(() {
        image = file;
      });
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        backgroundImage: image?.existsSync() == true
            ? Image.memory(
                image.readAsBytesSync(),
                fit: BoxFit.fill,
              ).image
            : null,
        child: image?.existsSync() != true ? Icon(Icons.person) : null);
  }
}
