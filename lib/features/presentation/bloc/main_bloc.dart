import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:snickz/features/data/datasources/local_data_source.dart';
import 'package:snickz/features/data/datasources/remote_data_source.dart';
import 'package:snickz/features/data/repositories/repository_impl.dart';
import 'package:snickz/features/domain/repositories/repository.dart';
import 'package:snickz/utils/app_constants.dart';

import '../../domain/entities/item_entity.dart';
import '../../domain/usecases/get_all_shoes.dart';

part 'main_event.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final GetAllShoesUseCase useCase = GetAllShoesUseCase(
      repositoryImpl:
          RepositoryImpl(remoteDataSourceImpl: RemoteDataSourceImpl()));
  final LocalDataSource? appSharedData = LocalDataSource();

  MainBloc() : super(GetShoesInitialState()) {
    on<GetAllShoesEvent>(_handleGetAllShoesEvent);
    on<SetCartItemsEvent>(_handleSetCartItemsEvent);
    on<GetCartItemsEvent>(_handleGetCartItemsEvent);
    on<ClearCartItemsEvent>(_handleClearCartItemsEvent);
  }

  Future<void> _handleGetAllShoesEvent(
      GetAllShoesEvent event, Emitter<MainState> emit) async {
    emit(GetShoesLoadingState());
    try {
      final result = await useCase();

      emit(result.fold((l) {
        return GetShoesFailedState();
      }, (r) {
        return GetShoesLoadedState(
            itemEntityList: r
                .map(
                  (item) => ItemEntity(
                    qty: 1,
                    title: item.name,
                    price: double.parse(item.price!),
                    description: item.description,
                    category: item.category,
                    imgUrl: item.image,
                  ),
                )
                .toList());
      }));
    } catch (e) {
      emit(GetShoesFailedState());
    }
  }

  Future<void> _handleSetCartItemsEvent(
      SetCartItemsEvent event, Emitter<MainState> emit) async {
    emit(SetCartItemsLoadingState());
    try {
      await appSharedData!.setCartItems(event.items);
      emit(SetCartItemsSuccessState());
    } catch (e) {
      print(e);
      emit(SetCartItemsFailedState());
    }
  }

  Future<void> _handleGetCartItemsEvent(
      GetCartItemsEvent event, Emitter<MainState> emit) async {
    emit(GetCartItemsLoadingState());
    try {
      final result = await appSharedData!.getCartItems();
      cartItemsList = result;

      emit(GetCartItemsLoadedState(itemEntityList: result));
    } catch (e) {
      print(e);
      emit(GetCartItemsFailedState());
    }
  }

  Future<void> _handleClearCartItemsEvent(
      ClearCartItemsEvent event, Emitter<MainState> emit) async {
    emit(ClearCartItemsLoadingState());
    try {
      await appSharedData!.clearCartItems();
      cartItemsList.clear();

      emit(ClearCartItemsLoadedState());
    } catch (e) {
      print(e);
      emit(ClearCartItemsFailedState());
    }
  }
}
