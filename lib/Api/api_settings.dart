class ApiSettings {

  //GENERAL-REQUEST
  static const String baseUrl = 'https://admin.mazadistore.net/api/';
  // static const String baseUrl = 'https://mazaad.fresh-app.com/api/';
  // static const String baseUrl = 'http://admin.mazadistore.com/api/';


  // Boardings
  static const String get_boardings = baseUrl + "user/get_boardings";
  // Auth
  static const String login = baseUrl + "user/login";
  static const String register = baseUrl + "user/register";
  static const String get_code = baseUrl + "user/get_code";
  static const String logout = baseUrl + "user/logout";
  static const String get_cities = baseUrl + "user/get_cities/188";


  // home

  static const String get_slider = baseUrl + "user/get_slider";
  static const String get_advertisements = baseUrl + "user/get_advertisements";
  static const String latest_auctions =  baseUrl +"user/auctions/latest_auctions";
  static const String singleAuction = baseUrl +"user/auctions/auction_by_id/";
  static const String latest_advertisements = baseUrl +"user/advertisements/latest_advertisements";
  static const String get_card_categories = baseUrl +"get_card_categories";
  static const String charg_amount = baseUrl +"charg_amount";
  static const String setting = baseUrl +"user/setting";
  static const String delete_all_notifications = baseUrl +"user/delete_all_notifications";

  // Auction
  static const String get_AuctionCategories = baseUrl +"user/auction_categories/get_categories";
  static const String my_auctions = baseUrl +"user/auctions/my_auctions";
  static const String my_waiting_auctions = baseUrl +"user/auctions/my_waiting_auctions";
  static const String my_completed_auctions = baseUrl +"user/auctions/my_completed_auctions";
  static const String my_canceled_auctions = baseUrl +"user/auctions/my_canceled_auctions";
  static const String my_ended_auctions = baseUrl +"user/auctions/my_ended_auctions";
  static const String auction_categoriesBy_id = baseUrl +"user/auction_categories/get_category_by_id/";
  static const String my_win_bids = baseUrl +"user/auctions/my_win_bids";
  static const String my_wait_bids = baseUrl +"user/auctions/my_wait_bids";
  static const String my_lose_bids = baseUrl +"user/auctions/my_lose_bids";
  static const String cancel_Aucation = baseUrl +"user/auctions/cancel/";
  static const String delete_Aucation = baseUrl +"user/auctions/delete/";
  static const String add_AucationBid = baseUrl +"user/auctions/add_bid/";
  static const String complete_auction = baseUrl +"user/auctions/complete_auction/";
  static const String get_Aucation_features = baseUrl +"user/auction_categories/get_category_data/";
  static const String auctions_add = baseUrl +"user/auctions/add";
  static const String auctions_update = baseUrl +"user/auctions/update/";



  // advertisements

  static const String my_advertisements = baseUrl +"user/advertisements/my_advertisements";
  static const String my_waiting_advertisements = baseUrl +"user/advertisements/my_waiting_advertisements";
  static const String singleAdvertisements = baseUrl +"user/advertisements/advertisement_by_id/";
  static const String get_category_by_id = baseUrl +"user/advertisement_categories/get_category_by_id/";
  static const String get_show_category_by_id = baseUrl +"user/advertisement_categories/get_show_category_by_id/";
  static const String get_sub_categories = baseUrl +"user/advertisement_categories/get_sub_categories/";
  static const String get_advertisementCategories = baseUrl +"user/advertisement_categories/get_categories";
  static const String get_category_features = baseUrl +"user/advertisement_categories/get_category_features/";
  static const String add_advertisement = baseUrl +"user/advertisements/add";
  static const String delete_advertisement = baseUrl +"user/advertisements/delete/";
  static const String stop_active_advertisement = baseUrl +"user/advertisements/stop_active_advertisement/";
  static const String get_advertisement_byCategory = baseUrl +"user/advertisements/category_advertisements/";
  static const String addAdvertisementComment = baseUrl +"user/advertisement_comments/add/";
  static const String CommentByID = baseUrl +"user/advertisement_comments/advertisement_comments_by_id/";
  static const String get_category_types = baseUrl +"user/advertisement_categories/get_category_types/";
  static const String delete_advertisement_image = baseUrl +"user/advertisements/delete_advertisement_image/";
  static const String user_advertisements = baseUrl +"user/advertisements/user_advertisements/";
  static const String add_CommentReplay = baseUrl +"user/advertisement_comments_reply/add/";
  static const String delete_CommentReplay = baseUrl +"user/advertisement_comments/delete/";
  static const String update_CommentReplay = baseUrl +"user/advertisement_comments/update/";
  static const String update_advertisements = baseUrl +"user/advertisements/update";

  // profile

  static const String get_profile = baseUrl +"user/get_profile";
  static const String update_profile = baseUrl +"user/update_profile";
  static const String update_photo = baseUrl +"user/update_photo";
  static const String get_my_address = baseUrl +"user/address/get_my_address";
  static const String add_address = baseUrl +"user/address/add_address";
  static const String delete_address = baseUrl +"/user/address/delete_address/";
  static const String my_balance = baseUrl +"user/wallets/my_balance";
  static const String block_auction = baseUrl +"user/wallets/block_auction";
  static const String my_transactions = baseUrl +"user/wallets/my_transactions";
  static const String add_balance = baseUrl +"user/wallets/add_balance";
  static const String add_contact = baseUrl + "user/contact/add_contact";
  static const String my_notification = baseUrl + "user/get_my_notification";
  static const String removeProfile = baseUrl +"user/delete_account";

  // wishlists
  static const String get_my_advertisement_wishlists = baseUrl +"user/get_my_advertisement_wishlists";
  static const String get_my_auction_wishlists = baseUrl +"user/get_my_auction_wishlists";
  static const String add_or_remove_from_advertisement_wishlists = baseUrl +"user/add_or_remove_from_advertisement_wishlists/";
  static const String add_or_remove_from_auction_wishlists = baseUrl +"user/add_or_remove_from_auction_wishlists/";

}
