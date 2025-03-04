class Task{
  Task(this.idTask, this.title, {this.done = false});

  Task.fromJson(Map<String, dynamic> json){
    idTask= json["idTask"];
    title= json["title"];
    done= json["done"];
  }

  late String idTask;
  late String title;
  late bool done;

  Map<String, dynamic> toJson(){
    return{
      "idTask": idTask,
      "title": title,
      "done": done
    };
  }
}