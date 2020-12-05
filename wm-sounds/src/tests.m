clear all; close all; clc;

disp('marking img 1');
addWatermark('sounds/SchemingWeasel_short.mp3')

disp('1');checkIntegrity('sounds/SchemingWeasel_short_wm.wav')
disp('2');checkIntegrity('sounds/SchemingWeasel_short_wm_unchanged.wav')

disp('3');checkIntegrity('sounds/SchemingWeasel_short_wm_echo.wav')
disp('4');checkIntegrity('sounds/SchemingWeasel_short_wm_inverted.wav')
disp('5');checkIntegrity('sounds/SchemingWeasel_short_wm_shorten.wav')
disp('6');checkIntegrity('sounds/SchemingWeasel_short_wm_speed.wav')

disp('----------------------------------');
disp('marking img 2');
addWatermark('sounds/troll.mp3')
disp('1');checkIntegrity('sounds/troll_wm.wav')
disp('2');checkIntegrity('sounds/troll_wm_distorted.mp3')