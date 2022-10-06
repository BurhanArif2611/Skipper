import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/controller/user_controller.dart';
import 'package:sixam_mart/data/api/api_checker.dart';
import 'package:sixam_mart/data/model/response/added_bank_account.dart';
import 'package:sixam_mart/data/model/response/bank_list.dart';
import 'package:sixam_mart/data/model/response/wallet_model.dart';
import 'package:sixam_mart/data/repository/wallet_repo.dart';
import 'package:sixam_mart/view/base/confirmation_dialog.dart';
import 'package:sixam_mart/view/base/custom_snackbar.dart';

import '../helper/route_helper.dart';
import '../util/images.dart';

class WalletController extends GetxController implements GetxService {
  final WalletRepo walletRepo;

  WalletController({@required this.walletRepo});

  List<Transaction> _transactionList;
  List<String> _offsetList = [];
  int _offset = 1;
  int _pageSize;
  bool _isLoading = false;

  List<Transaction> get transactionList => _transactionList;

  int get popularPageSize => _pageSize;

  bool get isLoading => _isLoading;

  int get offset => _offset;
  List<BankList> _predictionList = [];
  List<AddedBankAccount> _bankAccountList = [];
  List<BankList> _filterList = [];
  List<BankList> get predictionList => _predictionList;
  List<AddedBankAccount> get bankAccountList => _bankAccountList;
  List<BankList> get filterList => _filterList;
  void setOffset(int offset) {
    _offset = offset;
  }

  void showBottomLoader() {
    _isLoading = true;
    update();
  }

  Future<void> getWalletTransactionList(
      String offset, bool reload, bool isWallet) async {
    if (offset == '1' || reload) {
      _offsetList = [];
      _offset = 1;
      _transactionList = null;
      if (reload) {
        update();
      }
    }
    if (!_offsetList.contains(offset)) {
      _offsetList.add(offset);
      Response response;
      if (isWallet) {
        response = await walletRepo.getWalletTransactionList(offset);
      } else {
        response = await walletRepo.getLoyaltyTransactionList(offset);
      }

      if (response.statusCode == 200) {
        if (offset == '1') {
          _transactionList = [];
        }
        _transactionList.addAll(WalletModel.fromJson(response.body).data);
        _pageSize = WalletModel.fromJson(response.body).totalSize;

        _isLoading = false;
        update();
      } else {
        ApiChecker.checkApi(response);
      }
    } else {
      if (isLoading) {
        _isLoading = false;
        update();
      }
    }
  }

  Future<void> pointToWallet(int point, bool fromWallet) async {
    _isLoading = true;
    update();
    Response response = await walletRepo.pointToWallet(point: point);
    if (response.statusCode == 200) {
      Get.back();
      getWalletTransactionList('1', true, fromWallet);
      Get.find<UserController>().getUserInfo();
      showCustomSnackBar('converted_successfully_transfer_to_your_wallet'.tr,
          isError: false);
    } else {
      ApiChecker.checkApi(response);
      Get.dialog(
          ConfirmationDialog(
            icon: Images.warning,
            title: 'Are you sure to "Convert Loyalty Points to Currency" ?' ,
            description: response.statusText,
            onYesPressed: () {
              Get.back();
            },
          ),
          barrierDismissible: false);
    }
    _isLoading = false;
    update();
  }

  Future<void> addAcountToWallet(String bank_name, String account_number, String holder_name) async {
    _isLoading = true;
    update();
    Response response =
        await walletRepo.createAccount(bank_name, account_number, holder_name);
    if (response.statusCode == 200) {
      Get.back();
      print("response>>" + response.bodyString);

      if (response.body['status'] == 200) {
        showCustomSnackBar(response.body['message'].toString(), isError: false);
        bankAccountListDetail();
      } else {
        showCustomSnackBar(response.body['message'].toString(), isError: true);
      }
    } else {
      showCustomSnackBar(response.body['message'].toString(), isError: true);
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }

  Future<void> bankList() async {
     _isLoading = true;
    update();
    Response response = await walletRepo.getBankList();
    if (response.statusCode == 200 && response.body['status'] == 'success') {
      _predictionList = [];
      response.body['data'].forEach((prediction) => _predictionList.add(BankList.fromJson(prediction)));
    } else {
      showCustomSnackBar(response.body['error_message'] );
    }
   // ApiChecker.checkApi(response);

    _isLoading = false;
    update();
  }
  Future<void> bankAccountListDetail() async {
    _isLoading = true;
    update();
    Response response = await walletRepo.getBankAccountList();
    print("bankAccountList>>"+response.bodyString);
    if (response.statusCode == 200) {
      _bankAccountList = [];
      response.body.forEach((prediction) => _bankAccountList.add(AddedBankAccount.fromJson(prediction)));
    } else {
      showCustomSnackBar(response.body['error_message'] );
    }
   // ApiChecker.checkApi(response);

    _isLoading = false;
    update();
  }

  Future<List<BankList>> filter(String search) async {
   if(search !="") {
     _filterList = [];
     _predictionList.forEach((prediction) {
       print("filter>>>>" + prediction.name);

       if (prediction.name.toLowerCase().contains(search.toLowerCase())) {
         print("filter>>>>" + search);
         _filterList.add(prediction);
       }
     });
   }

   return _filterList;
  }

  Future<void> withdrawFundToWallet(String bank_name, String account_number) async {
    _isLoading = true;
    update();
    Response response =
    await walletRepo.withdrawFund(bank_name, account_number);
    if (response.statusCode == 200) {
      Get.back();
      print("response>>" + response.bodyString);

      if (response.body['status'] == 200) {
        showCustomSnackBar(response.body['message'].toString(), isError: false);
      } else {
        showCustomSnackBar(response.body['message'].toString(), isError: true);
      }
    } else {
      showCustomSnackBar(response.body['message'].toString(), isError: true);
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }

  Future<void> addFundToWallet(String bank_name) async {
    _isLoading = true;
    update();
    Response response =
    await walletRepo.addFund(bank_name);
    if (response.statusCode == 200) {
      Get.back();
      print("response>>" + response.bodyString);
      print("response>>" + response.body['link'].toString());

      if (response.body['status'] == 200) {
        Get.offNamed(RouteHelper.getPaymentRoute(
            "-12", Get.find<UserController>().userInfoModel.id, response.body['link'].toString()));
      } else {
        showCustomSnackBar(response.body['message'].toString(), isError: true);
      }
    } else {
      showCustomSnackBar(response.body['message'].toString(), isError: true);
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }

  Future<void> deleteAccount(String account_num) async {
    _isLoading = true;
    update();
    Response response =
    await walletRepo.deleteAccount(account_num);
    if (response.statusCode == 200) {
      Get.back();
      print("response>>" + response.bodyString);
      showCustomSnackBar(response.body['message'].toString(), isError: false);
      bankAccountListDetail();
    } else {
      showCustomSnackBar(response.body['message'].toString(), isError: true);
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }

}
