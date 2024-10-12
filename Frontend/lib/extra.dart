// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:http/http.dart' as http;
// import 'dart:typed_data';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Appiieee',
//       theme: ThemeData(
//         primarySwatch: Colors.teal,
//       ),
//       home: const HomePage(),
//     );
//   }
// }
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   String? fileName;
//   Uint8List? fileBytes;
//   bool isLoading = false;
//
//   Future<void> pickFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();
//
//     if (result != null) {
//       PlatformFile file = result.files.first;
//
//       setState(() {
//         fileName = file.name;
//         fileBytes = file.bytes;
//       });
//
//       uploadFile(fileName!, fileBytes!);
//     } else {
//       setState(() {
//         fileName = 'No file selected';
//       });
//     }
//   }
//
//   Future<void> uploadFile(String name, Uint8List bytes) async {
//     setState(() {
//       isLoading = true;
//     });
//
//     try {
//       var response = await http.post(
//         Uri.parse('https://your-backend-api.com/upload'),
//         headers: {'Content-Type': 'application/octet-stream'},
//         body: bytes,
//       );
//
//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('File uploaded successfully!')),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('File upload failed!')),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('An error occurred during upload.')),
//       );
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.teal[900],
//       appBar: AppBar(
//         title: const Text('File Upload App'),
//         actions: [
//           ElevatedButton.icon(
//             onPressed: pickFile,
//             icon: const Icon(Icons.upload_file, color: Colors.white),
//             label: const Text('Upload Files'),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.tealAccent[700],
//             ),
//           ),
//           const SizedBox(width: 10),
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(Icons.account_circle, color: Colors.white),
//             tooltip: 'Profile',
//           ),
//         ],
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           if (constraints.maxWidth < 600) {
//             return _buildMobileLayout();
//           } else {
//             return _buildWebLayout();
//           }
//         },
//       ),
//     );
//   }
//
//   Widget _buildWebLayout() {
//     return Row(
//       children: [
//         _buildSidebar(),
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 if (fileName != null) ...[
//                   Text(
//                     fileName!,
//                     style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
//                   ),
//                   const SizedBox(height: 10),
//                 ],
//                 ElevatedButton(
//                   onPressed: pickFile,
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
//                     textStyle: const TextStyle(fontSize: 16),
//                   ),
//                   child: const Text('Select a File'),
//                 ),
//                 const SizedBox(height: 20),
//                 if (isLoading)
//                   const CircularProgressIndicator(),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildSidebar() {
//     return Container(
//       width: 250,
//       color: Colors.teal[800],
//       child: Column(
//         children: [
//           const SizedBox(height: 20),
//           ListTile(
//             leading: const Icon(Icons.insert_drive_file, color: Colors.white),
//             title: const Text('Documents', style: TextStyle(color: Colors.white)),
//             onTap: () {},
//           ),
//           ListTile(
//             leading: const Icon(Icons.subscriptions, color: Colors.white),
//             title: const Text('Subscription', style: TextStyle(color: Colors.white)),
//             onTap: () {},
//           ),
//           ListTile(
//             leading: const Icon(Icons.history, color: Colors.white),
//             title: const Text('Redaction Log', style: TextStyle(color: Colors.white)),
//             onTap: () {},
//           ),
//           ListTile(
//             leading: const Icon(Icons.tour, color: Colors.white),
//             title: const Text('Start Tour', style: TextStyle(color: Colors.white)),
//             onTap: () {},
//           ),
//           ListTile(
//             leading: const Icon(Icons.help, color: Colors.white),
//             title: const Text('Help', style: TextStyle(color: Colors.white)),
//             onTap: () {},
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMobileLayout() {
//     return const Center(
//       child: Text(
//         "Mobile Layout",
//         style: TextStyle(color: Colors.white, fontSize: 18),
//       ),
//     );
//   }
// }
//
//
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:http/http.dart' as http;
// import 'dart:typed_data';
// import 'dart:ui';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Appiieee',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         scaffoldBackgroundColor: Colors.white,
//         appBarTheme: AppBarTheme(
//           backgroundColor: Colors.blueGrey[900],
//           foregroundColor: Colors.white,
//         ),
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             // color : Colors.blueGrey[800]
//           ),
//         ),
//         textTheme: TextTheme(
//           // bodyText1: TextStyle(color: Colors.black87),
//           // bodyText2: TextStyle(color: Colors.black54),
//         ),
//       ),
//       home: const HomePage(),
//     );
//   }
// }
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   String? fileName;
//   Uint8List? fileBytes;
//   bool isLoading = false;
//
//   Future<void> pickFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();
//
//     if (result != null) {
//       PlatformFile file = result.files.first;
//
//       setState(() {
//         fileName = file.name;
//         fileBytes = file.bytes;
//       });
//
//       uploadFile(fileName!, fileBytes!);
//     } else {
//       setState(() {
//         fileName = 'No file selected';
//       });
//     }
//   }
//
//   Future<void> uploadFile(String name, Uint8List bytes) async {
//     setState(() {
//       isLoading = true;
//     });
//
//     try {
//       var response = await http.post(
//         Uri.parse('https://your-backend-api.com/upload'),
//         headers: {'Content-Type': 'application/octet-stream'},
//         body: bytes,
//       );
//
//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('File uploaded successfully!')),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('File upload failed!')),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('An error occurred during upload.')),
//       );
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('File Upload App'),
//         actions: [
//           ElevatedButton.icon(
//             onPressed: pickFile,
//             icon: const Icon(Icons.upload_file, color: Colors.white),
//             label: const Text('Upload Files'),
//             style: ElevatedButton.styleFrom(
//               // primary: Colors.blueGrey[800], // Background color
//               // onPrimary: Colors.white, // Text color
//             ),
//           ),
//           const SizedBox(width: 10),
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(Icons.account_circle, color: Colors.white),
//             tooltip: 'Profile',
//           ),
//         ],
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           if (constraints.maxWidth < 600) {
//             return _buildMobileLayout();
//           } else {
//             return _buildWebLayout();
//           }
//         },
//       ),
//     );
//   }
//
//   Widget _buildWebLayout() {
//     return Row(
//       children: [
//         _buildSidebar(),
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 if (fileName != null) ...[
//                   Text(
//                     fileName!,
//                     style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 10),
//                 ],
//                 ElevatedButton(
//                   onPressed: pickFile,
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
//                     textStyle: const TextStyle(fontSize: 16),
//                   ),
//                   child: const Text('Select a File'),
//                 ),
//                 const SizedBox(height: 20),
//                 if (isLoading)
//                   const CircularProgressIndicator(),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildSidebar() {
//     return Container(
//       width: 250,
//       color: Colors.white,
//       child: Stack(
//         children: [
//           BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
//             child: Container(
//               color: Colors.black12,
//             ),
//           ),
//           Column(
//             children: [
//               const SizedBox(height: 20),
//               ListTile(
//                 leading: const Icon(Icons.insert_drive_file, color: Colors.black),
//                 title: const Text('Documents', style: TextStyle(color: Colors.black)),
//                 onTap: () {},
//               ),
//               ListTile(
//                 leading: const Icon(Icons.subscriptions, color: Colors.black),
//                 title: const Text('Subscription', style: TextStyle(color: Colors.black)),
//                 onTap: () {},
//               ),
//               ListTile(
//                 leading: const Icon(Icons.history, color: Colors.black),
//                 title: const Text('Redaction Log', style: TextStyle(color: Colors.black)),
//                 onTap: () {},
//               ),
//               ListTile(
//                 leading: const Icon(Icons.tour, color: Colors.black),
//                 title: const Text('Start Tour', style: TextStyle(color: Colors.black)),
//                 onTap: () {},
//               ),
//               ListTile(
//                 leading: const Icon(Icons.help, color: Colors.black),
//                 title: const Text('Help', style: TextStyle(color: Colors.black)),
//                 onTap: () {},
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMobileLayout() {
//     return const Center(
//       child: Text(
//         "Mobile Layout",
//         style: TextStyle(color: Colors.black, fontSize: 18),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:http/http.dart' as http;
// import 'dart:typed_data';
// import 'dart:ui';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Appiieee',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         scaffoldBackgroundColor: Colors.white,
//         appBarTheme: AppBarTheme(
//           backgroundColor: Colors.blueGrey[900],
//           foregroundColor: Colors.white,
//         ),
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             // primary: Colors.blueGrey[800], // Background color
//             // onPrimary: Colors.white, // Text color
//           ),
//         ),
//         textTheme: TextTheme(
//           // bodyText1: TextStyle(color: Colors.black87),
//           // bodyText2: TextStyle(color: Colors.black54),
//         ),
//       ),
//       home: const HomePage(),
//     );
//   }
// }
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   String? fileName;
//   Uint8List? fileBytes;
//   bool isLoading = false;
//
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   Future<void> pickFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();
//
//     if (result != null) {
//       PlatformFile file = result.files.first;
//
//       setState(() {
//         fileName = file.name;
//         fileBytes = file.bytes;
//       });
//
//       uploadFile(fileName!, fileBytes!);
//     } else {
//       setState(() {
//         fileName = 'No file selected';
//       });
//     }
//   }
//
//   Future<void> uploadFile(String name, Uint8List bytes) async {
//     setState(() {
//       isLoading = true;
//     });
//
//     try {
//       var response = await http.post(
//         Uri.parse('https://your-backend-api.com/upload'),
//         headers: {'Content-Type': 'application/octet-stream'},
//         body: bytes,
//       );
//
//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('File uploaded successfully!')),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('File upload failed!')),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('An error occurred during upload.')),
//       );
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         title: const Text('File Upload App'),
//         actions: [
//           IconButton(
//             onPressed: () {
//               _scaffoldKey.currentState?.openDrawer();
//             },
//             icon: const Icon(Icons.menu, color: Colors.white),
//             tooltip: 'Toggle Sidebar',
//           ),
//           ElevatedButton.icon(
//             onPressed: pickFile,
//             icon: const Icon(Icons.upload_file, color: Colors.white),
//             label: const Text('Upload Files'),
//             style: ElevatedButton.styleFrom(
//               // primary: Colors.blueGrey[800], // Background color
//               // onPrimary: Colors.white, // Text color
//             ),
//           ),
//           const SizedBox(width: 10),
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(Icons.account_circle, color: Colors.white),
//             tooltip: 'Profile',
//           ),
//         ],
//       ),
//       drawer: _buildSidebar(),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           if (constraints.maxWidth < 600) {
//             return _buildMobileLayout();
//           } else {
//             return _buildWebLayout();
//           }
//         },
//       ),
//     );
//   }
//
//   Widget _buildWebLayout() {
//     return Row(
//       children: [
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 if (fileName != null) ...[
//                   Text(
//                     fileName!,
//                     style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 10),
//                 ],
//                 ElevatedButton(
//                   onPressed: pickFile,
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
//                     textStyle: const TextStyle(fontSize: 16),
//                   ),
//                   child: const Text('Select a File'),
//                 ),
//                 const SizedBox(height: 20),
//                 if (isLoading)
//                   const CircularProgressIndicator(),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildSidebar() {
//     return Drawer(
//       child: Stack(
//         children: [
//           BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
//             child: Container(
//               color: Colors.black12,
//             ),
//           ),
//           ListView(
//             padding: EdgeInsets.zero,
//             children: [
//               const SizedBox(height: 20),
//               ListTile(
//                 leading: const Icon(Icons.insert_drive_file, color: Colors.black),
//                 title: const Text('Documents', style: TextStyle(color: Colors.black)),
//                 onTap: () {},
//               ),
//               ListTile(
//                 leading: const Icon(Icons.subscriptions, color: Colors.black),
//                 title: const Text('Subscription', style: TextStyle(color: Colors.black)),
//                 onTap: () {},
//               ),
//               ListTile(
//                 leading: const Icon(Icons.history, color: Colors.black),
//                 title: const Text('Redaction Log', style: TextStyle(color: Colors.black)),
//                 onTap: () {},
//               ),
//               ListTile(
//                 leading: const Icon(Icons.tour, color: Colors.black),
//                 title: const Text('Start Tour', style: TextStyle(color: Colors.black)),
//                 onTap: () {},
//               ),
//               ListTile(
//                 leading: const Icon(Icons.help, color: Colors.black),
//                 title: const Text('Help', style: TextStyle(color: Colors.black)),
//                 onTap: () {},
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMobileLayout() {
//     return const Center(
//       child: Text(
//         "Mobile Layout",
//         style: TextStyle(color: Colors.black, fontSize: 18),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:http/http.dart' as http;
// import 'dart:typed_data';
// import 'dart:ui';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Appiieee',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         scaffoldBackgroundColor: Colors.white,
//         appBarTheme: AppBarTheme(
//           backgroundColor: Colors.white.withOpacity(0.8), // Blur effect
//           foregroundColor: Colors.black,
//         ),
//         textTheme: TextTheme(
//             titleLarge: TextStyle(color: Colors.black) // Title text color
//         ),
//       ),
//       home: const HomePage(),
//     );
//   }
// }
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   String? fileName;
//   Uint8List? fileBytes;
//   bool isLoading = false;
//
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   Future<void> pickFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();
//
//     if (result != null) {
//       PlatformFile file = result.files.first;
//
//       setState(() {
//         fileName = file.name;
//         fileBytes = file.bytes;
//       });
//
//       uploadFile(fileName!, fileBytes!);
//     } else {
//       setState(() {
//         fileName = 'No file selected';
//       });
//     }
//   }
//
//   Future<void> uploadFile(String name, Uint8List bytes) async {
//     setState(() {
//       isLoading = true;
//     });
//
//     try {
//       var response = await http.post(
//         Uri.parse('https://your-backend-api.com/upload'),
//         headers: {'Content-Type': 'application/octet-stream'},
//         body: bytes,
//       );
//
//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('File uploaded successfully!')),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('File upload failed!')),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('An error occurred during upload.')),
//       );
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         title: const Text('File Upload App'),
//         actions: [
//           IconButton(
//             onPressed: () {
//               _scaffoldKey.currentState?.openDrawer();
//             },
//             icon: const Icon(Icons.menu, color: Colors.black),
//             tooltip: 'Toggle Sidebar',
//           ),
//           ElevatedButton.icon(
//             onPressed: pickFile,
//             icon: const Icon(Icons.upload_file, color: Colors.black),
//             label: const Text('Upload Files'),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.blue,
//             ),
//           ),
//           const SizedBox(width: 10),
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(Icons.account_circle, color: Colors.black),
//             tooltip: 'Profile',
//           ),
//         ],
//       ),
//       drawer: _buildSidebar(),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           if (constraints.maxWidth < 600) {
//             return _buildMobileLayout();
//           } else {
//             return _buildWebLayout();
//           }
//         },
//       ),
//     );
//   }
//
//   Widget _buildWebLayout() {
//     return Row(
//       children: [
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 if (fileName != null) ...[
//                   Text(
//                     fileName!,
//                     style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 10),
//                 ],
//                 ElevatedButton(
//                   onPressed: pickFile,
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
//                     textStyle: const TextStyle(fontSize: 16),
//                   ),
//                   child: const Text('Select a File'),
//                 ),
//                 const SizedBox(height: 20),
//                 if (isLoading)
//                   const CircularProgressIndicator(),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildSidebar() {
//     return Drawer(
//       child: Stack(
//         children: [
//           BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
//             child: Container(
//               color: Colors.black12,
//             ),
//           ),
//           ListView(
//             padding: EdgeInsets.zero,
//             children: [
//               const SizedBox(height: 20),
//               ListTile(
//                 leading: const Icon(Icons.insert_drive_file, color: Colors.black),
//                 title: const Text('Documents', style: TextStyle(color: Colors.black)),
//                 onTap: () {},
//               ),
//               ListTile(
//                 leading: const Icon(Icons.subscriptions, color: Colors.black),
//                 title: const Text('Subscription', style: TextStyle(color: Colors.black)),
//                 onTap: () {},
//               ),
//               ListTile(
//                 leading: const Icon(Icons.history, color: Colors.black),
//                 title: const Text('Redaction Log', style: TextStyle(color: Colors.black)),
//                 onTap: () {},
//               ),
//               ListTile(
//                 leading: const Icon(Icons.tour, color: Colors.black),
//                 title: const Text('Start Tour', style: TextStyle(color: Colors.black)),
//                 onTap: () {},
//               ),
//               ListTile(
//                 leading: const Icon(Icons.help, color: Colors.black),
//                 title: const Text('Help', style: TextStyle(color: Colors.black)),
//                 onTap: () {},
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMobileLayout() {
//     return const Center(
//       child: Text(
//         "Mobile Layout",
//         style: TextStyle(color: Colors.black, fontSize: 18),
//       ),
//     );
//   }
// }
//


// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:http/http.dart' as http;
// import 'dart:typed_data';
// import 'dart:ui';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Appiieee',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         scaffoldBackgroundColor: Colors.grey[100],
//         appBarTheme: AppBarTheme(
//           backgroundColor: Colors.white,
//           elevation: 4,
//           foregroundColor: Colors.black,
//           iconTheme: const IconThemeData(color: Colors.black),
//         ),
//         textTheme: TextTheme(
//           titleLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//       ),
//       home: const HomePage(),
//     );
//   }
// }
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   String? fileName;
//   Uint8List? fileBytes;
//   bool isLoading = false;
//
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   Future<void> pickFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();
//
//     if (result != null) {
//       PlatformFile file = result.files.first;
//
//       setState(() {
//         fileName = file.name;
//         fileBytes = file.bytes;
//       });
//
//       uploadFile(fileName!, fileBytes!);
//     } else {
//       setState(() {
//         fileName = 'No file selected';
//       });
//     }
//   }
//
//   Future<void> uploadFile(String name, Uint8List bytes) async {
//     setState(() {
//       isLoading = true;
//     });
//
//     try {
//       var response = await http.post(
//         Uri.parse('https://your-backend-api.com/upload'),
//         headers: {'Content-Type': 'application/octet-stream'},
//         body: bytes,
//       );
//
//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('File uploaded successfully!')),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('File upload failed!')),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('An error occurred during upload.')),
//       );
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         title: const Text('App Name'),
//         actions: [
//           ElevatedButton.icon(
//             onPressed: pickFile,
//             icon: const Icon(Icons.upload_file),
//             label: const Text('Upload File'),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//           ),
//           const SizedBox(width: 10),
//           IconButton(
//             iconSize: 40,
//             onPressed: () {},
//             icon: const Icon(Icons.account_circle),
//             tooltip: 'Profile',
//           ),
//           const SizedBox(width: 10,)
//         ],
//       ),
//       drawer: _buildSidebar(),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           if (constraints.maxWidth < 600) {
//             return _buildMobileLayout();
//           } else {
//             return _buildWebLayout();
//           }
//         },
//       ),
//     );
//   }
//
//   Widget _buildWebLayout() {
//     return Row(
//       children: [
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 if (fileName != null) ...[
//                   Text(
//                     fileName!,
//                     style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
//                   ),
//                   const SizedBox(height: 10),
//                 ],
//                 const SizedBox(height: 20),
//                 if (isLoading)
//                   const CircularProgressIndicator(),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildSidebar() {
//     return Drawer(
//       child: Stack(
//         children: [
//           BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
//             child: Container(
//               color: Colors.black12,
//             ),
//           ),
//           ListView(
//             padding: EdgeInsets.all(15),
//             children: [
//               const SizedBox(height: 20),
//               ListTile(
//                 leading: const Icon(Icons.insert_drive_file),
//                 title: const Text('Documents'),
//                 onTap: () {},
//               ),
//               ListTile(
//                 leading: const Icon(Icons.subscriptions),
//                 title: const Text('Subscription'),
//                 onTap: () {},
//               ),
//               ListTile(
//                 leading: const Icon(Icons.history),
//                 title: const Text('Redaction Log'),
//                 onTap: () {},
//               ),
//               ListTile(
//                 leading: const Icon(Icons.tour),
//                 title: const Text('Start Tour'),
//                 onTap: () {},
//               ),
//               ListTile(
//                 leading: const Icon(Icons.help),
//                 title: const Text('Help'),
//                 onTap: () {},
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMobileLayout() {
//     return const Center(
//       child: Text(
//         "Mobile Layout",
//         style: TextStyle(color: Colors.black, fontSize: 18),
//       ),
//     );
//   }
// }