// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i7;

import '../core/data/data_sources/cache_helper.dart' as _i14;
import '../core/data/data_sources/database.dart' as _i5;
import '../features/bottom_navbar/data/repositories/bottom_navbar_repository_impl.dart'
    as _i13;
import '../features/bottom_navbar/domain/repositories/bottom_navbar_repository.dart'
    as _i12;
import '../features/bottom_navbar/domain/use_cases/get_exchanges_history_use_case.dart'
    as _i15;
import '../features/bottom_navbar/domain/use_cases/get_rewards_use_case.dart'
    as _i16;
import '../features/bottom_navbar/domain/use_cases/get_user_data_use_case.dart'
    as _i17;
import '../features/bottom_navbar/domain/use_cases/set_exchange_history_use_case.dart'
    as _i19;
import '../features/bottom_navbar/domain/use_cases/set_steps_and_points_use_case.dart'
    as _i20;
import '../features/bottom_navbar/presentation/manager/exchanges_history/exchanges_history_cubit.dart'
    as _i24;
import '../features/bottom_navbar/presentation/manager/home/home_cubit.dart'
    as _i25;
import '../features/bottom_navbar/presentation/manager/rewards/rewards_cubit.dart'
    as _i18;
import '../features/intro/data/data_sources/auth_local_data_source.dart' as _i8;
import '../features/intro/data/data_sources/auth_remote_data_source.dart'
    as _i4;
import '../features/intro/data/repositories/auth_repository_impl.dart' as _i10;
import '../features/intro/data/services/auth_services.dart' as _i3;
import '../features/intro/domain/repositories/auth_repository.dart' as _i9;
import '../features/intro/domain/use_cases/auth_status_use_case.dart' as _i11;
import '../features/intro/domain/use_cases/sign_in_anonymously_use_case.dart'
    as _i21;
import '../features/intro/presentation/manager/auth_actions/auth_cubit.dart'
    as _i22;
import '../features/intro/presentation/manager/auth_status/auth_status_cubit.dart'
    as _i23;
import '../utilities/locale/cubit/locale_cubit.dart' as _i6;
import 'app_module.dart' as _i26; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final appModule = _$AppModule();
  gh.singleton<_i3.AuthBase>(_i3.Auth());
  gh.singleton<_i4.AuthRemoteDataSource>(
      _i4.AuthRemoteDataSourceImpl(authBase: get<_i3.AuthBase>()));
  gh.singleton<_i5.Database>(_i5.FireStoreDatabase());
  gh.singleton<_i6.LocaleCubit>(_i6.LocaleCubit());
  await gh.factoryAsync<_i7.SharedPreferences>(() => appModule.prefs,
      preResolve: true);
  gh.singleton<_i8.AuthLocalDataSource>(
      _i8.AuthLocalDataSourceImpl(get<_i7.SharedPreferences>()));
  gh.singleton<_i9.AuthRepository>(_i10.AuthRepositoryImpl(
      get<_i4.AuthRemoteDataSource>(),
      get<_i8.AuthLocalDataSource>(),
      get<_i5.Database>()));
  gh.factory<_i11.AuthStatusUseCase>(
      () => _i11.AuthStatusUseCase(get<_i9.AuthRepository>()));
  gh.singleton<_i12.BottomNavbarRepository>(_i13.BottomNavbarRepositoryImpl(
      get<_i5.Database>(), get<_i8.AuthLocalDataSource>()));
  gh.singleton<_i14.CacheHelper>(
      _i14.CacheHelperImpl(get<_i7.SharedPreferences>()));
  gh.factory<_i15.GetHistoryExchangesUseCase>(() =>
      _i15.GetHistoryExchangesUseCase(get<_i12.BottomNavbarRepository>()));
  gh.factory<_i16.GetRewardsUseCase>(
      () => _i16.GetRewardsUseCase(get<_i12.BottomNavbarRepository>()));
  gh.factory<_i17.GetUserDataUseCase>(
      () => _i17.GetUserDataUseCase(get<_i12.BottomNavbarRepository>()));
  gh.factory<_i18.RewardsCubit>(
      () => _i18.RewardsCubit(get<_i16.GetRewardsUseCase>()));
  gh.factory<_i19.SetExchangeHistoryUseCase>(
      () => _i19.SetExchangeHistoryUseCase(get<_i12.BottomNavbarRepository>()));
  gh.factory<_i20.SetStepsAndPointsUseCase>(
      () => _i20.SetStepsAndPointsUseCase(get<_i12.BottomNavbarRepository>()));
  gh.factory<_i21.SignInAnonymouslyUseCase>(() =>
      _i21.SignInAnonymouslyUseCase(authRepository: get<_i9.AuthRepository>()));
  gh.singleton<_i22.AuthCubit>(
      _i22.AuthCubit(get<_i21.SignInAnonymouslyUseCase>()));
  gh.singleton<_i23.AuthStatusCubit>(
      _i23.AuthStatusCubit(get<_i11.AuthStatusUseCase>()));
  gh.factory<_i24.ExchangesHistoryCubit>(
      () => _i24.ExchangesHistoryCubit(get<_i15.GetHistoryExchangesUseCase>()));
  gh.factory<_i25.HomeCubit>(() => _i25.HomeCubit(
      get<_i19.SetExchangeHistoryUseCase>(),
      get<_i20.SetStepsAndPointsUseCase>(),
      get<_i17.GetUserDataUseCase>()));
  return get;
}

class _$AppModule extends _i26.AppModule {}
