import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_supabase_starter/app.dart';
import 'package:flutter_clean_supabase_starter/core/injector/dependency_injector.dart';
import 'package:flutter_clean_supabase_starter/core/utils/bloc_observer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await initDependencies();
  Bloc.observer = AppBlocObserver();
  runApp(const App());
}
