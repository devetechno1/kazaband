import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/provider/category_provider.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/category_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/product/brand_and_category_product_screen.dart';
import 'package:provider/provider.dart';

import '../shimmer/category_shimmer.dart';

class CategoryView extends StatelessWidget {
  final bool isHomePage;
  const CategoryView({Key? key, required this.isHomePage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, categoryProvider, child) {

        return categoryProvider.categoryList.isNotEmpty ?
        isHomePage ? SizedBox( height: 120,
          child:  ListView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: isHomePage ? Axis.horizontal :Axis.vertical,
            itemCount: categoryProvider.categoryList.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(
                    isBrand: false,
                    id: categoryProvider.categoryList[index].id.toString(),
                    name: categoryProvider.categoryList[index].name,
                  )));
                },
                child: CategoryWidget(category: categoryProvider.categoryList[index], index: index,length:  categoryProvider.categoryList.length),
              );

            },
          ),
        ) :
        SizedBox( //height: 120,
          child:  GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // number of items in each row
              childAspectRatio: 0.95,
              mainAxisSpacing:30, // spacing between rows
              crossAxisSpacing: 0, // spacing between columns
            ),
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(10),
            scrollDirection: isHomePage ? Axis.horizontal :Axis.vertical,
            itemCount: categoryProvider.categoryList.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(
                    isBrand: false,
                    id: categoryProvider.categoryList[index].id.toString(),
                    name: categoryProvider.categoryList[index].name,
                  )));
                },
                child: CategoryWidget(category: categoryProvider.categoryList[index], index: index,length:  categoryProvider.categoryList.length),
              );

            },
          ),
        )
            : const CategoryShimmer();

      },
    );
  }
}



