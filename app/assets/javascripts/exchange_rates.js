(function(win, $, _) {

  var REFRESH_SECONDS = 10;

  var callback = function() {

    var url = '/exchange_rates.json';

    var table = $('.exchange-rates');

    var start_data_row_idx = 2;
    var start_data_col_idx = 1;

    var onFinish = function(response) {
      var currencies = [ 'eur', 'usd', 'chf', 'gbp' ];
      var sources = [ 'alior', 'walutomat', 'cinkciarz' ];
      _.each(sources, function(source, source_idx) {
        _.each(currencies, function(currency, currency_idx) {
          var values = response[source_idx * currencies.length + currency_idx];
          var row_idx = start_data_row_idx + currency_idx;
          var source_col_idx = start_data_col_idx + 2 * source_idx;
          var row = $('tr:eq(' + row_idx + ')', table);
          var cell_buy  = $('td:eq(' + (source_col_idx + 0) + ')', row);
          var cell_sell = $('td:eq(' + (source_col_idx + 1) + ')', row);
          cell_buy.text(values.buy);
          cell_sell.text(values.sell);
        });
      });
    };

    $.get(url, onFinish);
  };

  setInterval(callback, REFRESH_SECONDS * 1000);

})(window, jQuery, _);

