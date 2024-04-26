```text



Hello! This is a WIP HttT revision for Battle for Wesnoth. If you're interested in collaborating, please reach out to Dalas via the Wesnoth discord or forum.

Status: Intro scenario mostly finished. Bigmap for next 3 scenarios mostly finished.


//############################
// CONTRIBUTORS - READ THIS FIRST
//############################
- Right now, let's focus on writing the scenarios for Phase 1.
- Read through this document. Some scenarios have more info, some have less.
	- These are just my thoughts, not necessarily a must-have.
- Pick out a scenario you're interested in working on. Update this document to assign yourself.
- Work on a script/outline for the scenario. Post that here or in the discord for review.
- Once approved, write the WML itself. When finished, make a PR and we'll all give it a try.


//########################################################
//                     DESIGN OVERVIEW
//########################################################
//############################
// THE OVERWORLD
//############################
- after each scenario the player gets sent to the "overworld", an in-game map of the great continent
- the player chooses their next scenario via the overworld. Only some scenarios are available at a time, depending on the current "phase"
- after playing a certain number of scenarios (varies by difficulty), the player is forcibly advanced to the next phase
- each scenario has a preview, including:
	- difficulty (1 skull, 2 skulls, etc)
	- reward: gold carryover (no/low/high)
	- reward: new recruits
	- reward: loyal companions
	- reward: other
- after playing each scenario, the season of the year changes. Spring, Summer, Fall, Winter. Summer/Winter seasons result in battle scenarios with longer/shorter daytime.

//--------------------
// REWARDS
//--------------------
- Konrad starts with 0 recruits. In Phase 1 and Phase 2, he builds up his recruit list depending on which scenarios he chooses to play.
- many Phase 1 and Phase 2 scenarios also give loyal companions as rewards, who're auto-recalled in each scenario and have custom dialogue.
- Phase 3 scenarios focus on hindering Asheviere. For example, completing "Test of the Clans" might get rid of Asheviere's cavalry in the final confrontation.
	- possibly also scenarios that buff up Li'sar? (who's a separate side, not under the player's control)
- rewards can be given at the beginning of the scenario, at the end, in the overworld, or anywhere in between


//############################
// NARRATIVE DESIGN
//############################
//--------------------
// PLOT
//--------------------
Phase 1
- Konrad and Delfador are driven from the Aethenwood by Asheviere's human armies
- Konrad and Delfador complete 1 scenario together (limited choice here; only Exodus, Blackwater, or Pearls)
- Delfador leaves to help in the defense of Elensefar
- player plays 2-4 more phase 1 scenarios (varies by difficulty)
- Elensefar falls. Delfador returns, and exhorts Konrad to flee north, either via the Ford of Abez or via Elensefar

Phase 2
- Li'sar follows Konrad north across the great river. Both race to get the sceptre
- Li'sar's actions show she's a decent person, unlike her mother. We get some insight into her relationship with Asheviere.
- player plays 2-3 more phase 2 scenarios (varies by difficulty)
- Li'sar gets close to the sceptre. Konrad chases after her.

Phase 2.5
- Konrad gets the sceptre first. Delfador collapses the cave behind them, (presumably) killing Li'sar
- surprise, Li'sar's back. Her army is much weaker
- Konrad has a change of heart, and refuses to fight Li'sar. He joins her / is taken prisoner / something like that
- Delfador worries Konrad will be executed once Li'sar reaches Weldyn. Delfador goes off to fight Asheviere by himself
- Li'sar and Konrad fight Asheviere's ally Iliah'al (details TBD after AoA releases). They bond.
	- Li'sar is always a separate allied side, not directly under the player's control

Phase 3
- we learn that Delfador has been captured by Asheviere, and will be executed in X months (not immediately, because Asheviere is trying to lure Konrad)
- player plays 2-3 more phase 3 scenarios (varies by difficulty)
- Konrad and Li'sar confront Asheviere at Weldyn. Delfador is rescued; Asheviere dies/flees/etc. Hooray!

//--------------------
// CHARACTERS
//--------------------
Konrad (phase 1)
- sees the good right in front of him (contrast this with Delfador)
- calls people "Master", "Sir", "Uncle", "Ma'am", "Miss", "Aunt". Not every time, but occasionally.
- humans are foreign and weird. He understands elves, not humans.
- naive but good-hearted. Might get tricked or taken advantage of. Think samwise gamgee manners
- as he hits phase 2, phase 3, he starts to get more assertive and confident.

Delfador
- for the greater good; i.e. needs of the many/few (contrast this with Konrad)
- calls Konrad "young prince", "master Konrad", etc. Or just "Konrad"

Li'sar
- stoic, proud, relentless.
- prefers tricks, ambushes, and "clever" tactics, but doesn't shy away from a straight-up fight
- calls Asheviere "mother", like Eldred did. But their relationship is quite distant
- she's a decent person. For example, she wouldn't fight unarmed civilians and would try to evacuate them before a military battle in their village
	- but vs a military opponent, she'd hold back absolutely nothing and would have no problem being extremely brutal
- disapproves of Asheviere's orcs
- recruits primarily of HI and Fencers


//############################
// SCENARIO DESIGN
//############################
//--------------------
// GLOBAL INCLUDES
//--------------------
- to make it easy to tweak Konrad, please define side 1 with `{KONRAD_SIDE {ON_DIFFICULTY4 100 80 65 50}`. `FOG=yes` and `SHROUD=yes` optional
- to ensure your scenario's ToD reflects the overworld, use `{SCHEDULE_DYNAMIC $current_time}`
- to ensure all companions get recalled properly, please use `{RECALL_KONRAD_AND_COMPANIONS $x $y}`
	- companions need custom dialogue in many scenarios, to help them feel alive!

//--------------------
// DIFFICULTY
//--------------------
Easy should be nigh-unloseable. Nightmare should be seriously difficult even for you or me.

These are my recommended difficulty modifiers. You don't need to use this if you don't want to (or if it doesn't make sense for the scenario), but please ensure the difficulty scales similarly so all scenarios stay in balance.
- Easy:      1.0x enemy/ally strength, 100% starting gold (ignoring carryover)
- Normal:    1.5x enemy/ally strength,  80% starting gold (ignoring carryover)
- Hard:      2.0x enemy/ally strength,  65% starting gold (ignoring carryover)
- Nightmare: 2.5x enemy/ally strength,  50% starting gold (ignoring carryover)
- Additionally, on higher difficulties the player gets less time in each phase before being pushed on to the next one, which reduces your rewards/XP.

//--------------------
// XP FEEDING
//--------------------
Leveling units is fun! I want players to be able to continue to level units throughout the campaign, instead of maxing-out their army halfway through. With this in mind, please try to restrict available XP.
- small player armies; 50-75 initial gold (plus carryover) on Nightmare is a good guideline for the average scenario
- use lower-level enemies where possible. 1 Warlord is easy to farm for XP; 3 Grunts are much harder; 6 Goblins even more so.
- don't include a large amount of villages, unless carryover gold is the scenario's primary reward
- enemies should retreat and regroup where appropriate, instead of trickling. See EI's Xenophobia for an example.
- end scenarios sooner rather than later. If there's no threat after the first 10 turns, don't ask the player to survive for 20.

//--------------------
// AI DESIGN
//--------------------
- use `{SILENTLY_LIMIT_LEADER_MOVES}` to prevent AI leaders from running too far from their keeps. This macro provides a balance between the over-aggressive default behavior and the too-passive `passive_leader=yes`
- where applicable, reminder to have AI retreat and regroup instead of trickling. See EI's Xenophobia for an example.
- where applicable, AI should be less aggressive at unfavorable ToD (regardless of the player's favorable ToD). See EI's Xenophobia for an example.
- where applicable, if an AI side is defending, please use proper defensive AI with `[avoid]` and similar. See TDG's "Ring of Swords" for an example.
- if you have AI allies, I suggest scaling their gold so they always feel useful. For example, if my ally is 1/2 as strong as the enemy on Easy, they could be 1/2 as strong on Nightmare too.
- for consistency, I usually give AI sides a very very small general recruit list (e.g. just Spearman), and then allow for a few additional units with {LIMIT_CONTEMPORANEOUS_RECRUITS} (e.g. 0-2 Bowmen, 0-2 Cavalrymen)
	- this is also a good way to let the AI recruit a couple higher-level units (e.g. Javelineer, Pikeman) without making the entire side easy to farm for XP
- when creating AI guards, please use MAIs instead of status=guardian. For example, `{ZONE_GUARDIAN 14 14 x,y,radius=11,12,2}`. This also lets you sync up multiple guards so they fight together instead of being lured out 1-by-1.
	- some campaigns use loyal icons for guards, some campaigns don't. For consistentcy, let's not use loyal icons for guards in HttT

//--------------------
// TEAMS AND COLORS
//--------------------
(not mandatory, but let's try to stay more-or-less consistent please)
- Konrad: red
- Asheviere/Li'sar: purple
- Li'sar (after joining Konrad): wesred
- Elves: brightgreen
- Dwarves: brown
- Blackcrests: black (these guys use lots of shamans)
- Whitefangs: white (these guys use lots of goblins and goblin riders)
- Undead: white
- Drakes: orange

//--------------------
// COMPANIONS
//--------------------
Each companion has a personality and a quest - a specific scenario that provides a special bonus if they get there.
Maybe the quest reward is automatic (just complete the scenario), or maybe there's some special bonus objective.
Quest rewards should be minor bonuses, not major rewards. Perhaps you get a bonus ability, or maybe you get the option to "trade in" your companion for some more significant bonus.
----Morimeru
- jolly, holy, clever warrior monk from the monestary featured in Valley of Death
- someone who'll blast away zombies while quoting scripture (no specific religions plz; neither IRL ones nor Wesnoth ones)
- quest: bring him to Valley of Death and do something with him there.
----ulf
- hurls long strings of creative insults at his enemies
- takes offense very, very easily
----Harper
- 
----possibly Arvith/Baran
- 
----Kalenz
- 
----runesmith
- 

//--------------------
// CHARACTER INTERACTIONS
//--------------------
- in each scenario, please include 0-2 interactions between Konrad and his companions, at suitable moments
- if the preferred companions aren't present, fall back to firing a "say_companion_interaction" event so we can follow some scenario-independent companion storylines too
	- please set $scenario_number beforehand (e.g. "s14"), in case that matters for the scenario-independent companion storylines
	- "say_companion_interaction" will be implemented via macros in _main.cfg and unified_characters.cfg (probably by Dalas)

Example:
[if] {HAVE_UNIT id=Moremirmu} {THEN(
	[message]
		speaker=Moremirmu
		message=_"Undead are bad. I'm a holy guy. Let's beat these undead who are attacking."
	[/message]
	[message]
		speaker=Konrad
		message=_"Yeah let's do it."
	[/message]
)}
[elseif] {HAVE_UNIT id=Delfador} {THEN(
	[message]
		speaker=Konrad
		message=_"Delfador what shall we do?."
	[/message]
	[message]
		speaker=Delfador
		message=_"I shall blast these undead with scary lighting!"
	[/message]
)} [/elseif]
{ELSE(
	{VARIABLE scenario_number s14}
	{FIRE_EVENT say_companion_interaction}
	{CLEAR_VARIABLE scenario_number}
)}

//--------------------
// OTHER
//--------------------
- if your scenario has a time limit, please include at least a basic "time over" cutscene as well as "we're running out of time" dialogue some turns beforehand
	- instead of using `name=time over`, trigger this event on `side 1 turn {SCENARIO_TURN_LIMIT} end`, so that we don't waste the player's time when they've already lost
- please include an achievement in every scenario! Could be a difficult challenge, a hint towards some content the player might miss, or anything else.
- please avoid giving the player non-loyal companions. This is partially a style thing, partially to give players fewer "I'll reload if this unit dies" units, and partially to keep the overworld rewards preview simpler


//########################################################
//                         TASKLIST
//########################################################
//############################
// OTHER
//############################
[IN PROGRESS] Konrad Artwork (Mechanical)
[IN PROGRESS] S00: The Great Continent (Dalas)


//############################
// SCENARIOS TO WRITE
//############################
(Occasional gaps in scenario numbers are deliberate. That way if we need to add a new scenario sometime we don't have to renumber everything.)

//--------------------
// PHASE 1 (WESTERN WESNOTH)
//--------------------
----Western Scenarios:
[FINISHED] S01: The Elves Besieged (Dalas)

S02: Exodus (unassigned)
- 1-to-2-skull difficulty. Rewards: Elvish Archer, Elvish Fighter, Elvish Scout
- elves are fleeing from the top right while humans man the flanks. Similar to the first scenario of Dirty Blood
	- Ethiliel/Ithelden may or may not still be alive ($ethiliel_alive/$ithelden_alive), depending on the player's performance in the intro scenario
- the more elves who die, the fewer recruits you get (e.g. if 10 elves die you only get archers)
- the player might have Delfador in this scenario. Balance accordingly
	- if $bm_turns==1, foreshadow Delfador's impending departure

[IN PROGRESS] S03: Blackwater Port (ForestDragon)
- 1-to-2-skull difficulty. Rewards: Cavalryman, Horseman, Peasant, Woodsman
- Asheviere's humans start in control of the port, but not the town. You need to defeat them to gain access to the port
	- if Kaylan dies, you can still win, but you won't get to recruit Horsemen/Cavalrymen
	- if Kaylan dies, set bm_kaylan_dead=yes, so I can modify the bigmap to reflect that
- lore: Sir Kaylan wanted Delfador to raise Konrad at the port among his own kind, but Delfador thought the Aethenwood was better: both more powerful and safer.
	- And on top of that, the port was too heavily militarized - no place to raise a child.
- the player might have Delfador in this scenario. Balance accordingly.
	- if $bm_turns==1, foreshadow Delfador's impending departure

S05: Bay of Pearls (Anekron)
- 1-to-2-skull difficulty. Rewards: Merfolk Brawler, Merfolk Fighter, Merfolk Hunter, Merfolk Initiate
- fight orcs and free merfolk.
- remember to include the sea orc event, and use the new image/portrait once that PR finishes
- no storm trident please. It's a really cool item, but this campaign is already complicated enough.
- the player might have Delfador in this scenario. Balance accordingly.
	- if $bm_turns==1, foreshadow Delfador's impending departure

S06: Isle of Alduin (ForestDragon)
- 1-skull difficulty. Rewards: Rogue Mage, Mage (Red advancement only)

S07: Muff Malal's Peninsula (unassigned)
- 1-skull difficulty. Rewards: companion Moremirmu

S08a: Isle of the Damned, part 1 (unassigned)
- 2-skull difficulty. Rewards: Thug, Footpad, Poacher
- we learn that Harper is trapped inside those catacombs where Morimerru used to be, setting up S08b (if the player chooses to go there)
- need a good lore reason for the undead. Presumably the bandits have been living there peacefully since liberty, so the undead must be new
	- maybe Harper awakened them from down in the catacombs, or maybe something else

S08b: Isle of the Damned, part 2 (unassigned)
- 2-skull difficulty. Rewards: companion Harper
- need an older portrait

S10 Elensefar (unassigned)
- 3-skull difficulty. Rewards: Thieves, Shop (sell veterans, invest (spend now/bonus next scenario), smuggle to Wesmere, smuggle to Gryphon Mountains, smuggle to Dwarven Doors)
	- disable smuggling if Li'sar's currently at the sceptre, as it's possible for Konrad to be trapped if he hasn't completed the right scenarios
- even after Elensefar, there should still be royal ships blocking travel up the river
- this is basically 3 different scenarios, depending on what phase we're in. "X" represents the bm_turn in which Li'sar attacks
	- if turn is less than X:
		- 4-skull difficulty
		- combat involves Delfador/Maddock inside and Konrad outside, with a huge human army in between. Also some orcs in the north
	- if turn is equal to X:
		- 5-skull difficulty
		- similar to 3-skull, but Li'sar is also attacking from the north
		- if you win here, you get the Elensefar achievement
	- if turn is greater than X:
		- 3-skull difficulty
		- Maddock has fled on ship. Most of Asheviere's army is pursuing him. This is an opportunity to retake the city, at least temporarily!
		- Orcs still in the north, or on your flank, or something.

//--------------------
// PHASE 1 (CENTRAL WESNOTH)
//--------------------
if no AToTB in HttT, Mirion suggests making Arvith/Baran non-Konrad-side characters in a battle somewhere as backstory
S12a AToTB, part 1 (Dalas) (may or may not do these, depending on other AToTB reworks)
- 1-skull difficulty. Rewards: companion Arvith
- Arvith is trying to get past a group of guards at the Fort Tahn ford and find his brother (i.e. AToTB S2)
- during this scenario, Arvith explains the events of the original AToTB's "Rooting Out A Mage."
- where Arvith expects to find his brother, we instead encounter and kill the necromancer brother Mordak (who says some foreshadowy / brotherly bond-y stuff). Arvith despairs of finding his brother again.

S12b AToTB, part 2 (Dalas) (may or may not do these, depending on other AToTB reworks)
- 2-skull difficulty. Rewards: companion Baran
- Konrad and Arvith approach Rotharik's castle (i.e. AToTB S3). After various hijinks, they defeat Rotharik, and find and rescue Baran inside the castle.
- Baran and Arvith are surprisingly unenthusiastic to reunite (i.e. AToTB S1), but they both agree to join Konrad in his quest.
- During the next few HttT scenarios, Arvith and Baran talk with each-other and with Konrad/Delfador. Or possibly we read some journal entries from them.
	- We learn why/how the brothers don't like each other (events at Toen Caric, perhaps part of Garard's war against the orcs). We hint about "The Snow Plains".

S15: Crossroads (unassigned)
- 2-skull difficulty. Rewards: companion Ulf, Dwarvish Miner(L0 unit, advances to Fighter/Guardsman)
- bigmap approach: Hello “cousin”, if you really are Konrad and not an imposter. I am Li’sar, princess of Wesnoth and my mother’s most able commander.
	- Your rebellion ends here. I will not allow you to sow any more chaos among my people — step forth and face me if you dare.
- the player's starting position is dependent on which direction Konrad approached the crossroads from on the overworld
- there were once many dwarves and men mining together here, but the mines are long-since abandoned
- Li'sar uses the mines to hide her troops and ambush Konrad.
- companion Ulf is gibbeted at the middle of the crossroads
	- lieutenant suggests Li'sar kill him so he can't join Konrad. Li'sar refuses to execute a prisoner in cold blood
	- when rescued, companion Ulf move to the unoccupied corner of the crossroads and sets up an encampment (his units also end up triggering many ambushes)
	- companion joins you if he lives to the end of the scenario.

S16: Gryphon Mountain
- 1-skull difficulty. Rewards: Gryphon Rider, Dwarvish Scout
- no rider-less gryphons please; I don't think the lore for that makes sense
- not sure how to justify Dwarvish Scouts being here, but we'll need to somehow.

S17a: Valley of Death, part 1 (unassigned)
- 2-skull difficulty. Rewards: Heavy Infantryman
- needs to make sense even if we did part 2 first
- we encounter some HI trying to fight through undead and get help. They say they're warrior monks, whose home is besieged by undead.
	 - HI names (including future recruits) should all start with "Brother"

S17b: Valley of Death, part 2 (unassigned)
- 3-skull difficulty. Rewards: Mage (White advancement only)
- Konrad reaches the monastery in a dense fog. The monks (a White Mage and some normal Mages) are overjoyed. Everyone gets ready to leave.
	- White Mage names (including future promotions) should start with "Brother"/"Sister"
- Monks think the fog is suspicious. They cast a spell to illuminate the map, revealing the 3 liches from the original Valley of Death.
- overworld: ensure we can leave the area after completing part 2, even if we didn't do part 1 beforehand

S18 Dan'tonk (unassigned)
- 4-skull (3-skull to escape, 5-skull to conquer) difficulty. Rewards: Spearman, Bowman, Fencer
- similar to "The Human Army" from SotBE
- there's a stockpile of spears, bows, and swords in the city. To get the respective recruits, you need to send multiple units to grab equipment, and then escape with it all.
- if you're really an overachiever (or more likely, cheating), you can beat this scenario and rush straight to Asheviere without Li'sar/Sceptre/etc.
	- this is obviously non-canon, and we should include a message about that. We should also warn that this branch isn't well-tested, and plot elements may not make sense.

S20 The Ford of Abez (unassigned)
- 2-skull difficulty. Rewards: none
- on the bigmap, orcs give you an opportunity to pay and get let through without combat (and without taking any time). If you refuse, you have to fight the orcs.
	- they charge this fee EVERY TIME you want to cross the ford
	Crossin' into Blackcrest land? That'll be 100 gold for passage, whelp.
- if Li'sar tries to cross here:
	Crossin' into Blackcrest land? That'll be 100 gold for passage, whelp.
	Clan Blackcrest is an ally of the crown. Let me by or face the consequences.
	Tha's right, miss princess. And bein' our allies, I'm sure you wouldn't mind donatin' them 100 gold pieces, har har har.
	I don't think so. Infantry, form up! Prepare for battle!
- this scenario needs 3 versions:
	- by default, Konrad fights the orcs
	- if Li'sar's there too, she fights against both sides
	- if the orcs were defeated beforehand, it's just Li'sar vs Konrad


//--------------------
// PHASE 2 (SEEKING THE SCEPTRE)
//--------------------
S22 Outskirts of Glamdrol (unassigned)
- TBD difficulty, Rewards: varies
	- if you side with dwarves: Dwarvish Ulfserker, Dwarvish Thunderer
	- if you side with orcs:    Shop (sell veterans, hire single-scenario orcish mercenaries, purchase orcish catapults) (ensure you can't sell catapults)
- battle involves fighting against orcish catapults (units with a true ranged attack)
- orcs vs dwarves. You choose which side to ally with. Include some ambiguity; Dwarves shouldn't be the obviously "correct" side.
	- perhaps orcs paid dwarves to build catapults. Dwarves claim they didn't get paid; orcs claim they did
	- if the player recruits/recalls dwarves but fights against dwarves, we need some special voicelines related to this. Maybe "Surghan mercenaries", calling back to Sceptre of Fire

S23 Northern Winter (unassigned)
- TBD difficulty, Rewards: companion Runesmith
- runesmith was frozen in the ice for ages; that's why he survived while all others perished
- need to rename this, since it may not actually be winter. But keep the "terrain turns to snow" mechanic, and add to it
- fight against wild animals who've been driven to starvation/madness from the cold
	- while also dealing with harmful environmental effects

S24a something wesmere, part 1 (unassigned)
- TBD difficulty. Rewards: companion Kalenz
- needs to make sense even if we did part 2 first

S24b something wesmere, part 2 (unassigned)
- TBD difficulty. Rewards: Elvish Shamans
- overworld: ensure we can leave the area after completing part 2, even if we didn't do part 1 beforehand

S26 The Dwarven Doors (unassigned)
- TBD difficulty, Rewards: feel good about yourself at night
- free as many slaves as you can, and evacuate them into the underground
	- make a point of saying that this may not be as useful militarily as other scenarios would be, but it's the morally right thing to do
	- include some kind of bonus and/or callback to this near the end of the game. Maybe you get a "good ending", or someting like that
- this scenario needs 3 versions:
	- by default, Konrad fights the orcs
	- if Li'sar's there too, she fights against both sides
	- if the orcs were defeated beforehand, it's just Li'sar vs Konrad

S28 The Lost General (unassigned)
- TBD difficulty, Rewards: Naga Fighter, Troll Whelp (can advance to Troll Shaman)
- troll shamans create fire. Undead lionel is seeking the sceptre of fire.

S29 Knalga (unassigned)
- TBD difficulty. Rewards: Dwarvish Fighter, Dwarvish Guardsman, Shop (sell veterans, upgrade weapons, upgrade armor) (upgrades make all your recruits/recalls better, but also more expensive)
- involves using miners to mine through walls. Find a way to stop this from being a huge XP farm
- try to keep lore consistent with NR please

S30 The Sceptre of Fire (Dalas)
- 4-skull difficulty. Rewards: the sceptre of fire
- if player arrives early, tell them that this gives them a head start over Li'sar, but she'll still get here while we're searching for the sceptre
	- also make it clear that you can't go back after this


//--------------------
// PHASE 2.5 (JOINING LI'SAR)
//--------------------


//--------------------
// PHASE 3 (OVERTHROWING ASHEVIERE)
//--------------------
characters we meet should make a big deal out of the sceptre
	to justify everyone taking time off of a civil war to go find it


//############################
// LI'SAR'S MOVEMENT
//############################
//--------------------
// BEFORE ELENSEFAR
//--------------------
before turn X...
	check these things every prestart and every `name=enter hex` event
- if Konrad is near Dan'Tonk, Li'sar is at Dan'Tonk.
	- the first time this happens, she explains her ambush
- else if Crossroads is incomplete, Li'sar is at Crossroads
- else if Dan'Tonk is not fully conquered, Li'sar is at Dan'Tonk
- else Li'sar is at Weldyn

//--------------------
// ELENSEFAR
//--------------------
----If Konrad Ignores Elensefar:
- on turn X, Li'sar receives permission from Asheviere to attack Elensefar, and heads there with a fleet of ships
	- make sure this plays nice with other prestart Li'sar cutscenes. E.g. she's just been defeated at Crossroads
	- crossroads becomes failed; Konrad can move freely though it
	- Li'sar no longer moves to Dan'Tonk; instead it's a generic general
- on turn X+1, Delfador reunites with Konrad
	- Li'sar is now at Elensefar
	- storytext explain that Elensefar fell and Maddock fled. Burning, boats, etc.
	- "what do we do now?" "With Maddock fled we cannot win through force of arms, but we can go for the sceptre"
	- Li'sar's lieutenant is listening. Li'sar finds out, and resolves to beat Konrad to the sceptre. She vanishes into the fog
	- show objectives

----If Konrad Rescues Elensefar:
TODO - also explain what happens if Konrad attacks ON turn X
- before turn X, Konrad attacks and completes Elensefar
storytext

//--------------------
// AFTER ELENSEFAR
//--------------------
- on turn X+2, Li'sar goes to the Ford
	- dialogue should be a reminder that Li'sar is searching for the sceptre
	- Konrad is allowed to fight her here, as 5-skull difficulty. If we actually defeat her, she retreats to regroup and vanishes from the bigmap for 1 turn
		- Konrad may come from the north or south shore here
		- no turn limit; no early finish; 40% gold carryover. Have Li'sar retreat when she's clearly lost, so she can't be farmed
		- Li'sar has naval support here. Whatever that means
	- reminder that Elensefar may or may not be retaken by Konrad at this point
	- INCOMPLETE: she tries to cross, but the orcs demand payment. She's not impressed, and they fight
	- COMPLETE: she comments that Konrad has already come this way
	- IN PROGRESS: Li'sar attacks Konrad. We get an choice on the bigmap to either fight or flee.
- on turn X+3, Li'sar goes to Dwarven Doors
	- dialogue should be a reminder that Li'sar is searching for the sceptre
	- Konrad is allowed to fight her here, as 5-skull difficulty. If we actually defeat her, she retreats to regroup and vanishes from the bigmap for 1 turn
		- Konrad may come from the north or south entrance here
		- no turn limit; no early finish; 40% gold carryover. Have Li'sar retreat when she's clearly lost, so she can't be farmed
		- maybe do something interesting with the slaves here?
	- INCOMPLETE: Li'sar and the orcs interact. The orcs would let her through, but she demands they free their slaves and they end up fighting.
	- COMPLETE: The orcs are already beaten. Li'sar frees a few of their slaves, and passes through
	- IN PROGRESS: Li'sar attacks Konrad. We get an choice on the bigmap to either fight or flee.
- on turn X+4, Li'sar arrives at the sceptre
	- overwrite the scenario preview for everything except Sceptre of Fire, to prevent Konrad from playing any other scenario
	- ensure Konrad doesn't get softlocked. How do we achieve this?

----TODO:
- make sure positive elements of Li'sar's personality come through beforehand
	- perhaps we somehow force the player to fight Li'sar at least once? Maybe she's at both Crossroads (guarding) and Elensefar (taking command of the victorious city)
- ensure the bigmap adjusts in such a way that it's impossible to get stuck/softlocked when Li'sar reaches the sceptre
	- Li'sar is guaranteed to conquer Ford of Abez,  at which point the scenario counts as failed (and Konrad can move through) 
	- Li'sar is guaranteed to conquer Dwarven Doors, at which point the scenario counts as failed (and Konrad can move through)
	- including if the player uses Elensefar's smuggling
		- disable smuggling while Li'sar is at the sceptre, but Konrad can still smuggle just fine 1 turn before
		- make sure that if we complete the two smuggling part 2s, that there's an exit (both valley of death and wesmere)


```
