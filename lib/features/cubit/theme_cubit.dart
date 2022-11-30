import 'package:biz_alert/constants/style.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeLight(lightTheme));

  void goDark() => emit(
        ThemeDark(darkTheme),
      );

  void goLight() => emit(
        ThemeLight(lightTheme),
      );
}
