class NetworkConstants {
  static const BASE_IMAGE_URL = "https://www.themoviedb.org/t/p/w185/";
  static const LARGE_IMAGE_URL = "https://www.themoviedb.org/t/p/w780";
  static const BASE_URL = "https://api.themoviedb.org/3";
  static const API_KEY_PARAM = "?api_key=";
  static const API_KEY_VALUE = "100a07b42d270748700af2961af30218";
  static const ADULT_FALSE = "&adult=false";
  static const LANGUAGE_FR = "&language=fr-FR";
  static const REGION_FR = "&region=US";
  static const MOVIE_PATH = "/movie/";
  static const MOVIE_CREDITS_PATH = "/credits";
  static const ACTOR_PATH = "/person/";
  static const ACTOR_CREDITS_PATH = "/movie_credits";
  static const MOVIE_PREVIEW_PATH = "/discover/movie";
  static const TRENDS_PATH = "/trending/";
  static const TRENDS_MOVIE_WEEK_PATH = "/trending/movie/week";
  static const PREVIEW_GREATER = "&primary_release_date.gte";
  static const PREVIEW_LESS = "&primary_release_date.lte";
  static const PREVIEW_ACTION_QUERY = "&with_genres=28";
  static const PREVIEW_COMEDY_QUERY = "&with_genres=35";
  static const PREVIEW_EIGHTYS_QUERY = "&primary_release_date.gte=1980-01-01&primary_release_date.lte=1989-12-31";
  static const PREVIEW_NINETEENS_QUERY = "&primary_release_date.gte=1990-01-01&primary_release_date.lte=1999-12-31";
  static const AND_LOWEST_FIRST ="&sort_by=vote_average.asc";
  static const AND_AVERAGE_ONE ="&vote_average.gte=1";
  static const AND_VOTE_COUNT ="&vote_count.gte=25";
  static const AND_PAGE ="&page=";
  static const AND_MOVIE_ID ="&movie_id=";
}