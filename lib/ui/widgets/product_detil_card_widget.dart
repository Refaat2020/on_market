import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_market/constant/k_colors.dart';
import 'package:on_market/cubit/cart_cubit.dart';
import 'package:on_market/model/cart_model.dart';

import 'big_button.dart';

class ProductDetilCardWidget extends StatefulWidget {

  String image;
  String name;
  String description;
  int qty;
  String price;
  String discount;

  ProductDetilCardWidget({required this.image,required this.name,required this.description,required this.qty,required this.price,required this.discount});
  @override
  State<ProductDetilCardWidget> createState() => _ProductDetilCardWidgetState();
}

class _ProductDetilCardWidgetState extends State<ProductDetilCardWidget> {
  @override
  Widget build(BuildContext context) {
    final cartCubit = context.watch<CartCubit>();
    return Scaffold(
      body: Container(
        height: ScreenUtil().screenHeight / 2.2,
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Container(
          decoration:  BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0.r),
                  topRight: Radius.circular(25.0.r))),
          child: ListView(
            children: [
              SizedBox(
                height: 35.h,
              ),
              ///title
              Padding(
                padding: EdgeInsets.only(left: 20.w,),
                child: Text(
                  widget.name,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 22.sp,
                      color: Colors.black),
                ),
              ),
              Divider(
                height: 20.h,
                color: Colors.black26,
                thickness: 0.5,
                indent: 1,
                endIndent: 1,
              ),
              ///image and name and description
              Padding(
                padding: EdgeInsets.only(left: 20.w,bottom: 10.h,),
                child: Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: kGrey.withOpacity(0.2), width: 1.1)),
                        child:CachedNetworkImage(
                          imageUrl:
                          widget.image,
                          height: ScreenUtil().screenHeight / 7.h,
                          progressIndicatorBuilder:
                              (context, url, progress) =>
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                    ),
                    SizedBox(width: 10.w,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: ScreenUtil().screenWidth-200,
                          child: Text(
                            widget.description,
                            maxLines: 3,
                            style: TextStyle(fontSize: 10.sp),
                          ),
                        ),
                        SizedBox(height: 5.h,),
                        Text( widget.price,style: TextStyle(color: kBlueLite,fontSize: 14.sp,fontWeight: FontWeight.w700),),
                        SizedBox(height: 5.h,),

                        widget.discount == "0%"?
                        Container()
                            :Text("Discount:${widget.discount}",style: TextStyle(fontSize:14.sp,color: kRed,fontWeight: FontWeight.w500),),

                      ],
                    ),

                  ],
                ),
              ),
              Divider(
                height: 20.h,
                color: Colors.black26,
                thickness: 0.5,
                indent: 1,
                endIndent: 1,
              ),

              Padding(
                padding: EdgeInsets.only(left: 20.w,top: 20.h,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("quantity",style:  TextStyle(fontWeight: FontWeight.w700,color: kBlueLite,fontSize: 15.sp),),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            if ( widget.qty!=0) {
                              widget.qty = (widget.qty -1);
                              setState(() {

                              });
                            }
                          },
                          child: Container(
                            height: 35.h,
                            width: 35.w,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: kGrey,width: 1.1.w),
                              borderRadius: BorderRadius.all(Radius.circular(5.r)),
                            ),
                            child: const Center(
                              child: Icon(Icons.remove,color: Colors.black54,),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w,),

                        Text("${widget.qty}",style: const TextStyle(color: Colors.black54,),),
                        SizedBox(width: 8.w,),

                        GestureDetector(
                          onTap: () {
                            widget.qty = (widget.qty+1);
                              setState(() {
                              });
                          },
                          child: Container(
                            height: 35.h,
                            width: 35.w,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: kGrey,width: 1.1.w),
                              borderRadius: BorderRadius.all(Radius.circular(5.r)),
                            ),
                            child: const Center(
                              child: Icon(Icons.add,color: Colors.black54,),
                            ),
                          ),
                        ),
                        SizedBox(width: 15.w,),

                      ],
                    ),
                    SizedBox(height: 15.h,),
                    BigButton(height: 44.h, width: ScreenUtil().screenWidth/1.2, name: "Add item", onTap: (){
                      if (widget.qty == 0) {
                        ScaffoldMessenger
                            .of(context)
                            .showSnackBar(SnackBar(content: Text("you can't add item with quantity zero",style: TextStyle(color: Colors.white,fontSize: 13.sp,fontWeight: FontWeight.w700),),backgroundColor: Colors.black,elevation: 3,));
                        return;
                      }
                      CartModel cart;
                      cart = CartModel(description: widget.description,name: widget.name,image: widget.image,discount: widget.discount,price: widget.price,qty: widget.qty);
                      cartCubit.addToCart(cart).then((value) {
                        ScaffoldMessenger
                            .of(context)
                            .showSnackBar(SnackBar(content: Text("${widget.name} Added to your Cart",style: TextStyle(color: Colors.white,fontSize: 13.sp,fontWeight: FontWeight.w700),),backgroundColor: Colors.black,elevation: 3,));
                        Navigator.pop(context);
                      });

                    }, textColor: Colors.white, containerColor: kBlueLite, borderColor: kBlueLite),
                    SizedBox(height: 15.h,),

                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
