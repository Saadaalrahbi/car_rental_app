
class RPricingCalculator{
 ///calculating price based on shipping and tax
  static double calculateTotalPrice(double productPrice, String location){
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;


    double totalPrice = productPrice + taxAmount;
    return totalPrice;
  }

/// the tax calculation
  static String calculateTax(double productPrice, String location){
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;
    return taxAmount.toStringAsFixed(2);
  }

  static double getTaxRateForLocation(String location){
    return 0.10;
  }

  }
