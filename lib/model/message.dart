class MessagesModel {
  late String status;
  late List<Data> data;

  MessagesModel({required this.status, List<Data>? data})
      : data = data ?? <Data>[];

  MessagesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = List<Data>.from((json['data'] ?? []).map((v) => Data.fromJson(v)));
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.map((v) => v.toJson()).toList(),
    };
  }
}

class Data {
  late String messageid;
  late String time;
  late String sender;
  late String text;
  late String roomId;
  late String senderName;

  Data({
    required this.messageid,
    required this.time,
    required this.sender,
    required this.text,
    required this.roomId,
    required this.senderName,
  });

  Data.fromJson(Map<String, dynamic> json) {
    messageid = json['messageid'];
    time = json['time'];
    sender = json['sender'];
    text = json['text'];
    roomId = json['room_id'];
    senderName = json['sender_name'];
  }

  Map<String, dynamic> toJson() {
    return {
      'messageid': messageid,
      'time': time,
      'sender': sender,
      'text': text,
      'room_id': roomId,
      'sender_name': senderName,
    };
  }
}
