import "../../GameEntity.dart";
import "SBURBClass.dart";
import "../../../SBURBSim.dart";

import "../../../Lands/FeatureTypes/QuestChainFeature.dart";
import "../../../Lands/Reward.dart";
import "../../../Lands/Quest.dart";

class Clown extends SBURBClass {
    
    @override
    String sauceTitle = "Glitch";
    
    //what sort of quests rewards do I get?
    @override
    double itemWeight = 0.51;
    @override
    double fraymotifWeight = 0.01;
    @override
    double companionWeight = 0.51;

    @override
    List<String> associatedScenes = <String>[
        "Clown I:___ N4IgdghgtgpiBcIDCAbA9gdzAAgJIgBoQAzFCANzQCcAVGADwBcEQAeAIwD4BlXAEQCiARQCqA7jXisA9F2w0AFjGzckAgHICA+gHkA6poBKW9QEEAsgOwBLAM7YADgFdGja2ADm2NDgjZbCpjYjGjYACZ2jFQQAMaMwUrYMT621Iz2xFRoUAnKYTC2UU5x1j7YEFlOYGG5UAB0ePFhaAVgAOTxSigO2FDFCgTY7C7YYEGMiaoa2vpGJhZWChD2UNTKDA4wVNYwYDHKEE2R0SWejjBoDijKGNYTudZU5babcXWEIIwVHjCMOmBwRBFOBEKLWDw-KhIHwRNwpAAy1nI7g8LAA2sAADogaxQBxpCBgRh6ahhbHwbHqaSmbEESk6Gjk7HECAoWwwWnYgBqhlw3AA0jSEMzWezOeBoBzhSBcLZuDAUMRxbj8VQvkTcESmSAAAzYgC+gyxOLxBKJJKoZOlVKFdJA6gZ2pZbKldp5fMFTtFruxkFg2tlphQSJ9JtV6sYmsY2r1IEN2GNKrNxNJ2pt4odjOlwPF7oFQopJG94r9UsLsoA4mgwjQdlRlaa1YTI1rpbH44nGxGLVbCwAFFDFADW8jQQ928C0U+w6gALLgPGEPAoPIwPA5rAAhGK4UyC9imKgeACaGHUx9Mu4AjqYAJwoABWFaQpj4Qg8m6g-IEpnYHiEAgAKyzhgpgwKY8IeNYOjcBW9CmBgOingATGBNCbvQAgoEgSAeHwOgxEgUAYMem7wsQaC4KRCimFApi0XcaC2AAzNwFhoIwV78hgAC0NAeBWACMHimAAEoYSD8mgpibjqEAABwYAeOhXuYjBhAA1KJpEAJ6mH2QimB4YAAFpDjxtgAFKzn2kDcOYD5IAoS6bjeAjSUOeGCuouAKEg6gAGLcLY5CiR4OqiUBuBIGA3AQDQphoCgpgiDoABeHg6U47CoE4Ihsa+2mmOQUBCLOjDkCZOjwgom5VB4aUwJZx6iSZx7cJuGniDq9AaTA3CWVeJmmeQKCGIB9BVUIthIIJKDcMe6gQJuAWmIJPHEHofAPjEOooAA7GxYQQVQhG2FeV4VpxABsGlQJuFYaYJJnMQFfBICIKB8KYi0Pmxm7WE+5gOGA5gABrIbO5DMRpHiWZux59shOrWAookFRmjrZlQTihnmnrSs6YqEL6kraqJyzcPsAINuGzZRjGBpGtiSZNuaqbWtSmNZoWRN47y+Zei6JZk9KsqGISzRQLTyYM9KzHMUzCYs12zY9mmXMk-aWO88WWv4wWIrC1rpYBnKCpKlrrMRnLhbtszYbJurnO2vSPNG8TboCwTuvG3apti7YQYhjLbMttGbZK52dPs5aGuu9r7ufDj-MeobRZ+6T-qB1WNZ1qHNutnbUcqzHKZx9KA7DqO45gJO05zguS4rmuG7bru+6HieZ4Xted6Ps+r7vp+36-v+QEgWBEFQTBcEIUhGCoTA6GYdhuH4YRxGkeRlHUbR9FQIxLFseYHFcbx-FCSJ4mSdJskKUppgqWpmnaZuekGUZpnmVZNl2Q5TkXJuQ8l5UwPk-KBWCqFcKkVALRVivFRKyVUoZSyjlQc+V6J8CKiVMqFUqo1Tqp4RqzVWrtU6t1Xq-VBrDRMqNcak0dDTVmvNRay1VrrU2ttXaB0jonTOhdK6V5br3Ues9V671PrfV+v9QGFZgagwhlDGGcMEZIxRmjDGWtMzahzPrb26c+Yi2zoWCmcpqahmtvTIu2J7bK0dmHZ2hZ0zaJ1h7VOgtCZ639qLcstgJbVGyAXaxEdCwKxLg47sHNnGaztDorxmcQAGyFp7LOZZsSynlIqYJGobG6giVY2OvZKSxLdikjxPt3HGPSTKIOwZyCWNVrk0JtiClNPLsU+0pTE7lNzAY3pJtfEZNsLnWsWwcnh0ZnGB2hSOnairjEEcNAxwTinFoGc85FzLlXOuLcO49y-i7qec8l5TA3nvE+F8b4Pxfh-H+ACwFQLgUgtBWC8FEIoTQhhLCOE8IESIiRMiFEqKbhonRBiIRj7sU4txPiAlhJiQklJGSclFLKVUupLSul9KGWMmZCy1lbIQHso5ZyH5gGmE8nwbyvl-JBRCmFCKUUYpxQSklFK6VMrZVypgwqF5cHlUqtVWq9USEtTah1Lq3Aep9QGkNEaY0JpTRmnNBaS0VprQ2ltHae1DqmGOvCU6SBzqXRundB6T0XpvQ+l9H66g-oyTkQo8GkNoaw3hojZGqN0b0W5rolOfS04DJ8SY7EZiqa7EaWXW2rTpn2NmU4kpCd4m+1SUk-pCS00Bz8QEqWEyY0gGutdNpZdE1dOTW4jOabkmZtDNm4ZWTLZ2lmQWux0cnbRKTX62tgbPGprrUM2pwcGn5ryW20uHaK4xIrUnPRXsg09sGaG2poz85W3aa2ktk7OkLKWSsuuayNlN22a3PZHdDlHmOb3M5-dLlDxuaPe5E8nnT1eXPD5i8vmr1+RvAF29gV73BYfSFrFoXnzhVfRFt8UUP3RS-LF78cVf3xb-IlJLAHktMO5SloDwF0qgYy2B8DWVII5ag7lGCCrYP5aVQVBCRXEKauK8hUqZXUPlXQxVjDmGqrYRqzh2qeF6oNUak1QiREWvEdaqRdqHUAyBiDF1yj3VqK9Zo31rjZ0Bv0Qu-t1TyaUwsaOlp+S43tscZ28t3a9M6b7VUpdNTxaSyCeu6NeTwlxgALofDBBCLY0Jqh3FKGAWw8JJbom80QGAxBiAwDiLYAK1BETIk8OiczUSp3YnMO4XETgcjwmHPp6UTlCQ-HMDpbgXwI7zrs1WqNyZ1B5fYOM6UPFBKKzMxOizmWQCn3YNYYMjAdJFcLCVzwMByuVcOL2ypdWJmNagM1+s0p2tbu6zuwciya6rIbps5uOy277M7penupzzkDyucPW5Y8HmT2eTPN589PnL2+WvP5m9AU7xBWCg+R9QOnxhRfeF18kV31RY-Z+mK34f1xd-Alf9iUALJa5LDIDqVgNpZAhlMDmUILZcgzlaCeVUZwbR-BwqiENSY2QyVlDZU0IVQw5VLC1XsM1VwnVvD9X8ONYIs1ojLUSJtdI+1siFOKNdSoj16jvVaJDTUisIZTAlB8DN9Oc6usRgW0tqZHZNdq0s9lsAuX8uFYc9qMbZWKtVbV8G-XRJtctcLG15i47IkG5631gbdxhvm+K0scbk2be2dm0Y1zDWmtO+xO1t3CbLO7u2we3bx6W67Pbgcg8J2Tl9wuYPa5I87nj0eVPF5s93kLyXivH569-lbyBbvUF+8IVMX+2fWFl8EU32RffNFT8MWv2xZ-PFP9CX-1JUA1HOH0d4ax9AplcCWWIPZSgrl6C8ok5o3goVhDRXU4lRQ6VVC5W0PoUqphKrWHqo4Vq7huq+GGoEaa4R5qxFWskbamRjrxdKbdaoz1GifUE560QBFcGllc4QwBbdsZcZ5tI9lti5Ot3ciltQjcTdsACtFkRtsRLcJtrdpsQ9DFvF7dGBHd4DsQXc1sMtOkvdBtfd5cLcA8rcptqtuQM0bNm12lSDtRVtEC48esE9lla5651lG4tlU9Dtz1M9u5s8b1c9LsH1C9bsX1S9HsP1K9Xsf1a9PsANG8gM-sT428gdIMu8wdYM+94NockNh94c0MkcJ9sMqUaUIF6U58iNF98cyNV9icsFSct96NKcxUacD82Nj9Gcz8eNL82cBNb8ucRNH9xMX9BdpMP9Rcv95FFMlFf9pc1NACsCQClcVdICCD-UYDw8w4uDI4vMPhotYt4tEsqAwtqhbAIs4wgA",
        "Page II:___ N4IgdghgtgpiBcIAKEDmMAEBJLIA0IAZgDYQBuA9gE4AqMAHgC4IgA8ARgHwDKWAIgFEAigFUB3GvFYB6LhhoALTNwDCAgHICA+gHkA6poBKW9QEEAsgIwBXAM4xbGRkoCWVDAAclYCrEjEMCFsPGABjRk8KAHcYKkdGCgxbCmIyTApnWNsAck8qCnZiGChbPECAEwgPRhcwVCclQOCwiISMQhcIiDAATyTO6wgaijBI21sXQpgAOnlG1Q1tfSMTCwFsxwhiYhcHQKpMGDT3Z26Aa0JrYlnFZTVNXQMBYzNLJyorvuswcqzGbvKGCiCiGGE6GFg3XiiXYmAgGBQ6GmAB0wBwqJx0Zx8CB-lR0IwdGA4IhGB84AQyS5UOgqCoRuVOi4RrYADIuMi1VAsADawGRIBcUA81H+YEYemo5QF8AF6mkpgFeDlOhoMoFhC29iVAoAaoYsNwANKKhAarUwHXgaCWs0gLC2bgwYiEK1CkVUMWMLDi9UgAAMAoAvmV+YLhaLuhKpX75ablSB1Kq-ZriNr8HqDcbTbKiBarZBYH6HaYdmk3RHPVGfYw-YGQCGMGH3ZHxZKqNK7XGrUm1XbU+mE-rDSaU-mM9ai3aHQBxCjlGi7KgVj1emt14OhgUtqttmN2pDEayhM7yChnGBgeBaG8YdQAFiwqHKqAUqEYqA8LgAQqEsKYTXYUx8QATSidQQNMf8AEdTAATmIAArGcVFMPghFQb8oCNARTHYVAhAEABWe8olMGBTFZVAXB0bgZ3oUwoh0MCACZyJob96AEYgVBUVA+B0UIVCgKIQO-VlCAoLAxIUUwoFMOTOgoWwAGZuAsDJoKNKIAFoaFQGcAEZUFMAAJQwVCNChTG-f0IAADiiICdGg8xGHKABqUyxJ6UwkCEUxUDAAAtM4dNsAApe8kEgbhzEQlQFBfb9YIEayzn4k11CwBQVHUAAxbhbDIUzUH9UziKwFQwG4CAaFMFJTBEHQAC9UB6ax2BUI8RHUtDvNMMgoCEe9GDIYKdFZBRv2+VAWpgCKQNM4KQO4b8PPEf16A8mBuAi6DgpCshiEMIj6AmoRbBUQziG4ED1Agb98tMQydMIPQ+EQ0J-WIAB2dTykoqghNsaDoJnRhoIANg8qBvxnDzDOClT8r4FQRGIPhTHuxD1O-FxkPMDwwHMAANFj7zIFSPNQCLvxApAWP9FwFFMvqe2TO0yWsW0hyzUd+3HBNC1tXNTKCbhQkvXnt0rNdfTtetG2bOWo3bTtc27CdezHNMZZAYds11wcBRF4tbEMAFfBXVtvQV3Moah4MAF0cSpGlYnpH4mRZVkAV5V2CBgQhCBaWx8uodlOTqXkVdXNX91zcxaiFawoAwVljzOAsbT9RLunQcwem4f5awnQ2BdzAd9Z3L11DT2FlztHTDJUpWt3DeO9w7P18oOTA9BcbYc6nXN87qGAi5LoYrQrnNzT1m3d0YeuoEbv1W-bptZa76Me4PI8TzPC8rxvLQ70fZ9X3fT8fz-AC8OA1AwIgqDTFghDkNQ9DMOw3D8MIiRMiFEqI0TogxJirF2KcW4rxfiglhKiXEpJaS35ZLyUUgkVS6lzCaW0npAyxkzIWSsjZOyjlnKuXcl5HyfkApBVCuFKKMUIBxQSklTCqV0qZVMNlXKBUiolTKhVIiVUap1QasQJqrV2qdW6tYXqCk+ADSGiNMaE0pozTqPNRay1VrrU2ttXa+1DrBWOqdc6OhLrXVuvdR6z1XrvU+t9P6AMgYgzBhDaGsN4aI2RqjdGmNsbqFxjZAmM4iYk3JpTamtN6aM2ZqzdmE4zZ2hnByCi4RmRgFnvzeeuJyRLzrg3WIG4GyBxAMHUO4Rw6RwBLYAODYgA"
];
    
