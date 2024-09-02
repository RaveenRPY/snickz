part of 'main_bloc.dart';

abstract class MainEvent {}

class GetAllShoesEvent extends MainEvent {}

class GetCartItemsEvent extends MainEvent {}

class SetCartItemsEvent extends MainEvent {
  final List<ItemEntity> items;

  SetCartItemsEvent({required this.items});
}

class ClearCartItemsEvent extends MainEvent {}
