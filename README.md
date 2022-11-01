# STARTER

This is a starter project for Godot 4, and mostly aimed to do a quick start of a game for testing, prototyping or a game jam

It has some basic presets and some tooling that might be usefull

Please keep in mind that this project can be still be improved upon as some refactoring is needed to remove for example duplicated code

ALso this is an opinionated started. I added a workflow i like to use but by no means it is the only way to do stuff or sometimes even the recommended or right way to do it
# ASSETS USED

assets used in the starter are from

https://emhuo.itch.io/peaberry-pixel-font

https://moludar.itch.io/menu-sounds-archive

https://wenrexa.itch.io/holoui

# Starter

## Menu
Menu with some buttons has been added to load/start a new game and for settings

Note! there is a button conntinue and a button "How to play" these are not connected yet

## Logger
On the main node you have the option to set what level of log you want to see and what kind of log

While godot has a pretty good logger itself i always find when debbugging that i cant find the logs i want
with the logger you can easily filter what kind of logs you want to see.

I added some "channels" that i usually seem to be using. This can of course be extended. To add a new channel just take the
value of the previous one in src/managers/log.gd and double it. It will use bitwise oprations to turn on or off channels or
log levels.

## Save
Very basic save/load functionality is added where you have 4 slots available.

## Events
An autoloaded singleton for event is added and has some basic events already that are used for the starter.

## Settings
Some basic settings can be saved already for sound and display. To acces the settings when "playing" press escape

## Playing
To show some of the functionality you can start the game, which consist of a button to click. When you clicked 10 times you have a game over and can restart the level
Also when pressing escape and then save it will save your amount of clicks

