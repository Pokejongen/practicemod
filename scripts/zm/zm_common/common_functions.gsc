#using scripts\codescripts\struct;

#using scripts\shared\system_shared;
#using scripts\shared\_burnplayer;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\ai_shared;
#using scripts\shared\vehicle_shared;
#using scripts\shared\vehicle_ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\math_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\util_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\aat_shared;

#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai\systems\gib;

#using scripts\zm\_zm;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_blockers;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_pack_a_punch_util;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_power;
#using scripts\zm\_zm_magicbox;
#using scripts\zm\_zm_weapons;
#using scripts\zm\_zm_hero_weapon;
#using scripts\zm\_zm_placeable_mine;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_zonemgr;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_magicbox;
#namespace common_functions;

function main(){

    

}

function check_for_map_change(current_map){

    if(current_map == getDvarString("last_map")){

        return;

    }

    setDvar("last_map", level.script);
    setDvar("patch", "");

}

function ms_to_str(ms)
{
    min = 0;
    sec = 0;
    if(ms >= 60000)
    {
        min = Int(ms / 60000);
        ms -= min * 60000;
    }
    if(ms >= 1000)
    {
        sec = Int(ms / 1000);
        ms -= sec * 1000;
    }
    time = "";
    if(min > 0)
    {
        time += min + ":";
    }
    if(min || sec > 0)
    {
        if(sec < 10 && min) time += "0";
        time += sec + ".";
    }
    if(min || sec || ms > 0)
    {
        if(!min && !sec) time += "0.";
        if(ms <= 50) time += "0";
        ms /= 10;
        time += ms;
    }
    return time;
}

// COMMON FUNCTIONS FROM SCRAPPYS PRACTICE TOOL

function WriteToScreen(text)
{
    if(!IsDefined(level.messages_prompt)) level.messages_prompt = [];
    message = hud::createfontstring("big", 1.1);
    if(level.messages_prompt.size >= level.MAX_MESSAGES)
    {
        level.messages_prompt[0] Destroy();
        ArrayRemoveIndex(level.messages_prompt, 0, 0);
    }
    level.messages_prompt[level.messages_prompt.size] = message;
    index = 0;
    for(i = level.messages_prompt.size; i > 0; i--)
    {
        level.messages_prompt[i-1] hud::setpoint("BOTTOM LEFT", "BOTTOM LEFT", 20, (-130 - (15 * index)));
        index++;
    }
    if(IsDefined(message))
    {
        message SetText(text);
        message.alpha = 1;
    }
    wait 2.5;
    if(IsDefined(message))
    {
        message FadeOverTime(2);
        message.alpha = 0;
    }
    wait 2;
    if(IsDefined(message))
    {
        message Destroy();
        ArrayRemoveValue(level.messages_prompt, message, 0);
    }
}

// ROUNDS

function EndRound(text = 1)
{
    if(level flag::get("round_skip_request"))
    {
        thread WriteToScreen("Round Request Already Queued");
        return;
    }
    level flag::set("round_skip_request");
    while(!level.zombie_total && !zombie_utility::get_round_enemy_Array().size) wait 0.05;
    level.zombie_total = 0;
	zombie_utility::ai_calculate_health(level.round_number + 1);
	level notify("kill_round");
	PlaySoundAtPosition("zmb_bgb_round_robbin", (0, 0, 0));
    if(text) thread WriteToScreen("Ending Current Round");
    level endon("end_of_round");
    thread WaitRound();
    for(;;)
    {
        foreach(zombie in GetAITeamArray(level.zombie_team))
        {
            zombie Kill();
        }
        wait 1;
    }
}


function SkipToRound(round = 0, zombies_left = -1, delay = 0)
{
    if(level flag::get("round_skip_request"))
    {
        thread WriteToScreen("Round Request Already Queued");
        return;
    }
    if(!round) round = level.round_number;
    if(delay) wait delay;
    thread WriteToScreen("Changing To Round " + round);
	zm::set_round_number(round - 1);
    EndRound(0);
    level.zombie_move_speed = round * level.zombie_vars["zombie_move_speed_multiplier"];
    if(zombies_left >= 0)
    {
        level waittill("zombie_total_set");
        level.zombie_total = zombies_left;
    }
}

// STORM QUEST - DER EISENDRACHE

