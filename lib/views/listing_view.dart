import 'package:flutter/material.dart';
import 'package:funda_listings/services/listing/listing.dart';

class ListingView extends StatelessWidget {
  final Listing listing;

  const ListingView({Key? key, required this.listing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(listing.id),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(listing.media.first.mediaItems.first.url),
              Text(
                listing.address,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text('${listing.lotArea.toString()} m\u00b2'),
                  const SizedBox(width: 8.0),
                  Text('${listing.numberOfRooms.toString()} rooms'),
                ],
              ),
              Text(
                listing.price.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(listing.fullDescription),
            ],
          ),
        ),
      ),
    );
  }
}
