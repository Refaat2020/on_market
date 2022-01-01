part of 'products_cubit.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();
}

class ProductsInitial extends ProductsState {
  @override
  List<Object> get props => [];
}
class ProductsLoading extends ProductsState {
  @override
  List<Object> get props => [];
}

class ProductsFetched extends ProductsState {
 final  List<QueryDocumentSnapshot> products ;

 const ProductsFetched({required this.products});

  @override
  List<Object> get props => [];
}
