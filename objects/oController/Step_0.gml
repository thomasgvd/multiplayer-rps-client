if (room == rConnect) {
	connect_room_management();
} else if (room == rGame) {
	if (!spawned) {	
		with (instance_create_layer(room_width / 2, room_height / 2, "Instances", oPlayer)) {}
		spawned = true;
	}
} else if (room == rFight) {
	fight_room_management();
}