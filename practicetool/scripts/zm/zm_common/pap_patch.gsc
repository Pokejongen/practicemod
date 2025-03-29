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
#namespace pap_patch;

function main(){

    switch(level.script){

        case "zm_zod":

            self.bgb_pack = Array("zm_bgb_perkaholic", "zm_bgb_reign_drops", "zm_bgb_shopping_free", "zm_bgb_anywhere_but_here", "zm_bgb_extra_credit");
            self.bgb_pack_randomized = Array("zm_bgb_anywhere_but_here", "zm_bgb_extra_credit", "zm_bgb_perkaholic");
            ArrayInsert(self.bgb_pack_randomized, "zm_bgb_reign_drops", 0);
            ArrayInsert(self.bgb_pack_randomized, "zm_bgb_shopping_free", 4);
            level flag::wait_till("initial_blackscreen_passed");
	        iprintlnbold("Shadows of Evil " + getDvarString("patch") + " patch is loaded!");
            break;

        case "zm_factory":

            self.bgb_pack = Array("zm_bgb_shopping_free", "zm_bgb_reign_drops", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
            self.bgb_pack_ramdomized = Array("zm_bgb_reign_drops", "zm_bgb_extra_credit");
            ArrayInsert(self.bgb_pack_randomized, "zm_bgb_shopping_free", 0);
            level flag::wait_till("initial_blackscreen_passed");
	        iprintlnbold("The Giant " + getDvarString("patch") + " patch is loaded!");
            break;

        case "zm_castle":

            self.bgb_pack = Array("zm_bgb_shopping_free", "zm_bgb_reign_drops", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
            self.bgb_pack_ramdomized = Array("zm_bgb_reign_drops", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
            ArrayInsert(self.bgb_pack_randomized, "zm_bgb_shopping_free", 0);
            level flag::wait_till("initial_blackscreen_passed");
	        iprintlnbold("Der Eisendrache " + getDvarString("patch") + " patch is loaded!");
            break;

        case "zm_island":

            self.bgb_pack = Array("zm_bgb_shopping_free", "zm_bgb_reign_drops", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
            self.bgb_pack_randomized = Array("zm_bgb_shopping_free", "zm_bgb_reign_drops", "zm_bgb_extra_credit");
            ArrayInsert(self.bgb_pack_randomized, "zm_bgb_anywhere_but_here", 2);
            ArrayInsert(self.bgb_pack_randomized, "zm_bgb_perkaholic", 4);
            level flag::wait_till("initial_blackscreen_passed");
	        iprintlnbold("Zetsubou no Shima " + getDvarString("patch") + " patch is loaded!");
            break;

        case "zm_stalingrad":

            self.bgb_pack = Array("zm_bgb_shopping_free", "zm_bgb_reign_drops", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
            self.bgb_pack_randomized = Array("zm_bgb_shopping_free", "zm_bgb_reign_drops", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
            while(self.bgb_pack_randomized[0] != "zm_bgb_shopping_free" || self.bgb_pack_randomized[0] != "zm_bgb_reign_drops" || self.bgb_pack_randomized[0] != "zm_bgb_extra_credit"){

                self.bgb_pack_randomized = Array("zm_bgb_shopping_free", "zm_bgb_reign_drops", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
                wait 0.05;

            }
            level flag::wait_till("initial_blackscreen_passed");
	        iprintlnbold("Gorod Krovi " + getDvarString("patch") + " patch is loaded!");
            break;

        case "zm_genesis":

            self.bgb_pack = Array("zm_bgb_shopping_free", "zm_bgb_reign_drops", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
            self.bgb_pack_ramdomized = Array("zm_bgb_shopping_free", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
            ArrayInsert(self.bgb_pack_randomized, "zm_bgb_reign_drops", 0);
            level flag::wait_till("initial_blackscreen_passed");
	        iprintlnbold("Revelations " + getDvarString("patch") + " patch is loaded!");
            break;

        case "zm_theater":

            self.bgb_pack = Array("zm_bgb_shopping_free", "zm_bgb_reign_drops", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
            self.bgb_pack_ramdomized = Array("zm_bgb_reign_drops", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
            ArrayInsert(self.bgb_pack_randomized, "zm_bgb_shopping_free", 0);
            level flag::wait_till("initial_blackscreen_passed");
	        iprintlnbold("Kino der Toten " + getDvarString("patch") + " patch is loaded!");
            break;

        case "zm_cosmodrome":

            self.bgb_pack = Array("zm_bgb_shopping_free", "zm_bgb_reign_drops", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
            self.bgb_pack_ramdomized = Array("zm_bgb_reign_drops", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
            ArrayInsert(self.bgb_pack_randomized, "zm_bgb_shopping_free", 0);
            level flag::wait_till("initial_blackscreen_passed");
	        iprintlnbold("Ascension " + getDvarString("patch") + " patch is loaded!");
            break;

        case "zm_temple":

            self.bgb_pack = Array("zm_bgb_shopping_free", "zm_bgb_reign_drops", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
            self.bgb_pack_ramdomized = Array("zm_bgb_reign_drops", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
            ArrayInsert(self.bgb_pack_randomized, "zm_bgb_shopping_free", 0);
            level flag::wait_till("initial_blackscreen_passed");
	        iprintlnbold("Shangri La " + getDvarString("patch") + " patch is loaded!");
            break;

        case "zm_moon":

            self.bgb_pack = Array("zm_bgb_shopping_free", "zm_bgb_reign_drops", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
            self.bgb_pack_ramdomized = Array("zm_bgb_reign_drops", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
            ArrayInsert(self.bgb_pack_randomized, "zm_bgb_shopping_free", 0);
            level flag::wait_till("initial_blackscreen_passed");
	        iprintlnbold("Moon " + getDvarString("patch") + " patch is loaded!");
            break;

        case "zm_tomb":

            self.bgb_pack = Array("zm_bgb_shopping_free", "zm_bgb_reign_drops", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
            self.bgb_pack_randomized = Array("zm_bgb_shopping_free", "zm_bgb_reign_drops", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
            while(self.bgb_pack_randomized[0] != "zm_bgb_shopping_free" || self.bgb_pack_randomized[0] != "zm_bgb_reign_drops" || self.bgb_pack_randomized[0] != "zm_bgb_extra_credit"){

                self.bgb_pack_randomized = Array("zm_bgb_shopping_free", "zm_bgb_reign_drops", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
                wait 0.05;

            }
            level flag::wait_till("initial_blackscreen_passed");
	        iprintlnbold("Origins " + getDvarString("patch") + " patch is loaded!");
            break;

    }

}