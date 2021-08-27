// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart' as p;
// import 'package:path_provider/path_provider.dart';
// import 'package:firebase_storage/firebase_storage.dart' as storage;

// class ProductImage extends StatefulWidget {
//   final Function(String iamgeUrl) onFileChanged;

//   ProductImage({required this.onFileChanged});

//   @override
//   _ProductImageState createState() => _ProductImageState();
// }

// class _ProductImageState extends State<ProductImage> {
//   final ImagePicker _picker = ImagePicker();

//   String? imageUrl;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         if (imageUrl == null)
//           Icon(
//             Icons.image,
//             size: 30,
//             color: Colors.amber,
//           ),
//         if (imageUrl != null)
//           InkWell(
//               splashColor: Colors.transparent,
//               highlightColor: Colors.transparent,
//               onTap: () => _selectPhoto(),
//               child: Image.network(imageUrl!)),
//         InkWell(
//           onTap: () => _selectPhoto(),
//           child: Padding(
//             padding: EdgeInsets.all(0),
//             child: Text(imageUrl != null ? 'Change Photo' : 'Select Photo'),
//           ),
//         )
//       ],
//     );
//   }

//   Future<dynamic> _selectPhoto() async {
//     await showModalBottomSheet(
//       context: context,
//       builder: (context) => BottomSheet(
//         builder: (context) => Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               leading: Icon(Icons.camera),
//               title: Text('Camera'),
//               onTap: () {
//                 Navigator.of(context).pop();
//                 _pickImage(ImageSource.camera);
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.photo),
//               title: Text('Gallery'),
//               onTap: () {
//                 Navigator.of(context).pop();
//                 _pickImage(ImageSource.gallery);
//               },
//             ),
//           ],
//         ),
//         onClosing: () {},
//       ),
//     );
//   }

//   Future<dynamic> _pickImage(ImageSource source) async {
//     final pickedFile =
//         await _picker.pickImage(source: source, imageQuality: 50);
//     if (pickedFile == null) {
//       return;
//     }

//     var file = await ImageCropper.cropImage(
//         sourcePath: pickedFile.path,
//         aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1));

//     if (file == null) {
//       return;
//     }

//     file = await compressImage(file.path, 35);

//     await _uploadFile(file.path);
//   }

//   Future<File> compressImage(String path, int quality) async {
//     final newPath = p.join((await getTemporaryDirectory()).path,
//         '${DateTime.now()}.${p.extension(path)}');

//     final result = await FlutterImageCompress.compressAndGetFile(path, newPath,
//         quality: quality);
//     return result!;
//   }

//   Future<dynamic> _uploadFile(String path) async {
//     final ref = storage.FirebaseStorage.instance
//         .ref()
//         .child('images')
//         .child('${DateTime.now().toIso8601String() + p.basename(path)}');

//     final result = await ref.putFile(File(path));
//     final fileUrl = await result.ref.getDownloadURL();

//     setState(() {
//       imageUrl = fileUrl;
//     });
//     widget.onFileChanged(fileUrl);
//   }
// }
