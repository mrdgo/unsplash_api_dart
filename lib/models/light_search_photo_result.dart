import 'package:unsplash_api_dart/models/light_photo.dart';

class LightSearchPhotoResult {
  int total;
  int totalPages;
  List<LightPhoto> results;

  LightSearchPhotoResult({
    this.total,
    this.totalPages,
    this.results,
  });

  factory LightSearchPhotoResult.fromMap(Map data) {
    if (data == null) {
      return LightSearchPhotoResult(results: [], total: 0, totalPages: 0);
    }

    return LightSearchPhotoResult(
      total: data['total'],
      totalPages: data['total_pages'],
      results: List.from(data['results'])
          .map((photo) => LightPhoto.fromMap(photo))
          .toList(),
    );
  }
}
