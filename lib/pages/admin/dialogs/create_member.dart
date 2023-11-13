import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soccer/pages/admin/models/profile_model.dart';

class CreateMember extends StatefulWidget {
  final ProfileModel member;
  const CreateMember({Key? key, required this.member}) : super(key: key);

  @override
  CreateMemberState createState() => CreateMemberState();
}

class CreateMemberState extends State<CreateMember> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _contactEmergencyNameController =
      TextEditingController();
  @override
  void initState() {
    super.initState();
    _listenner();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _listenner() {
    _nameController
        .addListener(() => widget.member.name = _nameController.text);
    _emailController
        .addListener(() => widget.member.email = _emailController.text);
    _numberController
        .addListener(() => widget.member.contact = _numberController.text);
    _contactEmergencyNameController.addListener(() =>
        widget.member.emergencyContact = _contactEmergencyNameController.text);
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
                  "Agregar Miembro",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ),
              _uploadImage(),
              _generateTextField(
                controller: _nameController,
                text: 'Nombre',
              ),
              _generateTextField(
                controller: _emailController,
                text: 'Correo',
              ),
              _generateTextField(
                  controller: _numberController,
                  text: 'Número de teléfono',
                  isText: false),
              _generateTextField(
                  controller: _contactEmergencyNameController,
                  text: 'Contacto de emergencia',
                  isText: false),
            ],
          ),
        )
      ],
    );
  }

  Widget _generateTextField({
    required String text,
    required TextEditingController controller,
    bool isText = true,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextField(
        controller: controller,
        obscureText: false,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          label: Text(text),
        ),
        maxLines: 1,
        minLines: 1,
        keyboardType: isText ? null : TextInputType.number,
      ),
    );
  }

  Widget _uploadImage() {
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
                  "Presione para subir una imagen",
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

    widget.member.image = base64string;
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
