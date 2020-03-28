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
  Future<void> _fut;

  UnsplashProvider(this._data) {
    _photos = [];
    _currPage = 1;
    _fut = getLightPhotos(clientId: _data.accessKey).then(
      (photos) {
        _photos.addAll(photos);
      },
    );
  }

  Future<void> querySearch(String query) {
    if (this.query == query) return Future<void>(null);
    this.query = query;
    _photos = [];
    _currPage = 1;
    return lightSearchResult(
            clientId: _data.accessKey, query: query, page: _currPage++)
        .then(
      (result) {
        _searchResult = result;
      },
    );
  }

  LightPhoto getPhoto(int i) {
    List<LightPhoto> photos = _searchResult?.results ?? _photos;
    if (photos.length - i < 10) {
      _fut = _reload();
    }
    return photos[i];
  }

  Future<void> get state => _fut;

  Future<void> _reload() {
    if (query.isEmpty)
      return getLightPhotos(clientId: _data.accessKey, page: _currPage++).then(
        (photos) {
          _photos.addAll(photos);
        },
      );
    else if (_currPage < _searchResult.totalPages)
      return lightSearchResult(
              clientId: _data.accessKey, query: query, page: _currPage++)
          .then(
        (result) {
          _photos.addAll(result.results);
        },
      );
    return Future<void>(null);
  }
}
