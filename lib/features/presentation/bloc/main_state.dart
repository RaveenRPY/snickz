part of 'main_bloc.dart';

abstract class MainState {}

class GetShoesInitialState extends MainState {}

class GetShoesLoadingState extends MainState {}

class GetShoesFailedState extends MainState {}

class GetShoesLoadedState extends MainState {
  final List<ItemEntity>? itemEntityList;

  GetShoesLoadedState({this.itemEntityList});
}

class GetCartItemsLoadingState extends MainState {}

class GetCartItemsFailedState extends MainState {}

class GetCartItemsLoadedState extends MainState {
  final List<ItemEntity>? itemEntityList;

  GetCartItemsLoadedState({this.itemEntityList});
}

class SetCartItemsLoadingState extends MainState {}

class SetCartItemsFailedState extends MainState {}

class SetCartItemsLoadedState extends MainState {}

class ClearCartItemsLoadingState extends MainState {}

class ClearCartItemsFailedState extends MainState {}

class ClearCartItemsLoadedState extends MainState {}
