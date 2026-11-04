import 'package:image_picker/image_picker.dart';

abstract class AppEvent {
  AppEvent();
}



class ChangeVisibility extends AppEvent{
  final suffixIcon,isAbscure;
  ChangeVisibility({required this.suffixIcon,required this.isAbscure});
}

class SelectFlashSales extends AppEvent{
  int percentIndex;
  SelectFlashSales({required this.percentIndex});
}

class LoadOrdersAndProfileImage extends AppEvent {
}

class LoadAddress extends AppEvent {
}

class LoadContact extends AppEvent {
}

class EditAddress extends AppEvent {
  String value,purpose;
  EditAddress({required this.purpose,required this.value});
}


class SelectedFlashSalesDiscount extends AppEvent{
  String percentSelected;
  SelectedFlashSalesDiscount({required this.percentSelected});
}

class ClearFilter extends AppEvent{
}

class UpdateFilters extends AppEvent {
  final Map<String, String> filters;

  UpdateFilters({required this.filters});
}

class ScreensNavigation extends AppEvent{
  final int index;
  ScreensNavigation({required this.index});
}

class GetProducts extends AppEvent {
}

class ChangeDeliveryIndex extends AppEvent {
  final int index;
  ChangeDeliveryIndex({required this.index});
}

class GetFleshSales extends AppEvent {
}



class ChangeRating extends AppEvent {
  double value;
  ChangeRating({required this.value});
}

class SaveRating extends AppEvent {
  String ratingValue;
  int ordersPlacedIndex;
  SaveRating({required this.ratingValue,required this.ordersPlacedIndex});
}


class StoreOrder extends AppEvent {
  final double totalCost;
  StoreOrder({required this.totalCost});
}

class StoreVoucherInApp extends AppEvent {
  final voucherIndex;
  StoreVoucherInApp({required this.voucherIndex});
}

class RemoveVoucherInApp extends AppEvent {
}

class ClearSearch extends AppEvent {
}

class LoadSearchHistory extends AppEvent {
}

class AddToCart extends AppEvent {
}

class DecreaseQuantityFromCart extends AppEvent {
  final int decreaseIndex;
  DecreaseQuantityFromCart({required this.decreaseIndex});
}


class IncreaseQuantityFromCart extends AppEvent {
  final int increaseIndex;
  IncreaseQuantityFromCart({required this.increaseIndex});
}

class RemoveFromCart extends AppEvent {
  final int removeIndex;
  RemoveFromCart({required this.removeIndex});
}






class AddFavorateToCart extends AppEvent {
  String productId;
  AddFavorateToCart({required this.productId});
}





class AddToFavourite extends AppEvent {
  final String productId;
  AddToFavourite({required this.productId});
}

class RemoveFromFavourite extends AppEvent {
  final String productId;
  RemoveFromFavourite({required this.productId});
}


class UpdateCartProgress extends AppEvent {
  final String productId,size;
  final int quantity;
  final String color;

  UpdateCartProgress({required this.productId,required this.quantity,required this.color,required this.size});
}


class UpdateCart extends AppEvent {
  final int quantity;
  final int cartIndex;

  UpdateCart({required this.cartIndex,required this.quantity});
}

class SearchProducts extends AppEvent {
  String searchText;
  SearchProducts({required this.searchText});
}

