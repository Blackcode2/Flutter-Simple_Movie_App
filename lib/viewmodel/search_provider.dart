import 'package:flutter/material.dart';
import 'package:simple_movie/model/movie.dart';
import '../repository/search_repository.dart';

class SearchProvider extends ChangeNotifier {
  final SearchRepository _searchRepository = SearchRepository();

  String _query = '';
  String get query => _query;
  set query(String query) => _query = query;

  // list for the results of search
  List<Movie>? _searchList = [];
  List<Movie>? get searchList => _searchList;

  // a temporary list for post processing after geting results of search.
  // it gets sting values which are translformed from list for `Movie` class instace
  List<String> _loadedSuggestionList = [];
  List<String> get loadedSuggestionList => _loadedSuggestionList;

  // the final list that contains finally processed stirng values for suggestion.
  List<String> _suggestionList = [];
  List<String> get suggestionList => _suggestionList;
  set suggestionList(List<String> suggestionList) =>
      _suggestionList = suggestionList;

  // a set collection that contains rescently searched query strings.
  final Set<String> _recentList = {};
  Set<String> get recentList => _recentList;

  loadSearch() async {
    List<Movie>? listSearchResult = await _searchRepository.loadSearch(query);
    _searchList = listSearchResult;
    notifyListeners();
  }

  loadSuggestion() async {
    suggestionList.clear();

    List<Movie>? listSuggestionResult =
        await _searchRepository.loadSearch(query);
    if (listSuggestionResult != null) {
      _loadedSuggestionList =
          listSuggestionResult.map((e) => e.title as String).toList();
    } else {
      _loadedSuggestionList.add('No Result!');
    }
    notifyListeners();
  }
}
