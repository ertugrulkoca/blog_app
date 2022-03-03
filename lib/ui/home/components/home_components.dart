import 'package:flutter/material.dart';

Padding articleGridView() {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 10,
        childAspectRatio: (7 / 10),
      ),
      itemCount: 8,
      itemBuilder: (context, index) {
        return articleContainer(index);
      },
    ),
  );
}

Container articleContainer(int index) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
            image: AssetImage("assets/background.png"), fit: BoxFit.cover)),
    child: Stack(
      children: [articleName(index), favoriteIcon()],
    ),
  );
}

Align favoriteIcon() {
  return const Align(
    alignment: Alignment.topRight,
    child: Padding(
      padding: EdgeInsets.only(top: 5, right: 10),
      child: Icon(Icons.favorite),
    ),
  );
}

Align articleName(int index) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      width: double.infinity,
      height: 50,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            "Article $index",
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    ),
  );
}
