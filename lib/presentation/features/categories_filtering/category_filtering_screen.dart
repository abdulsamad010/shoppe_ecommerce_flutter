
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/bloc/app_bloc/app_bloc.dart';
import '../../core/bloc/app_bloc/app_event.dart';
import '../../core/bloc/app_bloc/app_state.dart';

import '../../core/colors/app_colors.dart';
import '../shop/shop_screen.dart';

class CategoriesFilteringScreen extends StatefulWidget {
  const CategoriesFilteringScreen({super.key});

  @override
  State<CategoriesFilteringScreen> createState() =>
      _CategoriesFilteringScreenState();
}

class _CategoriesFilteringScreenState
    extends State<CategoriesFilteringScreen> {
  @override
  void initState() {
    super.initState();

    context.read<AppBloc>().add(
      UpdateFilters(
        filters: {
          'category': '',
          'subCategory': '',
          'gender': 'All',
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 16, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'All Categories',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    color: Colors.white,
                    child: Column(
                      children: [
                        const SizedBox(height: 8),


                        Row(
                          children: [
                            for (String gender in [
                              'All',
                              'Female',
                              'Male',
                            ])
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {

                                    Map<String, String> filters =
                                    Map.from(state.filters);

                                    filters['gender'] = gender;

                                    context.read<AppBloc>().add(
                                      UpdateFilters(filters: filters),
                                    );
                                  },
                                  child: Container(

                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 3,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color:

                                      state.filters['gender'] == gender
                                          ? const Color(0xffe9edff)
                                          : const Color(0xfff8f8f8),
                                      border: Border.all(
                                        color:
                                        state.filters['gender'] == gender
                                            ? const Color(0xff4169ff)
                                            : Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),

                                    child: Text(
                                      gender,
                                      textAlign: TextAlign.center,

                                      style: TextStyle(
                                        fontSize: 12,
                                        color:

                                        state.filters['gender'] == gender
                                            ? const Color(0xff4169ff)
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),

                        const SizedBox(height: 14),

                        // Categories and subcategories
                        Expanded(
                          child: ListView(
                            children: [
                              for (int i = 0;
                              i < state.categories.length;
                              i++)
                                Container(
                                  margin: const EdgeInsets.only(bottom: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.white,

                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.08),
                                        blurRadius: 4,

                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: ExpansionTile(
                                    tilePadding: const EdgeInsets.symmetric(
                                      horizontal: 4,

                                    ),
                                    childrenPadding:
                                    const EdgeInsets.fromLTRB(0, 0, 0, 8),

                                    leading: ClipRRect(

                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.network(
                                        state.categories[i]['img1'] ?? '',
                                        width: 32,

                                        height: 32,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            width: 32,
                                            height: 32,

                                            color: Colors.grey.shade200,
                                            child: const Icon(
                                              Icons.image_not_supported,
                                              size: 18,
                                            ),
                                          );
                                        },
                                      ),
                                    ),

                                    title: Text(
                                      state.categories[i]['name'] ?? '',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),

                                    iconColor: Colors.black,
                                    collapsedIconColor: Colors.black,

                                    onExpansionChanged: (expanded) {
                                      if (expanded) {
                                        Map<String, String> filters =
                                        Map.from(state.filters);



                                        filters['category'] =
                                            state.categories[i]['name'] ?? '';
                                        filters['subCategory'] = '';


                                        context.read<AppBloc>().add(
                                          UpdateFilters(filters: filters),
                                        );
                                      }
                                    },

                                    children: [
                                      Builder(
                                        builder: (context) {
                                          String categoryName =
                                              state.categories[i]['name'] ??
                                                  '';

                                          List<String> items = state
                                              .subCategories[
                                          categoryName] ??
                                              [];

                                          if (items.isEmpty) {
                                            return const Padding(
                                              padding: EdgeInsets.all(12),
                                              child: Text(
                                                'No subcategories available',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            );
                                          }

                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 4,
                                            ),
                                            child: GridView.builder(
                                              shrinkWrap: true,
                                              physics:

                                               NeverScrollableScrollPhysics(),
                                              gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                childAspectRatio: 3.2,
                                                crossAxisSpacing: 6,
                                                mainAxisSpacing: 5,
                                              ),
                                              itemCount: items.length,
                                              itemBuilder: (context, index) {
                                                String subCategory =
                                                items[index];

                                                bool selected =
                                                    state.filters['category'] ==
                                                        categoryName &&
                                                        state.filters[
                                                        'subCategory'] ==
                                                            subCategory;

                                                return GestureDetector(
                                                  onTap: () {


                                                    Map<String, String> filters =
                                                    Map.from(state.filters);

                                                    filters['category'] =
                                                        categoryName;
                                                    filters['subCategory'] =
                                                        subCategory;

                                                    context.read<AppBloc>().add(
                                                      UpdateFilters(
                                                        filters: filters,
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color: selected
                                                          ? const Color(
                                                        0xffe9edff,
                                                      )
                                                          : Colors.white,
                                                      border: Border.all(
                                                        color: selected
                                                            ? const Color(
                                                          0xff4169ff,
                                                        )
                                                            : const Color(
                                                          0xffffdddd,
                                                        ),
                                                      ),

                                                      borderRadius:
                                                      BorderRadius.circular(
                                                        7,
                                                      ),
                                                    ),
                                                    child: Text(
                                                      subCategory,
                                                      textAlign:
                                                      TextAlign.center,
                                                      style: const TextStyle(
                                                        fontSize: 11,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),



                Padding(
                  padding:  EdgeInsets.fromLTRB(12, 10, 12, 12),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:  Color(0xff4169ff),
                        foregroundColor: Colors.white,
                        padding:  EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child:  Text(
                        'Apply Filters',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
