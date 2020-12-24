draw_set_halign(fa_center);
draw_set_font(fText);
draw_text(x, bbox_top - 20, username);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, stretch, image_angle, image_blend, image_alpha);

//if (username == oController.username && place_meeting(x, y, oPlayer)) {
//	draw_text(x, bbox_bottom + 20, "press SPACE to fight");
//}
