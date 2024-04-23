






<br>
<br>Hello! This is a WIP HttT revision for Battle for Wesnoth. If you're interested in collaborating, please reach out to Dalas via the Wesnoth discord or forum.
<br>
<br>
<br>//############################
<br>// CONTRIBUTORS - READ THIS FIRST
<br>//############################
<br>focus on writing scenarios on phase 1. That's the core of what were doing here
<br>we dont' need to go over 
<br>between both me and Yumi, a lot of your stuff will be overwritten
<br>not hard and fast rules, but we should try and stay kinda consistent since this is all part of the same campaign
<br>some scenarios have more info, some have less. These are just my thoughts not a must-have
<br>pick a scenario, then draft a script/outline for the scenario and post it
<br>these are guidelines, not required
<br>
<br>
<br>//###############################################################################################################################################################################
<br>// DESIGN OVERVIEW
<br>//###############################################################################################################################################################################
<br>//############################
<br>// THE OVERWORLD
<br>//############################
<br>- after each scenario the player gets sent to the "overworld", an in-game map of the great continent
<br>- the player chooses their next scenario via the overworld. Only some scenarios are available at a time, depending on the current "phase"
<br>- after playing a certain number of scenarios (varies by difficulty), the player is forcibly advanced to the next phase
<br>- each scenario has a preview, including:
<br> - difficulty (1 skull, 2 skulls, etc)
<br> - reward: gold carryover (no/low/high)
<br> - reward: new recruits
<br> - reward: loyal companions
<br> - reward: other
<br>- after playing each scenario, the season of the year changes. Spring, Summer, Fall, Winter. Summer/Winter seasons result in battle scenarios with longer/shorter daytime.
<br>
<br>//--------------------
<br>// REWARDS
<br>//--------------------
<br>- Konrad starts with 0 recruits. In Phase 1 and Phase 2, he builds up his recruit list depending on which scenarios he chooses to play.
<br>- many Phase 1 and Phase 2 scenarios also give loyal companions as rewards, who're auto-recalled in each scenario and have custom dialogue.
<br>- Phase 3 scenarios focus on hindering Asheviere. For example, completing "Test of the Clans" might get rid of Asheviere's cavalry in the final comfrontation.
<br>- rewards can be given at the beginning of the scenario, at the end, in the overworld, or anywhere in between
<br>
<br>
<br>//############################
<br>// NARRATIVE DESIGN
<br>//############################
<br>//--------------------
<br>// PLOT
<br>//--------------------
<br>Phase 1
<br>- Konrad and Delfador are driven from the Aethenwood by Asheviere's human armies
<br>- Konrad and Delfador complete 1 scenario together
<br>- Delfador leaves to help in the defense of Elensefar
<br>- player plays 2-4 more phase 1 scenarios (varies by difficulty)
<br>- Elensefar falls. Delfador returns, and exhorts Konrad to flee north, either via the Ford of Abez or via Elensefar
<br>
<br>Phase 2
<br>- Li'sar follows Konrad north across the great river. Both race to get the sceptre
<br>- Li'sar's actions show she's a decent person, unlike her mother. We get some insight into her relationship with Asheviere.
<br>- player plays 2-3 more phase 2 scenarios (varies by difficulty)
<br>- Li'sar gets close to the sceptre. Konrad chases after her.
<br>
<br>Phase 2.5
<br>- Konrad gets the sceptre first. Delfador collapses the cave behind them, (presumably) killing Li'sar
<br>- surprise, Li'sar's back. Her army is much weaker
<br>- Konrad has a change of heart, and refuses to fight Li'sar. He joins her / is taken prisoner / something like that
<br>- Delfador worries Konrad will be executed once Li'sar reaches Weldyn. Delfador goes off to fight Asheviere by himself
<br>- Li'sar and Konrad fight Asheviere's ally Iliah'al (details TBD after AoA releases). They bond.
<br>
<br>Phase 3
<br>- we learn that Delfador has been captured by Asheviere, and will be executed in X months (not immediately, because Asheviere is trying to lure Konrad)
<br>- player plays 2-3 more phase 3 scenarios (varies by difficulty)
<br>- Konrad and Li'sar confront Asheviere at Weldyn. Delfador is rescued; Asheviere dies/flees/etc. Hooray!
<br>
<br>//--------------------
<br>// CHARACTERS
<br>//--------------------
<br>Konrad (phase 1)
<br>- sees the good right in front of him (contrast this with Delfador)
<br>- calls people "Mister", "Ma'am", "Miss". Does NOT call Delfador "Master", since this sounds too similar to TDG
<br>- humans are foreign and weird. He understands elves, not humans.
<br>- naive but good-hearted. Might get tricked or taken advantage of
<br>
<br>Delfador
<br>- for the greater good; i.e. needs of the many/few (contrast this with Konrad)
<br>- calls Konrad "young prince", "master Konrad", etc. Or just "Konrad"
<br>
<br>Li'sar
<br>- stoic, proud, relentless.
<br>- prefers tricks, ambushes, and "clever" tactics, but doesn't shy away from a straight-up fight
<br>- calls Asheviere "mother", like Eldred did. But their relationship is quite distant
<br>
<br>
<br>//############################
<br>// SCENARIO DESIGN
<br>//############################
<br>//--------------------
<br>// GLOBAL INCLUDES
<br>//--------------------
<br>- to make it easy to tweak Konrad, please define side 1 with `{KONRAD_SIDE {ON_DIFFICULTY4 100 80 65 50}`. `FOG=yes` and `SHROUD=yes` optional
<br>- to ensure your scenario's ToD reflects the overworld, use `{SCHEDULE_DYNAMIC $current_time}`
<br>- to ensure all companions get recalled properly, please use `{RECALL_KONRAD_AND_COMPANIONS $x $y}`
<br> - companions need custom dialogue in many scenarios, to help them feel alive!
<br> - right now Moremirmu and an unnamed Ulf are planned to be options in Phase 1, and Kalenz is planned to be an option in Phase 2. There will probably be more.
<br>
<br>//--------------------
<br>// DIFFICULTY
<br>//--------------------
<br>Easy should be nigh-unloseable. Nightmare should be seriously difficult even for you or me.
<br>
<br>These are my recommended difficulty modifiers. You don't need to use this if you don't want to (or if it doesn't make sense for the scenario), but please ensure the difficulty scales similarly so all scenarios stay in balance.
<br>- Easy:      1.0x enemy/ally strength, 100% starting gold (ignoring carryover)
<br>- Normal:    1.5x enemy/ally strength,  80% starting gold (ignoring carryover)
<br>- Hard:      2.0x enemy/ally strength,  65% starting gold (ignoring carryover)
<br>- Nightmare: 2.5x enemy/ally strength,  50% starting gold (ignoring carryover)
<br>- Additionally, on higher difficulties the player gets less time in each phase before being pushed on to the next one, which reduces your rewards/XP.
<br>
<br>//--------------------
<br>// XP FEEDING
<br>//--------------------
<br>Leveling units is fun! I want players to be able to continue to level units throughout the campaign, instead of maxing-out their army halfway through. With this in mind, please try to restrict available XP.
<br>- small player armies; 50-100 gold (plus carryover) on Nightmare is a good guideline for the average scenario
<br>- use lower-level enemies where possible. 1 Warlord is easy to farm for XP; 3 Grunts are much harder; 6 Goblins even more so.
<br>- enemies should retreat and regroup where appropriate, instead of trickling. See EI's Xenophobia for an example.
<br>- end scenarios sooner rather than later. If there's no threat after the first 10 turns, don't ask the player to survive for 20.
<br>
<br>//--------------------
<br>// AI DESIGN
<br>//--------------------
<br>- where applicable, reminder to have a weak AI retreat and regroup instead of trickling. See EI's Xenophobia for an example.
<br>- where applicable, AI should be less aggressive at unfavorable ToD (regardless of the player's favorable ToD). See EI's Xenophobia for an example.
<br>- where applicable, if an AI side is defending, please use proper defensive AI with `[avoid]` and similar. See TDG's "Ring of Swords" for an example.
<br>- if you have AI allies, I suggest scaling their gold so they always feel useful. For example, if my ally is 1/2 as strong as the enemy on Easy, they could be 1/2 as strong on Nightmare too.
<br>
<br>//--------------------
<br>// TEAMS AND COLORS
<br>//--------------------
<br>(not mandatory, but let's try to stay more-or-less consistent please)
<br>Konrad: red
<br>Asheviere/Li'sar: purple
<br>Li'sar (after joining Konrad): wesred
<br>Elves: brightgreen
<br>Dwarves: brown
<br>Blackcrests: black (these guys use lots of shamans)
<br>Whitefangs: white (these guys use lots of goblins and goblin riders)
<br>Undead: white
<br>Drakes: orange
<br>
<br>//--------------------
<br>// OTHER
<br>//--------------------
<br>- if your scenario has a time limit, please include at least a basic "time over" cutscene as well as "we're running out of time" dialogue some turns beforehand
<br> - instead of using `name=time over`, trigger this event on `side 1 turn {SCENARIO_TURN_LIMIT} end`, so that we don't waste the player's time when they've already lost
<br>- please include an achievement in every scenario! Could be a difficult challenge, a hint towards some content the player might miss, or anything else.
<br>
<br>
<br>//###############################################################################################################################################################################
<br>// TASKLIST
<br>//###############################################################################################################################################################################
<br>//############################
<br>// OTHER
<br>//############################
<br>Konrad Artwork (Mechanical)
<br>
<br>//############################
<br>// SCENARIOS TO WRITE
<br>//############################
<br>//--------------------
<br>// OVERWORLD AND INTRO
<br>//--------------------
<br>S00: The Great Continent (Dalas)
<br>S01: The Elves Besieged (Dalas)
<br>
<br>//--------------------
<br>// PHASE 1 (WESTERN WESNOTH)
<br>//--------------------
<br>S02: Elven Exodus (unassigned)
<br>- 1-or-2-skull difficulty. Rewards: Elvish Archer, Elvish Fighter, Elvish Scout
<br>- elves are fleeing from the top right while humans man the flanks. Similar to the first scenario of Dirty Blood
<br> - Ethiliel/Ithelden may or may not still be alive ($ethiliel_alive/$ithelden_alive), depending on the player's performance in the intro scenario
<br>- the more elves who die, the fewer recruits you get (e.g. if 10 elves die you only get archers)
<br>- the player might have Delfador in this scenario. Balance accordingly
<br>
<br>S03: Blackwater Port (ForestDragon)
<br>- 1-or-2-skull difficulty. Rewards: Cavalryman, Horseman, Peasant, Woodsman
<br>- the player might have Delfador in this scenario. Balance accordingly.
<br>- Asheviere's humans start in control of the port, but not the town. You need to defeat them to gain access to the port
<br> - if Kaylan dies, you can still win, but you won't get to recruit Horsemen/Cavalrymen
<br> - if Kaylan dies, set bm_kaylan_dead=yes, so I can modify the bigmap to reflect that
<br>- lore: Sir Kaylan wanted Delfador to raise Konrad at the port among his own kind, but Delfador thought the Aethenwood was better: both more powerful and safer.
<br> - And on top of that, the port was too heavily militarized - no place to raise a child.
<br>
<br>S05: Bay of Pearls (unassigned)
<br>- 1-or-2-skull difficulty. Rewards: Merfolk Brawler, Merfolk Fighter, Merfolk Hunter, Merfolk Initiate
<br>- fight orcs and free merfolk.
<br>- remember to include the sea orc event, and use the new image/portrait once that PR finishes
<br>- no storm trident please. It's a really cool item, but this campaign is already complicated enough.
<br>- the player might have Delfador in this scenario. Balance accordingly.
<br>
<br>S06: Isle of Alduin (unassigned)
<br>- 1-to-3-skull difficulty. Rewards: Rogue Mage, Mage (Red advancement only)
<br>
<br>S07: Muff Malal's Peninsula (unassigned)
<br>- 1-to-3-skull difficulty. Rewards: Moremirmu
<br>
<br>S08: Isle of the Damned (unassigned)
<br>- 1-to-3-skull difficulty. Rewards: Thug, Footpad, Poacher
<br> - possibly a companion as an alternative reward? Something riffing off of TRoW's Vampire Lady?
<br>
<br>S10 Fort Tahn (unassigned)
<br>- TBD difficulty. Rewards: TBD
<br>- Selli? Oren? HI? Fencers? Shop? Let's wait until after TSG/AoA releases and then decide what to do here
<br>
<br>S12: Crossroads (unassigned)
<br>- 2-to-3-skull difficulty. Rewards: companion Ulf, Dwarvish Miner(L0 unit, advances to Fighter/Guardsman/Ulf)
<br>- Li'sar is the enemy here. She has a bunch of dwarvish miner prisoners digging holes in the mountainside where her forces can hide and ambush Konrad
<br> - Li'sar treats the dwarves pretty well. Once they're done digging, she releases them as a fair reward.
<br> - Except the dwarves are angry, and move to the unoccupied part of the crossroads, set up a keep, and start attacking her (which also triggers a bunch of her ambushes)
<br> - or something like that; I'm just making stuff up here
<br>- companion Ulf is gibbeted at the middle of the crossroads. When you reach him, he joins you. Perhaps he was a particularly angry miner who's being punished. With some interesting backstory
<br>- the player's starting position is dependent on which direction Konrad approached the crossroads from on the overworld
<br>
<br>S13: Gryphon Mountain
<br>- 1-to-2-skull difficulty. Rewards: Gryphon Rider, maybe other stuff too?
<br>- we either need to justify gryphon riders being dwarvish (maybe theres dwarves here, and you can also gain scouts as a recruit?), or make them human-ridden
<br>- no rider-less gryphons please; I don't think that makes sense lore-wise
<br>
<br>S14: Valley of Death (unassigned)
<br>- 3-to-4-skull difficulty. Rewards: Mage (White advancement only)
<br>- bit weird to have random liches running around the middle of Wesnoth. Let's try to figure out a good lore reason for this that ties them into other things (or at least tells us something about Asheviere's character)
<br>
<br>S15 Dan'tonk (unassigned)
<br>- 5-skull difficulty. Rewards: TBD
<br>- similar to "The Human Army" from SotBE
<br>
<br>S17 Elensefar (unassigned)
<br>- 3-to-4-skull difficulty
<br>- completing this scenario ends Phase 1
<br>- change konrad to use human portrait
<br>
<br>S18 The Ford of Abez (unassigned)
<br>- 2-to-3-skull difficulty
<br>- completing this scenario ends Phase 1
<br>- change konrad to use human portrait
<br>
<br>
<br>//--------------------
<br>// PHASE 2 (SEEKING THE SCEPTRE)
<br>//--------------------
<br>
<br>//--------------------
<br>// PHASE 2.5 (JOINING LI'SAR)
<br>//--------------------
<br>how do we handle attacking the 
<br>
<br>//--------------------
<br>// PHASE 3 (OVERTHROWING ASHEVIERE)
<br>//--------------------
<br>
<br>
<br>
<br>
