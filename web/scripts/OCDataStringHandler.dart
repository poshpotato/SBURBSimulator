//put all OCDataString code here.
import "dart:html";
import 'dart:typed_data';
import "dart:async";
import "SBURBSim.dart";
import 'includes/bytebuilder.dart';
import 'includes/lz-string.dart';
import 'navbar.dart';
import 'dart:convert';


//don't pollute global name space more than you already are, dunkass
//call this ONLY inside a function.
class CharacterEasterEggEngine {
  var creatorCharacters = ["b=E0%12%C2%B8%C3%BE*%00%11%1E%1E%2F&s=,,Drawing distant Lands,Procedural Generation,ParadoxLands"
  , "b=%2B*-%C3%96%C3%B4%5C%00%C3%90%2C%2C%0D&s=,,Arson,Shipping,authorBotJunior","b=%2B*-%06%C3%B4%C2%A3%04%C3%90%2C%2C%0D&s=,,Authoring,Robots,authorBot&x=hjAA","b=%C3%A8%C3%90%C2%99L%C3%BE)%04%17%1C%1C.&s=,,100 Art Projects At Once,Memes,karmicRetribution&x=pmAA","b=%3C%1E%07%C3%86%C3%BE%C2%A3%04%13%18%18%0D&s=,,The AuthorBot,Authoring,jadedResearcher"];

  Map<String, List<String>> ocs = {};
  //parses the text file as newline seperated and load them into the array.



  CharacterEasterEggEngine() {
    ocs["otherFandoms"] = new List<String>();
    ocs["canon"] = new List<String>();
    ocs["patrons3"] = new List<String>();
    ocs["patrons2"] = new List<String>();
    ocs["patrons"] = new List<String>();
    ocs["bards"] = new List<String>();
    ocs["ideasWranglers"] = new List<String>();
    ocs["creditsBuckaroos"] = new List<String>();
    ocs["discordCharcters"] = new List<String>();
    ocs["tumblrCharacters"] = new List<String>();
    ocs["redditCharacters"] = new List<String>();
  }


  //javascript was fine with processForSim being both a method and a bool so long as it was this.process, but dart is not.
  Future<Null> loadArrayFromFile(Session session, arr, String file, p)async{
    print("loading" + file);
   // var that = this; //TODO what the hell was i doing here, that comes from a param
    // 4/4/18 is this a sane thing to do? instead of a 'then' should i be doing something else?
    //how does homestuck the moive do it? oh, just like this. okay then.
    await HttpRequest.getString(file).then((String data) {
      parseFileContentsToArray(arr, data.trim());
      if(p != null) return processForSim(session);
    });


  }



  void parseFileContentsToArray(arr, fileContents){
    this.ocs[arr] = fileContents.split(new RegExp("\n"));
    //print("after regexp is");
    //window.console.table(this.ocs[arr]);
    ////print(arr);
    ////print(this[arr]);
  }
  void processForSim(Session session){
  	Random rand = session.rand;
  	//;
    var pool = this.getPoolBasedOnEggs(rand);
    var potentials = this.playerDataStringArrayToURLFormat(session, pool);
    List<Player> ret = [];
    List<Player> spacePlayers = findAllAspectPlayers(potentials, Aspects.SPACE);
    var space = rand.pickFrom(spacePlayers);
    removeFromArray(space,potentials);
    if(space == null){
      space = randomSpacePlayer(session);
      space.chatHandle = "randomSpace";
      ////;
      space.quirk = new Quirk(rand);
      space.quirk.favoriteNumber = 0;
      space.deriveChatHandle = false;
    }
    var timePlayers = findAllAspectPlayers(potentials, Aspects.TIME);
    var time = rand.pickFrom(timePlayers);
    removeFromArray(time,potentials);
    if(time == null){
      time = randomTimePlayer(session);
      time.chatHandle = "randomTime";
      time.quirk = new Quirk(rand);
      time.quirk.favoriteNumber = 0;
      time.deriveChatHandle = false;
    }
    ////print("space chatHandle " + space.chatHandle);
    ////print(space);
    ret.add(space);
    ret.add(time);
    var numPlayers = rand.nextIntRange(2,12);
    for(int i = 2; i<numPlayers; i++){
      var p = rand.pickFrom(potentials);
      if(p != null) ret.add(p);
      if(p != null) removeFromArray(p,potentials);  //no repeats. <-- modify all the removes l8r if i want to have a mode that enables them.
    }
    ////print(ret);
    for(num i = 0; i<ret.length; i++){
      var p = ret[i];
      ////print(p);
      if(p.chatHandle.trim() == "") p.chatHandle = getRandomChatHandle(rand, p.class_name,p.aspect,p.interest1, p.interest2);
    }
    session.replayers = ret;
  }

