import 'dart:io';

import 'package:flutter/material.dart';

class MachineInformation extends StatelessWidget {
  File? image;
  MachineInformation({required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Machine Information'),
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  child: Image.file(
                    image!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        child: Text(
                          'Machine Information',
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                      Text(
                          'Lorem ipsum dolor sit amet consectetur adipisicing repudiandae consequuntur voluptatum laborum numquam blanditiis harum quisquam eius sed odit fugiat'),
                    ],
                  ))
            ],
          ),
        ));
  }
}
