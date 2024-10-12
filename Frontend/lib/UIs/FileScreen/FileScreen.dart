import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:mime/mime.dart';
import 'package:redact/UIs/RedactedFileScreen/RedactedFileScreen.dart';
import 'package:redact/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:redact/utils/device/device_utility.dart';
import 'package:redact/utils/helper/alerts.dart';
import 'package:redact/utils/helper/helper_functions.dart';

class FileScreen extends StatefulWidget {
  const FileScreen({
    required this.file,
    required this.redactionLevel,
    required this.selectedEntities,
    super.key
  });
  final File file;
  final String redactionLevel;
  final Map<String, bool> selectedEntities;

  @override
  State<FileScreen> createState() => _FileScreenState();
}

class _FileScreenState extends State<FileScreen> {
  final TextEditingController _textController = TextEditingController();
  String originalText = "";

  File? _selectedFile;

  String _redactionLevel = "G1 - Basic Redaction";

  List<Map<String, String>> gradations = [
    {
      "string": "Grade 1 - Basic Redaction",
      "value": "G1 - Basic Redaction"
    },{
      "string": "Grade 2 - Medium Redaction",
      "value": "G2 - Medium Redaction"
    },{
      "string": "Grade 3 - High Redaction",
      "value": "G3 - High Redaction"
    }, {
      "string": "Grade 4 - Full Anonymization - Synthetic Data Generation",
      "value": "G4 - Synthetic Data"
    }
  ];

  Map<String, bool> _entities = {
    'PII': true,
    'Location': true,
    'Organization': false,
    'Document Numbers': false,
  };

  @override
  void initState() {
    super.initState();
    _loadFileContent();
  }

  void _loadFileContent() async {
    try {
      String fileContent = await widget.file.readAsString();
      setState(() {
        _textController.text = fileContent;
        _entities = widget.selectedEntities;
        _redactionLevel = widget.redactionLevel;
        originalText = fileContent;
      });
    } catch (e) {
      print("Error reading file: $e");
    }
  }

  void _saveFileContent() async {
    try {
      await widget.file.writeAsString(_textController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("File saved successfully!")),
      );
    } catch (e) {
      print("Error writing to file: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error saving file!")),
      );
      // Alerts.showSnackBar("Error saving file!");
    }
  }

  void _clearText() {
    setState(() {
      _textController.clear();
    });
  }

  void _originalText() {
    setState(() {
      _textController.text = originalText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:  Align(
            alignment: Alignment.center,
            child: Text("FILE SETTINGS", style: Theme.of(context).textTheme.titleLarge
                ?.merge(const TextStyle(color: FColors.primary)),)
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(widget.file.path.split('/').last, style: Theme.of(context).textTheme.headlineMedium
                ?.merge(const TextStyle(color: FColors.primary)),),
              Text(" ${lookupMimeType(widget.file.path)!}", style: Theme.of(context).textTheme.bodyMedium
                  ?.merge(const TextStyle(color: FColors.neutralDarkGrey)),),

              const SizedBox(height: 20,),

              TextField(
                controller: _textController,
                maxLines: 10,
                decoration: InputDecoration(
                  labelText: "File Content",
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                  labelStyle: Theme.of(context).textTheme.bodyLarge,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      width: 3,
                      color: FColors.primary,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(10),
                  hintStyle: Theme.of(context).textTheme.labelMedium,
                  hintText: 'Empty File',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      width: 3,
                      color: FColors.primary,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      width: 3,
                      color: FColors.accent,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8,),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: _originalText,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      side: BorderSide.none,
                    ),
                    child: const Text('Original'),
                  ),
                  const SizedBox(width: 8,),
                  ElevatedButton(
                    onPressed: _clearText,
                    style: ElevatedButton.styleFrom(side: BorderSide.none,backgroundColor: Colors.red,padding: const EdgeInsets.symmetric(vertical: 0)),
                    child: const Text('Clear'),
                  ),
                  const SizedBox(width: 8,),
                  ElevatedButton(
                    onPressed: _saveFileContent,
                    style: ElevatedButton.styleFrom(side: BorderSide.none,backgroundColor: Colors.green,padding: const EdgeInsets.symmetric(vertical: 0)),
                    child: const Text('Save'),
                  ),
                ],
              ),

              const SizedBox(height: 20,),

              DropdownButtonFormField<String>(
                value: _redactionLevel,
                icon: Icon(CupertinoIcons.arrow_down_circle),
                decoration: const InputDecoration(
                  labelText: 'Redaction Grade',
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  border: OutlineInputBorder(),
                ),
                items: gradations.map((Map<String, String> grade) {
                  return DropdownMenuItem<String>(
                    value: grade['value'],
                    child: Text(grade['value']!),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _redactionLevel = value!;
                  });
                },
              ),
              const SizedBox(height: 20),

              // Redaction Entities (Checkboxes)
              Text('Customize Entities:',
                style: Theme.of(context).textTheme.bodyLarge?.merge(TextStyle(color: FColors.primary)),
              ),

              ..._entities.keys.map((entity) {
                return Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: CheckboxListTile(
                    title: Text(entity),
                    value: _entities[entity],
                    onChanged: (bool? value) {
                      setState(() {
                        _entities[entity] = value!;
                      });
                    },
                  ),
                );
              }),

              SizedBox(
                width: DeviceUtils.getWidth(context),
                child: ElevatedButton(
                    onPressed: ()=> HelperFunctions.navigateToScreen(context, RedactedFileScreen(file: widget.file,
                        redactionLevel: _redactionLevel)),
                    child: const Text("RE-DACT SECURELY")
                ),
              )


            ],
          ),
        ),
      ),
    );
  }
}
