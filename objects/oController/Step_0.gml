if (room == rConnect) {
	connect_room_management();
} else if (room == rGame) {
	if (get_player(username) == -1 && waitingForServerResponse <= 0) {
		waitingForServerResponse = 30;
		send_movement_packet(0, 0);
	}
} else if (room == rFight) {
	fight_room_management();
}

waitingForServerResponse = max(0, waitingForServerResponse - 1);