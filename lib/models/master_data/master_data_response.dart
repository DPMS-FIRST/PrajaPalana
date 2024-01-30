class MasterDataResponse {
  String? statusMessage;
  String? message;
  int? statusCode;
  Data? data;

  MasterDataResponse(
      {this.statusMessage, this.message, this.statusCode, this.data});

  MasterDataResponse.fromJson(Map<String, dynamic> json) {
    statusMessage = json['status_Message'].toString();
    message = json['message'].toString();
    statusCode = json['status_Code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_Message'] = this.statusMessage;
    data['message'] = this.message;
    data['status_Code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Gender>? gender;
  List<Caste>? caste;
  List<Occupations>? occupations;
  List<Relationships>? relationships;
  List<Districts>? districts;
  List<Gascompanies>? gascompanies;
  List<Electricityunits>? electricityunits;
  String? policestation;

  Data(
      {this.gender,
      this.caste,
      this.occupations,
      this.relationships,
      this.districts,
      this.gascompanies,
      this.electricityunits,
      this.policestation});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['gender'] != null) {
      gender = <Gender>[];
      json['gender'].forEach((v) {
        gender!.add(new Gender.fromJson(v));
      });
    }
    if (json['caste'] != null) {
      caste = <Caste>[];
      json['caste'].forEach((v) {
        caste!.add(new Caste.fromJson(v));
      });
    }
    if (json['occupations'] != null) {
      occupations = <Occupations>[];
      json['occupations'].forEach((v) {
        occupations!.add(new Occupations.fromJson(v));
      });
    }
    if (json['relationships'] != null) {
      relationships = <Relationships>[];
      json['relationships'].forEach((v) {
        relationships!.add(new Relationships.fromJson(v));
      });
    }
    if (json['districts'] != null) {
      districts = <Districts>[];
      json['districts'].forEach((v) {
        districts!.add(new Districts.fromJson(v));
      });
    }
    if (json['gascompanies'] != null) {
      gascompanies = <Gascompanies>[];
      json['gascompanies'].forEach((v) {
        gascompanies!.add(new Gascompanies.fromJson(v));
      });
    }
    if (json['electricityunits'] != null) {
      electricityunits = <Electricityunits>[];
      json['electricityunits'].forEach((v) {
        electricityunits!.add(new Electricityunits.fromJson(v));
      });
    }
    policestation = json['policestation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.gender != null) {
      data['gender'] = this.gender!.map((v) => v.toJson()).toList();
    }
    if (this.caste != null) {
      data['caste'] = this.caste!.map((v) => v.toJson()).toList();
    }
    if (this.occupations != null) {
      data['occupations'] = this.occupations!.map((v) => v.toJson()).toList();
    }
    if (this.relationships != null) {
      data['relationships'] =
          this.relationships!.map((v) => v.toJson()).toList();
    }
    if (this.districts != null) {
      data['districts'] = this.districts!.map((v) => v.toJson()).toList();
    }
    if (this.gascompanies != null) {
      data['gascompanies'] = this.gascompanies!.map((v) => v.toJson()).toList();
    }
    if (this.electricityunits != null) {
      data['electricityunits'] =
          this.electricityunits!.map((v) => v.toJson()).toList();
    }
    data['policestation'] = this.policestation;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'gender': gender,
      'caste': caste,
      'occupations': occupations,
      'relationships': relationships,
      'districts': districts,
      'gascompanies': gascompanies,
      'electricityunits': electricityunits,
      'policestation': policestation,
    };
  }
}

class Gender {
  String? gendername;
  String? genderid;

  Gender({this.gendername, this.genderid});

  Gender.fromJson(Map<String, dynamic> json) {
    gendername = json['gendername'].toString();
    genderid = json['genderid'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gendername'] = this.gendername;
    data['genderid'] = this.genderid;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'genderid': genderid,
      'gendername': gendername,
    };
  }
}

class Caste {
  String? castname;
  String? castid;

  Caste({this.castname, this.castid});

  Caste.fromJson(Map<String, dynamic> json) {
    castname = json['castname'].toString();
    castid = json['castid'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['castname'] = this.castname;
    data['castid'] = this.castid;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'castname': castname,
      'castid': castid,
    };
  }
}

class Occupations {
  String? occupatioNNAME;
  String? id;

  Occupations({this.occupatioNNAME, this.id});

  Occupations.fromJson(Map<String, dynamic> json) {
    occupatioNNAME = json['occupatioN_NAME'].toString();
    id = json['id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['occupatioN_NAME'] = this.occupatioNNAME;
    data['id'] = this.id;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'occupatioN_NAME': occupatioNNAME,
      'id': id,
    };
  }
}

class Relationships {
  String? relationname;
  String? id;

  Relationships({this.relationname, this.id});

  Relationships.fromJson(Map<String, dynamic> json) {
    relationname = json['relationname'].toString();
    id = json['id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['relationname'] = this.relationname;
    data['id'] = this.id;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'relationname': relationname,
      'id': id,
    };
  }
}

class Districts {
  String? districtname;
  String? districtid;
  String? mandalid;
  String? mandalname;
  String? panchayatid;
  String? panchayatname;
  String? ulBCODE;
  String? municipalitYNAME;
  String? type;

  Districts(
      {this.districtname,
      this.districtid,
      this.mandalid,
      this.mandalname,
      this.panchayatid,
      this.panchayatname,
      this.ulBCODE,
      this.municipalitYNAME,
      this.type});

  Districts.fromJson(Map<String, dynamic> json) {
    districtname = json['districtname'].toString();
    districtid = json['districtid'].toString();
    mandalid = json['mandalid'].toString();
    mandalname = json['mandalname'].toString();
    panchayatid = json['panchayatid'].toString();
    panchayatname = json['panchayatname'].toString();
    ulBCODE = json['ulB_CODE'].toString();
    municipalitYNAME = json['municipalitY_NAME'].toString();
    type = json['type'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['districtname'] = this.districtname;
    data['districtid'] = this.districtid;
    data['mandalid'] = this.mandalid;
    data['mandalname'] = this.mandalname;
    data['panchayatid'] = this.panchayatid;
    data['panchayatname'] = this.panchayatname;
    data['ulB_CODE'] = this.ulBCODE;
    data['municipalitY_NAME'] = this.municipalitYNAME;
    data['type'] = this.type;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'districtname': districtname,
      'districtid': districtid,
      'mandalid': mandalid,
      'mandalname': mandalname,
      'panchayatid': panchayatid,
      'panchayatname': panchayatname,
      'ulB_CODE': ulBCODE,
      'municipalitY_NAME': municipalitYNAME,
      'type': type,
    };
  }
}

class Gascompanies {
  String? gasname;
  String? id;

  Gascompanies({this.gasname, this.id});

  Gascompanies.fromJson(Map<String, dynamic> json) {
    gasname = json['gasname'].toString();
    id = json['id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gasname'] = this.gasname;
    data['id'] = this.id;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'gasname': gasname,
      'id': id,
    };
  }
}

class Electricityunits {
  String? unitsname;
  String? id;

  Electricityunits({this.unitsname, this.id});

  Electricityunits.fromJson(Map<String, dynamic> json) {
    unitsname = json['unitsname'].toString();
    id = json['id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unitsname'] = this.unitsname;
    data['id'] = this.id;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'unitsname': unitsname,
      'id': id,
    };
  }
}
