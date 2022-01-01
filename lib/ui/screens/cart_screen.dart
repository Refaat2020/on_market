import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_market/constant/k_colors.dart';
import 'package:on_market/cubit/cart_cubit.dart';
import 'package:on_market/ui/widgets/big_button.dart';
import 'package:on_market/ui/widgets/product_card_widget.dart';
import 'package:provider/src/provider.dart';

class CartScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.watch<CartCubit>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text("Cart",style: TextStyle(color: kBlueLite,fontSize: 22.sp,fontWeight: FontWeight.w800),),
      ),
      body: ListView(
        children: [
          Divider(
            height: 20.h,
            color: Colors.black26,
            thickness: 1.2,
            indent: 1,
            endIndent: 1,
          ),
          BlocBuilder<CartCubit,CartState>(
              builder: (context, state) {
                if (state is CartEmpty) {
                  return Center(
                    child: Text("There are no items in cart yet",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16.sp,color: kBlueLite),),
                  );
                }else if (state is CartLoading) {
                  return const Center(child: CircularProgressIndicator(),);
                }else if (state is CartAddedOrRemoved) {
                  return Column(
                    children: [
                      ListView.separated(
                        itemCount: state.cart.length,
                        shrinkWrap: true,
                        padding:EdgeInsets.only(right: 20.w,left: 20.w) ,
                        separatorBuilder: (context, index) => SizedBox(height: 10.h,),
                        itemBuilder: (context, index) {
                          return  Dismissible(
                            key: Key(state.cart[index].toString()),
                              background: Container(color: Colors.red),
                              onDismissed: (direction) {
                                ScaffoldMessenger
                                    .of(context)
                                    .showSnackBar(SnackBar(content: Text("Item ${state.cart[index].name} Deleted",style: TextStyle(color: Colors.white,fontSize: 13.sp,fontWeight: FontWeight.w700),),backgroundColor: Colors.black,elevation: 3,));
                                cartCubit.removeFromCart(index);
                              },
                              child: ProductCardWidget(name: state.cart[index].name,description:state.cart[index].description ,qty: state.cart[index].qty,price: state.cart[index].price,index: index,));
                        },
                          ),
                      SizedBox(height: 10.h,),
                      Divider(
                        height: 20.h,
                        color: Colors.black26,
                        thickness: 1.2,
                        indent: 1,
                        endIndent: 1,
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left:10.w ,bottom: 30.h),
                        child: Row(
                          children: [

                          Text("Total:",style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w600,color: kBlack),),
                          const Spacer(),
                          Text("500 LE",style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w600,color: kBlueLite),),
                          SizedBox(width: 10.w,),


                        ],),
                      ),
                      BigButton(height: 40.h, width: ScreenUtil().screenWidth/1.3, name: "Check Out", onTap: (){
                        cartCubit.checkOut();
                        ScaffoldMessenger
                            .of(context)
                            .showSnackBar(SnackBar(content: Text("Order is getting placed",style: TextStyle(color: Colors.white,fontSize: 13.sp,fontWeight: FontWeight.w700),),backgroundColor: Colors.black,elevation: 3,));
                      }, textColor: Colors.white, containerColor: kBlueLite, borderColor: kBlueLite),
                    ],
                  );
                }
                return Center(
                  child: Text("There are no items in cart yet",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16.sp,color: kBlueLite),),
                );
              },
          ),

        ],
      ),
    );
  }
}
