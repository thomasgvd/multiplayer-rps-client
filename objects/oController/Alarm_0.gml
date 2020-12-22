// Manage fight
if (winner == undefined) {
	winner = choose(PLAYER.A, PLAYER.B);
	if (winner == PLAYER.A) {
		playerA.sprite_index = sPlayerWin;
		playerB.sprite_index = sPlayerLoss;
	} else if (winner == PLAYER.B) {
		playerA.sprite_index = sPlayerLoss;
		playerB.sprite_index = sPlayerWin;
	}
	
	with (instance_create_layer(room_width / 2, room_height / 3, "Instances", oText)) {
		text = "Player " + string(other.winner == PLAYER.A ? "A" : "B") + " wins!";	
	}
	
	alarm[1] = 120;
}