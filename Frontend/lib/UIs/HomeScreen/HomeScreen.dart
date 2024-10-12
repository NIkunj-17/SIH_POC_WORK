import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redact/UIs/AllFilesScreen/AllFilesScreen.dart';
import 'package:redact/UIs/AllRedactionScreen/AllRedactionScreen.dart';
import 'package:redact/UIs/FileScreen/FileScreen.dart';
import 'package:redact/UIs/ProjectsScreen/ProjectsScreen.dart';
import 'package:redact/utils/constants/colors.dart';
import 'package:redact/utils/constants/sizes.dart';
import 'package:redact/utils/device/device_utility.dart';
import 'package:redact/utils/helper/helper_functions.dart';

import '../../utils/Themes/theme_provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  final Map<String, bool> _entities = {
    'PII': true,
    'Location': true,
    'Organization': false,
    'Document Numbers': false,
  };

  Future<void> _pickFile(StateSetter setState) async {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
           type: FileType.custom,allowedExtensions: ['txt'],);

        if (result != null) {
          print(result.files.single.path);
        setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  final files = [
    {"name": "Notes.txt", "type": "txt", "size": 100, "time": "Added 5 min ago", "location": "Redact/Docs/Texts/", "src": "assets/images/Icons/text.png"},
    {"name": "Resume.pdf", "type": "pdf", "size": 2560, "time": "Added 16 min ago", "location": "Redact/Docs/PDF/", "src": "assets/images/Icons/pdf.png"},
    {"name": "aadhaar.jpeg", "type": "jpeg", "size": 4120, "time": "Added 20 min ago", "location": "Redact/Docs/Images/", "src": "assets/images/Icons/gallery.png"}
  ];

  Future<void> openUploadPopup(BuildContext context,String type) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Redaction Settings', textAlign: TextAlign.center,),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter SetState) {
                return Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  ElevatedButton.icon(
                    onPressed: (){
                      _pickFile(SetState);
                    },
                    icon: const Icon(CupertinoIcons.upload_circle),
                    label: const Text('Upload File'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                  ),

                  if (_selectedFile != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text("File Name: ${_selectedFile!.path.split('/').last}"),
                      ],
                    ),

                  const SizedBox(height: 15),

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
                  const Text('Entities to Redact:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  ..._entities.keys.map((entity) {
                    return CheckboxListTile(
                      title: Text(entity),
                      value: _entities[entity],
                      onChanged: (bool? value) {
                        SetState(() {
                          _entities[entity] = value!;
                        });
                      },
                    );
                  }),

                  const SizedBox(height: 20),
                ],
                                  );
              }
          ),
          actions: [

            ElevatedButton.icon(
              onPressed: () => HelperFunctions.navigateToScreen(context
                  , FileScreen(file: _selectedFile!, redactionLevel: _redactionLevel, selectedEntities: _entities)),
              icon: const Icon(CupertinoIcons.arrow_right_circle),
              iconAlignment: IconAlignment.end,
              label: const Text('Next'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Text("RE-DACT", style: Theme.of(context).textTheme.titleLarge
              ?.merge(TextStyle(color: FColors.primary)), ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                padding: FSizes.containerPadding,
                height: 300,
                decoration: BoxDecoration(
                  gradient: FColors.linearGradient,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: FSizes.getPadding(8),
                          height: 43,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: FColors.neutralDarkerGrey,width: 1.3 )
                          ),
                          child: Row(
                            children: [
                              const CircleAvatar(backgroundColor: Colors.transparent,child: Icon(CupertinoIcons.profile_circled),foregroundColor: FColors.neutralDarkGrey,),
                              const SizedBox(width: 4,),
                              Text("Guest", style: Theme.of(context).textTheme.bodyLarge
                                  ?.merge(const TextStyle(color: FColors.neutralDarkGrey)),),
                              const SizedBox(width: 5,)
                            ],
                          ),
                        ),

                        Container(
                          padding: FSizes.getPadding(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: FColors.neutralDarkerGrey, width: 1.3),
                            shape: BoxShape.circle
                          ),
                          child: Icon(CupertinoIcons.square_grid_2x2, color: FColors.neutralDarkGrey,),
                        )
                      ],
                    ),

                    SizedBox(height: 18,),
                    Text("Manage", style: Theme.of(context).textTheme.bodyMedium,),
                    SizedBox(height: 5,),
                    Text("Projects and Files", style: Theme.of(context).textTheme.headlineMedium,),
                    SizedBox(height: 18,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        GestureDetector(
                          onTap: () => HelperFunctions.navigateToScreen(context, const ProjectsScreen()),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)
                            ),
                            padding: FSizes.getPadding(10),
                            width: DeviceUtils.getWidth(context)*0.26,
                            height: 120,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Icon(CupertinoIcons.bag, color: FColors.primary, size: 50,),
                                Column(
                                  children: [
                                    Text("Projects", style: Theme.of(context).textTheme.titleMedium
                                        ?.merge(const TextStyle(fontWeight: FontWeight.w700)),),
                                    Text("34 Projects", style: Theme.of(context).textTheme.bodySmall
                                        ?.merge(const TextStyle(color: FColors.neutralDarkerGrey)),),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),


                        GestureDetector(
                          onTap: ()=> HelperFunctions.navigateToScreen(context, const AllFilesScreen()),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            padding: FSizes.getPadding(10),
                            width: DeviceUtils.getWidth(context)*0.26,
                            height: 120,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Icon(CupertinoIcons.folder, color: FColors.primary, size: 50,),
                                Column(
                                  children: [
                                    Text("Files", style: Theme.of(context).textTheme.titleMedium
                                        ?.merge(const TextStyle(fontWeight: FontWeight.w700)),),
                                    Text("269 Files", style: Theme.of(context).textTheme.bodySmall
                                        ?.merge(const TextStyle(color: FColors.neutralDarkerGrey)),),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),


                        GestureDetector(
                          onTap: ()=> HelperFunctions.navigateToScreen(context, const AllRedactionScreen()),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            padding: FSizes.getPadding(10),
                            width: DeviceUtils.getWidth(context)*0.26,
                            height: 128,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Icon(CupertinoIcons.eye_slash, color: FColors.primary, size: 50,),
                                Column(
                                  children: [
                                    Text("redactions", style: Theme.of(context).textTheme.titleMedium
                                        ?.merge(const TextStyle(fontWeight: FontWeight.w700)),textAlign: TextAlign.center,),
                                    Text("169 Redacted", style: Theme.of(context).textTheme.bodySmall
                                        ?.merge(const TextStyle(color: FColors.neutralDarkerGrey)),),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),



                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 30,),

              Row(
                children: [

                  Expanded(
                    child: GestureDetector(
                      onTap: ()=> openUploadPopup(context, "File"),
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: FColors.secondary
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(CupertinoIcons.cloud_upload_fill, size: 50, color: FColors.darkPrimary,),
                                Text("Upload File", style: Theme.of(context).textTheme.headlineMedium
                                  ?.merge(TextStyle(color: FColors.darkPrimary)),),
                                Text("e.g. Text, Images, PDF's", style: Theme.of(context).textTheme.bodySmall
                                  ?.merge(TextStyle(color: FColors.neutralDarkGrey)),),
                                Text("MS Word, pptx etc.", style: Theme.of(context).textTheme.bodySmall
                                    ?.merge(TextStyle(color: FColors.neutralDarkGrey)),),
                                SizedBox(height: 8,)
                              ],
                            )
                          ],
                        )
                      ),
                    ),
                  ),

                  const SizedBox(width: 10,),
                  Expanded(
                    child: GestureDetector(
                      onTap: ()=> openUploadPopup(context, "ZIP"),
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: FColors.secondary
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(CupertinoIcons.upload_circle_fill, size: 50, color: FColors.darkPrimary,),
                                Text("Upload ZIP", style: Theme.of(context).textTheme.headlineMedium
                                    ?.merge(TextStyle(color: FColors.darkPrimary)),),
                                Text("e.g. zip, rar etc.", style: Theme.of(context).textTheme.bodySmall
                                    ?.merge(TextStyle(color: FColors.neutralDarkGrey)),),
                                Text(""),
                                SizedBox(height: 8,)
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30,),

              Text("   Recently Added", style: Theme.of(context).textTheme.headlineMedium,),

              const SizedBox(height: 20,),

              SizedBox(
                height: 500,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: files.length,
                  itemBuilder: (context, index) {
                    final file = files[index];
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                          padding: FSizes.getPadding(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: FColors.neutralGrey,
                            image: DecorationImage(
                                image: AssetImage("${file['src']}")
                            )
                          ),
                        ),
                        // Image.asset("${file['src']}", height: 40, width: 60,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${file['name']}', style: Theme.of(context).textTheme.bodyLarge
                              ?.merge(const TextStyle(color: FColors.neutralDarkGrey)),),
                              Text('${file['time']}', style: Theme.of(context).textTheme.bodySmall
                                  ?.merge(const TextStyle(color: FColors.neutralDarkerGrey)),),
                            ],
                          ),
                        ),

                        const Icon(CupertinoIcons.ellipsis_vertical, size: 20,)
                      ],
                    );
                  },
                ),
              )


            ],
          ),
        ),
      ),
    );
  }
}
