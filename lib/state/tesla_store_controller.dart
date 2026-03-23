import 'package:flutter/foundation.dart';
import 'package:tesla_store/data/tesla_repository.dart';
import 'package:tesla_store/models/booking_draft.dart';
import 'package:tesla_store/models/vehicle_color.dart';
import 'package:tesla_store/models/vehicle_model.dart';
import 'package:tesla_store/models/vehicle_trim.dart';

class TeslaStoreController extends ChangeNotifier {
  TeslaStoreController({TeslaRepository? repository})
      : _repository = repository ?? const TeslaRepository(),
        _models = (repository ?? const TeslaRepository()).getModels();

  final TeslaRepository _repository;
  final List<VehicleModel> _models;

  final Set<String> _favoriteIds = <String>{};
  final List<String> _recentlyViewedIds = <String>[];
  final Map<String, String> _selectedTrimIds = <String, String>{};
  final Map<String, String> _selectedColorIds = <String, String>{};

  BookingDraft? _bookingDraft;
  String? _confirmationCode;

  List<VehicleModel> get models => List.unmodifiable(_models);
  List<String> get categories =>
      _models.map((model) => model.category).toSet().toList(growable: false);
  int get favoriteCount => _favoriteIds.length;
  BookingDraft? get bookingDraft => _bookingDraft;
  String? get confirmationCode => _confirmationCode;

  VehicleModel featuredModel() => _models.first;

  VehicleModel getModel(String modelId) {
    return _models.firstWhere((model) => model.id == modelId);
  }

  List<VehicleModel> modelsForCategory(String? category) {
    if (category == null || category == 'All') {
      return models;
    }
    return _models.where((model) => model.category == category).toList();
  }

  bool isFavorite(String modelId) => _favoriteIds.contains(modelId);

  void toggleFavorite(String modelId) {
    if (_favoriteIds.contains(modelId)) {
      _favoriteIds.remove(modelId);
    } else {
      _favoriteIds.add(modelId);
    }
    notifyListeners();
  }

  List<VehicleModel> favoriteModels() {
    return _models.where((model) => _favoriteIds.contains(model.id)).toList();
  }

  void markRecentlyViewed(String modelId) {
    _recentlyViewedIds.remove(modelId);
    _recentlyViewedIds.insert(0, modelId);
    if (_recentlyViewedIds.length > 4) {
      _recentlyViewedIds.removeLast();
    }
    notifyListeners();
  }

  List<VehicleModel> recentlyViewedModels() {
    return _recentlyViewedIds.map(getModel).toList();
  }

  VehicleTrim selectedTrimFor(String modelId) {
    final model = getModel(modelId);
    final trimId = _selectedTrimIds[modelId];
    return model.trims.firstWhere(
      (trim) => trim.id == trimId,
      orElse: () => model.trims.first,
    );
  }

  VehicleColorOption selectedColorFor(String modelId) {
    final trim = selectedTrimFor(modelId);
    final colorId = _selectedColorIds[modelId];
    return trim.colors.firstWhere(
      (color) => color.id == colorId,
      orElse: () => trim.colors.first,
    );
  }

  void selectTrim(String modelId, String trimId) {
    final model = getModel(modelId);
    final trim = model.trims.firstWhere((item) => item.id == trimId);
    _selectedTrimIds[modelId] = trim.id;
    _selectedColorIds[modelId] = trim.colors.first.id;
    _syncDraftSelection(modelId);
    notifyListeners();
  }

  void selectColor(String modelId, String colorId) {
    _selectedColorIds[modelId] = colorId;
    _syncDraftSelection(modelId);
    notifyListeners();
  }

  void startBooking(String modelId) {
    final model = getModel(modelId);
    final trim = selectedTrimFor(modelId);
    final color = selectedColorFor(modelId);
    _bookingDraft = BookingDraft(
      modelId: model.id,
      modelName: model.name,
      trimId: trim.id,
      trimName: trim.name,
      colorId: color.id,
      colorName: color.name,
      price: trim.price,
    );
    notifyListeners();
  }

  void updateBookingDetails({
    required String customerName,
    required String email,
    required String phone,
    required String city,
  }) {
    final current = _bookingDraft;
    if (current == null) {
      return;
    }
    _bookingDraft = current.copyWith(
      customerName: customerName,
      email: email,
      phone: phone,
      city: city,
    );
    notifyListeners();
  }

  void completeBooking() {
    _confirmationCode =
        'TSL-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
    notifyListeners();
  }

  TeslaRepository get repository => _repository;

  void _syncDraftSelection(String modelId) {
    final current = _bookingDraft;
    if (current == null || current.modelId != modelId) {
      return;
    }
    final trim = selectedTrimFor(modelId);
    final color = selectedColorFor(modelId);
    _bookingDraft = current.copyWith(
      trimId: trim.id,
      trimName: trim.name,
      colorId: color.id,
      colorName: color.name,
      price: trim.price,
    );
  }
}
