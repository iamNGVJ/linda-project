class Student{
  int _id;
  String _fullname;
  String _schlId;
  String _klass;
  String _date;
  int _attendance;

  Student(this._fullname, this._schlId, this._klass, this._date);
  Student.withId(this._id, this._fullname, this._schlId, this._klass, this._date);

  int get id => _id;
  String get fullname => _fullname;
  String get schlId => _schlId;
  String get klass => _klass;
  String get data => _date;
  int get attendance => _attendance;

  set fullname(String newFullName){
    if(newFullName.length < 100){
      this._fullname = newFullName;
    }
  }

  set schlId(String newId){
    if(newId.length == 8){
      this._schlId = newId;
    }
  }

  set klass(String newClass){
    this._klass = newClass;
  }

  set date(String newDate){
    this._date = newDate;
  }

  set attendance(int value){
    this._attendance = 0;
  }

  //convert student object to map object
  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    if(id != null){
      map['id'] = _id;
    }
    map['fullname'] = _fullname;
    map['schlId'] = _schlId;
    map['klass'] = _klass;
    map['date'] = _date;
    return map;
  }

  //extract a note from object
  Student.fromMapObject(Map<String, dynamic> map){
    this._id = map['id'];
    this._fullname = map['fullname'];
    this._schlId = map['schlId'];
    this._klass = map['klass'];
    this._date = map['date'];
  }
}