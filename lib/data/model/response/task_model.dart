import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:image_compression_flutter/image_compression_flutter.dart';

class TaskModel {

  String task_title;
  String task_description;
  List<File_path> task_media;
  List<File_Unitpath> rawFile;
 // List<Uint8List> rawFile;

  TaskModel({@required String task_title,@required String task_description,@required List<File_path> task_media,@required List<File_Unitpath> rawFile})
      {this.task_title=task_title;
        this.task_description=task_description;
        this.task_media=task_media;
        this.rawFile=rawFile;

      }


  TaskModel.fromJson(Map<String, dynamic> json) {

    task_title = json['task_title'];
    task_description = json['task_description'] ;
   // task_media = json['task_media'];
   // rawFile = json['rawFile'];

    if (json['task_media'] != null) {
      task_media = [];
      json['task_media'].forEach((v) {
        task_media.add(new File_path.fromJson(v));
      });

    } if (json['rawFile'] != null) {
      rawFile = [];
      json['rawFile'].forEach((v) {
        rawFile.add(new File_Unitpath.fromJson(v));
      });

    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['task_title'] = this.task_title;
    data['task_description'] = this.task_description;
   // data['task_media'] = this.task_media;
    if (this.task_media != null) {
         data['task_media'] = jsonEncode(this.task_media.map((v) => v.toJson()).toList());
    }
    if (this.rawFile != null) {
         data['rawFile'] = jsonEncode(this.rawFile.map((v) => v.toJson()).toList());
    }
    //data['rawFile'] = this.rawFile;
    //
    // if (this.rawFile != null) {
    //   data['receiver_addresses'] = jsonEncode(this.rawFile.map((v) => v.toJson()).toList());
    // }
    return data;
  }
}
class File_path {
  XFile file;
  File_path({this.file});

  File_path.fromJson(Map<String, dynamic> json) {
    file = json['file'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file'] = this.file;
    return data;
  }
}
class File_Unitpath {
  Uint8List rawFile;

  File_Unitpath({this.rawFile});

  File_Unitpath.fromJson(Map<String, dynamic> json) {
    rawFile = json['rawFile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rawFile'] = this.rawFile;
    return data;
  }
}
