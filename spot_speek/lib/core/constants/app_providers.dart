import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:spot_speek/data/datasources/auth_data_source.dart';
import 'package:spot_speek/data/datasources/post_data_source.dart';
import 'package:spot_speek/data/datasources/user_firestore_datasource.dart';
import 'package:spot_speek/data/repositories/auth_repository.dart';
import 'package:spot_speek/data/repositories/post_repository.dart';
import 'package:spot_speek/data/repositories/user_repository.dart';
import 'package:spot_speek/presentation/viewmodels/auth_viewmodel.dart';
import 'package:spot_speek/presentation/viewmodels/home_viewmodel.dart';
import 'package:spot_speek/presentation/viewmodels/post_viewmodel.dart';
import 'package:spot_speek/presentation/viewmodels/signup_viewmodel.dart';

class AppProviders {
  static List<SingleChildWidget> providers = [
    // Data Source
    Provider<AuthDataSource>(create: (context) => AuthDataSource()),
    Provider<PostDataSource>(create: (context) => PostDataSource()),
    Provider<UserFirestoreDataSource>(
        create: (context) => UserFirestoreDataSource()),

    // Repositories
    Provider<AuthRepository>(
      create: (context) => AuthRepository(context.read<AuthDataSource>()),
    ),
    Provider<PostRepository>(
      create: (context) => PostRepository(context.read<PostDataSource>()),
    ),
    Provider<UserRepository>(
      create: (context) =>
          UserRepository(context.read<UserFirestoreDataSource>()),
    ),

    // ViewModels
    ChangeNotifierProvider<SignUpViewModel>(
      create: (context) => SignUpViewModel(
          context.read<AuthRepository>(), context.read<UserRepository>()),
    ),
    ChangeNotifierProvider<AuthViewModel>(
      create: (context) => AuthViewModel(
        context.read<AuthRepository>(),
      ),
    ),
    ChangeNotifierProvider<PostViewModel>(
      create: (context) => PostViewModel(context.read<PostRepository>()),
    ),
    ChangeNotifierProvider<HomeViewModel>(
      create: (context) => HomeViewModel(context.read<PostRepository>()),
    )
  ];
}
