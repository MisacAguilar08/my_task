class Task{
  Task(this.date, this.title, {this.done = false, this.id = ""});

  Task.fromJson(Map<String, dynamic> json){
    id= json["id"];
    title= json["title"];
    date= json["date"];
    done= json["done"];
  }

  late String id;
  late String date;
  late String title;
  late bool done;

  Map<String, dynamic> toJson(){
    return{
      "id": id,
      "title": title,
      "done": done,
      "date": date
    };
  }
}