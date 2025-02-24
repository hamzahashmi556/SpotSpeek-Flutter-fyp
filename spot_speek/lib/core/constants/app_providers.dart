import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:spot_speek/data/datasources/auth_data_source.dart';
import 'package:spot_speek/data/datasources/post_data_source.dart';
import 'package:spot_speek/data/datasources/storage_data_source.dart';
import 'package:spot_speek/data/datasources/user_firestore_datasource.dart';
import 'package:spot_speek/data/repositories/auth_repository_impl.dart';
import 'package:spot_speek/data/repositories/post_repository_impl.dart';
import 'package:spot_speek/data/repositories/storage_repository_impl.dart';
import 'package:spot_speek/data/repositories/user_repository_impl.dart';
import 'package:spot_speek/presentation/viewmodels/auth_viewmodel.dart';
import 'package:spot_speek/presentation/viewmodels/home_viewmodel.dart';
import 'package:spot_speek/presentation/viewmodels/profile_viewmodel.dart';
import 'package:spot_speek/presentation/viewmodels/signup_viewmodel.dart';

class AppProviders {
  static List<SingleChildWidget> providers = [
    // Data Source
    Provider<AuthDataSource>(create: (context) => AuthDataSource()),
    Provider<PostDataSource>(create: (context) => PostDataSource()),
    Provider<UserFirestoreDataSource>(
        create: (context) => UserFirestoreDataSource()),
    Provider<StorageDataSource>(
      create: (context) => StorageDataSource(),
    ),

    // Repositories
    Provider<AuthRepositoryImpl>(
      create: (context) => AuthRepositoryImpl(context.read<AuthDataSource>()),
    ),
    Provider<PostRepositoryImpl>(
      create: (context) => PostRepositoryImpl(context.read<PostDataSource>()),
    ),
    Provider<UserRepositoryImpl>(
      create: (context) => UserRepositoryImpl(
          userDataSource: context.read<UserFirestoreDataSource>()),
    ),
    Provider<StorageRepositoryImpl>(
        create: (context) =>
            StorageRepositoryImpl(context.read<StorageDataSource>())),

    // ViewModels
    ChangeNotifierProvider<SignUpViewModel>(
      create: (context) => SignUpViewModel(context.read<AuthRepositoryImpl>(),
          context.read<UserRepositoryImpl>()),
    ),
    ChangeNotifierProvider<AuthViewModel>(
      create: (context) => AuthViewModel(
        context.read<AuthRepositoryImpl>(),
      ),
    ),
    ChangeNotifierProvider<ProfileViewModel>(
      create: (context) => ProfileViewModel(context.read<UserRepositoryImpl>(),
          context.read<StorageRepositoryImpl>()),
    ),
    ChangeNotifierProvider<HomeViewModel>(
      create: (context) => HomeViewModel(context.read<PostRepositoryImpl>(),
          context.read<UserRepositoryImpl>()),
    )
  ];
}
