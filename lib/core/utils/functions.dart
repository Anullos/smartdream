// Show total price product
  String resumePrice(double currentPrice, int quantity) {
    return '\$${(currentPrice * quantity).toStringAsFixed(2)}';
  }