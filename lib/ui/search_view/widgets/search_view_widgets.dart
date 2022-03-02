import 'package:flutter/material.dart';

Padding searchBar() {
  return Padding(
    padding: const EdgeInsets.only(right: 30),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Pengguna, topik, tema",
            hintStyle: TextStyle(color: Colors.grey.shade700),
          ),
        ),
      ),
    ),
  );
}

Padding profileContainer(String name, bio, imgUrl) {
  return Padding(
    padding: const EdgeInsets.only(right: 30),
    child: Container(
      width: 150,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 20,
              offset: const Offset(3, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(20),
          image: const DecorationImage(
              image: AssetImage("assets/background.png"), fit: BoxFit.cover)),
      child: profileContainerInfo(name, bio, imgUrl),
    ),
  );
}

Stack profileContainerInfo(String name, bio, imgUrl) {
  return Stack(
    alignment: Alignment.topCenter,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                profileCardUserName(name),
                sizedBox(5),
                profileCardUserInfo(bio),
                sizedBox(5),
                followButton(),
                sizedBox(15),
              ],
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: circleNetWorkAvatar(imgUrl),
      ),
    ],
  );
}

Text profileCardUserName(String name) {
  return Text(
    name,
    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
  );
}

Flexible profileCardUserInfo(String bio) {
  return Flexible(
    child: Text(bio,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 11, color: Colors.grey),
        textAlign: TextAlign.center),
  );
}

GestureDetector followButton() {
  return GestureDetector(
    onTap: () {},
    child: Container(
      decoration: BoxDecoration(
        color: Colors.purple.shade900,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        child: Text(
          "Follow",
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
      ),
    ),
  );
}

SizedBox sizedBox(double height) {
  return SizedBox(
    height: height,
  );
}

Padding questionContainer(
    String name, int date, String title, String body, String imgUrl) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            circleNetWorkAvatar(imgUrl),
            userInfo(name, date),
            const Expanded(
              child: SizedBox(),
            ),
            iconBookmark(),
          ],
        ),
        question(title, body),
      ],
    ),
  );
}

SizedBox circleNetWorkAvatar(String imgUrl) {
  return SizedBox(
    height: 65,
    child: CircleAvatar(
      radius: 50,
      backgroundImage: NetworkImage(imgUrl),
    ),
  );
}

Padding userInfo(String name, int date) {
  return Padding(
    padding: const EdgeInsets.only(left: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        Text(
          "$date",
          style: const TextStyle(color: Colors.grey, fontSize: 16),
        ),
      ],
    ),
  );
}

Icon iconBookmark() {
  return const Icon(
    Icons.bookmark_border,
    color: Colors.black,
    size: 20,
  );
}

Padding question(String title, body) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Column(
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 18, height: 1.5, fontWeight: FontWeight.bold),
        ),
        sizedBox(10),
        Text(
          body,
          style: const TextStyle(fontSize: 16, height: 1.5),
        ),
      ],
    ),
  );
}
