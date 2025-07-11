import 'dart:io';
import 'package:flutter/material.dart';
import 'package:found_one/presentation/widgets/custom_text_field.dart';

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

  Future<void> _pickImage() async{
    
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
