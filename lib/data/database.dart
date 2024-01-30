import 'package:praja_palana/models/master_data/master_data_response.dart';
import 'package:praja_palana/models/master_data/master_geograpics_response.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class DatabaseClient {
  static final databaseName = 'prajaPalana.db';
  static final databaseVersion = 1;

  static final genderTable = 'GenderTable';
  static final casteTable = 'CasteTable';
  static final occupationTable = 'OccupationTable';
  static final relationshipsTable = 'RelationshipsTable';
  static final districtsTable = 'DistrictsTable';
  static final gasCompaniesTable = 'GasCompaniesTable';
  static final electricityUnitsTable = 'ElectricityUnitsTable';
  static final residentailTable = 'ResidentailTable';
  static final typeRoofTable = 'TypeRoofTable';
  static final ownershipTable = 'OwnershipTable';
  static final cheyuthaTable = 'CheyuthaTable';
  static final toddyTapperTable = 'ToddyTapperTable';
  static final singleWomenTable = 'SingleWomenTable';
  static final pensionTable = 'PensionTable';

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, databaseName);

    return await openDatabase(path, version: databaseVersion,
        onCreate: (db, version) async {
      //Table creation to Save GenderData
      await db.execute('''
            CREATE TABLE $genderTable (
              gendername TEXT,
              genderid TEXT
            )
          ''');
      //Table creation to Save CasteData
      await db.execute('''
            CREATE TABLE $casteTable (
              castname TEXT,
              castid TEXT
            )
          ''');
      //Table creation to Save OccupationTable
      await db.execute('''
            CREATE TABLE $occupationTable (
              occupatioN_NAME TEXT,
              id TEXT
            )
          ''');
      await db.execute('''
            CREATE TABLE $relationshipsTable (
              relationname TEXT,
              id TEXT
            )
          ''');
      await db.execute('''
            CREATE TABLE $districtsTable (
              districtname TEXT,
              districtid TEXT,
              mandalid TEXT,
              mandalname TEXT,
              panchayatid TEXT,
              panchayatname TEXT,
              ulB_CODE TEXT,
              municipalitY_NAME TEXT,
              type TEXT
            )
          ''');
      await db.execute('''
            CREATE TABLE $gasCompaniesTable (
              gasname TEXT,
              id TEXT
            )
          ''');
      await db.execute('''
            CREATE TABLE $electricityUnitsTable (
              unitsname TEXT,
              id INTEGER
            )
          ''');
      await db.execute('''
            CREATE TABLE $residentailTable (
              reS_NAME TEXT,
              reS_ID INTEGER
            )
          ''');
      await db.execute('''
            CREATE TABLE $typeRoofTable (
              rooF_NAME TEXT,
              rooF_ID INTEGER
            )
          ''');
      await db.execute('''
            CREATE TABLE $ownershipTable (
              ownershiP_NAME TEXT,
              ownershiP_ID INTEGER
            )
          ''');

      await db.execute('''
            CREATE TABLE $cheyuthaTable (
              cschemE_NAME TEXT,
              cschemE_ID INTEGER,
              age INTEGER
            )
          ''');
      await db.execute('''
            CREATE TABLE $toddyTapperTable (
              tT_NAME TEXT,
              tT_ID INTEGER
            )
          ''');
      await db.execute('''
            CREATE TABLE $singleWomenTable (
              sW_NAME TEXT,
              sW_ID INTEGER,
              age INTEGER
            )
          ''');
      await db.execute('''
            CREATE TABLE $pensionTable (
              pensioN_NAME TEXT,
              pensioN_ID INTEGER
            )
          ''');
    });
  }

  //Method for retrieving Gender Data
  Future<List<Gender>> getGenderData() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(genderTable);

    return List.generate(maps.length, (i) {
      return Gender(
        genderid: maps[i]['genderid'],
        gendername: maps[i]['gendername'],
      );
    });
  }

  //Method for inserting gender data
  Future<int> insertGenderData(Gender data) async {
    var dbClient = await database;
    return await dbClient.insert(genderTable, data.toMap());
  }

  //Method for inserting pension data
  Future<int> insertPensionData(Pension data) async {
    var dbClient = await database;
    return await dbClient.insert(pensionTable, data.toMap());
  }

  //Method for retrieving Caste Data
  Future<List<Caste>> getCasteData() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(casteTable);

    return List.generate(maps.length, (i) {
      return Caste(
        castid: maps[i]['castid'],
        castname: maps[i]['castname'],
      );
    });
  }

  //Method for inserting caste data
  Future<int> insertCasteData(Caste data) async {
    var dbClient = await database;
    return await dbClient.insert(casteTable, data.toMap());
  }

  //Method for retrieving Occupation Data
  Future<List<Occupations>> getOccupationData() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(occupationTable);

    return List.generate(maps.length, (i) {
      return Occupations(
        id: maps[i]['id'].toString(),
        occupatioNNAME: maps[i]['occupatioN_NAME'].toString(),
      );
    });
  }

  //Method for inserting Occupation data
  Future<int> insertOccupationData(Occupations data) async {
    var dbClient = await database;
    return await dbClient.insert(occupationTable, data.toMap());
  }

  //Method for retrieving Relationship Data
  Future<List<Relationships>> getRelationshipData() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(relationshipsTable);

    return List.generate(maps.length, (i) {
      return Relationships(
        id: maps[i]['id'],
        relationname: maps[i]['relationname'],
      );
    });
  }

  //Method for inserting Relationship data
  Future<int> insertRelationshipData(Relationships data) async {
    var dbClient = await database;
    return await dbClient.insert(relationshipsTable, data.toMap());
  }

  //Method for retrieving Districts Data
  Future<List<Districts?>> getDistrictsData() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.rawQuery(
        'Select   distinct  *  from $districtsTable group by  districtid');

    return List.generate(maps.length, (i) {
      return Districts(
        districtid: maps[i]['districtid'],
        districtname: maps[i]['districtname'],
        mandalid: maps[i]['mandalid'],
        mandalname: maps[i]['mandalname'],
        panchayatid: maps[i]['panchayatid'],
        panchayatname: maps[i]['panchayatname'],
        ulBCODE: maps[i]['ulBCODE'],
        municipalitYNAME: maps[i]['municipalitY_NAME'],
        type: maps[i]['type'],
      );
    });
  }

  Future<List<Districts?>> getMandalData(String? disID, String getType) async {
    final db = await database;
    //  'Select *  from $districtsTable where  districtid=$disID group by mandalid '
//Select  mandalid, mandalname from  DistrictsTable where  districtid=501  and type="GP"  group by  mandalid
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        'Select  mandalid, mandalname from $districtsTable where  districtid=$disID  and type="GP" group by mandalid');

    return List.generate(maps.length, (i) {
      return Districts(
        districtid: maps[i]['districtid'],
        districtname: maps[i]['districtname'],
        mandalid: maps[i]['mandalid'],
        mandalname: maps[i]['mandalname'],
        panchayatid: maps[i]['panchayatid'],
        panchayatname: maps[i]['panchayatname'],
        ulBCODE: maps[i]['ulBCODE'],
        municipalitYNAME: maps[i]['municipalitY_NAME'],
        type: maps[i]['type'],
      );
    });
  }

  Future<List<Districts?>> getMunicipalityData(
      String? disID, String Mtype) async {
    final db = await database;
    // Select  ulB_CODE , municipalitY_NAME from  DistrictsTable where  districtid=501  and type="M"

    final List<Map<String, dynamic>> maps = await db.rawQuery(
        'Select ulB_CODE,municipalitY_NAME from $districtsTable where  districtid=$disID  and type="$Mtype"');

    return List.generate(maps.length, (i) {
      return Districts(
        districtid: maps[i]['districtid'],
        districtname: maps[i]['districtname'],
        mandalid: maps[i]['mandalid'],
        mandalname: maps[i]['mandalname'],
        panchayatid: maps[i]['panchayatid'],
        panchayatname: maps[i]['panchayatname'],
        ulBCODE: maps[i]['ulB_CODE'],
        municipalitYNAME: maps[i]['municipalitY_NAME'],
        type: maps[i]['type'],
      );
    });
  }

  Future<List<Districts?>> getPanchayData(
      String? disID, String? mandalID) async {
    final db = await database;
//Select panchayatid ,panchayatname  from DistrictsTable where districtid=501 and mandalid=4636 and type="GP" group by panchayatid,panchayatname
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        'SELECT panchayatid ,panchayatname FROM DistrictsTable WHERE districtid = $disID AND mandalid =$mandalID and type="GP" GROUP BY panchayatid');
    return List.generate(maps.length, (i) {
      return Districts(
        districtid: maps[i]['districtid'],
        districtname: maps[i]['districtname'],
        mandalid: maps[i]['mandalid'],
        mandalname: maps[i]['mandalname'],
        panchayatid: maps[i]['panchayatid'],
        panchayatname: maps[i]['panchayatname'],
        ulBCODE: maps[i]['ulBCODE'],
        municipalitYNAME: maps[i]['municipalit_YNAME'],
        type: maps[i]['type'],
      );
    });
  }

  //Method for retrieving certain districts Data
  // Future<List<Districts>> getMandalDistrictsData(String districtid) async {
  //   final db = await database;

  //   final List<Map<String, dynamic>> maps = await db.rawQuery('SELECT * FROM $districtsTable WHERE districtid = $districtid');

  //   return List.generate(maps.length, (i) {
  //     return Districts(
  //       districtid: maps[i]['districtid'],
  //       districtname: maps[i]['districtname'],
  //       mandalid: maps[i]['mandalid'],
  //       mandalname: maps[i]['mandalname'],
  //       panchayatid: maps[i]['panchayatid'],
  //       panchayatname: maps[i]['panchayatname'],
  //       ulBCODE: maps[i]['ulBCODE'],
  //       municipalitYNAME: maps[i]['municipalit_YNAME'],
  //       type: maps[i]['type'],
  //     );
  //   });
  // }

  //Method for inserting Districts data
  Future<int> insertDistrictsData(Districts data) async {
    var dbClient = await database;
    return await dbClient.insert(districtsTable, data.toMap());
  }

  //Method for retrieving GasCompanies Data
  Future<List<Gascompanies>> getGasCompaniesData() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(gasCompaniesTable);

    return List.generate(maps.length, (i) {
      return Gascompanies(
        id: maps[i]['id'],
        gasname: maps[i]['gasname'],
      );
    });
  }

  //Method for inserting GasCompanies data
  Future<int> insertGasCompaniesData(Gascompanies data) async {
    var dbClient = await database;
    return await dbClient.insert(gasCompaniesTable, data.toMap());
  }

  //Method for retrieving ElectricityUnits Data
  Future<List<Electricityunits>> getElectricityUnitsData() async {
    final db = await database;

    final List<Map<String, dynamic>> maps =
        await db.query(electricityUnitsTable);

    return List.generate(maps.length, (i) {
      return Electricityunits(
        id: maps[i]['id'].toString(),
        unitsname: maps[i]['unitsname'].toString(),
      );
    });
  }

  //Method for inserting ElectricityUnits data
  Future<int> insertElectricityUnitsData(Electricityunits data) async {
    var dbClient = await database;
    return await dbClient.insert(electricityUnitsTable, data.toMap());
  }

