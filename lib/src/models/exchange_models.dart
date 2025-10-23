// =============================================================================
// MISSING EXCHANGE MODELS - Quick Implementation for Phase 6B Completion
// =============================================================================

/// Update request for an exchange
class AdminUpdateExchange {
  final String? metadata;

  const AdminUpdateExchange({this.metadata});

  Map<String, dynamic> toJson() => {if (metadata != null) 'metadata': metadata};
}

/// Cancel exchange request
class AdminCancelExchange {
  final String? reason;

  const AdminCancelExchange({this.reason});

  Map<String, dynamic> toJson() => {if (reason != null) 'reason': reason};
}

/// Exchange status
class AdminExchangeStatus {
  final String status;

  const AdminExchangeStatus({required this.status});

  Map<String, dynamic> toJson() => {'status': status};
}

/// Create exchange item request
class AdminCreateExchangeItem {
  final String productId;
  final int quantity;

  const AdminCreateExchangeItem({
    required this.productId,
    required this.quantity,
  });

  Map<String, dynamic> toJson() => {
    'product_id': productId,
    'quantity': quantity,
  };
}

/// Create additional exchange item request
class AdminCreateAdditionalExchangeItem {
  final String productId;
  final int quantity;

  const AdminCreateAdditionalExchangeItem({
    required this.productId,
    required this.quantity,
  });

  Map<String, dynamic> toJson() => {
    'product_id': productId,
    'quantity': quantity,
  };
}

/// Process exchange payment request
class AdminProcessExchangePayment {
  final String paymentMethod;
  final double amount;

  const AdminProcessExchangePayment({
    required this.paymentMethod,
    required this.amount,
  });

  Map<String, dynamic> toJson() => {
    'payment_method': paymentMethod,
    'amount': amount,
  };
}
