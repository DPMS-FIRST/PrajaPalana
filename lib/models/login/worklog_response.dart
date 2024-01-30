class WorklogApprovalResponse {
  bool? success;
  String? statusMessage;
  int? statusCode;
  List<WorklogApprovalData>? data;
  bool? paginated;

  WorklogApprovalResponse(
      {this.success,
      this.statusMessage,
      this.statusCode,
      this.data,
      this.paginated});

  WorklogApprovalResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusMessage = json['status_Message'];
    statusCode = json['status_Code'];
    if (json['data'] != null) {
      data = <WorklogApprovalData>[];
      json['data'].forEach((v) {
        data!.add(new WorklogApprovalData.fromJson(v));
      });
    }
    paginated = json['paginated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status_Message'] = this.statusMessage;
    data['status_Code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['paginated'] = this.paginated;
    return data;
  }
}

class WorklogApprovalData {
  String? duration;
  String? empname;
  String? workLogId;
  String? workDate;
  String? noOfHoursWorked;
  String? taskname;
  String? description;
  String? startTime;
  String? endTime;
  String? taskid;
  String? remarks;
  String? status;

  WorklogApprovalData(
      {this.duration,
      this.empname,
      this.workLogId,
      this.workDate,
      this.noOfHoursWorked,
      this.taskname,
      this.description,
      this.startTime,
      this.endTime,
      this.taskid,
      this.remarks,
      this.status});

  WorklogApprovalData.fromJson(Map<String, dynamic> json) {
    duration = json['duration'];
    empname = json['empname'];
    workLogId = json['work_log_id'];
    workDate = json['workDate'];
    noOfHoursWorked = json['noOfHoursWorked'];
    taskname = json['taskname'];
    description = json['description'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    taskid = json['taskid'];
    remarks = json['remarks'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['duration'] = this.duration;
    data['empname'] = this.empname;
    data['work_log_id'] = this.workLogId;
    data['workDate'] = this.workDate;
    data['noOfHoursWorked'] = this.noOfHoursWorked;
    data['taskname'] = this.taskname;
    data['description'] = this.description;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['taskid'] = this.taskid;
    data['remarks'] = this.remarks;
    data['status'] = this.status;
    return data;
  }
}