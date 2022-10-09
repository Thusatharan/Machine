import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:machine/machine_information.dart';

class ImageUpload extends StatefulWidget {
  const ImageUpload({Key? key}) : super(key: key);

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  File? selectedImage;
  bool? isImageUploaded = false;
  Future pickImage(ImageSource source) async {
    try {
      print('hello');
      final selectedImage = await ImagePicker().pickImage(source: source);
      if (selectedImage == null) return;

      final imageTemporary = File(selectedImage.path);
      setState(() {
        this.selectedImage = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/gymbg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Image Upload'),
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 300,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: selectedImage != null
                    ? Image.file(
                        selectedImage!,
                        fit: BoxFit.cover,
                      )
                    : Image.asset("assets/images/noimageavailable.jpg"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () => pickImage(ImageSource.camera),
                    child: Text('Take Image'),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.deepOrangeAccent),
                        textStyle:
                            MaterialStateProperty.all(TextStyle(fontSize: 14))),
                  ),
                  selectedImage != null
                      ? ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      // title: Text('Your Current Location'),
                                      content: Container(
                                        height: 250,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const Icon(
                                              Icons.check_circle,
                                              color: Colors.green,
                                              size: 90,
                                            ),
                                            const Text(
                                              'Image Uploaded',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text('OK'),
                                        )
                                      ],
                                    ));

                            //enable details button
                            setState(() {
                              isImageUploaded = true;
                            });
                          },
                          child: Text('Upload Image'),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.deepOrangeAccent),
                              textStyle: MaterialStateProperty.all(
                                  TextStyle(fontSize: 14))),
                        )
                      : ElevatedButton(
                          onPressed: null,
                          child: Text('Upload Image'),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.grey),
                              textStyle: MaterialStateProperty.all(
                                  TextStyle(fontSize: 14))),
                        ),
                ],
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: ElevatedButton(
                  onPressed: isImageUploaded == true
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MachineInformation(image: selectedImage)),
                          );
                        }
                      : null,
                  child: Text('Search Exercise'),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.all(40)),
                    backgroundColor: MaterialStateProperty.all(
                        isImageUploaded == true
                            ? Colors.deepOrange
                            : Colors.grey),
                    textStyle:
                        MaterialStateProperty.all(TextStyle(fontSize: 14)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
