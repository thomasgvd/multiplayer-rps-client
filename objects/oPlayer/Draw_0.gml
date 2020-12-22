draw_set_halign(fa_center);
draw_text(x, bbox_top - 40, oController.username);
draw_text(x, bbox_top - 20, "w/l : " + string(0) + "/" + string(0));
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, stretch, image_angle, image_blend, image_alpha);

if (place_meeting(x, y, oDummy)) {
	draw_text(x, bbox_bottom + 20, "press SPACE to fight");
}
