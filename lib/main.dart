import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:funda_listings/services/listing/listing.dart';
import 'package:funda_listings/views/listing_view.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as devtools show log;

import 'constants/credentials.dart';

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
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homepage'),
      ),
      body: TextButton(
        onPressed: () async {
          final listing = await getListing();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ListingView(listing: listing),
            ),
          );
        },
        child: const Text('get listing'),
      ),
    );
  }
}

Future<Listing> getListing() async {
  const listingId = '9134f731-c348-4df2-b330-ab360a471b77';
  final url = Uri.parse(
      'http://partnerapi.funda.nl/feeds/Aanbod.svc/json/detail/$key/koop/$listingId/');
  final response = await http.get(url);
  final Listing listing = Listing.fromJson(jsonDecode(response.body));
  devtools.log("listing: $listing");

  return listing;
}
