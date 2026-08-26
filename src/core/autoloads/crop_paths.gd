# crop_paths.gd
extends Node

enum Crop { NONE, APPLE, BREAD, CABBAGE, CARROT, DOUGH, FLOUR, EGG, ONION, PUMPKIN, PEPPER, MILK, TOMATO, WHEAT }

var path: Dictionary[Crop, String] = {
	Crop.APPLE: "uid://40trarkd2ieq",
	Crop.BREAD: "uid://dbqcji3w0p2ov",
	Crop.CABBAGE: "uid://defmt0frpasuw",
	Crop.CARROT: "uid://croeowh5t0tup",
	Crop.DOUGH: "uid://cdgbjuv5sn5s1",
	Crop.FLOUR: "uid://cmvpj2hwwdioj",
	Crop.EGG: "uid://erg22l2oaegn",
	Crop.ONION: "uid://dluavk5a6sghj",
	Crop.PUMPKIN: "uid://mt6i5syav7vi",
	Crop.PEPPER: "uid://c1fhmhluw82md",
	Crop.MILK: "uid://dunwevqfwi60b",
	Crop.TOMATO: "uid://b7hgw7t50tfkm",
	Crop.WHEAT: "uid://c1d4nid2b3fs3"
}