//Method for retrieving residentails status Data
  Future<List<ResidentiaLSTATUS>> getResidentailStatusData() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(residentailTable);
    return List.generate(maps.length, (i) {
      return ResidentiaLSTATUS(
        reSID: maps[i]['reS_ID'],
        reSNAME: maps[i]['reS_NAME'],
      );
    });
  }

  //Method for inserting residentails status data
  Future<int> insertResidentailData(ResidentiaLSTATUS data) async {
    var dbClient = await database;

    return await dbClient.insert(residentailTable, data.toJson());
  }

//Method for retrieving residentails roof type status Data
  Future<List<TypEROOF>> getRoofTypeStatusData() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(typeRoofTable);
    return List.generate(maps.length, (i) {
      return TypEROOF(
        rooFID: maps[i]['rooF_ID'],
        rooFNAME: maps[i]['rooF_NAME'],
      );
    });
  }

  //Method for inserting roof type status data
  Future<int> insertRoofTypeData(TypEROOF data) async {
    var dbClient = await database;
    return await dbClient.insert(typeRoofTable, data.toJson());
  }

  //Method for retrieving Ownership Data
  Future<List<Ownership>> getOwnerShipData() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(ownershipTable);

    return List.generate(maps.length, (i) {
      return Ownership(
        ownershiPID: maps[i]['ownershiP_ID'],
        ownershiPNAME: maps[i]['ownershiP_NAME'],
      );
    });
  }

  //Method for inserting Ownership data
  Future<int> insertOwnershipData(Ownership data) async {
    var dbClient = await database;
    return await dbClient.insert(ownershipTable, data.toJson());
  }

  //Method for retrieving Toddytapper Data
  Future<List<Toddytapper>> gettoddyTapperData() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(toddyTapperTable);

    return List.generate(maps.length, (i) {
      return Toddytapper(
        tTID: maps[i]['tT_ID'],
        tTNAME: maps[i]['tT_NAME'],
      );
    });
  }

  //Method for inserting Toddytapper data
  Future<int> insertToddyTapperData(Toddytapper data) async {
    var dbClient = await database;
    return await dbClient.insert(toddyTapperTable, data.toJson());
  }

