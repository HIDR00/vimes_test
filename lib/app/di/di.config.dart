// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:base/app/my_app/bloc/app_bloc.dart' as _i283;
import 'package:base/app/navigation/routers/app_router.dart' as _i591;
import 'package:base/app/ui/detail/bloc/detail_bloc.dart' as _i1058;
import 'package:base/app/ui/edit/bloc/edit_bloc.dart' as _i340;
import 'package:base/app/ui/home/bloc/home.dart' as _i583;
import 'package:base/app/ui/home/bloc/home_bloc.dart' as _i229;
import 'package:base/data/data.dart' as _i712;
import 'package:base/data/src/repository/repository_impl.dart' as _i827;
import 'package:base/data/src/repository/source/api/api_service.dart' as _i749;
import 'package:base/data/src/repository/source/api/client/none_auth_app_server_api_client.dart'
    as _i708;
import 'package:base/data/src/service/import_receipt_firestore_service.dart'
    as _i890;
import 'package:base/domain/domain.dart' as _i636;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i591.AppRouter>(() => _i591.AppRouter());
    gh.lazySingleton<_i708.NoneAuthAppServerApiClient>(
        () => _i708.NoneAuthAppServerApiClient());
    gh.lazySingleton<_i890.ImportReceiptFirestoreService>(
        () => _i890.ImportReceiptFirestoreService());
    gh.lazySingleton<_i749.ApiService>(
        () => _i749.ApiService(gh<_i708.NoneAuthAppServerApiClient>()));
    gh.lazySingleton<_i636.Repository>(() => _i827.RepositoryImpl(
          gh<_i712.ApiService>(),
          gh<_i712.ImportReceiptFirestoreService>(),
        ));
    gh.factory<_i340.EditBloc>(() => _i340.EditBloc(gh<_i636.Repository>()));
    gh.factory<_i283.AppBloc>(() => _i283.AppBloc(gh<_i636.Repository>()));
    gh.factory<_i229.HomeBloc>(() => _i229.HomeBloc(gh<_i583.Repository>()));
    gh.factory<_i1058.DetailBloc>(
        () => _i1058.DetailBloc(gh<_i636.Repository>()));
    return this;
  }
}
