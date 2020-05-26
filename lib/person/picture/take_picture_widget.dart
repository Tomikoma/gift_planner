import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class TakePictureWidget extends StatelessWidget {
  final int personId;

  TakePictureWidget({this.personId});

  @override
  Widget build(BuildContext context) {
    return Consumer<CameraDescription>(
      builder: (context, camera, child) => TakePicture(
        camera: camera,
        personId: personId,
      ),
    );
  }
}

class TakePicture extends StatefulWidget {
  final CameraDescription camera;
  final int personId;

  TakePicture({@required this.camera, @required this.personId});

  @override
  _TakePictureState createState() => _TakePictureState();
}

class _TakePictureState extends State<TakePicture> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();

    _controller = CameraController(widget.camera, ResolutionPreset.low);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: _initializeControllerFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () async {
          try {
            await _initializeControllerFuture;

            final path = join(
              (await getApplicationDocumentsDirectory()).path,
              'person${widget.personId}.png',
            );
            final file = File(path);
            if (file.existsSync()) {
              file.deleteSync();
            }
            await _controller.takePicture(path);
            Navigator.pop(context, file);
          } catch (e) {
            print(e);
          }
        },
      ),
    );
  }
}
