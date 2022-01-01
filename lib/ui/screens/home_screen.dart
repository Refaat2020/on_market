import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_market/constant/category.dart';
import 'package:on_market/constant/k_colors.dart';
import 'package:on_market/cubit/products_cubit.dart';
import 'package:on_market/ui/widgets/item_card_widget.dart';
import 'package:on_market/ui/widgets/product_detil_card_widget.dart';

import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedCategoryIconIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProductsCubit>().initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Categories",
                      style: TextStyle(
                          color: kBlack,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.sp),
                    ),
                    const Spacer(),
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(),));
                    }, icon: Icon(Icons.shopping_cart,color: kZaty,size: 22.sp,))
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                ///category
                SizedBox(
                  height: 80.h,
                  width: 550.w,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(right: 10.w),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedCategoryIconIndex = index;
                            });
                          },
                          child: Container(
                            width: 100.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.r)),
                                border: Border.all(
                                  color: selectedCategoryIconIndex == index
                                      ? Colors.blue
                                      : Colors.grey.withOpacity(0.2),
                                  width: 1.8,
                                )),
                            child: Center(
                              child: Text(
                                kCategoryList[index],
                                style: TextStyle(
                                    color: selectedCategoryIconIndex == index
                                        ? Colors.blue
                                        : Colors.grey,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                            width: 30.w,
                          ),
                      itemCount: kCategoryList.length),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  "Products",
                  style: TextStyle(
                      color: kBlack,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.sp),
                ),
                BlocBuilder<ProductsCubit, ProductsState>(
                builder: (context, state) {
                  if (state is ProductsFetched) {
                    return ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(right: 10.w),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  builder: (builder) {
                                    return ProductDetilCardWidget(name: state.products[index].get("name"),description: state.products[index].get("desc"),qty:  state.products[index].get("qty"),price:  state.products[index].get("price"), image: state.products[index].get("image"),discount: state.products[index].get("discount"),);
                                  });
                            },
                              child: MovieCardWidget(name: state.products[index].get("name"),description: state.products[index].get("desc"),qty:  state.products[index].get("qty"),price:  state.products[index].get("price"), image: state.products[index].get("image"),discount: state.products[index].get("discount"),));
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          height: 15.h,
                        ),
                        itemCount: 2);
                  }
                  return Container();
                },
              ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
