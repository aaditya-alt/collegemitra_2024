import 'package:collegemitra/src/constants/colors.dart';
import 'package:collegemitra/src/features/authentication/models/user_model.dart';
import 'package:flutter/material.dart';

class ShowBranches extends StatefulWidget {
  final List<dynamic> userDetails;
  final List<BranchData> branchesToShow;
  final String counsellingName;
  final String collegeName;

  const ShowBranches({
    Key? key,
    required this.branchesToShow,
    required this.counsellingName,
    required this.userDetails,
    required this.collegeName,
  }) : super(key: key);

  @override
  _ShowBranchesState createState() => _ShowBranchesState();
}

class _ShowBranchesState extends State<ShowBranches> {
  List<bool> isExpanded = [];

  @override
  void initState() {
    super.initState();
    isExpanded = List.generate(widget.branchesToShow.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    List<String> userDetailsName = [
      "Counselling",
      "Domicile",
      "Category",
      "Sub Category",
      "JEE Mains Rank"
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 80.0,
            pinned: true,
            backgroundColor: tPrimaryColor,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.collegeName,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search Branches...",
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.filter_alt_rounded),
                      ),
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {},
                      ),
                      contentPadding: const EdgeInsets.all(12),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: tPrimaryColor.shade100,
              height: 55,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Container(
                        width: 120,
                        margin: const EdgeInsets.all(4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              userDetailsName[index],
                              style: const TextStyle(
                                color: Color.fromARGB(255, 117, 117, 117),
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              widget.userDetails[index],
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        "|\n|\n|",
                        style: TextStyle(color: tPrimaryColor),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) {
                var branches = widget.branchesToShow[i];

                return Column(
                  children: [
                    ListTile(
                      tileColor:
                          isExpanded[i] ? Colors.grey.shade200 : Colors.white,
                      title: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: const Center(
                              child: Text(
                                "🎓",
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  branches.branchName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "${branches.rounds.length} Rounds",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 40,
                            height: 40,
                            child: IconButton(
                              icon: Icon(
                                isExpanded[i]
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: tPrimaryColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  isExpanded[i] = !isExpanded[i];
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isExpanded[i])
                      Container(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: branches.rounds.length,
                          itemBuilder: (context, j) {
                            var round = branches.rounds[j];
                            return Container(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(8),
                              width: 200,
                              decoration: BoxDecoration(
                                  color: tPrimaryColor.shade100,
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(color: Colors.black)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Round ${j + 1}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Opening Rank: ${round.openingRank}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    "Closing Rank: ${round.closingRank}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    "Rank Difference: ${round.rankDifference}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                );
              },
              childCount: widget.branchesToShow.length,
            ),
          ),
        ],
      ),
    );
  }
}
