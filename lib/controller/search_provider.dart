import 'package:flutter/material.dart';
import 'package:simple_movie/model/search.dart';
import '../repository/search_repository.dart';

class SearchProvider extends ChangeNotifier {
  final SearchRepository _searchRepository = SearchRepository();
  List<Search>? _searchList = [];
  List<Search>? get searchList => _searchList;

  List<String> _loadedSuggestionList = [];
  List<String> get loadedSuggestionList => _loadedSuggestionList;

  String _query = '';
  String get query => _query;
  set query(String query) => _query = query;

  // final List<String> _listExample = [];
  // List<String> get listExample => _listExample;

  final Set<String> _recentList = {};
  Set<String> get recentList => _recentList;

  List<String> _suggestionList = [];
  List<String> get suggestionList => _suggestionList;
  set suggestionList(List<String> suggestionList) =>
      _suggestionList = suggestionList;

  String _selectResult = '';
  String get selectResult => _selectResult;
  set selectResult(String selectResult) => _selectResult = selectResult;

  loadSearch() async {
    List<Search>? listSearchResult =
        await _searchRepository.loadSearch(query); //예외처리등 후처리를 위해 다른 변수에 담는다.
    //_movies = await _movieRepository.loadMovies(); 예외처리 안할 땐 이렇게해도 됨.
    _searchList = listSearchResult;
    notifyListeners();
  }

  loadSuggestion() async {
    suggestionList.clear();

    List<Search>? listSuggestionResult =
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
