// Sprite animation
stretch = 1 + sin(timer * frequency) * amplitude;
timer++;

// Able to move while in game room
if (room == rGame) {
	if (username == oController.username) {
		var _xMove = keyboard_check(ord("D")) - keyboard_check(ord("Q"));
		var _yMove = keyboard_check(ord("S")) - keyboard_check(ord("Z"));

		if ((bbox_left <= 0 && _xMove == -1) || (bbox_right >= room_width && _xMove == 1)) _xMove = 0;
		if ((bbox_bottom >= room_height && _yMove == 1) || (bbox_top <= 0 && _yMove == -1)) _yMove = 0;
	
		if (x < 0 || x > room_width || y < 0 || y > room_height) {
			x = room_width / 2;
			y = room_height / 2;
		}
	
		if (_xMove != 0 || _yMove != 0) {
			with (oController) {
				send_movement_packet(_xMove, _yMove);
			}
		}
	}
} 
//else if (room == rFight) {
//}