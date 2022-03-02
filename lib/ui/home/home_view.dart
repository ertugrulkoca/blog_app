import 'package:blog_app_assignment/ui/favorites/my_favorites_view.dart';
import 'package:flutter/material.dart';

import 'components/home_components.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(context, "Home", Icons.favorite, MyFavorites()),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 170,
              child: ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            "assets/background.png",
                            fit: BoxFit.fill,
                            height: 100,
                            width: 170,
                          ),
                          const SizedBox(height: 10),
                          const Text("Category Tag1")
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            blogText(),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: articleGridView(),
            ),
          ],
        ),
      ),
    );
  }

  Padding blogText() {
    return const Padding(
      padding: EdgeInsets.only(left: 10),
      child: Text(
        "Blog",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}