    @override
    double difficulty = 0.0;
    @override
    List<String> levels = ["COMIC CRIMINAL", "JOURNEYING JUBALEE", "TIGER EYE"];
    @override
    List<String> quests = ["presenting their talents to the crowd while a partnered consort gathers information", "learning what tricks draw and keep the attention the most", "learning when to drop the facade and be genuine"];
    @override
    List<String> postDenizenQuests = ["learning to control their newfound prowess, accidentally wiping out a consort village or two", "getting all mopey about their new powers, because apparently actually being competent is too much for them", "finishing the legendary tests of valor with a never before seen aplomb", "accepting the role Sburb has placed upon them. They are themselves, and that is all that needs be said on the matter"];
    @override
    List<String> handles =  ["cunning","cabbaged","crazy","campy","control", "comic",];

    @override
    bool isProtective = false;
    @override
    bool isSmart = false;
    @override
    bool isSneaky = true;
    @override
    bool isMagical = true;
    @override
    bool isDestructive = false;
    @override
    bool isHelpful = false;

    Clown() : super("Clown", 21, false, isInternal:false);

    @override
    List<AssociatedStat> stats = new List<AssociatedStat>.unmodifiable(<AssociatedStat>[
        new AssociatedStat(Stats.MOBILITY, 3.14, false)
    ]);

