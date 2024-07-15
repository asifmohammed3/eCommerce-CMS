import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../core/data/data_provider.dart';
import '../../../models/api_response.dart';
import '../../../models/variant_type.dart';
import '../../../services/http_services.dart';
import '../../../utility/snack_bar_helper.dart';

class VariantsTypeProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;

  final addVariantsTypeFormKey = GlobalKey<FormState>();
  TextEditingController variantNameCtrl = TextEditingController();
  TextEditingController variantTypeCtrl = TextEditingController();

  VariantType? variantTypeForUpdate;



  VariantsTypeProvider(this._dataProvider);


  addVariantType() async {
    try {
      Map<String, dynamic> varType = {'name': variantNameCtrl.text, 'type': variantTypeCtrl.text};
      final response = await service.addItem(endpointUrl: 'variantTypes', itemData: varType);
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          clearFields();
          SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
          _dataProvider.getAllVariantType();
          log('Variant Type added');
        } else {
          SnackBarHelper.showErrorSnackBar('Failed to add variant Type: ${apiResponse.message}');
        }
      } else {
        SnackBarHelper.showErrorSnackBar('Error ${response.body? ['message'] ?? response.statusText}');
      }
    } catch (e) {
      print(e);
      SnackBarHelper.showErrorSnackBar('An error occurred: $e');
      rethrow;
    }
  }


  updateVariantType() async {
    try{
      if(variantTypeForUpdate != null) {
        Map<String, dynamic> varType = {
          'name': variantNameCtrl.text,
          'type': variantTypeCtrl.text
        };

        final response = await service.updateItem(endpointUrl: "variantTypes",
            itemData: varType,
            itemId: variantTypeForUpdate?.sId ?? '');
        if (response.isOk) {
          ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
          if (apiResponse.success == true) {
            clearFields();
            SnackBarHelper.showSuccessSnackBar(apiResponse.message);
            _dataProvider.getAllVariantType();
            log('variantType updated');
          } else {
            SnackBarHelper.showErrorSnackBar(
                'Failed to update variant type: ${apiResponse.message}');
          }
        } else {
          SnackBarHelper.showErrorSnackBar(
              'Error ${response.body?['message'] ?? response.statusText}');
        }
      }
    }catch(e){

    }
  }

  submitVariant(){
    if(variantTypeForUpdate != null){
      updateVariantType();
    }else{
      addVariantType();
    }
  }



  deleteVariantType (VariantType varType) async {
    try {
      Response response = await service.deleteItem(endpointUrl: 'variantType', itemId: varType.sId ?? '');
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body,null);
        if (apiResponse.success == true) {
          SnackBarHelper.showSuccessSnackBar('Variant Type Deleted Successfully');
          _dataProvider.getAllVariantType();
        }
      }else{
        SnackBarHelper.showErrorSnackBar('Error ${response.body? ['message'] ?? response.statusText}');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }


  setDataForUpdateVariantTYpe(VariantType? variantType) {
    if (variantType != null) {
      variantTypeForUpdate = variantType;
      variantNameCtrl.text = variantType.name ?? '';
      variantTypeCtrl.text = variantType.type ?? '';
    } else {
      clearFields();
    }
  }

  clearFields() {
    variantNameCtrl.clear();
    variantTypeCtrl.clear();
    variantTypeForUpdate = null;
  }
}
