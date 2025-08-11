class MedicalRecord {
  String? bloodType;
  List<Disease>? diseases;
  List<Medication>? medications;

  MedicalRecord({this.bloodType, this.diseases, this.medications});

  factory MedicalRecord.fromJson(Map<String, dynamic> json) {
    return MedicalRecord(
      bloodType: json["blood_type"],
      diseases: Disease.fromJsonList(json["chronic_diseases"]) ?? [],
      medications: Medication.fromJsonList(json["chronic_medications"]) ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (bloodType != null) {
      json["blood_type"] = bloodType;
    }

      json["chronic_diseases"] = diseases?.map((e) => e.toJson()).toList();
      json["chronic_medications"] = medications?.map((e) => e.toJson()).toList();

    return json;
    
  }
}

class Disease {
   String? name;
   String? diagnosedYear;

  Disease({this.name, this.diagnosedYear});

  factory Disease.fromJson(Map<String, dynamic> json) {
    return Disease(name: json["name"], diagnosedYear: json["diagnosed_year"]);
  }

  static List<Disease>? fromJsonList(List<dynamic>? data) {
    
    return data?.map((disease) => Disease.fromJson(disease)).toList();
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "diagnosed_year": diagnosedYear};
  }
}

class Medication {
   String? name;
   String? dosage;
   String? frequency;

  Medication({this.name, this.dosage, this.frequency});

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      name: json["name"],
      dosage: json["dosage"],
      frequency: json["frequency"],
    );
  }

  static List<Medication>? fromJsonList(List<dynamic>? data) {
    // Renamed for consistency
    return data?.map((medication) => Medication.fromJson(medication)).toList();
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "dosage": dosage, "frequency": frequency};
  }
}
