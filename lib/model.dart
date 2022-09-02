class Temp {
  Response? response;

  Temp({
    this.response,
  });

  Temp.fromJson(Map<String, dynamic> json) {
    // print('TEMP 완료');

    response =
        json['response'] != null ? Response.fromJson(json['response']) : null;
  }
}

class Response {
  Header? header;
  Body? body;

  Response({this.header, this.body});

  Response.fromJson(Map<String, dynamic> json) {
    // print('리스톤스 완료');
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
    // print('해더 완료');

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
    // print('바디 완료');

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
    // print('아이템 완료');

    item = json['item'] != null ? Item.fromJson(json['item']) : null;
  }
}

class Item {
  String? altdDpwt;
  String? ec;
  String? mesureDpwt;
  String? msmtTm;
  String? obsrvtNm;
  String? saln;
  String? wtep;
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
    // print("시작");

    altdDpwt = json['altdDpwt'].toString();
    // print("완료1 ${altdDpwt}");
    ec = json['ec'].toString();
    // print("완료2 ${ec}");
    mesureDpwt = json['mesureDpwt'].toString();
    // print("완료3");
    msmtTm = json['msmtTm'].toString();
    // print("완료4");
    obsrvtNm = json['obsrvtNm'].toString();
    // print("완료5 ${obsrvtNm}");
    saln = json['saln'].toString();
    // print("완료6");
    wtep = json['wtep'].toString();
    // print("완료7");
    wtqltObsrvtCd = json['wtqltObsrvtCd'].toString();
    // print("완료8");
  }
}
