if (keyboard_check_pressed(vk_space)) {
	oController.playerA = object_index;
	oController.playerB = other.object_index;
	room_goto(rFight);
}