import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:mime/mime.dart';
import 'package:redact/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:redact/utils/device/device_utility.dart';
import 'package:redact/utils/helper/alerts.dart';
import 'package:redact/utils/helper/helper_functions.dart';

class RedactedFileScreen extends StatefulWidget {
  const RedactedFileScreen({
    required this.file,
    required this.redactionLevel,
    super.key
  });
  final File file;
  final String redactionLevel;

  @override
  State<RedactedFileScreen> createState() => _RedactedFileScreenState();
}

class _RedactedFileScreenState extends State<RedactedFileScreen> {
  final TextEditingController _textController = TextEditingController();

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
      });
    } catch (e) {
      print("Error reading file: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:  Align(
            alignment: Alignment.center,
            child: Text("REDACTION", style: Theme.of(context).textTheme.titleLarge
                ?.merge(const TextStyle(color: FColors.primary)),)
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text("File Name : ${widget.file.path.split('/').last}", style: Theme.of(context).textTheme.headlineSmall
                  ?.merge(const TextStyle(color: FColors.neutralDarkGrey, fontWeight: FontWeight.bold)),),

              const SizedBox(height: 15,),

              Text("Redacted File Path : ", style: Theme.of(context).textTheme.headlineSmall
                ?.merge(const TextStyle(color: FColors.neutralDarkGrey, fontWeight: FontWeight.bold)),),
              Text(widget.file.path, style: Theme.of(context).textTheme.bodySmall
                  ?.merge(const TextStyle(color: FColors.neutralDarkGrey)),),

              const SizedBox(height: 15,),

              DropdownButtonFormField<String>(
                value: widget.redactionLevel,
                icon: const Icon(null),
                decoration: const InputDecoration(
                  labelText: 'Redaction Grade',
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  border: OutlineInputBorder(),
                ),
                items: [
                  {"string":widget.redactionLevel,
                    "value": widget.redactionLevel}
                ].map((Map<String, String> grade) {
                  return DropdownMenuItem<String>(
                    enabled: false,
                    value: grade['value'],
                    child: Text(grade['value']!),
                  );
                }).toList(), onChanged: (String? value) {},
              ),

              const SizedBox(height: 15,),

              SizedBox(
                width: DeviceUtils.getWidth(context),
                child: ElevatedButton(
                    onPressed: () {  },
                    child: const Text("SEE ORIGINAL FILE")
                ),
              ),

              const SizedBox(height: 20,),

              Text("Redacted File Content", style: Theme.of(context).textTheme.headlineMedium
                  ?.merge(const TextStyle(color: FColors.neutralDarkGrey, fontWeight: FontWeight.bold)),),

              const SizedBox(height: 15,),
              
              TextField(
                controller: _textController,
                maxLines: null,
                decoration: InputDecoration(
                  enabled: false,
                  labelText: "File Content",
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                  labelStyle: Theme.of(context).textTheme.bodyLarge,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      width: 1,
                      color: FColors.accent,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(10),
                  hintStyle: Theme.of(context).textTheme.labelMedium,
                  hintText: 'Empty File',
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      width: 1,
                      color: FColors.primary,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      width: 1,
                      color: FColors.primary,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      width: 1,
                      color: FColors.accent,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
