part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class LoadingInitialSetup extends HomeState {}

final class SuccessInitialSetup extends HomeState {
  final List<CategoryModel> categoryList;
  final List<Breakfast> breakfastList;
  final List<PopularDietsModel> popularMealList;

  SuccessInitialSetup({
    required this.categoryList,
    required this.breakfastList,
    required this.popularMealList,
  });
}

final class FailedInitialSetup extends HomeState {}
