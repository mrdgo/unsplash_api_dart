import 'package:unsplash_api_dart/http.dart';
import 'package:unsplash_api_dart/models/light_photo.dart';
import 'package:unsplash_api_dart/models/light_search_photo_result.dart';
import 'package:unsplash_api_dart/unsplash_api_dart.dart';

/// Provide lazily loaded infinitely many photos
class UnsplashProvider {
  final Unsplash _data;
  List<LightPhoto> _photos;
  LightSearchPhotoResult _searchResult;
  String query = '';
  int _currPage;

  UnsplashProvider(this._data, {this.query}) {
    _photos = [];
    _currPage = 1;
    if (query.isEmpty)
      getLightPhotos(clientId: _data.accessKey).then(
        (photos) {
          _photos.addAll(photos);
        },
      );
    else
      querySearch(query);
  }

  void querySearch(String query) {
    if (this.query == query) return;
    this.query = query;
    _photos = [];
    _currPage = 1;
    lightSearchResult(clientId: _data.accessKey, query: query, page: _currPage)
        .then(
      (result) {
        _searchResult = result;
      },
    );
  }

  LightPhoto getPhoto(int i) {
    List<LightPhoto> photos = _searchResult?.results ?? _photos;
    if (photos.length - i < 10) {
      _reload();
    }
    return photos[i];
  }

  void _reload() {
    if (query.isEmpty) {
      getLightPhotos(clientId: _data.accessKey, page: _currPage++).then(
        (photos) {
          _photos.addAll(photos);
        },
      );
    } else {
      lightSearchResult(
              clientId: _data.accessKey, query: query, page: _currPage++)
          .then(
        (result) {
          _photos.addAll(result.results);
        },
      );
    }
  }
}
