class GeographicsMastersResponse {
  String? statusMessage;
  String? message;
  int? statusCode;
  GeographicData? geoGrapicData;

  GeographicsMastersResponse(
      {this.statusMessage, this.message, this.statusCode, this.geoGrapicData});

  GeographicsMastersResponse.fromJson(Map<String, dynamic> json) {
    statusMessage = json['status_Message'];
    message = json['message'];
    statusCode = json['status_Code'];
    geoGrapicData =
        json['data'] != null ? new GeographicData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_Message'] = this.statusMessage;
    data['message'] = this.message;
    data['status_Code'] = this.statusCode;
    if (this.geoGrapicData != null) {
      data['data'] = this.geoGrapicData!.toJson();
    }
    return data;
  }
}

class GeographicData {
  List<ResidentiaLSTATUS>? residentiaLSTATUS;
  List<TypEROOF>? typEROOF;
  List<Ownership>? ownership;
  List<Cheyutha>? cheyutha;
  List<Toddytapper>? toddytapper;
  List<Singlewomen>? singlewomen;
  List<Pension>? pension;

  GeographicData(
      {this.residentiaLSTATUS,
      this.typEROOF,
      this.ownership,
      this.cheyutha,
      this.toddytapper,
      this.singlewomen});

  GeographicData.fromJson(Map<String, dynamic> json) {
    if (json['residentiaL_STATUS'] != null) {
      residentiaLSTATUS = <ResidentiaLSTATUS>[];
      json['residentiaL_STATUS'].forEach((v) {
        residentiaLSTATUS!.add(new ResidentiaLSTATUS.fromJson(v));
      });
    }
    if (json['typE_ROOF'] != null) {
      typEROOF = <TypEROOF>[];
      json['typE_ROOF'].forEach((v) {
        typEROOF!.add(new TypEROOF.fromJson(v));
      });
    }
    if (json['ownership'] != null) {
      ownership = <Ownership>[];
      json['ownership'].forEach((v) {
        ownership!.add(new Ownership.fromJson(v));
      });
    }
    if (json['cheyutha'] != null) {
      cheyutha = <Cheyutha>[];
      json['cheyutha'].forEach((v) {
        cheyutha!.add(new Cheyutha.fromJson(v));
      });
    }
    if (json['toddytapper'] != null) {
      toddytapper = <Toddytapper>[];
      json['toddytapper'].forEach((v) {
        toddytapper!.add(new Toddytapper.fromJson(v));
      });
    }
    if (json['pension'] != null) {
      pension = <Pension>[];
      json['pension'].forEach((v) {
        pension!.add(new Pension.fromJson(v));
      });
    }
    if (json['singlewomen'] != null) {
      singlewomen = <Singlewomen>[];
      json['singlewomen'].forEach((v) {
        singlewomen!.add(new Singlewomen.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.residentiaLSTATUS != null) {
      data['residentiaL_STATUS'] =
          this.residentiaLSTATUS!.map((v) => v.toJson()).toList();
    }
    if (this.typEROOF != null) {
      data['typE_ROOF'] = this.typEROOF!.map((v) => v.toJson()).toList();
    }
    if (this.ownership != null) {
      data['ownership'] = this.ownership!.map((v) => v.toJson()).toList();
    }
    if (this.cheyutha != null) {
      data['cheyutha'] = this.cheyutha!.map((v) => v.toJson()).toList();
    }
    if (this.toddytapper != null) {
      data['toddytapper'] = this.toddytapper!.map((v) => v.toJson()).toList();
    }
    if (this.pension != null) {
      data['pension'] = this.pension!.map((v) => v.toJson()).toList();
    }
    if (this.singlewomen != null) {
      data['singlewomen'] = this.singlewomen!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResidentiaLSTATUS {
  String? reSNAME;
  int? reSID;

  ResidentiaLSTATUS({this.reSNAME, this.reSID});

  ResidentiaLSTATUS.fromJson(Map<String, dynamic> json) {
    reSNAME = json['reS_NAME'];
    reSID = json['reS_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reS_NAME'] = this.reSNAME;
    data['reS_ID'] = this.reSID;
    return data;
  }
}

class TypEROOF {
  String? rooFNAME;
  int? rooFID;

  TypEROOF({this.rooFNAME, this.rooFID});

  TypEROOF.fromJson(Map<String, dynamic> json) {
    rooFNAME = json['rooF_NAME'];
    rooFID = json['rooF_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rooF_NAME'] = this.rooFNAME;
    data['rooF_ID'] = this.rooFID;
    return data;
  }
}

class Ownership {
  String? ownershiPNAME;
  int? ownershiPID;

  Ownership({this.ownershiPNAME, this.ownershiPID});

  Ownership.fromJson(Map<String, dynamic> json) {
    ownershiPNAME = json['ownershiP_NAME'];
    ownershiPID = json['ownershiP_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ownershiP_NAME'] = this.ownershiPNAME;
    data['ownershiP_ID'] = this.ownershiPID;
    return data;
  }
}

class Cheyutha {
  String? cschemENAME;
  int? cschemEID;
  int? age;

  Cheyutha({this.cschemENAME, this.cschemEID, this.age});

  Cheyutha.fromJson(Map<String, dynamic> json) {
    cschemENAME = json['cschemE_NAME'];
    cschemEID = json['cschemE_ID'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cschemE_NAME'] = this.cschemENAME;
    data['cschemE_ID'] = this.cschemEID;
    data['age'] = this.age;
    return data;
  }
}

class Toddytapper {
  String? tTNAME;
  int? tTID;

  Toddytapper({this.tTNAME, this.tTID});

  Toddytapper.fromJson(Map<String, dynamic> json) {
    tTNAME = json['tT_NAME'];
    tTID = json['tT_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tT_NAME'] = this.tTNAME;
    data['tT_ID'] = this.tTID;
    return data;
  }
}

class Singlewomen {
  String? sWNAME;
  int? sWID;
  int? age;

  Singlewomen({this.sWNAME, this.sWID, this.age});

  Singlewomen.fromJson(Map<String, dynamic> json) {
    sWNAME = json['sW_NAME'];
    sWID = json['sW_ID'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sW_NAME'] = this.sWNAME;
    data['sW_ID'] = this.sWID;
    data['age'] = this.age;
    return data;
  }
}

class Pension {
  String? pensioNNAME;
  int? pensioNID;

  Pension({this.pensioNNAME, this.pensioNID});

  Pension.fromJson(Map<String, dynamic> json) {
    pensioNNAME = json['pensioN_NAME'];
    pensioNID = json['pensioN_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pensioN_NAME'] = this.pensioNNAME;
    data['pensioN_ID'] = this.pensioNID;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'pensioN_ID': pensioNID,
      'pensioN_NAME': pensioNNAME,
    };
  }
}
