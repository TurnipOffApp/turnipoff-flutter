
class TrendsData {
  int? page;
  List<Results>? results;
  int? totalPages;
  int? totalResults;

  TrendsData({this.page, this.results, this.totalPages, this.totalResults});

  TrendsData.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = totalPages;
    data['total_results'] = totalResults;
    return data;
  }
}

class Results {
  String? originalTitle;
  String? posterPath;
  bool? video;
  double? voteAverage;
  String? overview;
  String? releaseDate;
  int? id;
  bool? adult;
  String? backdropPath;
  int? voteCount;
  List<int>? genreIds;
  String? title;
  String? originalLanguage;
  double? popularity;
  String? mediaType;

  Results(
      {this.originalTitle,
        this.posterPath,
        this.video,
        this.voteAverage,
        this.overview,
        this.releaseDate,
        this.id,
        this.adult,
        this.backdropPath,
        this.voteCount,
        this.genreIds,
        this.title,
        this.originalLanguage,
        this.popularity,
        this.mediaType});

  Results.fromJson(Map<String, dynamic> json) {
    originalTitle = json['original_title'];
    posterPath = json['poster_path'];
    video = json['video'];
    voteAverage = json['vote_average'];
    overview = json['overview'];
    releaseDate = json['release_date'];
    id = json['id'];
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    voteCount = json['vote_count'];
    genreIds = json['genre_ids'].cast<int>();
    title = json['title'];
    originalLanguage = json['original_language'];
    popularity = json['popularity'];
    mediaType = json['media_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['original_title'] = originalTitle;
    data['poster_path'] = posterPath;
    data['video'] = video;
    data['vote_average'] = voteAverage;
    data['overview'] = overview;
    data['release_date'] = releaseDate;
    data['id'] = id;
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['vote_count'] = voteCount;
    data['genre_ids'] = genreIds;
    data['title'] = title;
    data['original_language'] = originalLanguage;
    data['popularity'] = popularity;
    data['media_type'] = mediaType;
    return data;
  }
}