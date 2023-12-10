// import 'dart:js' show context;
// import 'package:Palestine/components/icon.dart';
// import 'package:Palestine/constants/app_colors.dart';
// import 'package:Palestine/extentions.dart';
// import 'package:Palestine/features/firestore_services.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:image_network/image_network.dart';

// FirestoreServices firestoreServices = FirestoreServices();

// class FavoritesProducts extends StatefulWidget {
//   const FavoritesProducts({Key? key}) : super(key: key);

//   @override
//   State<FavoritesProducts> createState() => _FavoritesProductsState();
// }

// class ProductModel {
//   String name;
//   double price;
//   bool isFavorite;

//   ProductModel({
//     required this.name,
//     required this.price,
//     this.isFavorite = false,
//   });
// }

// class _FavoritesProductsState extends State<FavoritesProducts> {
//   final CollectionReference productsCollection =
//       FirebaseFirestore.instance.collection('Favorites');

//   String search = "";

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Scaffold(
//         body: StreamBuilder<QuerySnapshot>(
//           stream:
//               FirebaseFirestore.instance.collection('Favorites').snapshots(),
//           builder: (context, snapshots) {
//             return (snapshots.connectionState == ConnectionState.waiting)
//                 ? const Center(child: CircularProgressIndicator())
//                 : GridView.builder(
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2, // عدد الأعمدة في الشبكة
//                       crossAxisSpacing: 8.0, // المسافة الأفقية بين العناصر
//                       mainAxisSpacing: 8.0, // المسافة العمودية بين العناصر
//                     ),
//                     itemCount: snapshots.data!.docs.length,
//                     itemBuilder: (context, i) {
//                       List products = snapshots.data!.docs;
//                       var data = snapshots.data!.docs[i].data()
//                           as Map<String, dynamic>;
//                       DocumentSnapshot document = products[i];
//                       late String docID = document.id;
//                       String url = data['Image'];
//                       return Container(
//                         color: Colors.white70,
//                         child: Column(
//                           children: [
//                             const Row(
//                               children: [
//                                MyIcon(),
//                               ],
//                             ),
//                             Expanded(
//                               child: SizedBox(
//                                 width: double.infinity,
//                                 child: fieldImage(url),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   fieldName(data),
//                                   fieldSize(data),
//                                   fieldPrice(data),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   );
//           },
//         ),
//       ),
//     );
//   }

//   ImageNetwork fieldImage(String url) {
//     return ImageNetwork(
//       image: url, // Required image url
//       width: 60,
//       height: 50,
//       fitAndroidIos: BoxFit.cover,
//     );
//   }

//   Text fieldName(Map<String, dynamic> data) {
//     return Text(
//       data['Name'],
//       style: const TextStyle(
//         color: Colors.black54,
//         fontSize: 16,
//         fontWeight: FontWeight.bold,
//       ),
//     );
//   }

//   Text fieldSize(Map<String, dynamic> data) {
//     return Text(
//       data['Size'],
//       style: const TextStyle(
//         color: Colors.black54,
//         fontSize: 15,
//         fontWeight: FontWeight.bold,
//       ),
//     );
//   }

//   Text fieldPrice(Map<String, dynamic> data) {
//     return Text(
//       ('\$ ' + data['Price']),
//       style: const TextStyle(
//         color: Colors.black54,
//         fontSize: 15,
//         fontWeight: FontWeight.bold,
//       ),
//     );
//   }
// }

// icon(
//   IconData icon, {
//   Color color = AppColors.iconColor,
//   double size = 20,
//   double padding = 10,
//   bool isOutLine = false,
//   required Function? onPressed,
//   bool isFavorite = false,
// }) {
//   Color iconColor = isFavorite ? Colors.red : color;

//   return Container(
//     height: 40,
//     width: 40,
//     padding: EdgeInsets.all(padding),
//     margin: EdgeInsets.all(padding),
//     decoration: BoxDecoration(
//       border: Border.all(
//         color: AppColors.iconColor,
//         style: isOutLine ? BorderStyle.solid : BorderStyle.none,
//       ),
//       borderRadius: const BorderRadius.all(Radius.circular(13)),
//       color: isOutLine
//           ? Colors.transparent
//           : Theme.of(context as BuildContext).colorScheme.background,
//       boxShadow: const <BoxShadow>[
//         BoxShadow(
//           color: Color(0xfff8f8f8),
//           blurRadius: 5,
//           spreadRadius: 10,
//           offset: Offset(5, 5),
//         ),
//       ],
//     ),
//     child: Icon(icon, color: iconColor, size: size),
//   ).ripple(() {
//     onPressed!();
//     updateFavoriteStatusInFirestore(!isFavorite);
//   }, borderRadius: const BorderRadius.all(Radius.circular(13)));
// }
