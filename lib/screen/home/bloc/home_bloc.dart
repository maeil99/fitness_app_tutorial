import 'package:fitness_app_tutorial/screen/home/model/breakfast_model.dart';
import 'package:fitness_app_tutorial/screen/home/model/category_model.dart';
import 'package:fitness_app_tutorial/screen/home/model/popular_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<InitialSetup>(_onInitialSetup);
  }

  Future<void> _onInitialSetup(
    HomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(LoadingInitialSetup());

      final cateList = CategoryModel.getCategories();
      final List<PopularDietsModel> popularDiets =
          PopularDietsModel.getPopularDiets();

      final List<Breakfast> breakfastList = Breakfast.getAllBreakfast();

      if (cateList.isEmpty || breakfastList.isEmpty || popularDiets.isEmpty) {
        emit(FailedInitialSetup());
      }
      emit(SuccessInitialSetup(
        categoryList: cateList,
        breakfastList: breakfastList,
        popularMealList: popularDiets,
      ));
    } catch (e) {
      emit(FailedInitialSetup());
    }
  }
}
