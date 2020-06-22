class Todo {
  int _id;
  String _title;
  String _description;
  String _date;

  String _kId = 'id';
  String _kTitle = 'title';
  String _kDescription = 'description';
  String _kDate = 'date';

  Todo(this._title, this._date, [this._description]);

  Todo.withId(this._id, this._title, this._date, [this._description]);

  int get id => _id;

  String get title => _title;

  String get description => _description;

  String get date => _date;

  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  set description(String newDescription) {
    if (newDescription.length <= 255) {
      this._description = newDescription;
    }
  }

  set date(String newDate) {
    this._date = newDate;
  }

  // Convert a Note object into a Map object
  Map<String, dynamic>toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) {
      map[_kId] = _id;
    }
    map[_kTitle] = _title;
    map[_kDescription] = _description;
    map[_kDate] = _date;

    return map;
  }

  // Extract a Note from a Map object
  Todo.fromMapObject(Map<String, dynamic> map) {
    this._id = map[this._kId];
    this._title = map[this._kTitle];
    this._description = map[this._kDescription];
    this._date = map[this._kDate];
  }
}