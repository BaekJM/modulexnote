import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class MyHomePage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore 데이터 불러오기'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('add').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          var documents = snapshot.data!.docs;

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              var document = documents[index];
              var title = document['title'];

              return ListTile(
                title: Text(title),
                onTap: () {
                  // 여기서 특정 도큐먼트의 title 필드 값을 이용하여 다른 화면으로 이동하거나 작업 수행 가능
                  // 예를 들어, Navigator.push()를 사용하여 새로운 화면으로 이동할 수 있습니다.
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => YourNextScreen(title)));
                },
              );
            },
          );
        },
      ),
    );
  }
}
