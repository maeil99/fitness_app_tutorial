import 'package:fitness_app_tutorial/screen/home/bloc/home_bloc.dart';
import 'package:fitness_app_tutorial/screen/home/model/breakfast_model.dart';
import 'package:fitness_app_tutorial/screen/home/model/category_model.dart';
import 'package:fitness_app_tutorial/screen/home/model/diet_model.dart';
import 'package:fitness_app_tutorial/screen/home/model/popular_model.dart';
import 'package:fitness_app_tutorial/utils/constant/path_route.dart';
import 'package:fitness_app_tutorial/utils/widget/loader.dart';
import 'package:fitness_app_tutorial/utils/widget/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:logger/web.dart';

part '../home_helper.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<DietModel> diets = DietModel.getDiets();

  late final List<PopularDietsModel> popularDiets;

  final List<Breakfast> breakfastList = Breakfast.getAllBreakfast();

  final TextEditingController searchController = TextEditingController()
    ..text = "";

  List<CategoryModel> displayedCategories = [];
  List<Breakfast> displayedBreakfast = [];

  late final HomeBloc _homeBloc;

  @override
  void initState() {
    _homeBloc = HomeBloc()..add(InitialSetup());

    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context),
      backgroundColor: Colors.white,
      body: BlocConsumer<HomeBloc, HomeState>(
        bloc: _homeBloc,
        listener: (context, state) async {
          if (state is SuccessInitialSetup) {
            displayedCategories.addAll(state.categoryList);
            displayedBreakfast.addAll(state.breakfastList);
            popularDiets = [];
            popularDiets.addAll(state.popularMealList);
            showSnackBar(context, "Success fetch data");
          }
        },
        builder: (context, state) {
          if (state is SuccessInitialSetup) {
            return CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _SliverAppBarDelegate(
                    minHeight: 130,
                    maxHeight: 130,
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      child: searchField(
                        searchController,
                        (searchText) async {
                          setState(() {
                            displayedBreakfast =
                                state.breakfastList.where((breakfast) {
                              return breakfast.name
                                  .toLowerCase()
                                  .contains(searchText!.toLowerCase());
                            }).toList();
                            displayedCategories =
                                state.categoryList.where((category) {
                              return category.name
                                  .toLowerCase()
                                  .contains(searchText!.toLowerCase());
                            }).toList();
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: Gap(40)),
                SliverToBoxAdapter(
                  child: categoriesSection(displayedCategories),
                ),
                const SliverToBoxAdapter(child: Gap(40)),
                SliverToBoxAdapter(child: dietSection(diets)),
                const SliverToBoxAdapter(child: Gap(40)),
                // popularDietSection(popularDiets),
                // const Gap(40),
                SliverToBoxAdapter(
                  child: allBreakfastSection(displayedBreakfast),
                ),
                const SliverToBoxAdapter(child: Gap(40)),
              ],
            );
          }
          return const Loader();
        },
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
