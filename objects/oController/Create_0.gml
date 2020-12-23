enum TEXTBOX_TYPE { USERNAME, PASSWORD }
enum PLAYER { A, B }

// Networking
enum PACKET_TYPE { CONNECTION, MOVEMENT, DISCONNECT }

network_set_config(network_config_connect_timeout, 4000);
network_set_config(network_config_use_non_blocking_socket, 1);
socket = network_create_socket(network_socket_tcp);
buffer = buffer_create(256, buffer_grow, 1);
connected = false;
waitingForServerResponse = 0;
WAIT_FOR_RESPONSE_DURATION = 120;

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

function manage_server_response(_load) {
	var _buffer = _load[? "buffer"];
	buffer_seek(_buffer, buffer_seek_start, 0);
	
	var _rawData = buffer_read(_buffer, buffer_string);
	var _packetData = string_to_array(_rawData);
	show_debug_message("received packet : " + string(_rawData) + " - converted into " + string(_packetData));
	
	var _packetType = _packetData[0];
	
	switch (_packetType) {
		case PACKET_TYPE.CONNECTION:
			var _success = _packetData[1];
			
			if (_success) room_goto(rGame);
			else display_error_message();
			
			break;
		case PACKET_TYPE.MOVEMENT:
			if (room == rGame && instance_exists(oPlayer)) {
				oPlayer.x = _packetData[1];
				oPlayer.y = _packetData[2];
			}
			
			break;
		default: break;
	}
	
	waitingForServerResponse = 0;
}

function string_to_array(_string) {
	var _list = ds_list_create();
	var _array = [];
	var _el = "";
	
	for (var i = 1; i <= string_length(_string); i++) {
		var _char = string_char_at(_string, i);
		
		if (_char != "|") {
			_el += _char;
		} 
		
		if (i == string_length(_string) || _char == "|") {
			ds_list_add(_list, _el);
			_el = "";
		}
	}
	
	
	for (var i = 0; i < ds_list_size(_list); i++) {
		_array[i] = ds_list_find_value(_list, i);
	}
	
	ds_list_destroy(_list);
	
	return _array;
}

function send_packet() {
	if (connected) {
		network_send_raw(socket, buffer, buffer_tell(buffer));
		show_debug_message("send packet")
	}
}

function connect_room_management() {
	// Initialize textbox ids
	if (usernameTextbox == undefined || passwordTextbox == undefined) {
		if (instance_exists(oTextbox)) {
			for (var i = 0; i < instance_number(oTextbox); i++) {
				var _textbox = instance_find(oTextbox, i);
			
				if (instance_exists(_textbox) && _textbox.myType = TEXTBOX_TYPE.USERNAME) usernameTextbox = _textbox;
				if (instance_exists(_textbox) && _textbox.myType = TEXTBOX_TYPE.PASSWORD) passwordTextbox  = _textbox;
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
	if (connected) {
		// Connection packet
		buffer_seek(buffer, buffer_seek_start, 0);
		buffer_write(buffer, buffer_string, string(PACKET_TYPE.CONNECTION) + "|" + string(username) + "|" + string(password) + "\n");
		send_packet();
	} else {
		network_connect_raw(socket, "127.0.0.1", 5555);
	}
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
	waitingForServerResponse = WAIT_FOR_RESPONSE_DURATION;
	button_effect();
	check_credentials();
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