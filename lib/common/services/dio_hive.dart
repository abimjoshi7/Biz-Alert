// For the Local Database Hive
import 'package:biz_alert/common/services/hive_sector_model.dart';
import 'package:biz_alert/common/services/hivemodel.dart';
import 'package:biz_alert/constants/helper.dart';
import 'package:biz_alert/constants/hive_identifiers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class DioHiveDB {
  // Company ID, Name and Symbol
  Future<StockDbModel?> viewStockInfo() async {
    try {
      // final stockInfo = Hive.box(companyIdSymbol).get('stockInfo',
      //     defaultValue: []); //Checking whether the data is stored in hive or not.
      // if (stockInfo.isNotEmpty) {
      //   return stockInfo;
      // } else {
      Dio dio = await getClient();
      Response<String> response = await dio.get(
        "/api/Master/GetCompany?userAuth.id=1", //$id,
      );
      // print(response.data);
      final resjson = stockDbModelFromJson(response.data!);
      Hive.box(companyIdSymbol).put("stockInfo", resjson);
      return resjson;
      // }
    } catch (e) {
      if (kDebugMode) {
        print('Error viewing stock info data: $e');
      }
      return null;
    }
  }

// Sector ID and Name
  Future<StockSectorDbModel?> viewSector() async {
    try {
      Dio dio = await getClient();
      Response<String> response = await dio.get(
        "/api/Master/GetSector?userAuth.id=1", //$id,
      );
      // print(response.data);
      final sectorjson = stockSectorDbModelFromJson(response.data!);
      Hive.box(sectorCompany).put("sectorInfo", sectorjson);
      return sectorjson;
      // }
    } catch (e) {
      if (kDebugMode) {
        print('Error viewing stock sector data: $e');
      }
      return null;
    }
  }
}
