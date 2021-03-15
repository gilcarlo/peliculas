//Esta clase es para recibir la lista que trae cast (revisa peticion) y con cada elemento mapear con la clase actor
class Cast{
  List<Actor> actoresList = List();

  //Recibira una lista de cast
  Cast.fromJsonList( List<dynamic> jsonList ){
    if ( jsonList == null ) return;

    jsonList.forEach((element) { 
      final actor = Actor.fromJsonMap( element );
      actoresList.add(actor);
    });
  }
}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath
  });

  Actor.fromJsonMap( Map<String, dynamic> json ){
    castId      = json['cast_id'];
    character   = json['character'];
    creditId    = json['credit_id'];
    gender      = json['gender'];
    id          = json['id'];
    name        = json['name'];
    order       = json['order'];
    profilePath = json['profile_path'];
  }

  getFotoActor(){
    if (profilePath == null){
      return 'https://st.depositphotos.com/2101611/3925/v/600/depositphotos_39258143-stock-illustration-businessman-avatar-profile-picture.jpg';
    }else{
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}

