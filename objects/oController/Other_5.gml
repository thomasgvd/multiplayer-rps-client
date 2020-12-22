if (room == rConnect) {
	usernameTextbox = undefined;
	passwordTextbox = undefined;
	messageObj = undefined;
} else if (room == rGame) {
	spawned = false;
} else if (room == rFight) {
	playerA = undefined;
	playerB = undefined;
	spawned = false;
	fightOver = true
	winner = undefined;
}