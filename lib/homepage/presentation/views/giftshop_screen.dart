import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zheeta/app/common/color.dart';
import 'package:zheeta/app/router/app_router.dart';
import 'package:zheeta/app/router/app_router.gr.dart';
import 'package:zheeta/widgets/drawer.dart';

@RoutePage()
class GiftShopScreen extends StatefulWidget {
  const GiftShopScreen({super.key});

  @override
  State<GiftShopScreen> createState() => _GiftShopScreenState();
}

class _GiftShopScreenState extends State<GiftShopScreen> {
  var search;
  static final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.secondaryLight,
        drawer: SideDrawer(),
        appBar: AppBar(
          backgroundColor: AppColors.secondaryLight,
          elevation: 0.0,
          leading: GestureDetector(
            onTap: () => router.pop(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(5),
                height: 30,
                width: 30,
                decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(100)),
                child: Icon(Icons.arrow_back_ios_new, color: AppColors.grey),
              ),
            ),
          ),
          title: Text(
            'Gift Shop',
            style: TextStyle(color: AppColors.grayscale, fontSize: 32, fontWeight: FontWeight.w600),
          ),
          centerTitle: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Row(
                children: [TopNavBtn2(icon: 'assets/images/icons/menu.svg'), TopNavBtn2(icon: 'assets/images/icons/bell.svg')],
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                  height: 50,
                  child: TextFormField(
                    onFieldSubmitted: (value) {},
                    onChanged: (value) {},
                    style: TextStyle(color: Colors.black),
                    controller: _searchController,
                    keyboardType: TextInputType.text,
                    cursorColor: AppColors.primaryDark,
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                          padding: EdgeInsets.all(10),
                          child: SvgPicture.asset(
                            'assets/images/icons/search.svg',
                            width: 10,
                            height: 10,
                          )),
                      border: OutlineInputBorder(),
                      hintText: 'Search',
                      hintStyle: TextStyle(color: AppColors.hintText),
                    ),
                    // focusNode: _focusNode,
                    validator: (searchValue) {
                      if (searchValue!.isEmpty) {
                        return 'Please enter search keyword';
                      }
                      return null;
                    },
                  )),
              SizedBox(height: 20),
              Wrap(
                runSpacing: 15,
                spacing: 15,
                children: [
                  for (var i = 0; i < 12; i++)
                    GestureDetector(
                      onTap: () {
                        router.push(ProductDetailsRoute(product: 'Plain black t-shirt'));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.48,
                        width: MediaQuery.of(context).size.width * 0.42,
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                        decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/shop.png",
                              height: MediaQuery.of(context).size.width * 0.28,
                              width: MediaQuery.of(context).size.width * 0.28,
                            ),
                            SizedBox(height: 8),
                            Text("Umbrella", style: TextStyle(color: AppColors.grayscale, fontSize: 14, fontWeight: FontWeight.w400)),
                            SizedBox(height: 5),
                            Text("\$20.4", style: TextStyle(color: AppColors.primaryDark, fontSize: 16, fontWeight: FontWeight.w600))
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 100),
            ],
          ),
        ));
  }
}

class TopNavBtn2 extends StatelessWidget {
  final icon;
  const TopNavBtn2({super.key, this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Scaffold.of(context).openDrawer();
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(padding: EdgeInsets.all(10), height: 40, width: 40, decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(100)), child: SvgPicture.asset(icon, width: 30, colorFilter: ColorFilter.mode(AppColors.grey, BlendMode.srcIn))),
      ),
    );
  }
}