function DoStormStep(num)
{
    switch(num)
    {
        case 0:
            self thread ActivateStormQuest();
            break;
        case 1:
            self thread StormShootBonfires();
            break;
        case 2:
            self thread StormWallrun();
            break;
        case 3:
            self thread StormFillUrns();
            break;
        case 4:
            self thread StormTriggerArrow();
            break;
        case 5:
            self thread StormBuildBow();
            break;
        case 6:
            self thread FinishStorm();
            break;
        default:
            break;
    }
}

function FinishStorm()
{
    self thread ActivateStormQuest();
    self thread StormShootBonfires();
    self thread StormWallrun();
    self thread StormFillUrns();
    self thread StormTriggerArrow();
    self thread StormBuildBow();
}

function ActivateStormQuest()
{
    if(CheckQuestProgress("storm") >= 1) return;
    if(!IsDefined(struct::get("quest_start_elemental_storm").var_67b5dd94))
    {
        weather_damage = 0;
        while(!weather_damage)
        {
            weather_trig = GetEnt("aq_es_weather_vane_trig", "targetname");
            if(!IsDefined(weather_trig))
            {
                wait 0.05;
                continue;
            }
            weather_damage = 1;
            weather_trig notify("damage", 1, self, (-0.55191, 0.294189, -13.1041), (-183.448, 1878.71, 1270.1), "MOD_EXPLOSIVE", "", "", "", GetWeapon("elemental_bow"));
            wait 0.05;
        }

        level waittill(#"hash_4e123b5d");
        wait 1;
    }

    arrow = struct::get("quest_start_elemental_storm");
    self BuildAndActivateTrigger(arrow.var_67b5dd94);
}

function StormShootBonfires()
{
    if(CheckQuestProgress("storm") >= 2) return;
    while(CheckQuestProgress("storm") < 1) wait 0.05;
    
    bonfires = GetEntArray("aq_es_beacon_trig", "script_noteworthy");
    foreach(bonfire in bonfires)
    {
        s_beacon = struct::get(bonfire.target);
        if(!IsDefined(s_beacon.var_41f52afd))
        {
            s_beacon.var_41f52afd = util::spawn_model("tag_origin", s_beacon.origin);
        }
        s_beacon.var_41f52afd clientfield::set("beacon_fx", 1);
        bonfire.b_lit = 1;
    }

    foreach(bonfire in bonfires)
    {
        bonfire notify("beacon_activated");
    }
}

function StormWallrun()
{
    if(CheckQuestProgress("storm") >= 3) return;
    while(CheckQuestProgress("storm") < 2) wait 0.05;
    if(level.var_f8d1dc16 != self) level.var_f8d1dc16 = self;
    wallruns = GetEntArray("aq_es_wallrun_trigger", "targetname");
    foreach(wallrun in wallruns)
    {
        wallrun notify("trigger", self);
    }
}

function StormFillUrns()
{
    if(CheckQuestProgress("storm") >= 4) return;
    while(CheckQuestProgress("storm") < 3) wait 0.05;

    bonfires = GetEntArray("aq_es_beacon_trig", "script_noteworthy");
    foreach(bonfire in bonfires)
    {
        s_beacon = struct::get(bonfire.target);
        s_beacon.var_41f52afd clientfield::set("beacon_fx", 2);
        bonfire.b_charged = 1;
    }

    if(level.var_f8d1dc16 != self) level.var_f8d1dc16 = self;
    urn_souls = GetEntArray("aq_es_battery_volume", "script_noteworthy");
    foreach(urn_soul in urn_souls)
    {
        urn_soul.var_bb486f65 = 4;
        urn_soul notify("killed");
    }
    foreach(bonfire in bonfires)
    {
        bonfire notify("beacon_charged");
    }
}

function StormTriggerArrow()
{
    if(CheckQuestProgress("storm") >= 5) return;
    while(CheckQuestProgress("storm") < 4) wait 0.05;
    if(level.var_f8d1dc16 != self) level.var_f8d1dc16 = self;
    arrow = struct::get("quest_reforge_elemental_storm");
    while(!IsDefined(arrow.var_67b5dd94)) wait 0.05;
    arrow.var_67b5dd94 notify("trigger", self);
    wait 0.1;
    level scene::skip_scene("p7_fxanim_zm_castle_quest_storm_arrow_reform_bundle", 0, 0, 0);
    wait 0.5;
    level scene::skip_scene("p7_fxanim_zm_castle_quest_storm_arrow_whole_bundle", 0, 0, 0);
    wait 0.5;
    arrow.var_67b5dd94 notify("trigger", self);
}

function StormBuildBow()
{
    if(CheckQuestProgress("storm") >= 6) return;
    soulbox = struct::get("upgraded_bow_struct_elemental_storm", "targetname");
    while(!IsDefined(soulbox.var_67b5dd94)) wait 0.05;
    if(level.var_f8d1dc16 != self) level.var_f8d1dc16 = self;
    soulbox.var_67b5dd94 notify("trigger", self);
    level flag::set("elemental_storm_upgraded");
    wait 3;
    soulbox.var_67b5dd94 notify("trigger", self);
    wait 0.5;
    level scene::skip_scene("p7_fxanim_zm_castle_quest_upgrade_bundle_elemental_storm", 0, 0, 0);
    wait 0.5;
    soulbox.var_67b5dd94 notify("trigger", self);
}

// WRATH OF THE ANCIENTS FUNCTION - DER EISENDRACHE
// 0 = Lower Courtyard - 1 = Church - 2 = Undercroft

function FillDragon(num)
{   
    if(level.soul_catchers[num].is_charged) return;
    level.var_63e17dd5 = self;
    level.soul_catchers[num] notify("first_zombie_killed_in_zone", self);
    level.soul_catchers[num].var_98730ffa = 8;
}

function FillAllDragons()
{
    thread FillDragon(0);
    thread FillDragon(1);
    thread FillDragon(2);
}

function PickupBow()
{
    level flag::wait_till("soul_catchers_charged");
    wait 1;
    level.var_15acc392 = GetEnt("base_bow_pickup", "targetname");
    while(!IsDefined(level.var_15acc392))
    {
        level.var_15acc392 = GetEnt("base_bow_pickup", "targetname");
        wait 0.05;
    }
    bow = struct::get("base_bow_pickup_struct", "targetname");
    self BuildAndActivateTrigger(bow.var_67b5dd94);
}

function CheckQuestProgress(quest)
{
    return level clientfield::get("quest_state_" + quest);
}

// TIME TRAVEL - DER EISENDRACHE
function TimeTravel(num)
{
    upgrades = Array("demon_gate_upgraded", "elemental_storm_upgraded", "rune_prison_upgraded", "wolf_howl_upgraded");
	level flag::wait_till_any(upgrades);
    level flag::set("ee_start_done");
    if(num >= 0 && !level flag::get("mpd_canister_replacement"))
    {
        level flag::set("time_travel_teleporter_ready");
        wait 0.25;
        fuse = struct::get("ee_lab_fuse");
        canister = struct::get("mpd_canister");
        fuse_found = 0;
        canister_found = 0;
        for(;;)
        {
            foreach(stub in level._unitriggers.trigger_stubs)
            {
                if(!fuse_found && fuse.origin == stub.origin)
                {
                    self BuildAndActivateTrigger(stub);
                    fuse_found = 1;
                }
                if(!canister_found && canister.origin == stub.origin)
                {
                    self BuildAndActivateTrigger(stub);
                    canister_found = 1;
                }
            }
            if(fuse_found && canister_found) break;
            wait 0.05;
        }
        wait 0.5;
        level flag::clear("time_travel_teleporter_ready");
    }
    if(num >= 1 && !level flag::get("ee_safe_open"))
    {
        level flag::set("death_ray_trap_used");
        fuse_box = GetEnt("fuse_box", "targetname");
        fuse_box notify("trigger_activated");
        wait 0.5;
        deathray = GetEnt("ee_death_ray_switch", "targetname");
        deathray notify("trigger_activated");
        wait 0.5;
        level.var_ab58bca7 = [0, 0, 0];
        monitor = struct::get("monitor_launch_platform_1");
        monitor.var_d82c7c68 = 1;
        for(i = 0; i < 3; i++)
        {
            monitor notify("trigger_activated");
            wait 1.5;
        }
        key = GetEnt("golden_key", "targetname");
        key notify("trigger_activated");
        wait 0.5;
    }
    if(num >= 1 && !level flag::get("channeling_stone_replacement"))
    {
        level flag::set("time_travel_teleporter_ready");
        wait 0.25;
        key_slot = struct::get("golden_key_slot_past");
        self BuildAndActivateTrigger(key_slot.s_unitrigger);
        wait 0.5;
        tablet = GetEnt("stone_past", "targetname");
        self BuildAndActivateTrigger(tablet.s_unitrigger);
        wait 0.5;
        level flag::clear("time_travel_teleporter_ready");
    }
}

// SIMON SAYS
function DoSimonStep(num)
{
    if(!num) self thread SimonSays();
    else self thread ActivateDempsey();
}

function DoAllSimon()
{
    self thread SimonSays();
    self thread ActivateDempsey();
}

function SimonSays()
{
    if(IsDefined(struct::get("death_ray_button").s_unitrigger)) return;
    level flag::wait_till("ee_golden_key");
    wait 0.5;
    tc = struct::get("tc_launch_platform");
    tc notify("trigger_activated");
    tc = struct::get("tc_lower_tower");
    tc notify("trigger_activated");
    deathray = GetEnt("ee_death_ray_switch", "targetname");
    deathray notify("trigger_activated");
    wait 0.5;
    simon_1 = struct::get_array("golden_key_slot")[0];
    simon_2 = struct::get_array("golden_key_slot")[1];
    simon_1 notify("trigger_activated");
    level waittill(#"hash_706f7f9a");
    wait 1;
    level.var_521b0bd1 = 8;
    monitor = struct::get("monitor_lower_tower_1");
    monitor.var_73527aa3 = 1;
    monitor notify("trigger_activated");
    wait 5;
    simon_2 notify("trigger_activated");
    level waittill(#"hash_706f7f9a");
    wait 1;
    level.var_521b0bd1 = 8;
    monitor = struct::get("monitor_launch_platform_1");
    monitor.var_73527aa3 = 1;
    monitor notify("trigger_activated");
}

function ActivateDempsey()
{
    if(level flag::get("start_channeling_stone_step")) return;
    while(!IsDefined(struct::get("death_ray_button").s_unitrigger)) wait 0.05;
    wait 0.5;
    button = struct::get("death_ray_button");
    button notify("trigger_activated");
}

// PERKS

function GiveAllPerks()
{
    if(!IsDefined(self.perks_active)) self.perks_active = [];
    if(self.perks_active.size == level._custom_perks.size)
    {
        thread WriteToScreen("Already Have All Perks");
        return;
    }
    thread WriteToScreen("Giving All Perks");
	perks = GetArrayKeys(level._custom_perks);
	foreach(perk in perks)
    {
        if(!self hasPerk(perk)) self zm_perks::give_perk(perk, 0);
    }
}

// TRIGGERS

function BuildAndActivateTrigger(stub, craft = 0)
{
    trig = zm_unitrigger::check_and_build_trigger_from_unitrigger_stub(stub, self);
	trig.delete_trigger = 0;
	if(IsDefined(trig.radius)) trig.radius = 1500;
    if(IsDefined(trig.script_height)) trig.script_height = 1500;
    if(IsDefined(trig.script_height)) trig.script_height = 1500;
    if(IsDefined(trig.script_length)) trig.script_length = 1500;
    if(IsDefined(trig.require_look_at)) trig.require_look_at = 0;
    if(IsDefined(trig.require_look_toward)) trig.require_look_toward = 0;
    trig zm_unitrigger::assess_and_apply_visibility(trig, trig.stub, self, 1);
	trig.parent_player = self;
	org = trig.origin;
	trig.origin = self.origin;
	wait 0.1;
	trig notify("trigger", self);
	if(craft)
	{
		self.usebar = 1;
		wait 0.2;
		trig notify("craft_succeed");
		self.usebar = undefined;
	}
	wait 0.1;
	if(IsDefined(trig))
	{
		trig.origin = org;
		zm_unitrigger::unregister_unitrigger(trig);
		//if(IsDefined(trig)) trig Delete();
	}
}

function FindAndactivateEnt(origin)
{
	wait_var = 0;
    found = 0;
	skip = 0;
    while(!found)
    {
        ents = GetEntArray();
        foreach(ent in ents)
        {
			if(!IsDefined(ent) || !IsDefined(ent.origin)) continue;
            if(IsArray(origin))
			{
				foreach(org in origin)
				{
					if(DistanceSquared(org, ent.origin) <= 5)
					{
						ent notify("trigger_activated", self);
						found = 1;
						skip = 1;
						break;
					}
				}
			}
			else if(DistanceSquared(origin, ent.origin) <= 5)
			{
				ent notify("trigger_activated", self);
				found = 1;
				break;
			}
			if(skip) break;
            wait_var++;
            if(wait_var >= 100)
            {
                wait 0.05;
                wait_var = 0;
            }
        }
    }
}
/* DETOUR MOVED TO _ZM_CRAFTABLES.GSC
detour zm_craftables<scripts\zm\craftables\_zm_craftables.gsc>::craftable_use_hold_think_internal(player, slot = self.stub.craftablespawn.inventory_slot)
{
	wait(0.01);
	if(!IsDefined(self))
	{
		if(IsDefined(player.craftableaudio))
		{
			player.craftableaudio delete();
			player.craftableaudio = undefined;
		}
		return;
	}
	if(self.stub.craftablespawn zm_craftables::craftable_can_use_shared_piece())
	{
		slot = undefined;
	}
	if(!IsDefined(self.usetime))
	{
		self.usetime = int(3000);
	}
	self.craft_time = self.usetime;
	self.craft_start_time = gettime();
	craft_time = self.craft_time;
	craft_start_time = self.craft_start_time;
	if(craft_time > 0)
	{
		player zm_utility::disable_player_move_states(1);
		player zm_utility::increment_is_drinking();
		orgweapon = player getcurrentweapon();
		build_weapon = getweapon("zombie_builder");
		player giveweapon(build_weapon);
		player switchtoweapon(build_weapon);
		if(IsDefined(slot))
		{
			self.stub.craftablespawn zm_craftables::craftable_set_piece_crafting(player.current_craftable_pieces[slot]);
		}
		else
		{
			player zm_craftables::start_crafting_shared_piece();
		}
		player thread zm_craftables::player_progress_bar(craft_start_time, craft_time);
		if(IsDefined(level.craftable_craft_custom_func))
		{
			player thread [[level.craftable_craft_custom_func]](self.stub);
		}
		while(IsDefined(self) && player zm_craftables::player_continue_crafting(self.stub.craftablespawn, slot) && (gettime() - self.craft_start_time) < self.craft_time)
		{
			wait(0.05);
		}
		player notify("craftable_progress_end");
		player zm_weapons::switch_back_primary_weapon(orgweapon);
		player takeweapon(build_weapon);
		if(IsDefined(player.is_drinking) && player.is_drinking)
		{
			player zm_utility::decrement_is_drinking();
		}
		player zm_utility::enable_player_move_states();
	}
	if(IsDefined(self) && (self.craft_time <= 0 || (gettime() - self.craft_start_time) >= self.craft_time))
	{
		if(IsDefined(slot))
		{
			self.stub.craftablespawn zm_craftables::craftable_clear_piece_crafting(player.current_craftable_pieces[slot]);
		}
		else
		{
			player zm_craftables::finish_crafting_shared_piece();
		}
		self notify("craft_succeed");
	}
	else
	{
		if(IsDefined(player.craftableaudio))
		{
			player.craftableaudio delete();
			player.craftableaudio = undefined;
		}
		if(IsDefined(slot))
		{
			self.stub.craftablespawn  zm_craftables::craftable_clear_piece_crafting(player.current_craftable_pieces[slot]);
		}
		else
		{
			player  zm_craftables::finish_crafting_shared_piece();
		}
		self notify("craft_failed");
	}
}
*/

// VARS
function Timescale(value)
{
    thread WriteToScreen("Changing Timescale To " + value);
    SetDvar("timescale", value);
}

function ThirdPerson(num)
{
    text = "POV First Person";
    if(num) text = "POV Third Person";
    thread WriteToScreen(text);
    SetDvar("cg_thirdperson", num);
}

function Godmode(num)
{
    if(num)
    {
        thread WriteToScreen("Enabling Godmode");
        level endon("godmode_end");
        for(;;)
        {
            self EnableInvulnerability();
            wait 0.25;
        }
    }
    else
    {
        thread WriteToScreen("Disabling Godmode");
        level notify("godmode_end");
        wait 0.5;
        self DisableInvulnerability();
    }
}

function InfiniteAmmo(value)
{
    text = "Infinite Ammo Disabled";
    if(value) text = "Infinite Ammo Enabled";
    thread WriteToScreen(text);
    SetDvar("player_sustainAmmo", value);
}