import '../SBURBSim.dart';
import "../Lands/FeatureTypes/QuestChainFeature.dart";
import "../Lands/Quest.dart";
import "../Lands/Reward.dart";
import "VoidSessionSummary.dart";
import "dart:html";
import "../Lands/FeatureTypes/EnemyFeature.dart";
import "../Controllers/Misc/VoidSimController.dart";
import 'dart:async';
import 'dart:html';
//only one player, player has no sprite, player has DeadLand, and session has 16 (or less) subLands.
class VoidSession extends Session {

    @override
    bool noReckoning = false;

    @override
    void setupBattlefield(){
        battlefield.planetsplode(new GameEntity(null, null));
    }

    Player metaPlayer;
    Land currentLand;
    VoidSession(int sessionID): super(sessionID) {
        SimController.instance.maxTicks = 300;
        mutator.sessionHealth = 13000 * Stats.POWER.coefficient;
        sessionHealth = mutator.sessionHealth;
        //have a metaplayer BEFORE you make the bullshit quests.
        mutator.metaHandler.initalizePlayers(this, false);
        metaPlayer = rand.pickFrom(mutator.metaHandler.metaPlayers);
        metaPlayer.setStat(Stats.EXPERIENCE, 1300);
        getPlayersReady();
        timeTillReckoning = minTimeTillReckoning; //pretty long compared to a normal session, but not 16 times longer. what will you do?
    }

    @override
    SessionSummary generateSummary() {
        return VoidSessionSummary.makeSummaryForSession(this);
    }


    @override
    Future<Null> doComboSession(Session tmpcurSessionGlobalVar) async {
        logger.info("Doing a Dead Combo");
        int id = this.session_id;

        if(tmpcurSessionGlobalVar == null) tmpcurSessionGlobalVar = this.initializeCombinedSession();  //if space field this ALWAYS returns something. this should only be called on null with space field
        //maybe ther ARE no corpses...but they are sure as shit bringing the dead dream selves.
        List<Player> living = findLiving(tmpcurSessionGlobalVar.aliensClonedOnArrival);
        //window.alert("doing combo session in dead, cloned aliens: ${living.length}");

        if(living.isEmpty) {
            appendHtml(SimController.instance.storyElement, "<br><Br>You feel a nauseating wave of space go over you. What happened? Wait. Fuck. That's right. The Space Player made it so that they could enter their own child Session. But. Fuck. Everybody is dead. This...god. Maybe...maybe the other Players can revive them? ");
        }else {
            appendHtml(SimController.instance.storyElement, "<br><Br> Entering: session <a href = 'index2.html?seed=${tmpcurSessionGlobalVar.session_id}'>${tmpcurSessionGlobalVar.session_id}</a>");
        }
        checkSGRUB();
        if(this.mutator.spaceField) {
            window.scrollTo(0, 0);
            querySelector("#charSheets").setInnerHtml("");
            SimController.instance.storyElement.setInnerHtml("You feel a nauseating wave of space go over you. What happened? Huh. Is that.... a new session? How did the Players get here? Are they joining it? Will...it...even FIT having ${this.players.length} fucking players inside it? ");
        }
        if(id ==612) this.session_id = 413;
        checkEasterEgg(tmpcurSessionGlobalVar);
        await tmpcurSessionGlobalVar.startSession();
    }


    @override
    Future<Session> startSession([bool dontReinit]) async {
        globalInit(); // initialise classes and aspects if necessary
        SimController.instance.currentSessionForErrors = this;
        changeCanonState(this, getParameterByName("canonState",null));
        //red miles are way too common and also dead sessions are special
        /*prospit.destroyRing();
        derse.destroyRing();*/
        if (doNotRender == true) {
            intro();
        } else {
            //
            load(this,players, getGuardiansForPlayers(players), "");
        }
        return completer.future;
    }

    @override
    Future<Null> intro() async {
        //

        SimController.instance.initGatherStats();

        //advertisePatreon(SimController.instance.storyElement);
        //
        List<String> playerTitlesWithTag = new List<String>();
        for(Player p in this.players) {
            p.handleSubAspects();
            playerTitlesWithTag.add(p.htmlTitleWithTip());
        }

        List<String> npcsWithTag = new List<String>();
        for(GameEntity g in this.activatedNPCS) {
            npcsWithTag.add(g.htmlTitleWithTip());
        }


        appendHtml(SimController.instance.storyElement, "<Br><br>Game ${session_id} of  SBURB has been initiated. All prepare for the arrival of ${turnArrayIntoHumanSentence(playerTitlesWithTag)}. The ${turnArrayIntoHumanSentence(npcsWithTag)} seem to be especially anticipating them.<br><br>Something feels... Off about this session.<br><br>");
        processBigBadIntros();
        await callNextIntro(0);
    }

    @override
    void easterEggCallBack() {
        VoidSession vs = (this as VoidSession);
        //initializePlayers(this.players, this); //will take care of overriding players if need be.
        //has to happen here cuz initializePlayers can wipe out relationships.
        vs.players[0].deriveLand = false;
        //ds.players[0].relationships.add(new Relationship(ds.players[0], -999, ds.metaPlayer)); //if you need to talk to anyone, talk to metaplayer.
        //ds.metaPlayer.relationships.add(new Relationship(ds.metaPlayer, -999, ds.players[0])); //if you need to talk to anyone, talk to metaplayer.

        checkSGRUB();
        if (doNotRender == true) {
            this.intro();
        } else {
            load(this, this.players, getGuardiansForPlayers(this.players), "");
        }
    }

