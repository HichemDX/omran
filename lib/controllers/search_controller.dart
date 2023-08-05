import 'dart:convert';

import 'package:bnaa/constants/constants.dart';
import 'package:bnaa/models/category.dart';
import 'package:bnaa/models/commune.dart';
import 'package:bnaa/models/product.dart';
import 'package:bnaa/models/sub_category.dart';
import 'package:bnaa/models/wilaya.dart';
import 'package:bnaa/services/api_http.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  bool isLoading = false;

  List<Product> result = [];

  List<Commune> selectedCommunes = [];
  Wilaya? selectedWilaya;
  List<SubCategory> selectedSubCategory = [];
  Category? selectedCategory;

  List<String> selectedCommunesIds = [];
  String selectedWilayaId = '';
  List<String> selectedSubCategoryIds = [];
  String selectedCategoryId = '';

  TextEditingController maxPrice = TextEditingController(text: '');
  TextEditingController minPrice = TextEditingController(text: '');
  TextEditingController word = TextEditingController(text: '');

  String searchRequest = '';

  //pagination params
  int currentPage = 0;
  int totalPage = 0;
  bool canLoadMore = false;

  Future<List<Product>> getResult() async {
    isLoading = true;
    update();
    /*searchRequest = '&word=${word.text}&wilaya=$selectedWilayaId'
        '&commune[]=$selectedCommunesIds&category=$selectedCategoryId'
        '&sou_category[]=$selectedSubCategoryIds&prix_max=${maxPrice.value.text}'
        '&prix_min=${maxPrice.value.text}';*/

    searchRequest = "&word=${word.text}";
    if (selectedWilayaId.isNotEmpty) {
      searchRequest += '&wilaya=$selectedWilayaId';
    }
    if (selectedCommunesIds.isNotEmpty) {
      selectedCommunesIds.forEach((element) {
        searchRequest += '&commune[]=$element';
      });
    }

    if (selectedCategoryId.isNotEmpty) {
      searchRequest += '&category=$selectedCategoryId';
    }

    if (selectedSubCategoryIds.isNotEmpty) {
      selectedSubCategoryIds.forEach((element) {
        searchRequest += '&sou_category[]=$element';
      });
    }

    if (maxPrice.value.text.isNotEmpty) {
      searchRequest += '&prix_max=${maxPrice.value.text}';
    }

    if (minPrice.value.text.isNotEmpty) {
      searchRequest += '&prix_min=${minPrice.value.text}';
    }

    try {
      Network api = Network();
      var response = await api
          .getWithHeader(apiUrl: '/search/?page=1' + searchRequest)
          .timeout(timeOutDuration);
      print(response.body);
      if (response.statusCode == 200) {
        result = (json.decode(response.body) as List)
            .map((i) => Product.fromJson(i))
            .toList();
        isLoading = false;
        update();
        return result;
      } else {
        isLoading = false;
        update();
        return Future.error("");
      }
    } catch (e) {
      isLoading = false;
      update();
      print(e);
      return Future.error(e);
    }
  }

  Future<List<Product>> loadMoreResult() async {
    try {
      Network api = Network();
      var response = await api
          .getWithHeader(
              apiUrl: 'search_page/?page=${currentPage + 1}' + searchRequest)
          .timeout(timeOutDuration);
      print(response.body);
      if (response.statusCode == 200) {
        // define pagination params
        totalPage = json.decode(response.body)['total_pages'];
        currentPage = json.decode(response.body)['current_page'];
        canLoadMore = currentPage < totalPage;

        result.addAll((json.decode(response.body)['result'] as List)
            .map((i) => Product.fromJson(i))
            .toList());
        update();
        return result;
      } else {
        return Future.error("");
      }
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  addCommune(commune) {
    selectedCommunes.add(commune);
    selectedCommunesIds.add(commune.id.toString());
    update();
  }

  removeCommune(communeId) {
    selectedCommunes.removeWhere((element) => element.id == communeId);
    selectedCommunesIds
        .removeWhere((element) => element == communeId.toString());
    update();
  }

  setWilaya(wilaya) {
    selectedWilaya = wilaya;
    selectedWilayaId = wilaya.id.toString();
    selectedCommunes.clear();
    update();
  }

  initWilaya() {
    selectedWilaya = null;
    selectedWilayaId = '';
    selectedCommunes.clear();
    update();
  }

  addSubCategory(subCategory) {
    selectedSubCategory.add(subCategory);
    selectedSubCategoryIds.add(subCategory.id.toString());
    print(selectedSubCategory.length);
    update();
  }

  removeSubCategory(subCategoryId) {
    selectedSubCategory.removeWhere((element) => element.id == subCategoryId);
    selectedSubCategoryIds
        .removeWhere((element) => element == subCategoryId.toString());
    update();
  }

  setCategory(category) {
    selectedCategory = category;
    selectedCategoryId = category.id.toString();
    selectedSubCategory.clear();
    update();
  }

  initCategory() {
    selectedCategory = null;
    selectedCategoryId = '';
    selectedSubCategory.clear();
    update();
  }
}
