part of 'theme_cubit.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();
}

class ThemeLight extends ThemeState {
  final ThemeData themeData;

  const ThemeLight(this.themeData);
  @override
  List<Object?> get props => [];
}

class ThemeDark extends ThemeState {
  final ThemeData themeData;

  const ThemeDark(this.themeData);
  @override
  List<Object?> get props => [];
}
