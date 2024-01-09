class Lead {
  int? id;
  dynamic source;
  String? createdUser;
  String? assignedUser;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;
  String? mobile;
  String? email;
  dynamic image;
  String? interest;
  String? location;
  bool? isAssigned;
  String? status;
  String? priority;
  int? fkCompany;
  int? createdBy;

  Lead({
    this.id,
    this.source,
    this.createdUser,
    this.assignedUser,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.mobile,
    this.email,
    this.image,
    this.interest,
    this.location,
    this.isAssigned,
    this.status,
    this.priority,
    this.fkCompany,
    this.createdBy,
  });

  factory Lead.fromJson(Map<String, dynamic> json) => Lead(
        id: json['id'] as int?,
        source: json['source'] as dynamic,
        createdUser: json['created_user'] as String?,
        assignedUser: json['assigned_user'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        name: json['name'] as String?,
        mobile: json['mobile'] as String?,
        email: json['email'] as String?,
        image: json['image'] as dynamic,
        interest: json['interest'] as String?,
        location: json['location'] as String?,
        isAssigned: json['is_assigned'] as bool?,
        status: json['status'] as String?,
        priority: json['priority'] as String?,
        fkCompany: json['fk_company'] as int?,
        createdBy: json['created_by'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'source': source,
        'created_user': createdUser,
        'assigned_user': assignedUser,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'name': name,
        'mobile': mobile,
        'email': email,
        'image': image,
        'interest': interest,
        'location': location,
        'is_assigned': isAssigned,
        'status': status,
        'priority': priority,
        'fk_company': fkCompany,
        'created_by': createdBy,
      };
}
