import 'package:flutter/material.dart';

class ImagePreviewAlert extends StatefulWidget {
  final String photoPath;

  const ImagePreviewAlert({
    Key? key,
    required this.photoPath,
  }) : super(key: key);

  @override
  _ImagePreviewAlertState createState() => _ImagePreviewAlertState();
}

class _ImagePreviewAlertState extends State<ImagePreviewAlert> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (bool value) {},
      child: Dialog(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close)),
                ],
              ),
              Expanded(
                child: Image.network(
                  "${widget.photoPath}",
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