//Method for retrieving cheyutha Data
  Future<List<Cheyutha>> getcheyuthaData() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(cheyuthaTable);

    return List.generate(maps.length, (i) {
      return Cheyutha(
        cschemEID: maps[i]['cschemE_ID'],
        cschemENAME: maps[i]['cschemE_NAME'],
        age: maps[i]['age'],
      );
    });
  }

  //Method for inserting cheyutha data
  Future<int> insertCheyuthaData(Cheyutha data) async {
    var dbClient = await database;
    return await dbClient.insert(cheyuthaTable, data.toJson());
  }

  //Method for retrieving single women Data
  Future<List<Singlewomen>> getsingleWomenData() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(singleWomenTable);

    return List.generate(maps.length, (i) {
      return Singlewomen(
        sWID: maps[i]['sW_ID'],
        sWNAME: maps[i]['sW_NAME'],
        age: maps[i]['age'],
      );
    });
  }
  Future<List<Pension>> getPensionData() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(pensionTable);

    return List.generate(maps.length, (i) {
      return Pension(
        pensioNID: maps[i]['pensioN_ID'],
        pensioNNAME: maps[i]['pensioN_NAME'],
      );
    });
  }
  //Method for inserting single women data
  Future<int> insertSingleWomenData(Singlewomen data) async {
    var dbClient = await database;
    return await dbClient.insert(singleWomenTable, data.toJson());
  }

  //Method for deleting all data from all tables
  Future<void> deleteAllData() async {
    final db = await database;
    await db.delete(genderTable);
    await db.delete(casteTable);
    await db.delete(occupationTable);
    await db.delete(relationshipsTable);
    await db.delete(districtsTable);
    await db.delete(gasCompaniesTable);
    await db.delete(electricityUnitsTable);
  }

  Future<void> deleteSecndData() async {
    final db = await database;

    await db.delete(genderTable);
    await db.delete(residentailTable);
    await db.delete(singleWomenTable);
    await db.delete(typeRoofTable);
    await db.delete(ownershipTable);
    await db.delete(toddyTapperTable);
    await db.delete(cheyuthaTable);
     await db.delete(pensionTable);
  }
}
