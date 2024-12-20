import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:sixam_mart/data/api/api_checker.dart';
import 'package:sixam_mart/data/model/response/onboarding_model.dart';
import 'package:sixam_mart/data/repository/onboarding_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/model/body/country_flag.dart';

class OnBoardingController extends GetxController implements GetxService {
  final OnBoardingRepo onboardingRepo;
  OnBoardingController({@required this.onboardingRepo});

  List<OnBoardingModel> _onBoardingList = [];
  int _selectedIndex = 0;

  List<OnBoardingModel> get onBoardingList => _onBoardingList;
  int get selectedIndex => _selectedIndex;

  void changeSelectIndex(int index) {
    _selectedIndex = index;
    update();
  }

  void getOnBoardingList() async {
    Response response = await onboardingRepo.getOnBoardingList();
    if (response.statusCode == 200) {
      _onBoardingList = [];
      _onBoardingList.addAll(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<CountryFlag> getCountryFlagByCode(String code) async {
    final CountryFlag country = await getCountryByCode(code);
    return country;
  }
  Future<CountryFlag> getCountryByCode(String code) async {
    // Load the map of countries
    final Map<String, CountryFlag> countries = await loadCountries();
    // Retrieve the country by code
    try {
      // Find the first country where the name matches
      return countries.values.firstWhere(
            (country) => country.name.toLowerCase().contains( code.toLowerCase()),
        orElse: () => null, // Return null if no match is found
      );
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
  Future<Map<String, CountryFlag>> loadCountries() async {
    try {
      // Load the JSON file as a string
      final String jsonString = await rootBundle.loadString('assets/team_flag.json');

      // Decode the JSON string into a Map
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      // Convert the JSON map into a Map<String, Country>
      return jsonData.map((key, value) => MapEntry(key, CountryFlag.fromJson(value)));
    } catch (e) {
      print("Error loading or parsing JSON: $e");
      return {};
    }
  }
}
