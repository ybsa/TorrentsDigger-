part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {}

class LoadTheme extends ThemeEvent {}

class ChangeTheme extends ThemeEvent {
  final AppTheme theme;
  ChangeTheme(this.theme);
}
