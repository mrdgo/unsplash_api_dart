import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';
import 'package:unsplash_api_dart/models/light_photo.dart';
import 'package:unsplash_api_dart/models/light_search_photo_result.dart';
import 'package:unsplash_api_dart/models/photo.dart';
import 'package:unsplash_api_dart/models/search_photo_result.dart';

const String GET_PHOTO = 'https://api.unsplash.com/photos/';
const String SEARCH_PHOTO = 'https://api.unsplash.com/search/photos/';

class PhotoOrientation {
  static const String LANDSCAPE = 'landscape';
  static const String PORTRAIT = 'portrait';
  static const String SQUARISH = 'squarish';
}

Future<List<Photo>> getPhotos({@required String clientId}) async {
  final dio = new Dio();
  Response response = await dio.get('$GET_PHOTO?client_id=$clientId');

  if (response.statusCode == 200) {
    return Future.value(
      List.from(response.data).map((photo) => Photo.fromMap(photo)).toList(),
    );
  } else {
    throw Exception('Failed to load post');
  }
}

Future<List<LightPhoto>> getLightPhotos({@required String clientId, int perPage, int page}) async {
  final dio = new Dio();
  Response response = await dio.get(
    '$GET_PHOTO',
    queryParameters: {
      'cliend_id': clientId,
      'per_page': perPage ?? 20,
      'page': page ?? 1,
    },
  );

  if (response.statusCode == 200) {
    return Future.value(
      List.from(response.data)
          .map((photo) => LightPhoto.fromMap(photo))
          .toList(),
    );
  } else {
    throw Exception('Failed to load post');
  }
}

Future<Photo> getPhoto({@required String clientId, @required String id}) async {
  final dio = new Dio();
  Response response = await dio.get('$GET_PHOTO$id?client_id=$clientId');

  if (response.statusCode == 200) {
    return Future.value(Photo.fromMap(response.data));
  } else {
    throw Exception('Failed to load post');
  }
}

Future<SearchPhotoResult> searchResult({
  @required String clientId,
  @required String query,
  String orientation = PhotoOrientation.PORTRAIT,
  int page = 1,
  int perPage = 10,
}) async {
  String uri =
      '$SEARCH_PHOTO?client_id=$clientId&page=$page&per_page=$perPage&query=$query&orientation=$orientation';

  final dio = new Dio();
  Response response = await dio.get(uri);

  if (response.statusCode == 200) {
    return Future.value(SearchPhotoResult.fromMap(response.data));
  } else {
    throw Exception('Failed to load post');
  }
}

Future<LightSearchPhotoResult> lightSearchResult({
  @required String clientId,
  @required String query,
  String orientation = PhotoOrientation.PORTRAIT,
  int page = 1,
  int perPage = 10,
}) async {
  String uri =
      '$SEARCH_PHOTO?client_id=$clientId&page=$page&per_page=$perPage&query=$query&orientation=$orientation';

  final dio = new Dio();
  Response response = await dio.get(uri);

  if (response.statusCode == 200) {
    return Future.value(LightSearchPhotoResult.fromMap(response.data));
  } else {
    throw Exception('Failed to load post');
  }
}
