class Breakfast {
  String name;
  String iconPath;
  String level;
  String duration;
  String calorie;
  bool boxIsSelected;

  Breakfast({
    required this.name,
    required this.iconPath,
    required this.level,
    required this.duration,
    required this.calorie,
    required this.boxIsSelected,
  });

  @override
  String toString() {
    return "Breakfast{ name: $name, iconPath: $iconPath, level: $level, duration: $duration, calorie: $calorie, boxIsSelected: $boxIsSelected }";
  }

  static List<Breakfast> getAllBreakfast() {
    List<Breakfast> breakfastList = [];

    breakfastList.add(
      Breakfast(
        name: 'Blueberry Pancake',
        iconPath: 'assets/icons/blueberry-pancake.svg',
        level: 'Medium',
        duration: '30mins',
        calorie: '230kCal',
        boxIsSelected: true,
      ),
    );

    breakfastList.add(
      Breakfast(
        name: 'Salmon Nigiri',
        iconPath: 'assets/icons/salmon-nigiri.svg',
        level: 'Easy',
        duration: '20mins',
        calorie: '120kCal',
        boxIsSelected: false,
      ),
    );

    breakfastList.add(
      Breakfast(
        name: 'Honey Pancake',
        iconPath: 'assets/icons/honey-pancakes.svg',
        level: 'Easy',
        duration: '30mins',
        calorie: '180kCal',
        boxIsSelected: false,
      ),
    );

    breakfastList.add(
      Breakfast(
        name: 'Canai Bread',
        iconPath: 'assets/icons/canai-bread.svg',
        level: 'Easy',
        duration: '20mins',
        calorie: '230kCal',
        boxIsSelected: false,
      ),
    );

    return breakfastList;
  }
}
