import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'dart:ui';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Appiieee',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[200],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          elevation: 4,
          foregroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? fileName;
  Uint8List? fileBytes;
  bool isLoading = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;

      setState(() {
        fileName = file.name;
        fileBytes = file.bytes;
      });

      uploadFile(fileName!, fileBytes!);
    } else {
      setState(() {
        fileName = 'No file selected';
      });
    }
  }

  Future<void> uploadFile(String name, Uint8List bytes) async {
    setState(() {
      isLoading = true;
    });

    try {
      var response = await http.post(
        Uri.parse('https://your-backend-api.com/upload'),
        headers: {'Content-Type': 'application/octet-stream'},
        body: bytes,
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('File uploaded successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('File upload failed!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred during upload.')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('App Name'),
        actions: [
          ElevatedButton.icon(
            onPressed: pickFile,
            icon: const Icon(Icons.upload_file),
            label: const Text('Upload File'),
          ),
          const SizedBox(width: 10),
          IconButton(
            iconSize: 40,
            onPressed: () {},
            icon: const Icon(Icons.account_circle),
            tooltip: 'Profile',
          ),
          const SizedBox(width: 10),
        ],
      ),
      drawer: _buildSidebar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return _buildMobileLayout();
          } else {
            return _buildWebLayout();
          }
        },
      ),
    );
  }

  Widget _buildWebLayout() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (fileName != null) ...[
                  Text(
                    fileName!,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                ],
                const SizedBox(height: 20),
                if (isLoading)
                  const CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSidebar() {
    return Drawer(
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              color: Colors.black12,
            ),
          ),
          ListView(
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.insert_drive_file, color: Colors.blue),
                title: const Text('Documents'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.history, color: Colors.blue),
                title: const Text('Redaction Log'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.tour, color: Colors.blue),
                title: const Text('Start Tour'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.help, color: Colors.blue),
                title: const Text('Help'),
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return const Center(
      child: Text(
        "Mobile Layout",
        style: TextStyle(color: Colors.black, fontSize: 18),
      ),
    );
  }
}
