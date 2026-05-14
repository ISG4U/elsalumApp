/// Note status enum with explicit int values stored in the DB.
enum NoteStatus {
  newNote(1),
  uploaded(2);

  const NoteStatus(this.value);
  final int value;

  static NoteStatus fromValue(int v) =>
      NoteStatus.values.firstWhere((e) => e.value == v);
}

/// Product type enum.
enum ProductType {
  box(1),
  unit(2);

  const ProductType(this.value);
  final int value;

  static ProductType fromValue(int v) =>
      ProductType.values.firstWhere((e) => e.value == v);
}

/// Product model with abbreviated JSON keys.
class Product {
  final String name;
  final double unitPrice;
  final int quantity;
  final ProductType type;

  Product({
    required this.name,
    required this.unitPrice,
    required this.quantity,
    required this.type,
  });
  double get total => unitPrice * quantity;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    name: json['n'] as String,
    unitPrice: (json['p'] as num).toDouble(),
    quantity: json['q'] as int,
    type: ProductType.fromValue(json['t'] as int),
  );

  Map<String, dynamic> toJson() => {
    'n': name,
    'p': unitPrice,
    'q': quantity,
    't': type.value,
  };

  /// Centralized conversion from [List] of [Product] to a multiline CSV string.
  static String listToCsv(List<Product> products) {
    if (products.isEmpty) return '';
    return products
        .map((p) => '${p.name}, ${p.unitPrice}, ${p.quantity}, ${p.type.value}')
        .join('\n');
  }

  /// Centralized conversion from a multiline CSV string to a [List] of [Product].
  static List<Product> listFromCsv(String csv) {
    return csv.split('\n').where((line) => line.trim().isNotEmpty).map((line) {
      final parts = line.split(',');
      if (parts.length >= 4) {
        return Product(
          name: parts[0].trim(),
          unitPrice: double.tryParse(parts[1].trim()) ?? 0,
          quantity: int.tryParse(parts[2].trim()) ?? 1,
          type: ProductType.fromValue(int.tryParse(parts[3].trim()) ?? 1),
        );
      }
      // Fallback parsing for just name or partially formatted lines
      return Product(
        name: line.trim(),
        unitPrice: 0,
        quantity: 1,
        type: ProductType.box,
      );
    }).toList();
  }
}

/// Lightweight domain model that mirrors the Drift-generated data class
/// but keeps business logic separate from generated code.
class NoteModel {
  final String id;
  final NoteStatus status;
  final String farms;
  final String merchant;
  final int trackNumber;
  final DateTime creationDate;
  final String userName;
  final List<Product> products;

  const NoteModel({
    required this.id,
    required this.status,
    required this.farms,
    required this.merchant,
    required this.trackNumber,
    required this.creationDate,
    required this.userName,
    required this.products,
  });
}
