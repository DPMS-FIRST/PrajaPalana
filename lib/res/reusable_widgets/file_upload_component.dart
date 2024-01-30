import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

import 'package:open_file/open_file.dart';

class FileUploadWidget extends StatefulWidget {
  final Function(File?) onImageSelected;
  final Function(File?) onDocumentSelected;
  final bool? isImageRequired;
  final bool? isDocumentRequired;

  FileUploadWidget({
    required this.onImageSelected,
    required this.onDocumentSelected,
    this.isImageRequired,
    this.isDocumentRequired,
  });

  @override
  _FileUploadWidgetState createState() => _FileUploadWidgetState();
}

class _FileUploadWidgetState extends State<FileUploadWidget> {
  File? _image;
  File? _document;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        widget.onImageSelected!(_image);
      });
    }
  }

  Future<void> _pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null) {
      setState(() {
        _document = File(result.files.single.path!);
        widget.onDocumentSelected!(_document);
      });
    }
  }

  void _previewDocument() {
    if (_document != null) {
      OpenFile.open(_document!.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.isImageRequired == true)
          _image == null
              ? ElevatedButton(
                  onPressed: _pickImage,
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Text('Upload Photo')),
                )
              : Column(
                  children: [
                    Text("Uploaded photo : "),
                    SizedBox(width: 8.0),
                    Image.file(
                      _image!,
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                  ],
                ),
        SizedBox(height: 30.0),
        if (widget.isDocumentRequired == true)
          _document == null
              ? ElevatedButton(
                  onPressed: _pickDocument,
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Text('Upload Doc')),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  
                  children: [
                    Text("Uploaded Doc : "),
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.insert_drive_file,
                            size: MediaQuery.of(context).size.width * 0.1,
                          ),
                          onPressed: _previewDocument,
                        ),
                        Text('${_document!.path.split('/').last}'),
                      ],
                    )
                  ],
                ),
      ],
    );
  }
}
