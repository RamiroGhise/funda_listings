import 'package:flutter/material.dart';

class MediaSlider extends StatefulWidget {
  final List<String> images;

  const MediaSlider({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  State<MediaSlider> createState() => _MediaSliderState();
}

class _MediaSliderState extends State<MediaSlider> {
  int index = 0;
  late String image;

  @override
  void initState() {
    image = widget.images.first;
    super.initState();
  }

  // todo setState can be called after the last/first image checking is made
  void nextImage() {
    List<String> images = widget.images;
    setState(() {
      if (index < images.length - 1) {
        index = index + 1;
        image = images.elementAt(index);
      }
    });
  }

  void previousImage() {
    List<String> images = widget.images;
    setState(() {
      if (index > 0) {
        index = index - 1;
        image = images.elementAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (dragEndDetails) {
        final double? value = dragEndDetails.primaryVelocity;
        if (value != null) {
          if (value < 0) {
            // Page forwards
            nextImage();
          } else if (value > 0) {
            // Page backwards
            previousImage();
          }
        }
      },
      child: Image.network(
        image,
        fit: BoxFit.cover,
      ),
    );
  }
}
