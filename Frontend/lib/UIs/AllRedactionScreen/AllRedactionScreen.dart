import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redact/utils/constants/colors.dart';
import 'package:redact/utils/constants/sizes.dart';

class AllRedactionScreen extends StatefulWidget {
  const AllRedactionScreen({super.key});

  @override
  State<AllRedactionScreen> createState() => _AllRedactionScreenState();
}

class _AllRedactionScreenState extends State<AllRedactionScreen> {
  final TextEditingController _searchQuery = TextEditingController();

  getSearchResult(String query){
    null;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:  Align(
            alignment: Alignment.center,
            child: Text("REDACTION LOG", style: Theme.of(context).textTheme.titleLarge
                ?.merge(const TextStyle(color: FColors.primary)),)
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
                  hintText: 'Search redacted files only ',
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

              Text("Redacted Files", style: Theme.of(context).textTheme.headlineMedium
                  ?.merge(const TextStyle(color: FColors.primary)),),

              const SizedBox(height: 20,),

              Container(
                padding: FSizes.getPadding(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: FColors.primaryBackground2
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(backgroundColor: Colors.white,child: Image.asset("assets/images/Icons/pdf.png"),),
                        const SizedBox(width: 8,),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Resume_Redacted.pdf", style: Theme.of(context).textTheme.bodyLarge,),
                              Text("Last Modified : 09-09-2024 - 10:37 AM ", style: Theme.of(context).textTheme.bodySmall,)
                            ],
                          ),
                        ),
                        const Icon(CupertinoIcons.ellipsis_vertical, size: 20,)
                      ],
                    ),

                    const SizedBox(height: 15,),

                    Row(
                      children: [

                        Container(
                          padding: FSizes.getPadding(6),
                          decoration: BoxDecoration(
                              color: FColors.neutralGrey,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text("• 19 Entities Replaced", style: Theme.of(context).textTheme.bodySmall
                              ?.merge(const TextStyle(color: FColors.neutralDarkGrey)),),
                        ),

                        const SizedBox(width: 10,),

                        Container(
                          padding: FSizes.getPadding(6),
                          decoration: BoxDecoration(
                              color: FColors.accent,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text("• Level 2", style: Theme.of(context).textTheme.bodySmall
                              ?.merge(const TextStyle(color: FColors.neutralDarkGrey)),),
                        ),

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