  Future<Null> loadArraysFromFile(Session session,bool processForSim) async {
    //too confusing trying to only load the assest i'll need. wait for now.
    await this.loadArrayFromFile(session,"redditCharacters","OCs/reddit.txt", processForSim);
    await this.loadArrayFromFile(session,"tumblrCharacters","OCs/tumblr.txt", processForSim);
    await this.loadArrayFromFile(session,"discordCharcters","OCs/discord.txt", processForSim);
    await this.loadArrayFromFile(session,"creditsBuckaroos","OCs/creditsBuckaroos.txt", processForSim);
    await this.loadArrayFromFile(session,"ideasWranglers","OCs/ideasWranglers.txt", processForSim);
    await this.loadArrayFromFile(session,"patrons","OCs/patrons.txt", processForSim);
    await this.loadArrayFromFile(session,"patrons2","OCs/patrons2.txt", processForSim);
    await this.loadArrayFromFile(session,"patrons3","OCs/patrons3.txt", processForSim);
    await this.loadArrayFromFile(session,"canon","OCs/canon.txt", processForSim);
    await this.loadArrayFromFile(session,"bards","OCs/bards.txt", processForSim);
    await this.loadArrayFromFile(session,"otherFandoms","OCs/otherFandoms.txt", processForSim); //last one in list has callback so I know to do next thing.
  }
  List<String> getPoolBasedOnEggs(Random rand){
    //;
    List<String> pool = [];
    //first, parse url params. for each param you find that's right, append the relevant characters into the array.
    if(getParameterByName("reddit",null)  == "true"){
      pool.addAll(this.ocs["redditCharacters"]);
    }

    if(getParameterByName("tumblr",null)  == "true"){
      pool.addAll(this.ocs["tumblrCharacters"]);
    }

    if(getParameterByName("discord",null)  == "true"){
      pool.addAll(this.ocs["discordCharcters"]);
    }

    if(getParameterByName("creditsBuckaroos",null)  == "true"){
      pool.addAll(this.ocs["creditsBuckaroos"]);
    }

    if(getParameterByName("ideasWranglers",null)  == "true"){
      pool.addAll(this.ocs["ideasWranglers"]);
    }

    if(getParameterByName("bards",null)  == "true"){
      pool.addAll(this.ocs["bards"]);
    }

    if(getParameterByName("patrons",null)  == "true"){
      pool.addAll(this.ocs["patrons"]);
    }

    if(getParameterByName("patrons2",null)  == "true"){
      pool.addAll(this.ocs["patrons2"]);
    }

    if(getParameterByName("patrons3",null)  == "true"){
      pool.addAll(this.ocs["patrons3"]);
    }

    if(getParameterByName("canon",null)  == "true"){
      //;
      pool.addAll(this.ocs["canon"]);
    }

    if(getParameterByName("otherFandoms",null)  == "true"){
      pool.addAll(this.ocs["otherFandoms"]);
    }


    if(getParameterByName("creators",null)  == "true"){
      pool.addAll(this.creatorCharacters);
    }

    if(pool.length == 0){
      //	//;
      pool.addAll(this.ocs["redditCharacters"]);
      pool.addAll(this.ocs["tumblrCharacters"]);
      pool.addAll(this.ocs["discordCharcters"]);
      pool.addAll(this.ocs["creditsBuckaroos"]);
      pool.addAll(this.ocs["patrons"]);
      pool.addAll(this.ocs["ideasWranglers"]);
      pool.addAll(this.ocs["canon"]);
      pool.addAll(this.creatorCharacters);
      pool.addAll(this.ocs["bards"]);
    }

    //return pool;
    return shuffle(rand, pool); //boring if the same peeps are always first.

  }
  List<Player> processEasterEggsViewer(Session session, Random rand){
    var pool = this.getPoolBasedOnEggs(rand);
    return this.playerDataStringArrayToURLFormat(session,pool);
  }


