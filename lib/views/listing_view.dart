import 'dart:async';

import 'package:flutter/material.dart';
import 'package:funda_listings/services/listing/listing.dart';
import 'package:funda_listings/widgets/expandable_text.dart';
import 'package:funda_listings/widgets/media_slider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ListingView extends StatelessWidget {
  final Listing listing;

  const ListingView({Key? key, required this.listing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // allow the body of the Scaffold to occupy the entire screen
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        // remove the color of the AppBar so that the content of the extended
        // body can be fully seen
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      // use a scrollable widget to avoid content overflow on the vertical axis
      body: SingleChildScrollView(
        child: Column(
          // MainAxisSize.min used to shrink the size of the column to fit the
          // children on the vertical axis
          mainAxisSize: MainAxisSize.min,
          // align the widgets from the Column to the left
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Used to limit the height of the images and stretch them
            // on the cross axis
            SizedBox(
              height: 256.0,
              child: Container(
                width: double.infinity,
                color: Colors.blue,
                child: MediaSlider(images: listing.mediaUrls),
              ),
            ),
            // use padding to visually align information in a clean manner
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    listing.address,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        listing.postalCode,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        listing.location,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Row(
                    children: [
                      // use \u00b2 for displaying the square meters as
                      // superscript
                      Text('${listing.lotArea.toString()} m\u00b2'),
                      const SizedBox(width: 8.0),
                      const Icon(
                        Icons.bed_outlined,
                        size: 14.0,
                      ),
                      Text(listing.numberOfRooms.toString()),
                    ],
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    '€ ${listing.price}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  // Display a maximum of 7 lines from the detailed description.
                  // The user has the option to expand the widget.
                  ExpandableText(
                    text: listing.fullDescription,
                    maxLines: 7,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Example Widget from google_maps_flutter.
/// todo fix access denied error.
class ListingMap extends StatefulWidget {
  const ListingMap({Key? key}) : super(key: key);

  @override
  State<ListingMap> createState() => _ListingMapState();
}

class _ListingMapState extends State<ListingMap> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _kGooglePlex,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}
