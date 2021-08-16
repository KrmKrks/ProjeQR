// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:convex_bottom_bar/convex_bottom_bar.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:projeqr/pages/urun_details.dart';
// import 'package:projeqr/pages/urun_listeleme.dart';
// import 'package:projeqr/provider/theme_provider.dart';
// import 'package:projeqr/shared/theme_decoration.dart';
// import 'package:projeqr/widget/build_textformfield_widget.dart';
// import 'package:provider/provider.dart';

// import 'malzeme_ekleme.dart';
// import 'mdv_takip_page.dart';
// import 'qrtarama.dart';

// class Categories extends StatefulWidget {
//   String categoriesGet;
//   Categories({Key? key, required this.categoriesGet}) : super(key: key);

//   @override
//   _CategoriesState createState() => _CategoriesState();
// }

// CollectionReference ref = FirebaseFirestore.instance.collection('products');
// final FirebaseAuth _auth = FirebaseAuth.instance;

// TextEditingController mobilyaTuruController = TextEditingController();
// TextEditingController adetController = TextEditingController();
// TextEditingController notController = TextEditingController();
// TextEditingController mudurlukController = TextEditingController();

// class _CategoriesState extends State<Categories> {
//   @override
//   void initState() {
//     getUserRole();
//     super.initState();
//   }

//   String userRole = '';

//   getUserRole() async {
//     await FirebaseFirestore.instance
//         .collection('Users')
//         .doc(_auth.currentUser!.uid)
//         .get()
//         .then((value) {
//       setState(() {
//         userRole = value.data()!['Role'].toString();
//       });
//     });
//   }

//   int pageIndex = 1;
//   List<Widget> pageList = <Widget>[
//     MalzemeEkleme(),
//     UrunListeleme(),
//     ScanQR(),
//     MdvTakip(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         padding: EdgeInsets.symmetric(
//           vertical: MediaQuery.of(context).devicePixelRatio / 0.1,
//           horizontal: MediaQuery.of(context).devicePixelRatio / 0.18,
//         ),
//         decoration: themeDecoration(context, BorderRadius.circular(0)),
//         child: SafeArea(
//           child: StreamBuilder(
//             stream: ref
//                 .where('Kategori', isEqualTo: widget.categoriesGet)
//                 .orderBy('CreatedAt', descending: true)
//                 .snapshots(),
//             builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return CircularProgressIndicator();
//               }
//               if (snapshot.hasData) {
//                 if (userRole == 'Admin') {
//                   return ListView.builder(
//                     itemCount: snapshot.data!.docs.length,
//                     itemBuilder: (context, index) {
//                       var docRef = snapshot.data!.docs[index];
//                       return Card(
//                         color: Theme.of(context).cardColor,
//                         shadowColor: Theme.of(context).shadowColor,
//                         child: ListTile(
//                           leading: Icon(
//                             Icons.account_circle_rounded,
//                             color: Theme.of(context).iconTheme.color,
//                           ),
//                           title: Text(
//                             "Mobilya Türü:" " \t${docRef['Mobilya Türü']} ",
//                             style: Theme.of(context).textTheme.headline1,
//                           ),
//                           subtitle: Column(
//                             children: <Widget>[
//                               Text(
//                                 docRef['Adet'] as String,
//                                 style: Theme.of(context).textTheme.headline2,
//                               ),
//                               Text(
//                                 docRef['Müdürlük'] as String,
//                                 style: Theme.of(context).textTheme.headline2,
//                               ),
//                               Text(
//                                 docRef['Not'] as String,
//                                 style: Theme.of(context).textTheme.headline2,
//                               ),
//                             ],
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                           ),
//                           trailing: IconButton(
//                             icon: Icon(Icons.edit),
//                             color: Theme.of(context).iconTheme.color,
//                             onPressed: () {
//                               mobilyaTuruController.text =
//                                   docRef['Mobilya Türü'] as String;
//                               adetController.text = docRef['Adet'] as String;
//                               mudurlukController.text =
//                                   docRef['Müdürlük'] as String;
//                               notController.text = docRef['Not'] as String;

