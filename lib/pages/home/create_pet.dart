import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soccer/pages/profile/models/pet_model.dart';

class CreatePet extends StatefulWidget {
  final PetModel pet;
  const CreatePet({Key? key, required this.pet}) : super(key: key);

  @override
  CreatePetState createState() => CreatePetState();
}

class CreatePetState extends State<CreatePet> {
  final TextEditingController _petNameController = TextEditingController();
  @override
  void initState() {
    _petNameController
        .addListener(() => widget.pet.name = _petNameController.text);
    super.initState();
  }

  @override
  void dispose() {
    _petNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Align(
            alignment: Alignment.topRight,
            child: Icon(Icons.close),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  "Add Your Pet",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ),
              _uploadImage(),
              TextField(
                controller: _petNameController,
                obscureText: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Name Your Pet'),
                ),
                maxLines: 1,
                minLines: 1,
              ),
            ],
          ),
        )
      ],
    );
  }

  _uploadImage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (image != null) ...[
          Stack(
            children: [
              /*
              Image.file(
                File(image!.path),
                fit: BoxFit.cover,
                width: 300.0,
                height: 180.0,
              ),
              */
              imageFromBase64String(base64string),
              Container(
                alignment: Alignment.topRight,
                width: 300.0,
                height: 30.0,
                child: GestureDetector(
                  onTap: () => setState(() => image = null),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
        if (image == null)
          GestureDetector(
            onTap: _myAlert,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                alignment: Alignment.center,
                color: Colors.grey,
                width: 300.0,
                height: 180.0,
                child: const Text(
                  "Press to upload a image",
                  style: TextStyle(color: Color.fromARGB(255, 232, 232, 232)),
                ),
              ),
            ),
          ),
        const SizedBox(height: 20.0),
      ],
    );
  }

  XFile? image;
  final ImagePicker picker = ImagePicker();
  String base64string = "";
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    File imagefile = File(img!.path); //convert Path to File
    Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes
    base64string = base64.encode(imagebytes); //convert bytes to base64 string

    widget.pet.image = base64string;
    setState(() => image = img);
  }

  Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.cover,
      width: 300.0,
      height: 180.0,
    );
  }

  Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  String base64String(Uint8List data) {
    return base64Encode(data);
  }

  //show popup dialog
  void _myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: const Text('Please choose media to select'),
            content: SizedBox(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: const [Icon(Icons.image), Text('From Gallery')],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: const [Icon(Icons.camera), Text('From Camera')],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
