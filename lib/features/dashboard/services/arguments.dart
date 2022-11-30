// For Watchlist
class WatchListDropSelectedItem {
  final String symbol;
  final String companyID;
  final String increasePrice;
  final String decreasePrice;
  final int emailIncrease;
  final int emailDecrease;

  WatchListDropSelectedItem(this.symbol, this.companyID, this.increasePrice,
      this.decreasePrice, this.emailDecrease, this.emailIncrease);
}

// For Ncell Payment
class BizService {
  final bool ncellPayment;

  BizService(
    this.ncellPayment,
  );
}
