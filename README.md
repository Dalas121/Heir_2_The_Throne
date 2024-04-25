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
- calls people "Mister", "Ma'am", "Miss". Does NOT call Delfador "Master", since this sounds too similar to TDG
- humans are foreign and weird. He understands elves, not humans.
- naive but good-hearted. Might get tricked or taken advantage of

Delfador
- for the greater good; i.e. needs of the many/few (contrast this with Konrad)
- calls Konrad "young prince", "master Konrad", etc. Or just "Konrad"

Li'sar
- stoic, proud, relentless.
- prefers tricks, ambushes, and "clever" tactics, but doesn't shy away from a straight-up fight
- calls Asheviere "mother", like Eldred did. But their relationship is quite distant


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
	- right now Moremirmu and an unnamed Ulf are planned to be options in Phase 1, and Kalenz is planned to be an option in Phase 2. There will be more, especially in Phase 1.

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
- where applicable, reminder to have a weak AI retreat and regroup instead of trickling. See EI's Xenophobia for an example.
- where applicable, AI should be less aggressive at unfavorable ToD (regardless of the player's favorable ToD). See EI's Xenophobia for an example.
- where applicable, if an AI side is defending, please use proper defensive AI with `[avoid]` and similar. See TDG's "Ring of Swords" for an example.
- if you have AI allies, I suggest scaling their gold so they always feel useful. For example, if my ally is 1/2 as strong as the enemy on Easy, they could be 1/2 as strong on Nightmare too.

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
Konrad Artwork (Mechanical)

//############################
// SCENARIOS TO WRITE
//############################
(Occasional gaps in scenario numbers are deliberate. That way if we need to add a new scenario sometime we don't have to renumber everything.)

//--------------------
// OVERWORLD AND INTRO
//--------------------
S00: The Great Continent (Dalas)
S01: The Elves Besieged (Dalas)

//--------------------
// PHASE 1 (WESTERN WESNOTH)
//--------------------
----Western Scenarios:
S02: Elven Exodus (unassigned)
- 1-to-2-skull difficulty. Rewards: Elvish Archer, Elvish Fighter, Elvish Scout
- elves are fleeing from the top right while humans man the flanks. Similar to the first scenario of Dirty Blood
	- Ethiliel/Ithelden may or may not still be alive ($ethiliel_alive/$ithelden_alive), depending on the player's performance in the intro scenario
- the more elves who die, the fewer recruits you get (e.g. if 10 elves die you only get archers)
- the player might have Delfador in this scenario. Balance accordingly
	- if $bm_turns==1, foreshadow Delfador's impending departure

S03: Blackwater Port (ForestDragon)
- 1-to-2-skull difficulty. Rewards: Cavalryman, Horseman, Peasant, Woodsman
- Asheviere's humans start in control of the port, but not the town. You need to defeat them to gain access to the port
	- if Kaylan dies, you can still win, but you won't get to recruit Horsemen/Cavalrymen
	- if Kaylan dies, set bm_kaylan_dead=yes, so I can modify the bigmap to reflect that
- lore: Sir Kaylan wanted Delfador to raise Konrad at the port among his own kind, but Delfador thought the Aethenwood was better: both more powerful and safer.
	- And on top of that, the port was too heavily militarized - no place to raise a child.
- the player might have Delfador in this scenario. Balance accordingly.
	- if $bm_turns==1, foreshadow Delfador's impending departure

S05: Bay of Pearls (Ankeron)
- 1-to-2-skull difficulty. Rewards: Merfolk Brawler, Merfolk Fighter, Merfolk Hunter, Merfolk Initiate
- fight orcs and free merfolk.
- remember to include the sea orc event, and use the new image/portrait once that PR finishes
- no storm trident please. It's a really cool item, but this campaign is already complicated enough.
- the player might have Delfador in this scenario. Balance accordingly.
	- if $bm_turns==1, foreshadow Delfador's impending departure

S06: Isle of Alduin (unassigned)
- 1-to-3-skull difficulty. Rewards: Rogue Mage, Mage (Red advancement only)

S07: Muff Malal's Peninsula (unassigned)
- 1-to-3-skull difficulty. Rewards: Moremirmu

S08: Isle of the Damned (unassigned)
- 1-to-3-skull difficulty. Rewards: Thug, Footpad, Poacher
	- possibly a companion as an alternative reward? Something riffing off of TRoW's Vampire Lady?

S10 Elensefar (unassigned)
- 3-to-4-skull difficulty
- Rewards: Thieves, Shop
- completing this scenario ends Phase 1
- change konrad to use human portrait


----Eastern Scenarios:
S11 AToTB part 1
- 1-to-3-skull difficulty. Rewards: Arvith
- Arvith is trying to get past a group of guards at the Fort Tahn ford and find his brother (i.e. AToTB S2)
- during this scenario, Arvith explains the events of the original AToTB's "Rooting Out A Mage."
- where Arvith expects to find his brother, we instead encounter and kill the necromancer brother Mordak (who says some foreshadowy / brotherly bond-y stuff). Arvith despairs of finding his brother again.

S12 AToTB part 2
- 1-to-3-skull difficulty. Rewards: Baran
- Konrad and Arvith approach Rotharik's castle (i.e. AToTB S3). After various hijinks, they defeat Rotharik, and find and rescue Baran inside the castle.
- Baran and Arvith are surprisingly unenthusiastic to reunite (i.e. AToTB S1), but they both agree to join Konrad in his quest.
- During the next few HttT scenarios, Arvith and Baran talk with each-other and with Konrad/Delfador. Or possibly we read some journal entries from them.
	- We learn why/how the brothers don't like each other (events at Toen Caric, perhaps part of Garard's war against the orcs). We hint about "The Snow Plains".

S15: Crossroads (unassigned)
- 2-to-3-skull difficulty. Rewards: companion Ulf, Dwarvish Miner(L0 unit, advances to Fighter/Guardsman/Ulf)
- Li'sar is the enemy here. She has a bunch of dwarvish miner prisoners digging holes in the mountainside where her forces can hide and ambush Konrad
	- Li'sar treats the dwarves pretty well. Once they're done digging, she releases them as a fair reward.
	- Except the dwarves are angry, and move to the unoccupied part of the crossroads, set up a keep, and start attacking her (which also triggers a bunch of her ambushes)
	- or something like that; I'm just making stuff up here
- companion Ulf is gibbeted at the middle of the crossroads. When you reach him, he joins you. Perhaps he was a particularly angry miner who's being punished. With some interesting backstory
- the player's starting position is dependent on which direction Konrad approached the crossroads from on the overworld

S16: Gryphon Mountain
- 1-to-2-skull difficulty. Rewards: Gryphon Rider, maybe other stuff too?
- we either need to justify gryphon riders being dwarvish (maybe theres dwarves here, and you can also gain scouts as a recruit?), or make them human-ridden
- no rider-less gryphons please; I don't think that makes sense lore-wise

S17: Valley of Death (unassigned)
- 3-to-4-skull difficulty. Rewards: Mage (White advancement only)
- bit weird to have random liches running around the middle of Wesnoth. Let's try to figure out a good lore reason for this that ties them into other things (or at least tells us something about Asheviere's character)

S18 Dan'tonk (unassigned)
- 5-skull difficulty. Rewards: TBD
- similar to "The Human Army" from SotBE. Fighting Li'sar
- if you're really an overachiever (or more likely, cheating), you can beat this scenario and rush straight to Asheviere without Li'sar/Sceptre/etc.
	- this is obviously non-canon, and we should include a message about that

S20 The Ford of Abez (unassigned)
- 2-to-3-skull difficulty
- fighting Li'sar
- completing this scenario ends Phase 1
- change konrad to use human portrait

//--------------------
// PHASE 2 (SEEKING THE SCEPTRE)
//--------------------
Planned available rewards:
- Elvish Shaman
- Kalenz
- 2 scenarios that give dwarves
- Orcs? Trolls? Naga?

//--------------------
// PHASE 2.5 (JOINING LI'SAR)
//--------------------

//--------------------
// PHASE 3 (OVERTHROWING ASHEVIERE)
//--------------------




```
