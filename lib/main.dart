import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movie_app/cubits/add_movie_cubit/add_movie_cubit.dart';
import 'package:movie_app/cubits/category_movie_cubit/category_movie_cubit.dart';
import 'package:movie_app/cubits/cubit/search_movie_cubit.dart';
import 'package:movie_app/cubits/movie_cubit/movie_cubit.dart';
import 'package:movie_app/cubits/movie_detail_cubit/movie_detail_cubit.dart';
import 'package:movie_app/firebase_options.dart';

import 'package:movie_app/models/movie_detail.dart';
import 'package:movie_app/views/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(MovieDetailAdapter());
  await Hive.openBox<MovieDetail>('movieBox');
  runApp(
    const MovieApp(),
  );
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieCubit>(
          create: (_) => MovieCubit(),
        ),
        BlocProvider<MovieDetailCubit>(
          create: (_) => MovieDetailCubit(),
        ),
        BlocProvider<AddMovieCubit>(
          create: (_) => AddMovieCubit(),
        ),
        BlocProvider<CategoryMovieCubit>(
          create: (_) => CategoryMovieCubit(),
        ),
        BlocProvider<SearchMovieCubit>(
          create: (_) => SearchMovieCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie App',
        theme: ThemeData(brightness: Brightness.dark),
        home: const SplashView(),
      ),
    );
  }
}
