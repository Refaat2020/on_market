import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());
  List<QueryDocumentSnapshot> products = [];

  FirebaseFirestore? fireStore;
  initialize() {
    fireStore = FirebaseFirestore.instance;
    getProducts();
  }

  Future<List> getProducts() async {
    try {
      emit(ProductsLoading());
      fireStore
          ?.collection('source')
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          products = querySnapshot.docs.toList();
          emit(ProductsFetched(products: products));
        }
      });
    } catch (e) {
      print(e);
    }
    return products;
  }


}
