import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_movie/controller/search_provider.dart';

class Search extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return <Widget>[
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.close))
    ];
    throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back));
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return SearchWidget(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    SearchProvider searchProvider =
        Provider.of<SearchProvider>(context, listen: true);

    Future<void> queryChange() async {
      searchProvider.query = query;
      await searchProvider
          .loadSuggestion(); // await를 쓰지 않으면 새 리스트가 불러지기 전에 기존 리스트를 밑에 줄에서 불러옴
      searchProvider.suggestionList.addAll(searchProvider.loadedSuggestionList);
    }

    if (query.isEmpty) {
      List<String> temp = searchProvider.recentList.toList();
      searchProvider.suggestionList = temp.reversed.toList();
    } else {
      if (query != searchProvider.query) {
        queryChange();
      }
    }

    return ListView.builder(
        itemCount: searchProvider.suggestionList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(searchProvider.suggestionList[index]),
            leading: query.isEmpty
                ? const Icon(Icons.access_time)
                : const SizedBox(),
            onTap: () {
              searchProvider.selectResult =
                  searchProvider.suggestionList[index];
              query = searchProvider.suggestionList[index];
              searchProvider.recentList.add(searchProvider.selectResult);
              showResults(context);
            },
          );
        });
  }
}

class SearchWidget extends StatelessWidget {
  late String query;
  SearchWidget({required this.query, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SearchProvider searchProvider =
        Provider.of<SearchProvider>(context, listen: true);
    searchProvider.query = query;

    searchProvider.loadSearch();
    if (query != '') {
      searchProvider.recentList.add(query);
    }
    if (searchProvider.searchList != null) {
      return ListView.separated(
          itemCount: searchProvider.searchList!.length,
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (BuildContext context, int index) => const Divider(
                height: 2,
                thickness: 2,
                color: Colors.white70,
              ),
          itemBuilder: (BuildContext context, int idx) {
            return GestureDetector(
              onTap: () {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) =>
                //               DetailPage(movie: searchProvider.searchList![idx])));
              },
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Image.network(
                      searchProvider.searchList![idx].postUrl,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width * 0.28,
                    ),
                    Expanded(
                      // Expanded 위젯은 제일 바같쪽을 감싸야함
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          searchProvider.searchList![idx].title!,
                          style: const TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    } else {
      return const Center(
        child: Text(
          'Oops! There is no result!',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      );
    }
  }
}
