


import 'package:flutter/material.dart';
import 'package:my_coffee_shop/view/components/app_slider.dart';
import 'package:my_coffee_shop/view/components/counter.dart';
import 'package:my_coffee_shop/view/components/style.dart';
import 'package:my_coffee_shop/view/components/text.dart';



import '../controller/product_controller.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final productCtrl = ProductController();

  final sugars = <double>[];
  final sizes = <String>[];
  final qties = <int>[];

  int i = 0;  //j = 0;  ?

  @override
  void initState() {
    super.initState();
    sugars.clear();
    for (var i = 0; i < productCtrl.products.length; i++) {
      sugars.add(0);
      sizes.add("");
      qties.add(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 32,
              left: 16,
              right: 16,
              bottom: 32,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  "WELCOME TO ORIF COFFEE",
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF4C7766),
                ),
                const SizedBox(height: 14),
                AppText(
                  "Find your favorite & take your order",
                  fontSize: 14,
                ),
                const SizedBox(height: 32),
                const AppTextField(),
                const SizedBox(height: 32),
                AppText("All"),
                const SizedBox(height: 22),
                GridView.builder(
                  itemCount: productCtrl.products.length,
                  shrinkWrap: true, // 
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 3,
                    childAspectRatio: 9 / 16,
                  ),
                  itemBuilder: (context, index) => Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 4,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.asset(
                              productCtrl.products[index].image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    productCtrl.products[index].name.length < 15
                                        ? productCtrl.products[index].name
                                        : "${productCtrl.products[index].name.substring(0, 14)}...",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                  GestureDetector(
                                    onTap: () => setState(() {
                                      if (i < 2) {
                                        i++;
                                      } else {
                                        i = 0;
                                      }
                                      sizes[index] = productCtrl.products[index].sizes[i];
                                    }),
                                    child: AppText(
                                      sizes[index].isEmpty
                                          ? productCtrl.products[index].sizes[0]
                                          : sizes[index],
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: AppSlider(
                                      onChanged: (value) => setState(() {
                                        sugars[index] = value;
                                      }),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  AppText(
                                    sugars[index].toStringAsFixed(0),
                                    textAlign: TextAlign.right,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: AppColors.primary,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    productCtrl.findFinalPrice(
                                      index,
                                      sizes[index],
                                      qties[index],
                                    ),
                                  ),
                                  Counter(
                                    onChanged: (value) => setState(() {
                                      qties[index] = value;
                                    }),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}