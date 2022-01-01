import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:on_market/model/cart_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  List<CartModel>cart = [];

  Future addToCart(CartModel cartModel)async{
  emit(CartLoading());
  cart.add(cartModel);
  emit(CartAddedOrRemoved(cart: cart));
  }

  Future removeFromCart(int index)async{
    emit(CartLoading());
    cart.removeAt(index);
    emit(CartAddedOrRemoved(cart: cart));
    if (cart.length ==0) {
      emit(CartEmpty());
    }
  }

  void checkOut(){
    emit(CartLoading());
    cart= [];
    emit(CartEmpty());

  }
}
