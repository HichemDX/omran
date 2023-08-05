import 'package:bnaa/constants/app_colors.dart';
import 'package:bnaa/models/category.dart';
import 'package:bnaa/utils/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesPagingWidget extends StatelessWidget {
  int id;
  List<Category> listCategories;
  Function(int) onChange;
  CategoriesPagingWidget(
      {Key? key,
      required this.id,
      required this.listCategories,
      required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView(scrollDirection: Axis.horizontal, children: [
              GestureDetector(
                onTap: () {
                  onChange(0);
                },
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 35),
                  child: Container(
                    decoration: BoxDecoration(
                        border: 0 == id
                            ? const Border(
                                bottom: BorderSide(
                                color: Colors.black,
                                width: 1.0,
                              ))
                            : null),
                    child: Text(
                      'all'.tr,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                        color: AppColors.BLUE_COLOR,
                      ),
                    ),
                  ),
                ),
              ),
              ...List.generate(listCategories.length, (index) {
                return GestureDetector(
                  onTap: () {
                    onChange(listCategories[index].id!);
                  },
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(end: 35),
                    child: Container(
                      decoration: BoxDecoration(
                          border: listCategories[index].id == id
                              ? const Border(
                                  bottom: BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                ))
                              : null),
                      child: Text(
                        getValueLang(
                            valFr: listCategories[index].nameFr!,
                            valAr: listCategories[index].nameAr.toString()),
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w300,
                          color: AppColors.BLUE_COLOR,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ]),
          ),
        ),
        // categoryPage[index]
      ],
    );
  }
}
