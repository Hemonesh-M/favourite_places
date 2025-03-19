import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddImage extends StatefulWidget {
  const AddImage({super.key,required this.onPickImage});
  final Function(File img) onPickImage;
  @override
  State<AddImage> createState() {
    return _AddImageState();
  }
}

class _AddImageState extends State<AddImage> {
  File? selectedImage;
  void _takePicture() async {
    final imagePicker = ImagePicker();
    // final _pickedImage=await imagePicker.pickImage(source: ImageSource.camera);
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage == null) {
      return;
    }
    setState(() {
      selectedImage = File(pickedImage.path);
      widget.onPickImage(selectedImage!);
    });
  }

    @override
    Widget build(BuildContext context) {
      Widget content = TextButton.icon(
        onPressed: _takePicture,
        icon: Icon(Icons.camera, size: 40),
        label: Text("Take Picture"),
      );
      if (selectedImage != null) {
        content = GestureDetector(
          onTap: () {
            _takePicture();
          },
          child: Image.file(
            selectedImage!,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        );
      }
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 2),
          ),
        ),
        height: 250,
        width: double.infinity,
        alignment: Alignment.center,
        child: content,
      );
    }
  }
