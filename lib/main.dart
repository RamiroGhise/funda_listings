import 'package:flutter/material.dart';
import 'package:funda_listings/services/listing/listing_exceptions.dart';
import 'package:funda_listings/utilities/show_error_dialog.dart';
import 'package:funda_listings/views/listing_view.dart';
import 'package:funda_listings/services/listing/listing_service.dart';
import 'dart:developer' as devtools show log;


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

  ListingService listingService = ListingService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homepage'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            const listingId = '9134f731-c348-4df2-b330-ab360a471b779';
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