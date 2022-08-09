class Temp {
  Response? response;

  Temp({
    this.response,
  });

  Temp.fromJson(Map<String, dynamic> json) {
    response =
        json['response'] != null ? Response.fromJson(json['response']) : null;
  }
}

class Response {
  Header? header;
  Body? body;

  Response({this.header, this.body});

  Response.fromJson(Map<String, dynamic> json) {
    header = json['header'] != null ? Header.fromJson(json['header']) : null;
    body = json['body'] != null ? Body.fromJson(json['body']) : null;
  }
}

class Header {
  String? resultCode;
  String? resultMsg;

  Header({
    this.resultCode,
    this.resultMsg,
  });

  Header.fromJson(Map<String, dynamic> json) {
    resultCode = json['resultCode'];
    resultMsg = json['resultMsg'];
  }
}

class Body {
  Items? items;
  int? numOfRows;
  int? pageNo;
  int? totalCount;

  Body({
    this.items,
    this.numOfRows,
    this.pageNo,
    this.totalCount,
  });

  Body.fromJson(Map<String, dynamic> json) {
    numOfRows = json['numOfRows'];
    pageNo = json['pageNo'];
    totalCount = json['totalCount'];
    items = json['items'] != null ? Items.fromJson(json['items']) : null;
  }
}

class Items {
  Item? item;

  Items({this.item});

  Items.fromJson(Map<String, dynamic> json) {
    item = json['item'] != null ? Item.fromJson(json['item']) : null;
  }
}

class Item {
  double? altdDpwt;
  String? ec;
  double? mesureDpwt;
  String? msmtTm;
  String? obsrvtNm;
  double? saln;
  double? wtep;
  String? wtqltObsrvtCd;

  Item({
    this.altdDpwt,
    this.ec,
    this.mesureDpwt,
    this.msmtTm,
    this.obsrvtNm,
    this.saln,
    this.wtep,
    this.wtqltObsrvtCd,
  });

  Item.fromJson(Map<String, dynamic> json) {
    altdDpwt = json['altdDpwt'];
    // print("완료1");
    ec = json['ec'];
    // print("완료2");
    mesureDpwt = json['mesureDpwt'];
    // print("완료3");
    msmtTm = json['msmtTm'].toString();
    // print("완료4");
    obsrvtNm = json['obsrvtNm'];
    // print("완료5");
    saln = json['saln'];
    // print("완료6");
    wtep = double.parse(json['wtep'].toString());
    // print("완료7");
    wtqltObsrvtCd = json['wtqltObsrvtCd'];
    // print("완료8");
  }
}
