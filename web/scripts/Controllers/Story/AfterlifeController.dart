import '../../SBURBSim.dart';
import '../../navbar.dart';
import '../../v2.0/char_creator_helper.dart';
import 'dart:html';
import 'dart:async';

AfterlifeController self;
Session session;
DivElement brawlArena = querySelector("#arena");

Future<Null> main() async {
  window.onError.listen((Event event){
    ErrorEvent e = event as ErrorEvent;
    //String msg, String url, lineNo, columnNo, error
    printCorruptionMessage(SimController.instance.currentSessionForErrors,e);//(e.message, e.path.toString(), e.lineno.toString(), e.colno.toString(), e.toString());
    return;
  });

  new AfterlifeController();
  await globalInit(); // initialise classes and aspects if necessary
  session = Session.defaultSession;
  self = SimController.instance;
  if(getParameterByName("seed",null) != null){
    self.initial_seed = int.parse(getParameterByName("seed",null));
  }else{
    int tmp = getRandomSeed();
    self.initial_seed = tmp;
  }
  self.loadPlayers(session);
  globalCallBack = self.renderGhostsPlusShenanigans;
  load(session, session.players, [], "ghostNewBullshitReallyIShouldJustBeUsingCallbackAlone");
}

/*
  doesn't do sim stuff, it's overrides are errors, but need it to do a few other things. whatever.
 */
class AfterlifeController extends SimController {

  List<Player> players;


  AfterlifeController() : super();


  void loadPlayers(Session session){
    session.players = getReplayers(session);
    for(num i = 0; i<session.players.length; i++){
      session.players[i].ghost = true; //not storing that as a bool. 'cause fuck you,thats why'
    }
  }

  void renderSingleGhost(Player ghost, int i) {
    //;
    Element div = querySelector("#afterlifeViewer");
    String html = "<div class = 'eulogy'><div class = 'eulogy_text'>The " + ghost.htmlTitle() + " died " + ghost.causeOfDeath + ".";
    if(ghost.causeOfDrain != null && ghost.causeOfDrain.isNotEmpty){
      html += " They were drained to the point of uselessness by the" + ghost.causeOfDrain + ".  They will recover eventually. ";
    }
    html +="</div>";
    String divID = "Eulogy$i";
    html += "<br><canvas id='canvas" + divID+"' width='$canvasWidth' height='$canvasHeight'>  </canvas></div>";
    appendHtml(div, html);
    CanvasElement canvas = querySelector("#canvas"+ divID);

    var pSpriteBuffer = Drawing.getBufferCanvas(SimController.spriteTemplateWidth, SimController.spriteTemplateHeight);
    Drawing.drawSprite(pSpriteBuffer,ghost);

    Drawing.copyTmpCanvasToRealCanvasAtPos(canvas, pSpriteBuffer,0,0);
  }

  void renderGhostsPlusShenanigans() {
    for(int i =0; i<session.players.length; i++) {
      Player p = session.players[i];
      renderSingleGhost(p, i);
    }
    DivElement arena = querySelector("#arena");
    DivElement controlPanel = querySelector("#controlPanel");
    renderVal(controlPanel);
  }

  void renderVal(DivElement controlPanel){
    controlPanel.append(new ImageElement()..src="images/Credits/val.png"..id="valPic");
    controlPanel.append(new ButtonElement()..type="button"..id="playerBrawlButton"..className="controlButton"..text="Pit the players against one another?");
    ButtonElement playerBrawlButton = querySelector("#playerBrawlButton");
    playerBrawlButton.onClick.listen((_) => self.startBrawl(brawlArena));
    controlPanel.append(new ButtonElement()..type="button"..id="enemyVsBrawlButton"..className="controlButton"..text="Pit the players against equal foes in Glorious Combat?");
    ButtonElement enemyVsBrawlButton = querySelector("#enemyVsBrawlButton");
    enemyVsBrawlButton.onClick.listen((_) => self.brawlWithEnemies(brawlArena));
    controlPanel.append(new DivElement()..id="multiBattleDiv");
    DivElement multiDiv = querySelector("#multiBattleDiv");
    controlPanel.append(new InputElement()..type="number"..className="multiButton"..id="numMultiStrifeBox"..min="1"..max="50"..value="7");
    InputElement numMultiStrifeBox = querySelector("#numMultiStrifeBox");
    controlPanel.append(new ButtonElement()..type="button"..id="multiEnemyVsBrawlButton"..className="multiButton"..text="Pit the players against equal foes in Glorious Combat multiple times?");
    ButtonElement multiEnemyVsBrawlButton = querySelector("#multiEnemyVsBrawlButton");
    multiEnemyVsBrawlButton.onClick.listen((_) => self.brawlWithEnemiesMulti(int.parse(numMultiStrifeBox.value)));
  }

