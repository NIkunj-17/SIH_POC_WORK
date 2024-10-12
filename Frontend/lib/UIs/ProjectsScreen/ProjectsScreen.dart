import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redact/utils/constants/colors.dart';
import 'package:redact/utils/constants/sizes.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  final TextEditingController _searchQuery = TextEditingController();

  getSearchResult(String query){
    null;
  }

  Gradient gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.blue,
      Colors.red,
    ],
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:  Align(
          alignment: Alignment.center,
        child: Text("PROJECTS", style: Theme.of(context).textTheme.titleLarge
            ?.merge(TextStyle(color: FColors.primary)),)
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TextField(
                controller: _searchQuery,
                onChanged: (value){
                  getSearchResult(value);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(10),
                  prefixIcon: const Icon(CupertinoIcons.search, color: FColors.primary,),
                  hintStyle: Theme.of(context).textTheme.labelMedium,
                  hintText: 'Search projects',
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

              const SizedBox(height: 30,),

              Text("Projects", style: Theme.of(context).textTheme.headlineMedium
                ?.merge(TextStyle(color: FColors.primary)),),

              const SizedBox(height: 20,),

              Container(
                padding: FSizes.getPadding(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: FColors.primaryBackground
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(child: Icon(CupertinoIcons.folder, 
                          color: FColors.neutralDarkGrey,),backgroundColor: Colors.white,),
                        SizedBox(width: 8,),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Hospital Data Redaction Project", style: Theme.of(context).textTheme.headlineSmall,),
                              Text("Personal Information Redaction", style: Theme.of(context).textTheme.bodySmall,)
                            ],
                          ),
                        ),
                        Icon(CupertinoIcons.ellipsis_vertical, size: 20,)
                      ],
                    ),

                    SizedBox(height: 15,),

                    Row(
                      children: [
                        Container(
                          padding: FSizes.getPadding(6),
                          decoration: BoxDecoration(
                            color: FColors.accent,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text("• 269 total files", style: Theme.of(context).textTheme.bodySmall
                            ?.merge(TextStyle(color: FColors.neutralDarkGrey)),),
                        ),

                        SizedBox(width: 10,),

                        Container(
                          padding: FSizes.getPadding(6),
                          decoration: BoxDecoration(
                              color: FColors.success2,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text("• 169 files redacted", style: Theme.of(context).textTheme.bodySmall
                              ?.merge(TextStyle(color: FColors.neutralDarkGrey)),),
                        )
                      ],
                    ),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
