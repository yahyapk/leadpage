import 'lead.dart';

class Data {
  List<Lead>? leads;
  int? totalCount;
  int? totalPage;
  dynamic nextPageNo;
  dynamic previousPageNo;
  int? currentPage;

  Data({
    this.leads,
    this.totalCount,
    this.totalPage,
    this.nextPageNo,
    this.previousPageNo,
    this.currentPage,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        leads: (json['leads'] as List<dynamic>?)
            ?.map((e) => Lead.fromJson(e as Map<String, dynamic>))
            .toList(),
        totalCount: json['total_count'] as int?,
        totalPage: json['total_page'] as int?,
        nextPageNo: json['next_page_no'] as dynamic,
        previousPageNo: json['previous_page_no'] as dynamic,
        currentPage: json['current_page'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'leads': leads?.map((e) => e.toJson()).toList(),
        'total_count': totalCount,
        'total_page': totalPage,
        'next_page_no': nextPageNo,
        'previous_page_no': previousPageNo,
        'current_page': currentPage,
      };
}
