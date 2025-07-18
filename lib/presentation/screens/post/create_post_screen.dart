//create_post_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:found_one/presentation/widgets/custom_button.dart';
import 'package:found_one/presentation/widgets/custom_text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  File? _image;

  List<Widget> type = <Widget>[Text("Sale"), Text("Lost")];

  final List<bool> _selectedType = <bool>[true, false];

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      print("No image selected");
    }
  }

  void _removeImage() {
    setState(() {
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                "Create Post",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: const TextSpan(
                            text: "Title",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    "  (in 50 character. Make sure to add item name)",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          textLength: 50,
                          controller: titleController,
                          hintText: "",
                          keyboardType: TextInputType.text,
                          labelText: "",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          "Description",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          controller: descController,
                          hintText: "",
                          keyboardType: TextInputType.multiline,
                          labelText: "",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          "Upload Pic",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10),
                        _image == null
                            ? Container()
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  child: Image.file(_image!),
                                ),
                              ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Container(
                              width: 300,
                              child: OutlinedButton(
                                onPressed: _pickImage,
                                child: Text("Tap to add photo"),
                                style: ButtonStyle(
                                  shape:
                                      MaterialStateProperty.all<
                                        RoundedRectangleBorder
                                      >(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            OutlinedButton(
                              onPressed: _removeImage,
                              child: Icon(Icons.delete),
                              style: ButtonStyle(
                                shape:
                                    MaterialStateProperty.all<
                                      RoundedRectangleBorder
                                    >(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                        Row(
                          children: [
                            Text(
                              "Category",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            Spacer(),
                            ToggleButtons(
                              onPressed: (int index) {
                                setState(() {
                                  for (
                                    int i = 0;
                                    i < _selectedType.length;
                                    i++
                                  ) {
                                    _selectedType[i] = i == index;
                                  }
                                });
                              },
                              borderRadius: BorderRadius.circular(10),
                              selectedBorderColor: Theme.of(
                                context,
                              ).primaryColor,
                              constraints: BoxConstraints(
                                minHeight: 40,
                                minWidth: 100,
                              ),
                              children: type,
                              isSelected: _selectedType,
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                        Container(
                          width: double.infinity,
                          height: 50,
                          child: CustomElevatedButton(
                            onPressed: () {},
                            text: "Post",
                          ),
                        ),
                      ],
                    ),
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
