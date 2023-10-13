class Imc {
  int _id = 0;
  double _height = 0.0;
  double _weight = 0.0;
  double _imc = 0.0;
  String _status = "";

  Imc(this._id, this._height, this._weight, this._imc, this._status);

  //getters and setters
  int get id => _id;
  set id(int value) => _id = value;

  double get height => _height;
  set height(double value) => _height = value;

  double get weight => _weight;
  set weight(double value) => _weight = value;

  double get imc => _imc;
  set imc(double value) => _imc = value;

  String get status => _status;
  set status(String value) => _status = value;
}
