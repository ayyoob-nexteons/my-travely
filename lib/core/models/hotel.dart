class Hotel {
  final String propertyCode;
  final String propertyName;
  final String propertyImage;
  final String propertyType;
  final int propertyStar;
  final String city;
  final String state;
  final String country;
  final String street;
  final String zipcode;
  final double latitude;
  final double longitude;
  final String propertyUrl;
  final double markedPriceAmount;
  final String markedPriceDisplay;
  final String markedPriceCurrency;
  final double staticPriceAmount;
  final String staticPriceDisplay;
  final String staticPriceCurrency;
  final double? overallRating;
  final int? totalUserRating;
  final int? withoutDecimal;
  final bool reviewPresent;
  final String? roomName;
  final int? numberOfAdults;
  final double? propertyMaxPriceAmount;
  final double? propertyMinPriceAmount;
  final List<String> amenities;
  final bool petsAllowed;
  final bool coupleFriendly;
  final bool suitableForChildren;
  final bool bachularsAllowed;
  final bool freeWifi;
  final bool freeCancellation;
  final bool payAtHotel;
  final bool payNow;
  final String? cancelPolicy;
  final String? refundPolicy;
  final String? childPolicy;
  final String? damagePolicy;
  final String? propertyRestriction;

  Hotel({
    required this.propertyCode,
    required this.propertyName,
    required this.propertyImage,
    required this.propertyType,
    required this.propertyStar,
    required this.city,
    required this.state,
    required this.country,
    required this.street,
    required this.zipcode,
    required this.latitude,
    required this.longitude,
    required this.propertyUrl,
    required this.markedPriceAmount,
    required this.markedPriceDisplay,
    required this.markedPriceCurrency,
    required this.staticPriceAmount,
    required this.staticPriceDisplay,
    required this.staticPriceCurrency,
    this.overallRating,
    this.totalUserRating,
    this.withoutDecimal,
    this.reviewPresent = false,
    this.roomName,
    this.numberOfAdults,
    this.propertyMaxPriceAmount,
    this.propertyMinPriceAmount,
    this.amenities = const [],
    this.petsAllowed = false,
    this.coupleFriendly = false,
    this.suitableForChildren = false,
    this.bachularsAllowed = false,
    this.freeWifi = false,
    this.freeCancellation = false,
    this.payAtHotel = false,
    this.payNow = false,
    this.cancelPolicy,
    this.refundPolicy,
    this.childPolicy,
    this.damagePolicy,
    this.propertyRestriction,
  });

  factory Hotel.fromPopularStayJson(Map<String, dynamic> json) {
    final address = json['propertyAddress'] as Map<String, dynamic>;
    final markedPrice = json['markedPrice'] as Map<String, dynamic>;
    final staticPrice = json['staticPrice'] as Map<String, dynamic>;
    final googleReview = json['googleReview'] as Map<String, dynamic>;
    final policies = json['propertyPoliciesAndAmmenities']?['data'] as Map<String, dynamic>?;

    return Hotel(
      propertyCode: json['propertyCode'] ?? '',
      propertyName: json['propertyName'] ?? '',
      propertyImage: json['propertyImage'] ?? '',
      propertyType: json['propertyType'] ?? '',
      propertyStar: json['propertyStar'] ?? 0,
      city: address['city'] ?? '',
      state: address['state'] ?? '',
      country: address['country'] ?? '',
      street: address['street'] ?? '',
      zipcode: address['zipcode'] ?? '',
      latitude: (address['latitude'] ?? 0.0).toDouble(),
      longitude: (address['longitude'] ?? 0.0).toDouble(),
      propertyUrl: json['propertyUrl'] ?? '',
      markedPriceAmount: (markedPrice['amount'] ?? 0.0).toDouble(),
      markedPriceDisplay: markedPrice['displayAmount'] ?? '',
      markedPriceCurrency: markedPrice['currencySymbol'] ?? '',
      staticPriceAmount: (staticPrice['amount'] ?? 0.0).toDouble(),
      staticPriceDisplay: staticPrice['displayAmount'] ?? '',
      staticPriceCurrency: staticPrice['currencySymbol'] ?? '',
      overallRating: googleReview['data']?['overallRating']?.toDouble(),
      totalUserRating: googleReview['data']?['totalUserRating'],
      withoutDecimal: googleReview['data']?['withoutDecimal'],
      reviewPresent: googleReview['reviewPresent'] ?? false,
      petsAllowed: policies?['petsAllowed'] ?? false,
      coupleFriendly: policies?['coupleFriendly'] ?? false,
      suitableForChildren: policies?['suitableForChildren'] ?? false,
      bachularsAllowed: policies?['bachularsAllowed'] ?? false,
      freeWifi: policies?['freeWifi'] ?? false,
      freeCancellation: policies?['freeCancellation'] ?? false,
      payAtHotel: policies?['payAtHotel'] ?? false,
      payNow: policies?['payNow'] ?? false,
      cancelPolicy: policies?['cancelPolicy'],
      refundPolicy: policies?['refundPolicy'],
      childPolicy: policies?['childPolicy'],
      damagePolicy: policies?['damagePolicy'],
      propertyRestriction: policies?['propertyRestriction'],
    );
  }

  factory Hotel.fromSearchResultJson(Map<String, dynamic> json) {
    final address = json['propertyAddress'] as Map<String, dynamic>;
    final markedPrice = json['markedPrice'] as Map<String, dynamic>;
    final propertyMaxPrice = json['propertyMaxPrice'] as Map<String, dynamic>;
    final propertyMinPrice = json['propertyMinPrice'] as Map<String, dynamic>;
    final googleReview = json['googleReview'] as Map<String, dynamic>;
    final policies = json['propertyPoliciesAndAmmenities']?['data'] as Map<String, dynamic>?;

    return Hotel(
      propertyCode: json['propertyCode'] ?? '',
      propertyName: json['propertyName'] ?? '',
      propertyImage: json['propertyImage']?['fullUrl'] ?? '',
      propertyType: json['propertytype'] ?? '',
      propertyStar: json['propertyStar'] ?? 0,
      city: address['city'] ?? '',
      state: address['state'] ?? '',
      country: address['country'] ?? '',
      street: address['street'] ?? '',
      zipcode: address['zipcode'] ?? '',
      latitude: (address['latitude'] ?? 0.0).toDouble(),
      longitude: (address['longitude'] ?? 0.0).toDouble(),
      propertyUrl: json['propertyUrl'] ?? '',
      markedPriceAmount: (markedPrice['amount'] ?? 0.0).toDouble(),
      markedPriceDisplay: markedPrice['displayAmount'] ?? '',
      markedPriceCurrency: markedPrice['currencySymbol'] ?? '',
      staticPriceAmount: (propertyMinPrice['amount'] ?? 0.0).toDouble(),
      staticPriceDisplay: propertyMinPrice['displayAmount'] ?? '',
      staticPriceCurrency: propertyMinPrice['currencySymbol'] ?? '',
      overallRating: googleReview['data']?['overallRating']?.toDouble(),
      totalUserRating: googleReview['data']?['totalUserRating'],
      withoutDecimal: googleReview['data']?['withoutDecimal'],
      reviewPresent: googleReview['reviewPresent'] ?? false,
      roomName: json['roomName'],
      numberOfAdults: json['numberOfAdults'],
      propertyMaxPriceAmount: (propertyMaxPrice['amount'] ?? 0.0).toDouble(),
      propertyMinPriceAmount: (propertyMinPrice['amount'] ?? 0.0).toDouble(),
      petsAllowed: policies?['petsAllowed'] ?? false,
      coupleFriendly: policies?['coupleFriendly'] ?? false,
      suitableForChildren: policies?['suitableForChildren'] ?? false,
      bachularsAllowed: policies?['bachularsAllowed'] ?? false,
      freeWifi: policies?['freeWifi'] ?? false,
      freeCancellation: policies?['freeCancellation'] ?? false,
      payAtHotel: policies?['payAtHotel'] ?? false,
      payNow: policies?['payNow'] ?? false,
      cancelPolicy: policies?['cancelPolicy'],
      refundPolicy: policies?['refundPolicy'],
      childPolicy: policies?['childPolicy'],
      damagePolicy: policies?['damagePolicy'],
      propertyRestriction: policies?['propertyRestriction'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'propertyCode': propertyCode,
      'propertyName': propertyName,
      'propertyImage': propertyImage,
      'propertyType': propertyType,
      'propertyStar': propertyStar,
      'city': city,
      'state': state,
      'country': country,
      'street': street,
      'zipcode': zipcode,
      'latitude': latitude,
      'longitude': longitude,
      'propertyUrl': propertyUrl,
      'markedPriceAmount': markedPriceAmount,
      'markedPriceDisplay': markedPriceDisplay,
      'markedPriceCurrency': markedPriceCurrency,
      'staticPriceAmount': staticPriceAmount,
      'staticPriceDisplay': staticPriceDisplay,
      'staticPriceCurrency': staticPriceCurrency,
      'overallRating': overallRating,
      'totalUserRating': totalUserRating,
      'withoutDecimal': withoutDecimal,
      'reviewPresent': reviewPresent,
      'roomName': roomName,
      'numberOfAdults': numberOfAdults,
      'propertyMaxPriceAmount': propertyMaxPriceAmount,
      'propertyMinPriceAmount': propertyMinPriceAmount,
      'amenities': amenities,
      'petsAllowed': petsAllowed,
      'coupleFriendly': coupleFriendly,
      'suitableForChildren': suitableForChildren,
      'bachularsAllowed': bachularsAllowed,
      'freeWifi': freeWifi,
      'freeCancellation': freeCancellation,
      'payAtHotel': payAtHotel,
      'payNow': payNow,
      'cancelPolicy': cancelPolicy,
      'refundPolicy': refundPolicy,
      'childPolicy': childPolicy,
      'damagePolicy': damagePolicy,
      'propertyRestriction': propertyRestriction,
    };
  }
}

class HotelSearchResponse {
  final List<Hotel> hotels;
  final int totalCount;
  final int currentPage;
  final int totalPages;
  final bool hasNextPage;
  final bool hasPreviousPage;

  HotelSearchResponse({
    required this.hotels,
    required this.totalCount,
    required this.currentPage,
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });

  factory HotelSearchResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    final hotels = (data['arrayOfHotelList'] as List<dynamic>?)
        ?.map((hotel) => Hotel.fromSearchResultJson(hotel))
        .toList() ?? [];
    
    return HotelSearchResponse(
      hotels: hotels,
      totalCount: hotels.length,
      currentPage: 1,
      totalPages: 1,
      hasNextPage: false,
      hasPreviousPage: false,
    );
  }
}

