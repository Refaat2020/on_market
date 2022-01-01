import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_market/constant/k_colors.dart';
import 'package:on_market/cubit/cart_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ProductCardWidget extends StatefulWidget {
  String ?name;
  String ?description;
  String ?price;
  int ?qty;
  int? index;
  ProductCardWidget({this.name, this.description, this.price, this.qty,this.index});

  @override
  State<ProductCardWidget> createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  late StreamController _qtyController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _qtyController = StreamController<int>();

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      padding: EdgeInsets.only(left: 7.w,top: 10.h,),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(13.r)),
        border: Border.all(color: kGrey,width: 1.2.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.name!,style: TextStyle(color: kBlack,fontSize: 14.sp,fontWeight: FontWeight.w600),),
          SizedBox(height: 10.h,),
          SizedBox(
              width: ScreenUtil().screenWidth/1.5,
              child: Text(widget.description!,maxLines: 2,style: TextStyle(color: kGrey,fontSize: 11.sp,fontWeight: FontWeight.w400),overflow: TextOverflow.ellipsis,)),
          SizedBox(height: 20.h,),
          Row(
            children: [
              Text("quantity",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14.sp,color: kBlack),),
              SizedBox(width: ScreenUtil().screenWidth/4.5,),

              GestureDetector(
                onTap: () {

                  if ( widget.qty!=0) {
                    widget.qty = (widget.qty! -1);
                    setState(() {

                    });
                  }
                  _qtyController.sink.add(widget.qty);
                  _qtyController.stream.listen((event) {
                    if (event ==0) {
                      context.read<CartCubit>().removeFromCart(widget.index!);
                    }
                  });


                },
                child: Container(
                  height: 25.h,
                  width: 30.w,
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

               Text(widget.qty.toString(),style: const TextStyle(color: kGrey,),),
              SizedBox(width: 8.w,),

              GestureDetector(
                onTap: () {
                  widget.qty = (widget.qty! +1);
                  setState(() {
                    
                  });
                },
                child: Container(
                  height: 25.h,
                  width: 30.w,
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
              const Spacer(),
              Text("${widget.price} L.E",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14.sp,color: kBlack),),
              SizedBox(width: 15.w,),

            ],
          )

        ],
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _qtyController.close();
    super.dispose();

  }
}
