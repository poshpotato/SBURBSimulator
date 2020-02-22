import '../../SBURBSim.dart';
import "../Misc/VoidSimController.dart";
import '../../navbar.dart';
import 'dart:async';
import 'dart:html';

Future<Null> main() async {
  //maybe if i define it here it won't be the same as end time
  startTime =new DateTime.now();
  await globalInit();
  //;
  new DateTime.now();
  new Timer(new Duration(milliseconds: 1000), () =>window.scrollTo(0, 0));

  //make a new StoryController (which will auto set itself as it's parent's singleton instance
  window.onError.listen((Event event){
    ErrorEvent e = event as ErrorEvent;
    //String msg, String url, lineNo, columnNo, error
    printCorruptionMessage(SimController.instance.currentSessionForErrors,e);//(e.message, e.path.toString(), e.lineno.toString(), e.colno.toString(), e.toString());
    return;
  });
  loadNavbar();
  //be dead looking


  new VoidStoryController(); //will set this as SimController's instance variable.
  SimController.instance.storyElement.style.backgroundColor = "grey";
  //querySelector("#links").style.backgroundColor = "grey";
  querySelector("#debug").style.backgroundColor = "grey";
  querySelector("#charSheets").style.backgroundColor = "grey";
  if(getParameterByName("seed",null) != null){
    // Math.seed = getParameterByName("seed");  //TODO replace this somehow
    SimController.instance.initial_seed = int.parse(getParameterByName("seed",null));
  }else{
    var tmp = getRandomSeed();
    // Math.seed = tmp; //TOdo do something else here but rand is inside of session......
    SimController.instance.initial_seed = tmp;
  }

  SimController.instance.shareableURL();
  Session session = new VoidSession(SimController.instance.initial_seed);
  checkEasterEgg(session);
  session.startSession();
}

//so dead session finder can use this without a main.
//TODO: PP: do some shit about this
class VoidStoryController extends VoidSimController {
  VoidStoryController() : super();
}

class StoryController extends SimController {
  StoryController() : super();
}