    @override
    Future<Null> reckoning() async{
        Scene s = new VoidReckoning(this);
        s.trigger(this.players);
        s.renderContent(this.newScene(s.runtimeType.toString(),));
        simulationComplete("Dead Reckoning.");
        renderAfterlifeURL(this);
    }

    @override
    Future<Null> processCombinedSession() async{
        logger.info("processing a Dead Combo");

        //guaranteed to make one since it's a dead session
        this.players[0].relationships.clear(); //forgot about that annoying voice in your head.
        Session tmpcurSessionGlobalVar = this.initializeCombinedSession();
        SimController.instance = null;
        new StoryController();
        await doComboSession(tmpcurSessionGlobalVar);

    }


    @override
    Future<Null> callNextIntro(int player_index) async{

        if (player_index >= this.players.length) {
            await tick(); //NOW start ticking
            return;
        }
        IntroVoid s = new IntroVoid(this);
        Player p = this.players[player_index];
        //

        //var playersInMedium = curSessionGlobalVar.players.slice(0, player_index+1); //anybody past me isn't in the medium, yet.
        List<Player> playersInMedium = this.players.sublist(0, player_index + 1);
        s.trigger(playersInMedium, p);
        s.renderContent(this.newScene(s.runtimeType.toString()), player_index); //new scenes take care of displaying on their own.
        this.processScenes(playersInMedium);
        //player_index += 1;
        //new Timer(new Duration(milliseconds: 10), () => callNextIntro(player_index)); //sweet sweet async
        SimController.instance.gatherStats(this);
        await window.requestAnimationFrame((num t) => callNextIntro(player_index + 1));
    }





    @override
    void makePlayers() {
        logger.info("making players from seed ${rand.spawn().nextInt()}");
        this.players = <Player>[];
        if(tableGuardianMode ) {
            activateAllCarapaces();
        }else{
            resetAvailableClasspects();
            print("after reseting classpects, got $canonLevel");
            int numPlayers = this.rand.nextIntRange(
                2, 12); //rand.nextIntRange(2,12);
            if (getParameterByName("playerCrowd", null) != null) {
                String holder1 = getParameterByName("playerCrowd", null);
                int holder2 = int.parse(holder1);
                numPlayers = holder2;
            }
            print("initialising $numPlayers players");
            double special = rand.nextDouble();
            List<Player> replayer = getReplayers(this);
            if (replayer.isEmpty) {
                //this.players.add(randomSpacePlayer(this));
                //this.players.add(randomTimePlayer(this));
                //no spacetime baybee!!
                for (int i = 0; i < numPlayers; i++) {
                    this.players.add(randomPlayer(this));
                }

                //random chance of Lord/Muse for two player sessions
                if (numPlayers <= 2) {
                    ;
                    if (special > .6) {
                        players[0].class_name = SBURBClassManager.LORD;
                        players[1].class_name = SBURBClassManager.MUSE;
                        players[0].initializeDerivedStuff();
                        players[1].initializeDerivedStuff();

                    } else if (special < .3) {
                        players[0].class_name = SBURBClassManager.MUSE;
                        players[1].class_name = SBURBClassManager.LORD;
                        players[0].initializeDerivedStuff();
                        players[1].initializeDerivedStuff();
                    }
                }
            } else {
                players = new List.from(replayer);
            }

            logger.info("players is $players");
            playerInitialization();
        }
    }

    @override
    void reinit(String source) {;
        super.reinit(source);
        mutator.sessionHealth = 13000 * Stats.POWER.coefficient;
        sessionHealth = mutator.sessionHealth;
        //have a metaplayer BEFORE you make the bullshit quests.
        mutator.metaHandler.initalizePlayers(this,true);
        metaPlayer = rand.pickFrom(mutator.metaHandler.metaPlayers);
        metaPlayer.setStat(Stats.EXPERIENCE, 1300);
        timeTillReckoning = minTimeTillReckoning; //pretty long compared to a normal session, but not 16 times longer. what will you do?
        //this.rand.setSeed(131313131313);

    }

    @override
    void makeGuardians() {
        for(Player p in players) {
            p.makeGuardian();
        }
    }

    /*@override
    String convertPlayerNumberToWords() {
        return "ONE";
    }*/

    //unlike regular sessions there is no way to fail this.
    @override
    Session initializeCombinedSession() {
        logger.info("initing a Void Combo");

        this.aliensClonedOnArrival = <Player>[]; //PROBABLY want to do this.
        List<Player> living = findLiving(this.players);
        living.add((this as VoidSession).metaPlayer);
        //nobody is the leader anymore.
        Session newSession = new Session(this.rand.nextInt(),true); //Math.seed);  //this is a real session that could have gone on without these new players.
        newSession
            ..currentSceneNum = this.currentSceneNum
            ..afterLife = this.afterLife //afterlife carries over.
            ..stats.dreamBubbleAfterlife = this.stats.dreamBubbleAfterlife //this, too
            ..reinit("Dead Combo")
            ..makePlayers()
            ..randomizeEntryOrder()
            ..makeGuardians();

        newSession.addAliensToSession(this.players); //used to only bring players, but that broke shipping. shipping is clearly paramount to Skaia, because everything fucking crashes if shipping is compromised.

        this.stats.hadCombinedSession = true;
        this.childSession = childSession;
        //newSession.parentSession = this;
        Scene.createScenesForPlayer(newSession, players.first);
        //logger.info("initializing  a session with players ${newSession.players}");
        return newSession;
    }

}