  List<Player> playerDataStringArrayToURLFormat(Session session, List<String> playerDataStringArray){
    window.console.table(playerDataStringArray);
    List<Player> ret = new List<Player>();
    String params =  window.location.href.substring(window.location.href.indexOf("?") + 1);
    String base = window.location.href.replaceAll("?$params","");
    //first, take each element in the array and seperate it out into s and b  (getRawParameterByName(name, url))
    for(num i = 0; i<playerDataStringArray.length; i++){
      String bs = "${base}?" +playerDataStringArray[i];
      //;
      String b = (getParameterByName("b", bs));
      window.console.table(b);
      if(b == null) {
        throw ("hey why the hell is this null plz");
        window.console.trace(b);
      }
      List<String> s = Uri.encodeFull(getParameterByName("s", bs)).split(","); //these are NOT encoded in files, so make sure to encode them
      String x = (getParameterByName("x", bs));
      print ("processing fan oc, bs is $bs and b is $b and s is $s and x is: $x");
      Player p = (dataBytesAndStringsToPlayer(session,b,s));
      if(x != null) {
        ByteReader reader = new ByteReader((stringToByteArray(x).buffer), 0);
        p.readInExtensionsString(reader);
      }
      ret.add(p);
    }
    return ret;
  }
  List<Player>  getAllReddit(Session session,){
    return this.playerDataStringArrayToURLFormat(session,this.ocs["redditCharacters"]);
  }


}



//TODO shove methods like this into static player methods
String playersToDataBytes(players){
  String ret = "";
  for(num i = 0; i<players.length; i++){
    ////;
    ret += players[i].toDataBytes();
  }
  return LZString.compressToEncodedURIComponent(ret);
  //return ret;
}



String playersToExtensionBytes(players){
  String ret = "";
  ByteBuilder builder = new ByteBuilder();
  /*
      ignore what i was doing before, that was flaming garbage. what i need to do is
      take a byte builder, and shove each player into it. modded player to take in a builder.

   */
  for(Player p in players) {
      p.toDataBytesX(builder);
  }
  return  base64Url.encode(builder.toBuffer().asUint8List());
}





String playersToDataStrings(players, includeChatHandle){
  List<String> ret = [];
  for(num i = 0; i<players.length; i++){
    ret.add(players[i].toDataStrings(true));
  }
  //return Uri.encodeComponent(ret.join(",")).replace(new RegExp(r"""#""", multiLine:true), '%23').replace(new RegExp(r"""&""", multiLine:true), '%26');;
  return LZString.compressToEncodedURIComponent(ret.join(","));
}



//pair with seed for shareable url for character creator, or pair with nothing for afterlife viewer.
//Posh here: FUCK that let the afterlife have a seed too
String generateURLParamsForPlayers(List<Player>players, bool includeChatHandle){
  //var json = JSON.stringify(players);  //inside of players handles looking for keys
  ////print(json);
  //if want localStorage , then compressToUTF16  http://pieroxy.net/blog/pages/lz-string/guide.html
  //var compressed = LZString.compressToEncodedURIComponent(json);
  ////print(compressed);
  var data = playersToDataBytes(players);
  var strings = playersToDataStrings(players,true);
  var extensions = playersToExtensionBytes(players);
  return "b="+data+"&s="+strings + "&x="+extensions;

}



List<Player> dataBytesAndStringsToPlayers(Session session, String bytes, String s, String xbytes){
  //;
  //bytes are 11 chars per player
  //strings are 5 csv per player.
  ////print(bytes);
  ////print(bytes.length);
  List<String> strings = s.split(",");
  List<Player> players = [];
  print("databytes etc to players bytes i have are $bytes and strings is $strings");
  for(num i = 0; i<bytes.length/11; i+=1){;
    print("in the for loop, i is $i");
    var bi = i*11; //i is which player we are on, which is 11 bytes long
    var si = i*5; //or 5 strings long
    var b = bytes.substring(bi, bi+11);
    //List<dynamic> s = [];
    var s = strings.sublist(si, si +5);  //TODO used to be "slice" in js, is it still?
    ////;
    print("for one player, b is $b");
    var p = (dataBytesAndStringsToPlayer(session, b,s));
    p.id = i; //will be overwritten by sim, but viewer needs it
    players.add(p);
  }
  //if(extensionString) player.readInExtensionsString(extensionString);
  if(xbytes != null && !xbytes.isEmpty) applyExtensionStringToPlayers(players, xbytes);
  return players;

}



