class Task{
  Task(this.date, this.title, {this.done = false, this.id = "", this.notification = 0});

  Task.fromJson(Map<String, dynamic> json){
    id= json["id"];
    title= json["title"];
    date= json["date"];
    done= json["done"];
    notification = json["notification"];
  }

  late String id;
  late String date;
  late String title;
  late bool done;
  late int notification;

  Map<String, dynamic> toJson(){
    return{
      "id": id,
      "title": title,
      "done": done,
      "date": date,
      "notification": notification
    };
  }
}