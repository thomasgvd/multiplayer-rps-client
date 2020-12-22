enum TEXTBOX_TYPE { USERNAME, PASSWORD }
enum PLAYER { A, B }

// Connection
textboxFocused = undefined;
usernameTextbox = undefined;
passwordTextbox = undefined;
messageObj = undefined;

username = "";
password = "";

// Fighting
spawnA = undefined;
spawnB = undefined;
playerA = undefined;
playerB = undefined;
spawned = false;
fightOver = true;
winner = undefined;
fightManaged = false;

function connect_room_management() {
	// Initialize textbox ids
	if (usernameTextbox == undefined || passwordTextbox == undefined) {
		if (instance_exists(oTextbox)) {
			for (var i = 0; i < instance_number(oTextbox); i++) {
				var textbox = instance_find(oTextbox, i);
			
				if (instance_exists(textbox) && textbox.myType = TEXTBOX_TYPE.USERNAME) usernameTextbox = textbox;
				if (instance_exists(textbox) && textbox.myType = TEXTBOX_TYPE.PASSWORD) passwordTextbox  = textbox;
			}
		}
	} else if (textboxFocused == undefined) {
		textboxFocused = usernameTextbox;
	}
	
	if (keyboard_check_pressed(vk_tab)) {
		if (textboxFocused == usernameTextbox) {
			change_focus(TEXTBOX_TYPE.PASSWORD);
		} else {
			change_focus(TEXTBOX_TYPE.USERNAME);
		}
	}
	
	if (keyboard_check_pressed(vk_enter)) {
		connect();
	}
}

function fight_room_management() {
	if (spawnA == undefined || spawnB == undefined) { // Initialize room
		set_spawns();
	} else if (playerA != undefined && playerB != undefined && !spawned) { // Initiliaze fight
		fightOver = false;
		spawned = true;
		with (instance_create_layer(spawnA.x, spawnA.y, "Instances", playerA)) {
			playerA = id;	
		}
		with (instance_create_layer(spawnB.x, spawnB.y, "Instances", playerB)) {
			playerB = id;	
			image_xscale = -1;
		}
	} else if (!fightOver) { // Manage fight
		manage_fight();
	} else if (fightOver) { // End fight
		room_goto(rGame);
	}
}

function manage_fight() {
	if (!fightManaged) {
		fightManaged = true;
		alarm[0] = 60;
	}
}

function change_focus(_type) {
	if (_type == TEXTBOX_TYPE.PASSWORD) {
		textboxFocused = passwordTextbox;
		username = keyboard_string;
		keyboard_string = password;
	} else {
		textboxFocused = usernameTextbox;
		password = keyboard_string;
		keyboard_string = username;
	}
}

function check_credentials() {
	// Send check_credentialsion request with username / password
	
	show_debug_message("username : " + string(username));
	show_debug_message("password : " + string(password));
	
	return username == "user1" && password == "pass1";
}

function display_error_message() {
	messageObj = instance_find(oMessage, 0);
	if (instance_exists(messageObj)) {
		messageObj.text = "Incorrect username or password.";
	}
}

function button_effect() {
	if (instance_exists(oButton)) {
		with (oButton) { 
			sprite_index = sButtonPressed;
			alarm[0] = 7;
		}
	}
}

function connect() {
	
	button_effect();
	
	if (oController.check_credentials()) {
		room_goto(rGame);
	} else {
		oController.display_error_message();
	}
}

function set_spawns() {
	if (instance_exists(oSpawn)) {
		for (var i = 0; i < instance_number(oSpawn); i++) {
			var _spawn = instance_find(oSpawn, i);
			if (_spawn.spawnId == PLAYER.A) spawnA = _spawn;
			if (_spawn.spawnId == PLAYER.B) spawnB = _spawn;
		}
	}
}