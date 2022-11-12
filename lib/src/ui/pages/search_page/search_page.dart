import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:space_api_app/src/controllers/search_controller.dart';
import 'package:space_api_app/src/models/search_result.dart';
import 'package:space_api_app/src/ui/widgets/try_again_error_widget.dart';
import 'package:space_api_app/src/ui/widgets/loading_widget.dart';

import 'nasa_media_item_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    Key? key,
  }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends StateMVC<SearchPage> {
  late SearchController _con;
  String searchString = "";

  _SearchPageState() : super(SearchController()) {
    _con = controller as SearchController;
  }

  void updateSearchString(String? value) {
    if (value != null) {
      searchString = value;
    }
  }

  void onSearchSubmitted(String? value) {
    updateSearchString(value);
    _con.search(searchString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: false,
            snap: false,
            centerTitle: false,
            flexibleSpace: AppBar(
              title: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                ),
                child: Center(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search for something',
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                    onSubmitted: onSearchSubmitted,
                  ),
                ),
              ),
            ),
          ),
          getCurrentWidget(),
        ],
      ),
    );
  }

  Widget getCurrentWidget() {
    if (_con.loading) {
      return const SliverFillRemaining(
        child: Center(
          child: LoadingWidget(),
        ),
      );
    }
    if (_con.hasError) {
      return SliverFillRemaining(
        child: TryAgainErrorWidget(
          onTryAgainClicked: () {
            _con.search(searchString);
          },
        ),
      );
    }

    if (_con.searchResult == null) {
      return SliverFillRemaining(
        child: Container(),
      );
    }

    return _Body(nasaItems: _con.searchResult!.nasaMediaItems);
  }
}

class _Body extends StatelessWidget {
  final List<NasaMediaItem> nasaItems;

  const _Body({Key? key, required this.nasaItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (nasaItems.isEmpty) {
      return const SliverFillRemaining(
        child: Center(
          child: Text("No Results Found"),
        ),
      );
    }

    return getItemsListWidget();
  }

  Widget getItemsListWidget() {
    List<Widget> widgets = [];
    for (var element
        in nasaItems.where((element) => !element.isVideo()).toList()) {
      widgets.add(Container(
          margin: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: NasaMediaItemCard(item: element)));
    }

    return SliverList(
      delegate: SliverChildListDelegate(
        widgets,
      ),
    );
  }
}
