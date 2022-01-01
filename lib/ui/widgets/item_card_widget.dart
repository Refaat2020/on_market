import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_market/constant/k_colors.dart';

class MovieCardWidget extends StatefulWidget {
String image;
String name;
String description;
int qty;
String price;
String discount;
MovieCardWidget({required this.image,required this.name,required this.description,required this.qty,required this.price,required this.discount});

  @override
  State<MovieCardWidget> createState() => _MovieCardWidgetState();
}

class _MovieCardWidgetState extends State<MovieCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3.0,
      borderRadius: BorderRadius.all(Radius.circular(20.r)),
      child: Container(
        height: 110.h,
        width: ScreenUtil().screenWidth/1.8.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.r)),

        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: 60.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: CachedNetworkImage(
                  imageUrl: widget.image,
                  fit: BoxFit.contain,
                  errorWidget:(context, url, error) =>  Icon(Icons.error,color: Colors.black,size: 25.sp,),
                  progressIndicatorBuilder: (context, url, progress) => const Center(child: CircularProgressIndicator(),),
                ),
              ),
            ),
            ///name and desc and price and qty
            Expanded(
                flex: 5,
                child: Padding(
                  padding:  EdgeInsets.only(right: 0.w,top: 15.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ///name
                      Text(widget.name,maxLines: 2,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 14.sp),
                      ),
                      SizedBox(height: 5.h,),
                      ///desc
                      Text(widget.description,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 13.sp),),
                      SizedBox(height: 20.h,),
                      ///price and qty
                      Row(
                        children: [
                          Text("${widget.price} L.E",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14.sp,color: kBlack),),
                          const Spacer(),
                          widget.discount == "0%"?
                              Container()
                              :Text("Discount:${widget.discount}",style: TextStyle(fontSize:14.sp,color: kRed,fontWeight: FontWeight.w500),),
                          SizedBox(width: 10.w,)
                        ],
                      ),
                    ],
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
