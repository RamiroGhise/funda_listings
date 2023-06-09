import 'package:funda_listings/services/listing/constants/listing_field_names.dart';

/// The model of a Listing.
/// Contains information about an estate.
class Listing {
  final String id;
  final String address;
  final String location;
  final String postalCode;
  final int numberOfRooms;
  final int price;

  // final String livingArea;
  final int lotArea;
  final String fullDescription;
  final String url;
  final List<Media> media;

  Listing({
    required this.id,
    required this.address,
    required this.location,
    required this.postalCode,
    required this.numberOfRooms,
    required this.price,
    // required this.livingArea,
    required this.lotArea,
    required this.fullDescription,
    required this.url,
    required this.media,
  });

  /// Filter [Media] and extract a list of URLs used to display
  /// images related to a [Listing].
  ///
  /// For each [Media] with category of 1, get the first 'larger'
  /// (i.e. 'grotere') image (media item category 7).
  List<String> get mediaUrls {
    List<String> urls =
        media.where((media) => media.category == 1).map((media) {
      MediaItem mediaItem =
          media.mediaItems.firstWhere((element) => element.category == 7);
      return mediaItem.url;
    }).toList();
    return urls;
  }

  /// Named constructor to create a [Listing] from a JSON object.
  Listing.fromJson(Map<String, dynamic> json)
      : id = json[listingIdFieldName],
        address = json[addressFieldName],
        location = json[locationFieldName],
        postalCode = json[postalCodeFieldName],
        numberOfRooms = json[numberOfRoomsFieldName] as int,
        price = json[purchasePriceFieldName],
        // livingArea = json[livingAreaFieldName],
        lotArea = json[lotAreaFieldName],
        fullDescription = json[fullDescriptionFieldName],
        url = json[urlFieldName],
        // to create a List<Media>, use Media.fromJson constructor from [Media]
        // for each element
        media = (json[mediaFieldName] as List)
            .map((media) => Media.fromJson(media))
            .toList();

  // override the toString() method to customize logging
  @override
  String toString() {
    return 'Listing, id: $id, address: $address, location: $location, postalCode: $postalCode, numberOfRooms: $numberOfRooms, '
        'price: $price, lotArea: $lotArea, url: $url, media: $media';
  }
}

/// The model of a Media.
/// Contains information about a Media.
class Media {
  final String id;
  final int category;
  final int contentType;
  final List<MediaItem> mediaItems;

  Media({
    required this.id,
    required this.category,
    required this.contentType,
    required this.mediaItems,
  });

  // Named constructor to create a [Media] from a JSON.
  Media.fromJson(Map<String, dynamic> json)
      : id = json[mediaIdFieldName],
        category = json[mediaCategoryFieldName],
        contentType = json[mediaContentTypeFieldName],
        mediaItems = (json[mediaItemsFieldName] as List)
            .map((mediaItem) => MediaItem.fromJson(mediaItem))
            .toList();

  @override
  String toString() {
    return 'Media, id: $id, category: $category, contentType: $contentType, mediaItems: $mediaItems';
  }
}


/// The model of a MediaItem.
/// Contains information about a MediaItem.
class MediaItem {
  final int category;
  final String url;
  final int height;
  final int width;

  MediaItem(
    this.category,
    this.url,
    this.height,
    this.width,
  );

  MediaItem.fromJson(Map<String, dynamic> json)
      : category = json[mediaItemCategoryFieldName],
        url = json[mediaItemUrlFieldName],
        height = json[mediaItemHeightFieldName],
        width = json[mediaItemWidthFieldName];

  @override
  String toString() {
    return 'MediaItem, category: $category, url: $url, height: $height, width: $width';
  }
}
