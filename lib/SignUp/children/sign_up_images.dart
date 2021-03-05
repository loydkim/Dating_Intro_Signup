import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class SignUpImages extends StatefulWidget {
  @override _SignUpImagesState createState() => _SignUpImagesState();
}

class _SignUpImagesState extends State<SignUpImages> with AutomaticKeepAliveClientMixin<SignUpImages>{

  @override
  bool get wantKeepAlive => true;

  int _imagePosition = 0;
  List<File> _imageList = List<File>.generate(4,(file) => File(''));

  Widget _addImageButton(int position,Size size){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new GestureDetector(
        onTap: () {
          _imagePosition = position;
          _getImageAndCrop();
        },
        child: Container(
            width: size.width * 0.4,
            height: size.width * 0.6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: (_imageList[position].path != '') ?
              DecorationImage(
                image: FileImage(_imageList[position]),
                fit: BoxFit.fill,
              ) : null,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(1, 1), // changes position of shadow
                ),
              ],
            ),
            child: (_imageList[position].path != '')
                ? Container() :Icon(Icons.add_photo_alternate,
                size: 130,color: Colors.grey[700])
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Select your photos',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.only(top:16.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _addImageButton(0,size),
                    _addImageButton(1,size),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _addImageButton(2,size),
                _addImageButton(3,size),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getImageAndCrop() async {
    final _picker = ImagePicker();
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if(pickedFile != null){
      print('file path is ${pickedFile.path}');
      final File imageFileFromGallery = File(pickedFile.path);
      if (imageFileFromGallery != null) {
        File croppedFile = await _cropImageFile(imageFileFromGallery);
        if (croppedFile != null) {
          setState(() =>_imageList[_imagePosition]= croppedFile);
        }
      }
    }else{
      print('file path is null');
    }
  }

  Future<File> _cropImageFile(File image) async {
    return await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ]
            : [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.blue[800],
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
  }
}
