import 'dart:convert';
import 'dart:io';
import 'package:flutter_application_3/class.dart';
import 'package:flutter_application_3/comment.dart';
import 'package:http/http.dart' as http;

Future<HomeData> getHomeData() async {
  String domain = "";
  var response = await http.get(Uri.parse("$domain/home"));
  if (response.statusCode == 200) {
    return HomeData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load HomeData');
  }
}

Future<ThreadPage> getThreadPageData(
    String cursor, int order, int pid, int fid, String q) async {
  String domain = "";
  // ignore: non_constant_identifier_names
  String Conditon = "?";
  http.Response response;

  //default String="",int=-1
  if (cursor != "") {
    Conditon = "${Conditon}cursor=$cursor";
  }
  if ((order != -1) & (Conditon != "?")) {
    Conditon = "$Conditon&order=$order";
  } else if (order != -1) {
    Conditon = "${Conditon}order=$order";
  }
  if ((pid != -1) & (Conditon != "")) {
    Conditon = "$Conditon&pid=$pid";
  } else if (pid != -1) {
    Conditon = "${Conditon}pid=$pid";
  }
  if ((fid != -1) & (Conditon != "")) {
    Conditon = "$Conditon&fid=$fid";
  } else if (fid != -1) {
    Conditon = "${Conditon}fid=$fid";
  }
  if ((q != "") & (Conditon != "")) {
    Conditon = "$Conditon&q=$q";
  } else if (q != "") {
    Conditon = "${Conditon}q=$q";
  }

  if (Conditon != "?") {
    response = await http.get(Uri.parse("$domain/thread$Conditon"));
  } else {
    response = await http.get(Uri.parse("$domain/thread"));
  }

  if (response.statusCode == 200) {
    return ThreadPage.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load ThreadPage');
  }
}

//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
/////////////////////////////////////////////////////////
//////////////////////////////////////////////////////
Future<ThreadDetail> getThreadInsideData(String tid, String cursor) async {
  String domain = "";
  http.Response response;
//cursor deafult =""
  if (cursor != "") {
    response = await http.get(Uri.parse("$domain/thread/$tid?coursor=$cursor"));
  } else {
    response = await http.get(Uri.parse("$domain/thread/$tid"));
  }

  if (response.statusCode == 200) {
    return ThreadDetail.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load ThreadDetail');
  }
}

/////////////////////////////////////////////////////////
//////////////////////////////////////////////////////

//Not confirmed.

Future<CommentDetail> getCommentInsideData(
    String cid, String Authorization) async {
  String domain = "";
  http.Response response = await http.get(Uri.parse("$domain/comment/$cid"),
      headers: <String, String>{'Authorization': Authorization});
  if (response.statusCode == 200) {
    return CommentDetail.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load CommentDetail');
  }
}

/////////////////////////////////////////////////////////
//////////////////////////////////////////////////////
class Api {}
