import 'package:tuncbooking/model/posting_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tuncbooking/view/screens/view_posting/view_posting_screen.dart';
import 'package:tuncbooking/view/widgets/posting_grid_tile_ui.dart';

class ExploreScreen extends StatefulWidget {
  static String routeName = "/explore";

  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  TextEditingController controllerSearch = TextEditingController();
  Stream stream = FirebaseFirestore.instance.collection('postings').snapshots();
  String searchType = "";

  bool isNameButtonSelected = false;
  bool isCityButtonSelected = false;
  bool isTypeButtonSelected = false;

  searchByField() {}

  pressSearchByButton(String searchTypeStr, bool isNameButtonSelectedB,
      bool isCityButtonSelectedB, bool isTypeButtonSelectedB) {
    searchType = searchTypeStr;
    isNameButtonSelected = isNameButtonSelectedB;
    isCityButtonSelected = isCityButtonSelectedB;
    isTypeButtonSelected = isTypeButtonSelectedB;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 15, 20, 0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            //searchBar
            Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 0),
              child: TextField(
                decoration: const InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                    contentPadding: EdgeInsets.all(5.0)),
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
                controller: controllerSearch,
                onEditingComplete: searchByField,
              ),
            ),

            //name - city - type - clear btn
            SizedBox(
              height: 48,
              width: MediaQuery.of(context).size.width / .5,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                children: [
                  MaterialButton(
                    onPressed: () {
                      pressSearchByButton("name", true, false, false);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color:
                        isNameButtonSelected ? Colors.pinkAccent : Colors.white,
                    child: const Text("Name"),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  MaterialButton(
                    onPressed: () {
                      pressSearchByButton("city", false, true, false);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color:
                        isNameButtonSelected ? Colors.pinkAccent : Colors.white,
                    child: const Text("City"),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  MaterialButton(
                    onPressed: () {
                      pressSearchByButton("type", false, false, true);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color:
                        isNameButtonSelected ? Colors.pinkAccent : Colors.white,
                    child: const Text("Type"),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  MaterialButton(
                    onPressed: () {
                      pressSearchByButton("", false, false, false);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color:
                        isNameButtonSelected ? Colors.pinkAccent : Colors.white,
                    child: const Text("Clear"),
                  ),
                ],
              ),
            ),

            //display listings
            StreamBuilder(
              stream: stream,
              builder: (context, dataSnapshots) {
                if (dataSnapshots.hasData) {
                  return GridView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: dataSnapshots.data.docs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 15,
                        childAspectRatio: 3 / 4,
                      ),
                      itemBuilder: (context, index) {
                        DocumentSnapshot snapshot =
                            dataSnapshots.data.docs[index];

                        PostingModel cPosting = PostingModel(id: snapshot.id);

                        cPosting.getPostingInfoFromSnapshot(snapshot);

                        return InkResponse(
                          onTap: () {
                            Get.to(ViewPostingScreen(
                              posting: cPosting,
                            ));
                          },
                          enableFeedback: true,
                          child: PostingGridTileUI(
                            posting: cPosting,
                          ),
                        );
                      });
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
