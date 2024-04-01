import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_provider/main_screens/home_page.dart';
import 'package:firebase_provider/product_item.dart';
import 'package:flutter/material.dart';
class FruitsScreen extends StatefulWidget {
  const FruitsScreen({super.key});

  @override
  State<FruitsScreen> createState() => _FruitsScreenState();
}

class _FruitsScreenState extends State<FruitsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        leading: IconButton(onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const HomePage()));
        }, icon: const Icon(Icons.arrow_back)),
      ),
      body: Container(
        color: Colors.grey.shade200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Fruits',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w900),
              ),
              const Text(
                'Fresh and fast delivery',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('products').where('category', isEqualTo: 'fruits')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    return GridView(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                         maxCrossAxisExtent: 190,
                        mainAxisExtent: 130,
                        mainAxisSpacing: 5,
                        crossAxisSpacing:5,
                      ),
                      children: (snapshot.data != null)
                          ? snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data() as Map<String, dynamic>;
                              return ProductItem(productData: data);
                            }).toList()
                          : [],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
