(function() {

  this.NumberHelpers = (function() {

    function NumberHelpers() {}

    NumberHelpers.number_to_currency = function(float, opts) {
      var decimal, integer, number, _delimiter, _precision, _ref, _ref1, _ref2, _ref3, _ref4, _separator, _unit;
      if (opts == null) {
        opts = {};
      }
      _precision = (_ref = opts.precision) != null ? _ref : 2;
      _unit = (_ref1 = opts.unit) != null ? _ref1 : '$';
      _separator = (_ref2 = opts.separator) != null ? _ref2 : '.';
      _delimiter = (_ref3 = opts.delimiter) != null ? _ref3 : ',';
      number = float.toString().split('.');
      integer = number[0];
      decimal = number[1];
      decimal = parseFloat("0." + decimal).toFixed(_precision);
      decimal = decimal.toString().split('.');
      decimal = (_ref4 = decimal[1]) != null ? _ref4 : '';
      if (!decimal) {
        _separator = '';
      }
      if (isNaN(integer)) {
        _separator = decimal = '';
      }
      integer = NumberHelpers.number_with_delimiter(integer, {
        delimiter: _delimiter
      });
      return "" + _unit + integer + _separator + decimal;
    };

    NumberHelpers.number_with_delimiter = function(float, opts) {
      var decimal, integer, number, rgx, _delimiter, _ref, _ref1, _ref2, _separator;
      if (opts == null) {
        opts = {};
      }
      _separator = (_ref = opts.separator) != null ? _ref : '.';
      _delimiter = (_ref1 = opts.delimiter) != null ? _ref1 : ',';
      number = float.toString().split(".");
      integer = number[0];
      decimal = (_ref2 = number[1]) != null ? _ref2 : '';
      if (!decimal) {
        _separator = '';
      }
      rgx = /(\d+)(\d{3})/;
      if (_delimiter) {
        while (rgx.test(integer)) {
          integer = integer.replace(rgx, "$1" + _delimiter + "$2");
        }
      }
      return "" + integer + _separator + decimal;
    };

    NumberHelpers.number_to_phone = function(number, opts) {
      var first, last, lng, second, str, _area_code, _country_code, _delimiter, _extension, _ref, _ref1, _ref2, _ref3;
      if (opts == null) {
        opts = {};
      }
      _area_code = (_ref = opts.area_code) != null ? _ref : false;
      _delimiter = (_ref1 = opts.delimiter) != null ? _ref1 : '-';
      _country_code = (_ref2 = opts.country_code) != null ? _ref2 : false;
      _extension = (_ref3 = opts.extension) != null ? _ref3 : false;
      if (isNaN(number)) {
        return number;
      }
      str = number.toString();
      lng = str.length;
      last = str.substr(lng - 4, lng);
      if (lng < 8) {
        first = str.substr(0, 3);
      } else {
        first = str.substr(0, 3);
        second = str.substr(3, 3);
        if (_area_code) {
          first = "(" + first + ") " + second;
        } else {
          first = "" + first + _delimiter + second;
        }
      }
      _extension = _extension ? " x " + opts.extension : '';
      _country_code = _country_code ? "+" + _country_code + _delimiter : '';
      return "" + _country_code + first + _delimiter + last + _extension;
    };

    NumberHelpers.currency_to_number = function (currency) {
      return Number(currency.replace(/[^0-9\.]+/g,""));
    };

    return NumberHelpers;

  })();

}).call(this);