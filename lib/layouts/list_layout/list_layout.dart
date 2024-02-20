import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:monster_library/API/monsters/getSpecificMonster.dart';
import 'package:monster_library/layouts/list_layout/list_logic.dart';
import 'package:monster_library/models/Monster.dart';
import 'package:monster_library/styles/input_decoration/textformfields.dart';

import '../../models/MonsterIndex.dart';

class ListLayout extends StatefulWidget {
  const ListLayout({super.key});

  @override
  State<ListLayout> createState() => _ListLayoutState();
}

class _ListLayoutState extends State<ListLayout> {
  late TextEditingController _searchTC;
  late Future<void> getPageData;
  late List<MonsterIndex> dataList;
  List<MonsterIndex> searchedDataList = [];

  @override
  void initState() {
    super.initState();
    _searchTC = TextEditingController()..addListener(filterDataList);
    loadingMonster = false;
    getPageData = pageInit();
  }

  Future<void> pageInit() async {
    dataList = await getMonsterListFuture();
    filterDataList();
  }

  void filterDataList() {
    searchedDataList = [];

    //If the search text is empty, return the whole list
    if (_searchTC.text.isEmpty) {
      searchedDataList = List.from(dataList);
      setState((){});
      return;
    }

    //If the search text has input, begin filtering
    for (MonsterIndex i in dataList) {
      if (i.name.toLowerCase().contains(_searchTC.text.toLowerCase()) || i.index.toLowerCase().contains(_searchTC.text.toLowerCase())) {
        searchedDataList.add(i);
      }
    }
    setState((){});
  }

  @override
  void dispose() {
    _searchTC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * 0.8,
      decoration: BoxDecoration(
        //border: Border.all(color: Colors.white)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Search for a Monster', style: Theme.of(context).textTheme.headlineMedium),
          TextFormField(
            decoration: listSearchDecoration(context),
            controller: _searchTC,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Expanded(
            child: FutureBuilder(
              future: getPageData,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                    itemCount: searchedDataList.length,
                    itemBuilder: (BuildContext context, int index) {
                      //If not the first index, and the first letter of this monster matches the first letter of the previous
                      if (index != 0 && searchedDataList[index].name.characters.first == searchedDataList[index - 1].name.characters.first) {
                        return Material(
                          child: InkWell(
                            onTap: () {
                              if (loadingMonster) return;
                              goToMonster(context, searchedDataList[index]);
                            },
                            child: Ink(
                              padding: EdgeInsets.all(MediaQuery.sizeOf(context).shortestSide * 0.0125),
                              decoration: BoxDecoration(
                                border: Border(
                                  left: BorderSide(color: Colors.white),
                                  bottom: BorderSide(color: Colors.white),
                                  right: BorderSide(color: Colors.white),
                                )
                              ),
                              child: Text(searchedDataList[index].name, style: Theme.of(context).textTheme.bodyLarge),
                            ),
                          ),
                        );
                      }

                      //Otherwise, return a column with the alphabetical letter clearly shown
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.amber)
                              )
                            ),
                            width: double.infinity,
                            padding: EdgeInsets.all(MediaQuery.sizeOf(context).shortestSide * 0.0125),
                            child: Text(searchedDataList[index].name.characters.first.toUpperCase(), style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.amber)),
                          ),
                          Material(
                            child: InkWell(
                              onTap: () {
                                if (loadingMonster) return;
                                goToMonster(context, searchedDataList[index]);
                              },
                              child: Ink(
                                padding: EdgeInsets.all(MediaQuery.sizeOf(context).shortestSide * 0.0125),
                                decoration: BoxDecoration(
                                  border: Border(
                                    left: BorderSide(color: Colors.white),
                                    bottom: BorderSide(color: Colors.white),
                                    right: BorderSide(color: Colors.white),
                                  )
                                ),
                                width: double.infinity,
                                child: Text(searchedDataList[index].name, style: Theme.of(context).textTheme.bodyLarge),
                              ),
                            ),
                          ),
                        ]
                      );
                    },
                  );
                }
                else if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: LoadingIndicator(
                        indicatorType: Indicator.ballClipRotateMultiple,
                        colors: const [Colors.amber],
                        strokeWidth: 2,
                    )
                  );
                }
                else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.error,
                          color: Colors.grey,
                          size: MediaQuery.sizeOf(context).shortestSide * 0.1,
                        ),
                        Text('An error occurred.', style: Theme.of(context).textTheme.bodyMedium),
                        TextButton(
                          onPressed: () {
                            getPageData = pageInit();
                          },
                          child: Text('Try again', style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.amber)),
                        )
                      ],
                    )
                  );
                }
              }
            )
          )
        ]
      )
    );
  }
}
