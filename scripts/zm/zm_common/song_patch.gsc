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
#namespace song_patch;

function main(){

    switch(level.script){

        case "zm_zod":
            
            level.players[0].bgb_pack = Array("zm_bgb_shopping_free", "zm_bgb_reign_drops", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
            level.players[0].bgb_pack_ramdomized = Array("zm_bgb_reign_drops", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
            ArrayInsert(level.players[0].bgb_pack_randomized, "zm_bgb_shopping_free", 0);
            level flag::wait_till("initial_blackscreen_passed");
	        iprintlnbold("Snakeskin and Boots " + getDvarString("patch") + " patch is loaded!");
            break;
        
        case "zm_factory":

            level.players[0].bgb_pack = Array("zm_bgb_shopping_free", "zm_bgb_reign_drops", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
            level.players[0].bgb_pack_ramdomized = Array("zm_bgb_reign_drops", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
            ArrayInsert(level.players[0].bgb_pack_randomized, "zm_bgb_shopping_free", 0);
            level flag::wait_till("initial_blackscreen_passed");
	        iprintlnbold("Beauty of Annihilation Remix " + getDvarString("patch") + " patch is loaded!");
            break;
        
        case "zm_castle":

            level.players[0].bgb_pack = Array("zm_bgb_shopping_free", "zm_bgb_reign_drops", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
            level.players[0].bgb_pack_ramdomized = Array("zm_bgb_reign_drops", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
            ArrayInsert(level.players[0].bgb_pack_randomized, "zm_bgb_shopping_free", 0);
            level flag::wait_till("initial_blackscreen_passed");
	        iprintlnbold("Dead Again " + getDvarString("patch") + " patch is loaded!");
            break;

        case "zm_island":

            level.players[0].bgb_pack = Array("zm_bgb_shopping_free", "zm_bgb_reign_drops", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
            level.players[0].bgb_pack_ramdomized = Array("zm_bgb_shopping_free", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
            ArrayInsert(level.players[0].bgb_pack_randomized, "zm_bgb_reign_drops", 0);
            level flag::wait_till("initial_blackscreen_passed");
	        iprintlnbold("Dead Flowers " + getDvarString("patch") + " patch is loaded!");
            break;

        case "zm_stalingrad":

            level.players[0].bgb_pack = Array("zm_bgb_shopping_free", "zm_bgb_reign_drops", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
            level.players[0].bgb_pack_ramdomized = Array("zm_bgb_reign_drops", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
            ArrayInsert(level.players[0].bgb_pack_randomized, "zm_bgb_shopping_free", 0);
            level flag::wait_till("initial_blackscreen_passed");
	        iprintlnbold("Dead Ended " + getDvarString("patch") + " patch is loaded!");
            break;

        case "zm_genesis":

            level.players[0].bgb_pack = Array("zm_bgb_shopping_free", "zm_bgb_reign_drops", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
            level.players[0].bgb_pack_ramdomized = Array("zm_bgb_reign_drops", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
            ArrayInsert(level.players[0].bgb_pack_randomized, "zm_bgb_shopping_free", 0);
            level flag::wait_till("initial_blackscreen_passed");
	        iprintlnbold("The Gift " + getDvarString("patch") + " patch is loaded!");
            break;

        case "zm_asylum":

            level.players[0].bgb_pack = Array("zm_bgb_shopping_free", "zm_bgb_reign_drops", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
            level.players[0].bgb_pack_ramdomized = Array("zm_bgb_reign_drops", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
            ArrayInsert(level.players[0].bgb_pack_randomized, "zm_bgb_shopping_free", 0);
            level flag::wait_till("initial_blackscreen_passed");
	        iprintlnbold("Lullaby For a Dead Man " + getDvarString("patch") + " patch is loaded!");
            break;

        case "zm_sumpf":

            level.players[0].bgb_pack = Array("zm_bgb_shopping_free", "zm_bgb_reign_drops", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
            level.players[0].bgb_pack_ramdomized = Array("zm_bgb_reign_drops", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
            ArrayInsert(level.players[0].bgb_pack_randomized, "zm_bgb_shopping_free", 0);
            level flag::wait_till("initial_blackscreen_passed");
	        iprintlnbold("The One " + getDvarString("patch") + " patch is loaded!");
            break;

        case "zm_theater":

            level.players[0].bgb_pack = Array("zm_bgb_shopping_free", "zm_bgb_reign_drops", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
            level.players[0].bgb_pack_ramdomized = Array("zm_bgb_reign_drops", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
            ArrayInsert(level.players[0].bgb_pack_randomized, "zm_bgb_shopping_free", 0);
            level flag::wait_till("initial_blackscreen_passed");
	        iprintlnbold("115 " + getDvarString("patch") + " patch is loaded!");
            break;

        case "zm_cosmodrome":

            level.players[0].bgb_pack = Array("zm_bgb_shopping_free", "zm_bgb_reign_drops", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
            level.players[0].bgb_pack_ramdomized = Array("zm_bgb_reign_drops", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
            ArrayInsert(level.players[0].bgb_pack_randomized, "zm_bgb_shopping_free", 0);
            level flag::wait_till("initial_blackscreen_passed");
	        iprintlnbold("Abracadavre " + getDvarString("patch") + " patch is loaded!");
            break;
        
        case "zm_temple":

            level.players[0].bgb_pack = Array("zm_bgb_shopping_free", "zm_bgb_reign_drops", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
            level.players[0].bgb_pack_ramdomized = Array("zm_bgb_reign_drops", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
            ArrayInsert(level.players[0].bgb_pack_randomized, "zm_bgb_shopping_free", 0);
            level flag::wait_till("initial_blackscreen_passed");
	        iprintlnbold("Pareidolia " + getDvarString("patch") + " patch is loaded!");
            break;

        case "zm_moon":

            level.players[0].bgb_pack = Array("zm_bgb_shopping_free", "zm_bgb_reign_drops", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
            level.players[0].bgb_pack_ramdomized = Array("zm_bgb_shopping_free", "zm_bgb_extra_credit", "zm_bgb_perkaholic");
            ArrayInsert(level.players[0].bgb_pack_randomized, "zm_bgb_reign_drops", 0);
            ArrayInsert(level.players[0].bgb_pack_randomized, "zm_bgb_anywhere_but_here", 1);
            level flag::wait_till("initial_blackscreen_passed");
	        iprintlnbold("Coming Home " + getDvarString("patch") + " patch is loaded!");
            break;

        case "zm_tomb":

            level.players[0].bgb_pack = Array("zm_bgb_shopping_free", "zm_bgb_reign_drops", "zm_bgb_extra_credit", "zm_bgb_perkaholic", "zm_bgb_anywhere_but_here");
            level.players[0].bgb_pack_ramdomized = Array("zm_bgb_shopping_free", "zm_bgb_extra_credit", "zm_bgb_perkaholic");
            ArrayInsert(level.players[0].bgb_pack_randomized, "zm_bgb_reign_drops", 0);
            ArrayInsert(level.players[0].bgb_pack_randomized, "zm_bgb_anywhere_but_here", 1);
            level flag::wait_till("initial_blackscreen_passed");
	        iprintlnbold("Archangel " + getDvarString("patch") + " patch is loaded!");
            break;

    }

    

}