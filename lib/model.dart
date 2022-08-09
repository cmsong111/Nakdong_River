import 'package:nakdong_river/http.dart';

class Temp {
  Response? response;

  Temp({
    this.response,
  });

  Temp.fromJson(Map<String, dynamic> json) {
    print("response : " + json['response'].toString());
    response =
        json['response'] != null ? Response.fromJson(json['response']) : null;
  }
}

class Response {
  Header? header;
  Body? body;

  Response({this.header, this.body});

  Response.fromJson(Map<String, dynamic> json) {
    print("\n\n");
    print("header : " + json['header'].toString());
    print("body : " + json['body'].toString());
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
    print("\n\n");
    print("numOfRows : " + json['numOfRows'].toString());
    print("pageNo : " + json['pageNo'].toString());
    print("totalCount : " + json['totalCount'].toString());
    print("items : " + json['items'].toString());

    numOfRows = json['numOfRows'];
    pageNo = json['pageNo'];
    totalCount = json['totalCount'];
    queryParameters = json['pageNo'].toString() as Map<String, String>;
    items = json['items'] != null ? Items.fromJson(json['items']) : null;
  }
}

class Items {
  Item? item;

  Items({this.item});

  Items.fromJson(Map<String, dynamic> json) {
    print("\n\n");
    print("item : " + json['item'].toString());
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
    print("\n\n");
    print("altdDpwt : " + json['altdDpwt'].toString());
    print("ec : " + json['ec'].toString());
    print("mesureDpwt : " + json['mesureDpwt'].toString());
    print("saln : " + json['saln'].toString());
    print("wtep : " + json['wtep'].toString());
    print("wtqltObsrvtCd : " + json['wtqltObsrvtCd'].toString());

    altdDpwt = json['altdDpwt'];
    ec = json['ec'];
    mesureDpwt = json['mesureDpwt'];
    msmtTm = json['msmtTm'];
    obsrvtNm = json['obsrvtNm'];
    saln = json['saln'];
    wtep = json['wtep'];
    wtqltObsrvtCd = json['wtqltObsrvtCd'];
  }
}
