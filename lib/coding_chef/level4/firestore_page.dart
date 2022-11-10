import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FireStorePage extends StatefulWidget {
  const FireStorePage({Key? key}) : super(key: key);

  @override
  State<FireStorePage> createState() => _FireStorePageState();
}

class _FireStorePageState extends State<FireStorePage> {
  CollectionReference product = FirebaseFirestore.instance.collection('items');

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  Future<void> _update(DocumentSnapshot documentSnapshot) async {
    nameController.text = documentSnapshot['name'];
    priceController.text = documentSnapshot['price'];

    await showModalBottomSheet(
      // 기본 높이 조절
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          child: Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(labelText: 'price'),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final String name = nameController.text;
                    final String price = priceController.text;
                    await product.doc(documentSnapshot.id).update({
                      'name': name,
                      'price': price,
                    });

                    nameController.text = '';
                    priceController.text = '';
                    Navigator.pop(context);
                  },
                  child: Text('Update'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _create() async {
    await showModalBottomSheet(
      // 기본 높이 조절
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          child: Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(labelText: 'price'),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final String name = nameController.text;
                    final String price = priceController.text;
                    await product.add({
                      'name': name,
                      'price': price,
                    });

                    nameController.text = '';
                    priceController.text = '';
                    Navigator.pop(context);
                  },
                  child: Text('Update'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _delete(String productId) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              children: <Widget>[
                Icon(Icons.notifications),
                Text("Confirm"),
              ],
            ),
            content: Text(
              "Do you really want to delete item?",
                textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    child: new Text("Yes"),
                    onPressed: () async {
                      Navigator.pop(context);
                      await product.doc(productId).delete();
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    child: new Text("No"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cloud Firestore'),
      ),
      body: StreamBuilder(
        stream: product.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                  return Card(
                    margin: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                    child: ListTile(
                      title: Text(documentSnapshot['name']),
                      subtitle: Text(documentSnapshot['price']),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                _update(documentSnapshot);
                              },
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                _delete(documentSnapshot.id);
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          _create();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
