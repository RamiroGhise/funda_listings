import 'package:flutter/material.dart';
import 'package:funda_listings/services/listing/listing_exceptions.dart';
import 'package:funda_listings/utilities/show_error_dialog.dart';
import 'package:funda_listings/views/listing_view.dart';
import 'package:funda_listings/services/listing/listing_service.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  // instantiate the ListingService
  ListingService listingService = ListingService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listings'),
      ),
      body: Center(
        child: ElevatedButton(
          // get information about a listing when pressing the button.
          // todo use a ListView.builder to choose from a List<Listing>
          onPressed: () async {
            const listingId = '9134f731-c348-4df2-b330-ab360a471b77';
            try {
              final listing = await listingService.getListing(listingId);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ListingView(listing: listing),
                ),
              );
            } on BadRequestListingException catch(e) {
              showErrorDialog(context, e.text);
            } catch (e) {
              showErrorDialog(context, e.toString());
            }
          },
          child: const Text('Get listing'),
        ),
      ),
    );
  }
}