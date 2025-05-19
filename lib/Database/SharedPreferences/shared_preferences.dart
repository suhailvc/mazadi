import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesController {

  static final SharedPreferencesController _instance = SharedPreferencesController._internal();
  late final SharedPreferences _sharedPreferences;

  factory SharedPreferencesController(){
    return _instance;
  }
  SharedPreferencesController._internal();

  Future<void> initSharedPreference() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool> setLanguage(String languageCode) async{
    return await _sharedPreferences.setString('language_code', languageCode);
  }

  String get languageCode {
    return _sharedPreferences.getString('language_code') ?? 'ar';
  }

  //
  // Future<bool> setTheme(String languageCode) async{
  //   return await _sharedPreferences.setString('language_code', languageCode);
  // }

  // String get ThemeCode {
  //   return _sharedPreferences.getString('language_code') ?? 'en';
  // }
  Future<bool> setDarkTheme(bool active) async{
    return await _sharedPreferences.setBool('DarkTheme', active);
  }
  bool get DarkTheme{
    return _sharedPreferences.getBool('DarkTheme') ?? false;
  }



  Future<bool> setFirstLoggin(bool active) async{
    return await _sharedPreferences.setBool('FirstLoggin', active);
  }
  bool get getFirstLoggin{
    return _sharedPreferences.getBool('FirstLoggin') ?? false;
  }


  Future<bool> setToken(String Token) async{
    return await _sharedPreferences.setString('Token', Token);
  }

  String get getToken {
    return _sharedPreferences.getString('Token') ?? '';
  }

  Future<bool> setADVLanguage(String ADVLanguage) async{
    return await _sharedPreferences.setString('ADVLanguage', ADVLanguage);
  }

  String get ADVLanguage {
    return _sharedPreferences.getString('ADVLanguage') ?? 'both';
  }
  String newADVLanguage='ar';
  List<Map> features =[];

  String category_id ='';
  String city_id ='1';
  String type_id ='';
  String subCategoryID ='';
  String cover_image_id ='';
  List<String?> oldDeletedPhotos = [];







  //------------------------------- Caching--------------------------//

  Future<bool> setLastAucations_cache(String Token) async{
    return await _sharedPreferences.setString('LastAucations_cache', Token);
  }

  String get getLastAucations_cache {
    return _sharedPreferences.getString('LastAucations_cache') ?? '';
  }




  //----------------------------------------------------------------//




}
