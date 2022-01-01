part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState();
}

class CartInitial extends CartState {
  @override
  List<Object> get props => [];
}

class CartLoading extends CartState {
  @override
  List<Object> get props => [];
}

class CartAddedOrRemoved extends CartState {
 final  List<CartModel>cart;

  CartAddedOrRemoved({required this.cart});

  @override
  List<Object> get props => [];
}

class CartEmpty extends CartState {
  @override
  List<Object> get props => [];
}
