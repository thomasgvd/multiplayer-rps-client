// Sprite animation
stretch = 1 + sin(timer * frequency) * amplitude;
timer++;

// Able to move while in game room
if (room == rGame) {
	var _xMove = keyboard_check(ord("D")) - keyboard_check(ord("Q"));
	var _yMove = keyboard_check(ord("S")) - keyboard_check(ord("Z"));

	if (_xMove != 0) image_xscale = _xMove;
	
	if ((bbox_left <= 0 && _xMove == -1) || (bbox_right >= room_width && _xMove == 1)) _xMove = 0;
	if ((bbox_bottom >= room_height && _yMove == 1) || (bbox_top <= 0 && _yMove == -1)) _yMove = 0;
	
	if (x < 0 || x > room_width || y < 0 || y > room_height) {
		x = room_width / 2;
		y = room_height / 2;
	}

	x += _xMove * SPEED;
	y += _yMove * SPEED;
// Choosing attacks while in fighting room
} else if (room == rFight) {
}