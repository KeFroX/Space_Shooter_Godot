extends Control


signal game_settings_menu_back

func _on_btn_back_pressed():
	emit_signal("game_settings_menu_back")
