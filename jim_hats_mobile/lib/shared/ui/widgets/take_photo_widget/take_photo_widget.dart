import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jim_hats_mobile/routing/app_routes.dart';

class TakePhotoWidget extends StatefulWidget {
  const TakePhotoWidget({super.key, required this.onPhotoChosen});
  final Function(XFile ? photo) onPhotoChosen;
  @override
  State<TakePhotoWidget> createState() => _TakePhotoWidgetState();
}

class _TakePhotoWidgetState extends State<TakePhotoWidget> {
  List<CameraDescription> cameras = [];
  CameraController? cameraController;
  XFile? photo;
  Size? size;
  bool isFlashOn = false;
  bool isFrontCamera = false;

  @override
  void initState() {
    super.initState();
    _loadCameras();
  }

  void _loadCameras() async {
    try {
      cameras = await availableCameras();
      _startCamera();
    } on CameraException catch (e) {
      print(e.description);
    }
  }

  _startCamera() {
    if (cameras.isEmpty) {
      print('Câmera não foi encontrada');
    } else {
      _previewCamera(cameras[0]);
    }
  }

  _previewCamera(CameraDescription camera) async {
    cameraController = CameraController(camera, ResolutionPreset.medium,
        enableAudio: false, imageFormatGroup: ImageFormatGroup.jpeg);
    try {
      await cameraController?.initialize();
      //await cameraController?.setFlashMode(FlashMode.off);
    } on CameraException catch (e) {
      print(e.description);
    }
    if (mounted) {
      setState(() {});
    }
  }

  _selectedPhotoWidget() {
    return Image.file(
      File(photo!.path),
      fit: BoxFit.cover,
    );
  }

  _cameraPreviewWidget() {
    final CameraController? camController = cameraController;
    if (camController == null || !camController.value.isInitialized) {
      return Center(
        child: Text('Camera not allowed'),
      );
    }

    return CameraPreview(camController);
  }

  _takePicture() async {
    final CameraController? camController = cameraController;
    if (camController == null || !camController.value.isInitialized) {
      return;
    }
    try {
      //await camController.setFlashMode(FlashMode.off);
      XFile photoTaken = await camController.takePicture();
      if (mounted) {
        setState(() {
          photo = photoTaken;
        });
      }
    } on CameraException catch (e) {
      print(e.description);
    }
  }

  _toggleFlash() async {
    final CameraController? camController = cameraController;
    if (camController == null || !camController.value.isInitialized) {
      return;
    }
    try {
      if (isFlashOn) {
        await camController.setFlashMode(FlashMode.off);
        setState(() {
          isFlashOn = false;
        });
      } else {
        await camController.setFlashMode(FlashMode.always);
        setState(() {
          isFlashOn = true;
        });
      }
    } on CameraException catch (e) {
      print(e.description);
    }
  }



  _toggleCamera() async {
    final CameraController? camController = cameraController;
    if (camController == null || !camController.value.isInitialized) {
      return;
    }

    try {
      if (isFrontCamera) {
        await camController.setDescription(cameras[0]);
        setState(() {
          isFrontCamera = false;
        });
      } else {
        await camController.setDescription(cameras[1]);
        setState(() {
          isFrontCamera = true;
        });
      }
    } on CameraException catch (e) {
      print(e.description);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              flex: 8,
              child: Container(
                  child: photo == null
                      ? _cameraPreviewWidget()
                      : _selectedPhotoWidget())),
          Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: photo == null
                      ? [
                          IconButton(
                              onPressed: () async {
                                await _toggleFlash();
                              },
                              icon: Icon(isFlashOn
                                  ? Icons.flash_on
                                  : Icons.flash_off)),
                          IconButton(
                              iconSize: 40,
                              onPressed: () {
                                _takePicture();
                              },
                              icon: Icon(Icons.photo_camera)),
                          IconButton(
                              onPressed: () {
                                _toggleCamera();
                              },
                              icon: Icon(isFrontCamera
                                  ? Icons.camera_front
                                  : Icons.camera_rear))
                        ]
                      : [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  photo = null;
                                });
                              },
                              icon: Icon(Icons.close)),
                          IconButton(
                              onPressed:()=>widget.onPhotoChosen(photo),
                              icon: Icon(Icons.check))
                        ],
                ),
              )),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              photo == null
                  ? TextButton.icon(
                      style: TextButton.styleFrom(),
                      onPressed: () async {
                        final file = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (file == null) {
                          return;
                        }
                        setState(() {
                          photo = file;
                        });
                      },
                      icon: Icon(Icons.image),
                      label: Text('From library'))
                  : SizedBox.shrink()
            ],
          ))
        ],
      )),
    );
  }
}
