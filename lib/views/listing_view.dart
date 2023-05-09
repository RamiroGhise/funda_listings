import 'dart:async';

import 'package:flutter/material.dart';
import 'package:funda_listings/services/listing/listing.dart';
import 'package:funda_listings/widgets/expandable_text.dart';
import 'package:funda_listings/widgets/media_slider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:developer' as devtools show log;

class ListingView extends StatelessWidget {
  final Listing listing;

  const ListingView({Key? key, required this.listing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 256.0,
              child: Container(
                width: double.infinity,
                color: Colors.blue,
                child: MediaSlider(images: listing.mediaUrls),
              ),
            ),
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
