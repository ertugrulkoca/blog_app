import 'package:flutter/material.dart';
import '../components/ui_components.dart';
import 'components/home_components.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(context, "Home"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            categoriListView(),
            blogText(),
            SizedBox(
              height: size.height,
              width: double.infinity,
              child: articleGridView(context),
            ),
          ],
        ),
      ),
      bottomNavigationBar: buttomBar(context, 1),
    );
  }
}