    @override
    bool isActive([double multiplier = 0.0]) {
        return false;
    }

    @override
    void initializeItems() {
        items = new WeightedList<Item>()
            ..add(new Item("Gun",<ItemTrait>[ ItemTraitFactory.METAL,ItemTraitFactory.CLASSY,ItemTraitFactory.IRONICFAKECOOL],shogunDesc: "You Gonna Fire That Little Man?.",abDesc:"It's a gun, chucklenuts"))
            ..add(new Item("Rubber Nose",<ItemTrait>[ItemTraitFactory.PLASTIC, ItemTraitFactory.CLASSRELATED, ItemTraitFactory.COOLK1D],shogunDesc: "Honk Honk, Bitch",abDesc:"That's a sterotype.."))
            ..add(new Item("Steroids",<ItemTrait>[ItemTraitFactory.EDIBLE, ItemTraitFactory.CLASSRELATED, ItemTraitFactory.MAGICAL],shogunDesc: "My Morning Medication",abDesc:"Shit son, calm down with all the screaming and the powering up."));
    }

    //they don't have many quests, but once they get going they are hard to stop.

    @override
    void initializeThemes() {
        /*
        new Quest(" "),
        new Quest(""),
        new Quest(" ")

        */
        addTheme(new Theme(<String>["Desert","Sand", "Pyramids", "Camels","Tombs"])
            ..addFeature(FeatureFactory.OVERHEATED, Feature.HIGH)
            ..addFeature(FeatureFactory.ZOOSMELL, Feature.MEDIUM)
            ..addFeature(FeatureFactory.SPICYSMELL, Feature.MEDIUM)
            ..addFeature(FeatureFactory.SALTSMELL, Feature.MEDIUM)
            ..addFeature(FeatureFactory.NATURESOUND, Feature.MEDIUM)
            ..addFeature(FeatureFactory.RUSTLINGSOUND, Feature.MEDIUM)
            ..addFeature(FeatureFactory.CROCODILECONSORT, Feature.MEDIUM)
            ..addFeature(FeatureFactory.IGUANACONSORT, Feature.MEDIUM)
            ..addFeature(FeatureFactory.SNAKECONSORT, Feature.MEDIUM)
            ..addFeature(FeatureFactory.ALLIGATORCONSORT, Feature.MEDIUM)
            ..addFeature(FeatureFactory.LIZARDCONSORT, Feature.MEDIUM)

            ..addFeature(new PostDenizenFrogChain("Help Breed the Frogs", [
                new Quest("The ${Quest.DENIZEN} has allowed water to flow once more. The croaking of frogs fills the air as pools begin to form. The ${Quest.PLAYER1} asks the ${Quest.CONSORT}s to help them collect frogs. The ${Quest.CONSORT}s agree with enthusiastic ${Quest.CONSORTSOUND}s. "),
                new Quest("The ${Quest.CONSORT}s hit buttons on the ectobiology machine at random. The ${Quest.PLAYER1} shows them how to do it right, and soon everybody is helping out. "),
                new Quest("A ${Quest.CONSORT} child has tripped over the final frog. They cry and ${Quest.CONSORTSOUND} at their skinned knee, but their pain is quickly forgotten when the ${Quest.PLAYER1} praises them for finding the frog.  Together,     "),
            ], new FrogReward(), QuestChainFeature.spacePlayer), Feature.WAY_HIGH)

            ..addFeature(new DenizenQuestChain("Become The Best", [
                new Quest("The ${Quest.PLAYER1} was about to walk through a patch of incongruous tall grass when a quirky ${Quest.CONSORT} named Professor ${Quest.CONSORTSOUND} halts them. apparently, it's not safe to travel without trusty ${Quest.PHYSICALMCGUFFIN} by their side. The professor also makes some side comments about the ${Quest.PHYSICALMCGUFFIN} League. If the ${Quest.PLAYER1} can assemble a team strong enough to beat the gym leaders, they might have a shot at becoming the ${Quest.PHYSICALMCGUFFIN} League Champion!"),
                new Quest("The ${Quest.PLAYER1} wanders about their land, learning how to use their ${Quest.PHYSICALMCGUFFIN} effectively and taking down the ${Quest.PHYSICALMCGUFFIN} gym leaders. Along the way, they hear rumors that the dastardly Team ${Quest.CONSORTSOUND}, led by ${Quest.DENIZEN}, plans to interfere with the league. The ${Quest.PLAYER1} will not stand for this."),
                new Quest("After an intense round of ${Quest.PHYSICALMCGUFFIN} battling, the ${Quest.PLAYER1} finally defeats the last gym leader of the ${Quest.PHYSICALMCGUFFIN} league. Turns out, the ${Quest.PHYSICALMCGUFFIN} they used was super effective! they can now challenge the ${Quest.PHYSICALMCGUFFIN} League. "),
                new DenizenFightQuest("The ${Quest.PLAYER1} has finally almost completed the ${Quest.PHYSICALMCGUFFIN} League. Much to their suprise, the Champion they must defeat in order to claim the title is none other than ${Quest.DENIZEN}!!! Will they succeed? STRIFE!","The ${Quest.PLAYER1} is now the ${Quest.PHYSICALMCGUFFIN} League champion. ${Quest.DENIZEN} remains alive just long enough to walk them to the hall of fame, which is suprisingly filled with grist!","The ${Quest.PLAYER1} whited out...")
            ], new DenizenReward(), QuestChainFeature.defaultOption), Feature.WAY_LOW)

            ..addFeature(new PostDenizenQuestChain("Explore the Tombs", [
                new Quest("Now that the ${Quest.DENIZEN} is finally out of the way, some of the previously sealed tombs have opened up. It is time for the ${Quest.PLAYER1} to desecrate the fuck out of some tombs."),
                new Quest("In a twist that is shocking only to the ${Quest.PLAYER1}, they are now inflicted with a Mummy's Curse. There is a REASON you don't desecrate random tombs. A local ${Quest.CONSORT} explains that they will have to find a ${Quest.CONSORT} champion to face the Mummy, for anyone cursed by it will surely perish should they face it in a strife."),
                new Quest("The ${Quest.PLAYER1} finds a competent enough Warrior ${Quest.CONSORT} to help them fight the Mummy. While they can't fight directly, the ${Quest.PLAYER1} can at least give them some ${Quest.MCGUFFIN} buffs. With a deafening ${Quest.CONSORTSOUND}, the Warrior ${Quest.CONSORT} wins the day! The curse is lifted! ")
            ], new ConsortReward(), QuestChainFeature.defaultOption), Feature.WAY_LOW)
            ,  Theme.MEDIUM);
    }
}