  void startBrawl(DivElement div){
    DivElement div = querySelector("#arena");
    if(session.players.length == 1){
      div.text = "Shit, man. Theres only one kid here, and they cant very well fight themself.";
      div.text += " Although... Perhaps valhalla has a challenge for them? A one on one fight should cheer them right up!";
      brawlWithEnemy(div);
      return;
    }
    prepareForBrawl();
    List<GameEntity> playerTeam1 = new List<GameEntity>();
    List<GameEntity> playerTeam2 = new List<GameEntity>();
    List<Team> teams = new List<Team>();
    for(int i =0; i<session.players.length; i++) {
      Player p = session.players[i];
      if(i%2==0){
        playerTeam1.add(p);
      }else{
        playerTeam2.add(p);
      }
    }
    playerTeam1.shuffle(session.rand);
    playerTeam2.shuffle(session.rand);
    teams.add(new Team(session, playerTeam1));
    teams.add(new Team(session, playerTeam2));
    Strife brawl = new Strife(session, teams);
    brawl.startTurn(div);
  }

  GameEntity genEnemyOneOnOne(GameEntity fighter){
    print("TEST MOBILITY: " + fighter.getStat(Stats.MOBILITY).toString());
    GameEntity enemy = new GameEntity(" Val's First Hope Underling", session);
    Map<Stat, num> tmpStatHolder = {};
    tmpStatHolder[Stats.MIN_LUCK] = 0;
    tmpStatHolder[Stats.MAX_LUCK] = 0;
    tmpStatHolder[Stats.CURRENT_HEALTH] = fighter.getStat(Stats.CURRENT_HEALTH, true)*2;
    tmpStatHolder[Stats.HEALTH] = fighter.getStat(Stats.HEALTH, true)*2;
    tmpStatHolder[Stats.MOBILITY] = fighter.getStat(Stats.MOBILITY, true)-100;
    tmpStatHolder[Stats.SANITY] = 0;
    tmpStatHolder[Stats.FREE_WILL] = 0;
    tmpStatHolder[Stats.POWER] = fighter.getStat(Stats.POWER, true)/2; //this will be a challenge.
    tmpStatHolder[Stats.GRIST] = 0;
    tmpStatHolder[Stats.RELATIONSHIPS] = -100;
    enemy.stats.setMap(tmpStatHolder);
    return enemy;
  }

  void brawlWithEnemy(DivElement div){
    prepareForBrawl();
    Player mvp = findStrongestPlayer(session.players);
    List<GameEntity> team1 = new List();
    List<GameEntity> team2 = new List();
    List<Team> teams = new List();
    team1.add(mvp);
    team2.add(genEnemyOneOnOne(mvp));
    teams.add(new Team(session, team1));
    teams.add(new Team(session, team2));
    Strife strife = new Strife(session, teams);
    strife.startTurn(div);
  }

  void brawlWithEnemies(DivElement div){
    prepareForBrawl();
    List<GameEntity> team1 = new List();
    List<GameEntity> team2 = new List();
    List<Team> teams = new List();
    for(int i=0; i<session.players.length; i++) {
      Player p = session.players[i];
      team1.add(p);
      team2.add(genEnemyOneOnOne(p));
    }
    teams.add(new Team(session, team1));
    teams.add(new Team(session, team2));
    Strife strife = new Strife(session, teams);
    strife.startTurn(div);
  }

  void prepareForBrawl(){
    for(int i=0; i<session.players.length; i++) {
      Player p = session.players[i];
      if(p.dead = true){
        p.increasePower();
      }
      p.makeAlive();
      p.heal();
    }
  }

  void brawlWithEnemiesMulti(int numToStrife){
    for(int i=0; i<numToStrife; i++){
      brawlWithEnemies(brawlArena);
    }
  }

}