//                               showDialog(
//                                   context: context,
//                                   builder: (context) => Dialog(
//                                         shape: RoundedRectangleBorder(
//                                             borderRadius: BorderRadius.all(
//                                                 Radius.circular(20.0))),
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                             gradient: LinearGradient(
//                                                 begin: Alignment.topCenter,
//                                                 end: Alignment.bottomCenter,
//                                                 colors:
//                                                     Provider.of<ThemeProvider>(
//                                                                 context)
//                                                             .isDarkMode
//                                                         ? gradientDarkMode
//                                                         : gradientLightMode),
//                                             borderRadius:
//                                                 BorderRadius.circular(20),
//                                           ),
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: ListView(
//                                               shrinkWrap: true,
//                                               children: <Widget>[
//                                                 buildTextFormField(
//                                                     mobilyaTuruController,
//                                                     "Mobilya Türü",
//                                                     context) as Widget,
//                                                 SizedBox(
//                                                   height: 20,
//                                                 ),
//                                                 buildTextFormField(
//                                                     adetController,
//                                                     "Adet Giriniz",
//                                                     context) as Widget,
//                                                 SizedBox(
//                                                   height: 20,
//                                                 ),
//                                                 buildTextFormField(
//                                                     mudurlukController,
//                                                     "Gelen veya Giden Müdürlüğü Belirtiniz",
//                                                     context) as Widget,
//                                                 SizedBox(
//                                                   height: 20,
//                                                 ),
//                                                 buildTextFormField(
//                                                     notController,
//                                                     "Eklemek istediğiniz notunuz var ise ekleyiniz",
//                                                     context) as Widget,
//                                                 SizedBox(
//                                                   height: 20,
//                                                 ),
//                                                 MaterialButton(
//                                                   child: Padding(
//                                                     padding:
//                                                         const EdgeInsets.all(
//                                                             8.0),
//                                                     child: Text(
//                                                       "Dökümanı Güncelle",
//                                                       style: Theme.of(context)
//                                                           .textTheme
//                                                           .button,
//                                                     ),
//                                                   ),
//                                                   color: Theme.of(context)
//                                                       .buttonColor,
//                                                   shape: RoundedRectangleBorder(
//                                                       borderRadius:
//                                                           BorderRadius.all(
//                                                               Radius.circular(
//                                                                   10.0))),
//                                                   onPressed: () {
//                                                     snapshot.data!.docs[index]
//                                                         .reference
//                                                         .update({
//                                                       'Mobilya Türü':
//                                                           mobilyaTuruController
//                                                               .text
//                                                               .trim(),
//                                                       'Adet': adetController
//                                                           .text
//                                                           .trim(),
//                                                       'Müdürlük':
//                                                           mudurlukController
//                                                               .text
//                                                               .trim(),
//                                                       'Not': notController.text
//                                                           .trim(),
//                                                       'UpdatedDate':
//                                                           DateTime.now(),
//                                                       'UserId': _auth
//                                                           .currentUser!.uid,
//                                                     }).whenComplete(() =>
//                                                             Navigator.pop(
//                                                                 context));
//                                                   },
//                                                 ),
//                                                 MaterialButton(
//                                                   child: Padding(
//                                                     padding:
//                                                         const EdgeInsets.all(
//                                                             8.0),
//                                                     child: Text(
//                                                       "Ürünü Sil",
//                                                       style: Theme.of(context)
//                                                           .textTheme
//                                                           .button,
//                                                     ),
//                                                   ),
//                                                   color: Theme.of(context)
//                                                       .buttonColor,
//                                                   shape: RoundedRectangleBorder(
//                                                       borderRadius:
//                                                           BorderRadius.all(
//                                                               Radius.circular(
//                                                                   10.0))),
//                                                   onPressed: () {
//                                                     snapshot.data!.docs[index]
//                                                         .reference
//                                                         .delete()
//                                                         .whenComplete(() =>
//                                                             Navigator.pop(
//                                                                 context));
//                                                   },
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ));
//                             },
//                           ),
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => UrunDetails(
//                                       documentID:
//                                           docRef['Document ID'] as String,
//                                       mobilyaTuru:
//                                           docRef['Mobilya Türü'] as String,
//                                       adet: docRef['Adet'] as String,
//                                       mudurluk: docRef['Müdürlük'] as String,
//                                       not: docRef['Not'] as String)),
//                             );
//                           },
//                         ),
//                       );
//                     },
//                   );
//                 }
//                 return ListView.builder(
//                   itemCount: snapshot.data!.docs.length,
//                   itemBuilder: (context, index) {
//                     var docRef = snapshot.data!.docs[index];
//                     return Card(
//                       color: Theme.of(context).cardColor,
//                       shadowColor: Theme.of(context).shadowColor,
//                       child: ListTile(
//                         leading: Icon(
//                           Icons.account_circle_rounded,
//                           color: Theme.of(context).iconTheme.color,
//                         ),
//                         title: Text(
//                           "Mobilya Türü:" " \t${docRef['Mobilya Türü']} ",
//                           style: Theme.of(context).textTheme.headline1,
//                         ),
//                         subtitle: Column(
//                           children: <Widget>[
//                             Text(
//                               docRef['Adet'] as String,
//                               style: Theme.of(context).textTheme.headline2,
//                             ),
//                             Text(
//                               docRef['Müdürlük'] as String,
//                               style: Theme.of(context).textTheme.headline2,
//                             ),
//                             Text(
//                               docRef['Not'] as String,
//                               style: Theme.of(context).textTheme.headline2,
//                             ),
//                           ],
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                         ),
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => UrunDetails(
//                                     documentID: docRef['Document ID'] as String,
//                                     mobilyaTuru:
//                                         docRef['Mobilya Türü'] as String,
//                                     adet: docRef['Adet'] as String,
//                                     mudurluk: docRef['Müdürlük'] as String,
//                                     not: docRef['Not'] as String)),
//                           );
//                         },
//                       ),
//                     );
//                   },
//                 );
//               }
//               return Text('Herhangi bir ürün bulunamadı!');
//             },
//           ),
//         ),
//       ),
//       bottomNavigationBar: ConvexAppBar(
//         backgroundColor:
//             Theme.of(context).bottomNavigationBarTheme.backgroundColor,
//         activeColor:
//             Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
//         style: TabStyle.reactCircle,
//         height: 60,
//         items: [
//           TabItem(
//             title: "Malzeme Ekle",
//             icon: Icon(
//               Icons.plus_one,
//               color: Theme.of(context)
//                   .bottomNavigationBarTheme
//                   .unselectedIconTheme!
//                   .color,
//               size: 27,
//             ),
//           ),
//           TabItem(
//             title: "Liste",
//             icon: Icon(
//               Icons.list,
//               color: Theme.of(context)
//                   .bottomNavigationBarTheme
//                   .unselectedIconTheme!
//                   .color,
//               size: 30,
//             ),
//           ),
//           TabItem(
//             icon: Icon(
//               Icons.qr_code,
//               color: Theme.of(context)
//                   .bottomNavigationBarTheme
//                   .unselectedIconTheme!
//                   .color,
//               size: 27,
//             ),
//             title: "Qr Tara",
//           ),
//           TabItem(
//             title: "MDV Takip",
//             icon: Icon(
//               Icons.folder,
//               color: Theme.of(context)
//                   .bottomNavigationBarTheme
//                   .unselectedIconTheme!
//                   .color,
//               size: 27,
//             ),
//           ),
//         ],
//         onTap: (value) {
//           setState(() {
//             pageIndex = value;
//           });
//         },
//       ),
//     );
//   }
// }