class HotelSearchRequest {
  final String checkIn;
  final String checkOut;
  final int rooms;
  final int adults;
  final int children;
  final String searchType;
  final List<String> searchQuery;
  final List<String> accommodation;
  final List<String> arrayOfExcludedSearchType;
  final String highPrice;
  final String lowPrice;
  final int limit;
  final List<String> preloaderList;
  final String currency;
  final int rid;

  HotelSearchRequest({
    required this.checkIn,
    required this.checkOut,
    required this.rooms,
    required this.adults,
    required this.children,
    required this.searchType,
    required this.searchQuery,
    this.accommodation = const ['all', 'hotel'],
    this.arrayOfExcludedSearchType = const ['street'],
    this.highPrice = '3000000',
    this.lowPrice = '0',
    this.limit = 10,
    this.preloaderList = const [],
    this.currency = 'INR',
    this.rid = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'action': 'getSearchResultListOfHotels',
      'getSearchResultListOfHotels': {
        'searchCriteria': {
          'checkIn': checkIn,
          'checkOut': checkOut,
          'rooms': rooms,
          'adults': adults,
          'children': children,
          'searchType': searchType,
          'searchQuery': searchQuery,
          'accommodation': accommodation,
          'arrayOfExcludedSearchType': arrayOfExcludedSearchType,
          'highPrice': highPrice,
          'lowPrice': lowPrice,
          'limit': limit,
          'preloaderList': preloaderList,
          'currency': currency,
          'rid': rid,
        }
      }
    };
  }
}

class PopularStayRequest {
  final int limit;
  final String entityType;
  final String searchType;
  final String country;
  final String state;
  final String city;
  final String currency;

  PopularStayRequest({
    this.limit = 10,
    this.entityType = 'Any',
    this.searchType = 'byCity',
    this.country = 'India',
    this.state = 'Jharkhand',
    this.city = 'Jamshedpur',
    this.currency = 'INR',
  });

  Map<String, dynamic> toJson() {
    return {
      'action': 'popularStay',
      'popularStay': {
        'limit': limit,
        'entityType': entityType,
        'filter': {
          'searchType': searchType,
          'searchTypeInfo': {
            'country': country,
            'state': state,
            'city': city,
          }
        },
        'currency': currency,
      }
    };
  }
}
