import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:sixam_mart/data/api/api_client.dart';
import 'package:sixam_mart/util/app_constants.dart';

class WalletRepo {
  final ApiClient apiClient;
  WalletRepo({@required this.apiClient});

  Future<Response> getWalletTransactionList(String offset) async {
    return await apiClient.getData('${AppConstants.WALLET_TRANSACTION_URL}?offset=$offset&limit=10');
  }
  Future<Response> getBankList() async {
    return await apiClient.getData('${AppConstants.BANK_LIST_URL}');
  }

  Future<Response> getBankAccountList() async {
    return await apiClient.getData('${AppConstants.GET_BANK_ACCOUNT_LIST_URL}');
  }

  Future<Response> getLoyaltyTransactionList(String offset) async {
    return await apiClient.getData('${AppConstants.LOYALTY_TRANSACTION_URL}?offset=$offset&limit=10');
  }

  Future<Response> pointToWallet({int point}) async {
    return await apiClient.postData(AppConstants.LOYALTY_POINT_TRANSFER_URL, {"point": point});
  }

  Future<Response> createAccount(String bank_name,String account_number,String holder_name ) async {
    return await apiClient.postData(AppConstants.ADD_BANK_ACCOUNT_URL, {"account_bank": bank_name,"account_number": account_number,"holder_name": holder_name});
  }

  Future<Response> withdrawFund(String amount,String description ) async {
    return await apiClient.postData(AppConstants.WITHDRAW_FUND_URL, {"amount": amount,"description": description});
  }

  Future<Response> addFund(String amount ) async {
    return await apiClient.postData(AppConstants.ADD_FUND_URL, {"amount": amount});
  }

  Future<Response> deleteAccount(String account_number ) async {
    return await apiClient.deleteData('${AppConstants.DELETE_BANK_ACCOUNT_URL}${ 'account_number=' }$account_number');
  }

}