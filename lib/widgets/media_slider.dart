import 'package:flutter/material.dart';


/// Widget used to display the images from a Listing by detecting horizontal
/// swipes. Displays the next image when a Right-to-Left swipe is detected and
/// displays the previous image when a Left-to-Right swipe is detected by a
/// [GestureDetector].
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
      // checks if there are any more URL images in the list, increments the index
      // and takes the next URL.
      if (index < images.length - 1) {
        index = index + 1;
        image = images.elementAt(index);
      }
    });
  }

  void previousImage() {
    List<String> images = widget.images;
    setState(() {
      // checks if the index has been incremented (i.e. swipe RTL), decrements
      // the index and selects the previous image URL.
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
            // right to left swipe, rebuild widget, show next image
            nextImage();
          } else if (value > 0) {
            // left to right swipe, rebuild widget, display previous image
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
