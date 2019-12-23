-- Persistent Data
local multiRefObjects = {

} -- multiRefObjects
local obj1 = {
	["classes"] = {
		[1] = false;
		[2] = false;
		[3] = false;
		[4] = false;
		[5] = false;
		[6] = false;
		[7] = false;
		[8] = false;
		[9] = false;
		[10] = false;
		[11] = false;
		[12] = false;
		[13] = false;
		[14] = false;
		[15] = false;
		[16] = false;
		[17] = false;
		[18] = false;
		[19] = false;
		[20] = false;
		[21] = true;
		[22] = false;
		[23] = false;
		[24] = false;
		[25] = false;
		[26] = false;
		[27] = false;
		[28] = false;
		[29] = false;
		[30] = false;
		[31] = false;
		[32] = false;
		[33] = false;
		[34] = false;
		[35] = false;
		[36] = false;
		[37] = false;
		[38] = false;
	};
	["filters"] = {
		[1] = "Buffs OFF";
		[2] = "AOE OFF";
		[3] = "Onslaught ON";
		[4] = "Tank CDs ON";
		[5] = "";
	};
	["skills"] = {
		[1] = {
			["combat"] = "Any";
			["filtertwo"] = "Off";
			["id"] = 16463;
			["levelmin"] = 72;
			["maxRange"] = 0;
			["name"] = "Chaotic Cyclone";
			["prio"] = 1;
			["tarange"] = 5;
			["tecenter"] = "Self";
			["tecount"] = 2;
			["terange"] = 7;
			["trg"] = "Player";
		};
		[2] = {
			["combat"] = "Any";
			["comboskill"] = "False";
			["condition"] = "";
			["filtertwo"] = "Off";
			["gcdtime"] = 0.5;
			["id"] = 3550;
			["levelmin"] = 60;
			["maxRange"] = 0;
			["name"] = "Decimate";
			["playerlevelmin"] = 60;
			["prio"] = 2;
			["tarange"] = 5;
			["tecenter"] = "Self";
			["tecount"] = 2;
			["terange"] = 7;
			["trg"] = "Player";
		};
		[3] = {
			["alias"] = "Steel Cyclone";
			["combat"] = "Any";
			["filtertwo"] = "Off";
			["id"] = 51;
			["levelmax"] = 59;
			["levelmin"] = 45;
			["maxRange"] = 0;
			["name"] = "Decimate";
			["prio"] = 3;
			["tarange"] = 5;
			["tecenter"] = "Self";
			["tecount"] = 2;
			["terange"] = 7;
			["trg"] = "Player";
		};
		[4] = {
			["combat"] = "Any";
			["filtertwo"] = "Off";
			["id"] = 16462;
			["levelmin"] = 40;
			["maxRange"] = 0;
			["name"] = "Mythril Tempest";
			["pcskill"] = "41";
			["pnbuff"] = "1177";
			["prio"] = 4;
			["tarange"] = 5;
			["tecenter"] = "Self";
			["tecount"] = 2;
			["terange"] = 7;
			["trg"] = "Player";
		};
		[5] = {
			["combat"] = "Any";
			["filtertwo"] = "Off";
			["id"] = 41;
			["levelmin"] = 40;
			["maxRange"] = 8;
			["name"] = "Overpower";
			["npgskill"] = "31,37";
			["pbuff"] = "90";
			["pbuffdura"] = 5;
			["prio"] = 5;
			["skncdtimemax"] = 80;
			["sknoffcd"] = "7389";
			["tarange"] = 5;
			["tecenter"] = "Self";
			["tecount"] = 2;
			["terange"] = 7;
		};
		[6] = {
			["id"] = 16465;
			["levelmin"] = 80;
			["maxRange"] = 3;
			["name"] = "Inner Chaos";
			["pbuff"] = "90";
			["pbuffdura"] = 5;
			["prio"] = 6;
		};
		[7] = {
			["id"] = 3549;
			["levelmin"] = 70;
			["maxRange"] = 3;
			["name"] = "Fell Cleave";
			["pbuff"] = "1177";
			["prio"] = 7;
		};
		[8] = {
			["id"] = 3549;
			["levelmin"] = 70;
			["maxRange"] = 3;
			["name"] = "Fell Cleave";
			["pbuff"] = "90";
			["pbuffdura"] = 5;
			["pnbuff"] = "1177";
			["prio"] = 8;
			["skncdtimemax"] = 80;
			["skncdtimemin"] = 10;
			["sknoffcd"] = "7389";
		};
		[9] = {
			["filterfour"] = "On";
			["gcd"] = "True";
			["id"] = 7548;
			["levelmin"] = 32;
			["maxRange"] = 0;
			["name"] = "Arm's Length";
			["phpb"] = 90;
			["prio"] = 9;
			["trg"] = "Player";
		};
		[10] = {
			["dobuff"] = true;
			["filterfour"] = "On";
			["id"] = 7535;
			["levelmin"] = 32;
			["maxRange"] = 3;
			["name"] = "Reprisal";
			["phpb"] = 80;
			["playerlevelmin"] = 32;
			["prio"] = 10;
		};
		[11] = {
			["filterfour"] = "On";
			["id"] = 3551;
			["levelmin"] = 56;
			["maxRange"] = 0;
			["name"] = "Raw Intuition";
			["phpb"] = 85;
			["prio"] = 11;
			["trg"] = "Player";
		};
		[12] = {
			["dobuff"] = true;
			["filterfour"] = "On";
			["id"] = 7531;
			["levelmin"] = 8;
			["maxRange"] = 0;
			["name"] = "Rampart";
			["phpb"] = 70;
			["playerlevelmin"] = 8;
			["prio"] = 12;
			["trg"] = "Player";
		};
		[13] = {
			["dobuff"] = true;
			["filterfour"] = "On";
			["gcdtime"] = 0.5;
			["id"] = 44;
			["levelmin"] = 46;
			["maxRange"] = 0;
			["name"] = "Vengeance";
			["phpb"] = 60;
			["playerlevelmin"] = 46;
			["prio"] = 13;
			["ptrg"] = "Enemy";
			["trg"] = "Player";
		};
		[14] = {
			["filterfour"] = "On";
			["id"] = 3552;
			["levelmin"] = 70;
			["maxRange"] = 0;
			["name"] = "Equilibrium";
			["phpb"] = 50;
			["playerlevelmin"] = 58;
			["prio"] = 14;
			["trg"] = "Player";
		};
		[15] = {
			["filterfour"] = "On";
			["gcdtime"] = 0.5;
			["id"] = 40;
			["levelmin"] = 26;
			["maxRange"] = 0;
			["name"] = "Thrill of Battle";
			["phpb"] = 55;
			["playerlevelmin"] = 26;
			["prio"] = 15;
			["trg"] = "Player";
		};
		[16] = {
			["filterfour"] = "On";
			["gcdtime"] = 0.0099999997764826;
			["id"] = 43;
			["levelmin"] = 42;
			["maxRange"] = 6;
			["name"] = "Holmgang";
			["phpb"] = 10;
			["playerlevelmin"] = 42;
			["prio"] = 16;
			["trg"] = "Player";
		};
		[17] = {
			["alias"] = "Infuriate Opener";
			["combat"] = "Any";
			["filterone"] = "Off";
			["gauge1or"] = "0";
			["gcd"] = "True";
			["gcdtime"] = 0.0099999997764826;
			["id"] = 52;
			["levelmin"] = 80;
			["maxRange"] = 0;
			["name"] = "Infuriate";
			["pgskill"] = "31,46";
			["pnbuff"] = "90+";
			["prio"] = 17;
			["skoffcd"] = "7389";
			["trg"] = "Player";
		};
		[18] = {
			["combat"] = "Any";
			["filterone"] = "Off";
			["gauge1lt"] = 50;
			["gcdtime"] = 0.75;
			["id"] = 52;
			["levelmin"] = 80;
			["maxRange"] = 0;
			["name"] = "Infuriate";
			["playerlevelmin"] = 50;
			["pnbuff"] = "1177";
			["prio"] = 18;
			["skncdtimemax"] = 80;
			["skncdtimemin"] = 5;
			["sknoffcd"] = "7389";
			["trg"] = "Player";
		};
		[19] = {
			["filterone"] = "Off";
			["gauge1gt"] = 90;
			["gcdtime"] = 0.0099999997764826;
			["gcdtimelt"] = 2.2000000476837;
			["id"] = 38;
			["levelmax"] = 69;
			["levelmin"] = 6;
			["maxRange"] = 0;
			["name"] = "Berserk";
			["playerlevelmin"] = 6;
			["prio"] = 19;
			["ptrg"] = "Enemy";
			["trg"] = "Player";
		};
		[20] = {
			["filterone"] = "Off";
			["gcdtime"] = 0.0099999997764826;
			["gcdtimelt"] = 0.5;
			["id"] = 7389;
			["levelmin"] = 80;
			["maxRange"] = 0;
			["name"] = "Inner Release";
			["pbuff"] = "90";
			["pbuffdura"] = 18;
			["pgskill"] = "45,42,51,3550,16463,16462,16465";
			["playerlevelmin"] = 70;
			["pnbuff"] = "1897";
			["prio"] = 20;
			["ptrg"] = "Enemy";
			["skoffcd"] = "7389";
			["trg"] = "Player";
		};
		[21] = {
			["alias"] = "Inner Release lvl";
			["filterone"] = "Off";
			["gcdtime"] = 0.0099999997764826;
			["gcdtimelt"] = 1;
			["id"] = 7389;
			["levelmax"] = 79;
			["levelmin"] = 70;
			["maxRange"] = 0;
			["name"] = "Inner Release";
			["pbuff"] = "90";
			["pbuffdura"] = 18;
			["pgskill"] = "45,42,47,3549,49,16462,16463";
			["prio"] = 21;
			["trg"] = "Player";
		};
		[22] = {
			["alias"] = "Storm's Eye IR prep";
			["filterone"] = "Off";
			["id"] = 45;
			["levelmin"] = 70;
			["maxRange"] = 3;
			["name"] = "Storm's Eye";
			["pcskill"] = "37";
			["pnbuff"] = "90";
			["pnbuffdura"] = 23;
			["prio"] = 22;
			["skncdtimemax"] = 1;
			["sknoffcd"] = "7389";
		};
		[23] = {
			["alias"] = "Fell Cleave lvl";
			["id"] = 3549;
			["levelmax"] = 69;
			["levelmin"] = 54;
			["maxRange"] = 3;
			["name"] = "Fell Cleave";
			["prio"] = 23;
			["skncdtimemin"] = 18;
			["sknoffcd"] = "38";
		};
		[24] = {
			["alias"] = "Inner Beast lvl";
			["id"] = 49;
			["levelmax"] = 53;
			["levelmin"] = 35;
			["maxRange"] = 3;
			["name"] = "Fell Cleave";
			["pbuff"] = "90";
			["pbuffdura"] = 5;
			["prio"] = 24;
			["skncdtimemin"] = 18;
			["sknoffcd"] = "38";
		};
		[25] = {
			["id"] = 45;
			["levelmin"] = 50;
			["maxRange"] = 3;
			["name"] = "Storm's Eye";
			["pcskill"] = "37";
			["playerlevelmin"] = 50;
			["pnbuff"] = "90";
			["pnbuffdura"] = 8;
			["prio"] = 25;
			["tnbuffowner"] = "Any";
		};
		[26] = {
			["id"] = 42;
			["levelmin"] = 38;
			["maxRange"] = 3;
			["name"] = "Storm's Path";
			["pcskill"] = "37";
			["playerlevelmin"] = 38;
			["prio"] = 26;
		};
		[27] = {
			["id"] = 37;
			["levelmin"] = 38;
			["maxRange"] = 3;
			["name"] = "Maim";
			["pcskill"] = "31";
			["playerlevelmin"] = 18;
			["prio"] = 27;
		};
		[28] = {
			["gcdtime"] = 0.5;
			["id"] = 31;
			["levelmin"] = 1;
			["maxRange"] = 3;
			["name"] = "Heavy Swing";
			["playerlevelmin"] = 1;
			["prio"] = 28;
			["ptrg"] = "Enemy";
			["skncdtimemax"] = 80;
			["sknoffcd"] = "7389";
		};
		[29] = {
			["gcd"] = "True";
			["id"] = 7387;
			["levelmin"] = 70;
			["maxRange"] = 3;
			["name"] = "Upheaval";
			["playerlevelmin"] = 64;
			["prio"] = 29;
			["skncdtimemax"] = 89.999000549316;
			["skncdtimemin"] = 25;
			["sknoffcd"] = "7389";
			["tecount2"] = 1;
			["terange"] = 10;
		};
		[30] = {
			["gcd"] = "True";
			["id"] = 7387;
			["levelmin"] = 64;
			["maxRange"] = 3;
			["name"] = "Upheaval";
			["pbuff"] = "1177";
			["prio"] = 30;
		};
		[31] = {
			["filterthree"] = "On";
			["gcd"] = "True";
			["id"] = 7386;
			["levelmin"] = 70;
			["maxRange"] = 20;
			["name"] = "Onslaught";
			["ncurrentaction"] = "7387";
			["npskill"] = "7387";
			["pbuff"] = "1177";
			["prio"] = 31;
			["terange"] = 20;
		};
		[32] = {
			["alias"] = "Berserk lvl";
			["filterone"] = "Off";
			["gauge1gt"] = 90;
			["id"] = 38;
			["levelmax"] = 69;
			["levelmin"] = 6;
			["maxRange"] = 0;
			["name"] = "Berserk";
			["playerlevelmin"] = 6;
			["prio"] = 32;
			["trg"] = "Player";
		};
		[33] = {
			["alias"] = "Berserk lvl";
			["filterone"] = "Off";
			["id"] = 38;
			["levelmax"] = 34;
			["levelmin"] = 6;
			["maxRange"] = 0;
			["name"] = "Berserk";
			["prio"] = 33;
			["trg"] = "Player";
		};
		[34] = {
			["alias"] = "Equilibrium lvl";
			["filterone"] = "Off";
			["id"] = 3552;
			["levelmax"] = 69;
			["levelmin"] = 58;
			["maxRange"] = 0;
			["name"] = "Equilibrium";
			["phpb"] = 50;
			["playerlevelmin"] = 58;
			["prio"] = 34;
			["trg"] = "Player";
		};
		[35] = {
			["alias"] = "Heavy Swing lvl";
			["id"] = 31;
			["levelmax"] = 70;
			["levelmin"] = 1;
			["maxRange"] = 3;
			["name"] = "Heavy Swing";
			["prio"] = 35;
		};
		[36] = {
			["alias"] = "Upheaval lvl";
			["id"] = 7387;
			["levelmax"] = 69;
			["levelmin"] = 64;
			["maxRange"] = 3;
			["name"] = "Upheaval";
			["prio"] = 36;
			["tecenter"] = "Self";
			["tecount2"] = 1;
			["terange"] = 10;
		};
		[37] = {
			["alias"] = "Infuriate lvl";
			["filterone"] = "Off";
			["gauge1lt"] = 50;
			["gcd"] = "True";
			["id"] = 52;
			["levelmax"] = 79;
			["levelmin"] = 50;
			["maxRange"] = 0;
			["name"] = "Infuriate";
			["pnbuff"] = "1177";
			["prio"] = 37;
			["trg"] = "Player";
		};
		[38] = {
			["combat"] = "Any";
			["filterfour"] = "On";
			["gcd"] = "False";
			["id"] = 48;
			["ignoremoving"] = true;
			["levelmin"] = 10;
			["maxRange"] = 0;
			["name"] = "Defiance";
			["onlyparty"] = true;
			["partysizelt"] = 4;
			["pnbuff"] = "91";
			["prio"] = 38;
			["trg"] = "Player";
		};
	};
	["version"] = 3;
}
return obj1
