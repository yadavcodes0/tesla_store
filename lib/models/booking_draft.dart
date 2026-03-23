class BookingDraft {
  const BookingDraft({
    required this.modelId,
    required this.modelName,
    required this.trimId,
    required this.trimName,
    required this.colorId,
    required this.colorName,
    required this.price,
    this.customerName = '',
    this.email = '',
    this.phone = '',
    this.city = '',
    this.deposit = 250,
  });

  final String modelId;
  final String modelName;
  final String trimId;
  final String trimName;
  final String colorId;
  final String colorName;
  final int price;
  final String customerName;
  final String email;
  final String phone;
  final String city;
  final int deposit;

  BookingDraft copyWith({
    String? modelId,
    String? modelName,
    String? trimId,
    String? trimName,
    String? colorId,
    String? colorName,
    int? price,
    String? customerName,
    String? email,
    String? phone,
    String? city,
    int? deposit,
  }) {
    return BookingDraft(
      modelId: modelId ?? this.modelId,
      modelName: modelName ?? this.modelName,
      trimId: trimId ?? this.trimId,
      trimName: trimName ?? this.trimName,
      colorId: colorId ?? this.colorId,
      colorName: colorName ?? this.colorName,
      price: price ?? this.price,
      customerName: customerName ?? this.customerName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      city: city ?? this.city,
      deposit: deposit ?? this.deposit,
    );
  }
}
