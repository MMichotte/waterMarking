clear all; close all; clc;

addWatermark('sounds/SchemingWeasel_short.mp3')

checkIntegrity('sounds/SchemingWeasel_short_wm.wav')
checkIntegrity('sounds/SchemingWeasel_short_wm_unchanged.wav')

checkIntegrity('sounds/SchemingWeasel_short_wm_echo.wav')
checkIntegrity('sounds/SchemingWeasel_short_wm_inverted.wav')
checkIntegrity('sounds/SchemingWeasel_short_wm_shorten.wav')
checkIntegrity('sounds/SchemingWeasel_short_wm_speed.wav')

addWatermark('sounds/troll.mp3')
checkIntegrity('sounds/troll_wm.wav')
checkIntegrity('sounds/troll_wm_distorted.mp3')