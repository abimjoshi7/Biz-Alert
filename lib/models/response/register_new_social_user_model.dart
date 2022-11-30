/// status : "Success"
/// message : ""
/// dataCollection : {"msgType":"success","msg":"User registeration successfull. Please check your email inbox for account activation link and mobile inbox for mobile verification code","social":"Server"}

class RegisterNewSocialUserResponse {
  String? _status;
  String? _message;
  DataCollection? _dataCollection;

  String? get status => _status;
  String? get message => _message;
  DataCollection? get dataCollection => _dataCollection;

  RegisterNewSocialUserResponse(
      {String? status, String? message, DataCollection? dataCollection}) {
    _status = status;
    _message = message;
    _dataCollection = dataCollection;
  }

  RegisterNewSocialUserResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _dataCollection = json['dataCollection'] != null
        ? DataCollection.fromJson(json['dataCollection'])
        : null;
  }

  Map<String?, dynamic> toJson() {
    var map = <String?, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_dataCollection != null) {
      map['dataCollection'] = _dataCollection?.toJson();
    }
    return map;
  }
}

/// msgType : "success"
/// msg : "User registeration successfull. Please check your email inbox for account activation link and mobile inbox for mobile verification code"
/// social : "Server"

class DataCollection {
  String? _msgType;
  String? _msg;
  String? _social;

  String? get msgType => _msgType;
  String? get msg => _msg;
  String? get social => _social;

  DataCollection({String? msgType, String? msg, String? social}) {
    _msgType = msgType;
    _msg = msg;
    _social = social;
  }

  DataCollection.fromJson(dynamic json) {
    _msgType = json['msgType'];
    _msg = json['msg'];
    _social = json['social'];
  }

  Map<String?, dynamic> toJson() {
    var map = <String?, dynamic>{};
    map['msgType'] = _msgType;
    map['msg'] = _msg;
    map['social'] = _social;
    return map;
  }
}
