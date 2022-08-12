import 'dart:typed_data';

import 'package:image_compression_flutter/image_compression_flutter.dart';

class TaskModel {

  String task_title;
  String task_description;
  XFile task_media;
  Uint8List rawFile;


  TaskModel(
      {this.task_title,
        this.task_description,
        this.task_media,
        this.rawFile,

      });

  TaskModel.fromJson(Map<String, dynamic> json) {

    task_title = json['task_title'];
    task_description = json['task_description'] ;
    task_media = json['task_media'];
    rawFile = json['rawFile'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['task_title'] = this.task_title;
    data['task_description'] = this.task_description;
    data['task_media'] = this.task_media;
    data['rawFile'] = this.rawFile;
    return data;
  }
}
