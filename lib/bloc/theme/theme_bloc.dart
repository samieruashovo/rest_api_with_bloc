
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:rest_api_with_bloc/theme/app_theme.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<PostThemeEvent, PostThemeState> {
  ThemeBloc()
      : super(PostThemeState(
            themeData: AppThemes.appThemeData[AppTheme.lightTheme])) {
    on<PostThemeEvent>((event, emit) {
      emit(PostThemeState(themeData: AppThemes.appThemeData[event.appTheme]));
    });
  }
}