void applyExtensionStringToPlayers(List<Player> players, xbytes){
  var reader = new ByteReader((stringToByteArray(xbytes).buffer), 0);
  for(num i = 0; i<players.length; i++){
    players[i].readInExtensionsString(reader);
  }

}



Uint8List stringToByteArray(str){
  return base64Url.decode(str);
}



//TODO FUTUREJR, REMOVE THIS METHOD AND INSTAD RELY ON session.RenderingEngine.renderers[1].dataBytesAndStringsToPlayer
//see player.js toDataBytes and toDataString to see how I expect them to be formatted.
dynamic dataBytesAndStringsToPlayer(Session session, String charString, List<String>str_arr){
  var player = new Player();
  player.session = session;
  //player.session = new Session(-13); //so shit doesn't crash lookin gfor a mututator
  player.quirk = new Quirk(null);
  //;
  ////print("chars is: " + charString);
  player.causeOfDrain = sanitizeString(Uri.decodeFull(str_arr[0]).trim());
  player.causeOfDeath = sanitizeString(Uri.decodeFull(str_arr[1]).trim());
  String i1= sanitizeString(Uri.decodeFull(str_arr[2]).trim());
  String i2 = sanitizeString(Uri.decodeFull(str_arr[3]).trim());
  player.chatHandle = sanitizeString(Uri.decodeFull(str_arr[4]).trim());
  //don't redo this please
  if(player.chatHandle.isNotEmpty) player.deriveChatHandle = false;
  //for bytes, how to convert uri encoded string into char string into unit8 buffer?
  //holy shit i haven't had this much fun since i did the color replacement engine a million years ago. this is exactlyt he right flavor of challenging.
  ////print("charString is: " + charString);
  player.hairColor = intToHexColor((charString.codeUnitAt(0) << 16) + (charString.codeUnitAt(1) << 8) + (charString.codeUnitAt(2)) );
  player.class_name = intToClassName(charString.codeUnitAt(3) >> 4);
  player.aspect = Aspects.get(charString.codeUnitAt(3) & 15) ;//get 4 bits on end;
  //;

  player.victimBlood = intToBloodColor(charString.codeUnitAt(4) >> 4);
  player.bloodColor = intToBloodColor(charString.codeUnitAt(4) & 15);

  print("totaly byte is ${charString.codeUnitAt(5)} or ${charString[5]} interest1 value is ${charString.codeUnitAt(5) >> 4} and interest2 value is ${charString.codeUnitAt(5) & 15}");
  InterestCategory ic1 = InterestManager.get(charString.codeUnitAt(5) >> 4);
  print("interest category 1 is $ic1");
  InterestCategory ic2 = InterestManager.get(charString.codeUnitAt(5) & 15);
  print("interest category 2 is $ic2");
  //TODO this probably means interest category can't be null.
  player.interest1 = new Interest(i1, ic1);
  player.interest2 = new Interest(i2, ic2);

  player.grimDark = charString.codeUnitAt(6) >> 5;
  player.isTroll = 0 != ((1<<4) & charString.codeUnitAt(6)); //only is 1 if character at 1<<4 is 1 in charString
  player.isDreamSelf = 0 != ((1<<3) & charString.codeUnitAt(6));
  player.godTier = 0 != ((1<<2) & charString.codeUnitAt(6));
  player.murderMode = 0 != ((1<<1) & charString.codeUnitAt(6));
  player.leftMurderMode = 0 != ((1) & charString.codeUnitAt(6));
  player.robot = 0 != ((1<<7) & charString.codeUnitAt(7));
  var moon = 0 != ((1<<6) & charString.codeUnitAt(7));
  print("moon binary is: $moon");
  if(player.session.prospit == null) player.session.setupMoons("moon is null when trying to parse a data string");
  player.moon = moon ? player.session.prospit : player.session.derse;
  print("i think that becomes ${player.moon}, is that ${player.session.prospit} or ${player.session.derse}?");

  ////print("moon string is: "  + player.moon);
  player.dead = 0 != ((1<<5) & charString.codeUnitAt(7));
  ////print("Binary string is: " + charString[7]);
  player.godDestiny = 0 != ((1<<4) & charString.codeUnitAt(7));
  player.quirk.favoriteNumber = charString.codeUnitAt(7) & 15;
 // //;
  player.leftHorn = charString.codeUnitAt(8);
  player.rightHorn = charString.codeUnitAt(9);
  player.hair = charString.codeUnitAt(10);

  ;
  return player;
}
