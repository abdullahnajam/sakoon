class Service{
  String id,name,imgUrl,count;

  Service(this.id, this.name,this.imgUrl,this.count);

  Service.fromMap(Map<String,dynamic> map,String key)
      : id=key,
        name = map['name']??"",
        imgUrl = map['image']??"",
        count =map['count']??"";
}