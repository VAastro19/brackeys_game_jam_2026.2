# shop_data.gd
extends Node

var descriptions: Dictionary[Enums.ItemType, String] = {
	Enums.ItemType.APPLE:	 "Common fruit, grows on trees",
	Enums.ItemType.BREAD: 	 "Made in bakery with water and flour",
	Enums.ItemType.CABBAGE:  "Green and crispy",
	Enums.ItemType.CARROT: 	 "Orange and crunchy",
	Enums.ItemType.DOUGH: 	 "Not implemented",
	Enums.ItemType.FLOUR: 	 "Not implemented",
	Enums.ItemType.EGG:		 "So delicate, so delicious",
	Enums.ItemType.ONION: 	 "Chug it anywhere and it will make it better",
	Enums.ItemType.PUMPKIN:	 "Comfort food for autumn lovers",
	Enums.ItemType.PEPPER: 	 "Not implemented",
	Enums.ItemType.MILK: 	 "Not implemented",
	Enums.ItemType.TOMATO: 	 "Squishy red vegetable... or  a fruit",
	Enums.ItemType.WHEAT:	 "Basis of agriculture",
	Enums.ItemType.INVENTORY_UPGRADE: "Expands your inventory slot by one",
	Enums.ItemType.DOUBLE_FORAGE: "Doubles the amount of forage you pick up",
	Enums. ItemType.INCREASED_DAMAGE: "Increases your weapon's damage"
}

var string_names: Dictionary[Enums.ItemType, String] = {
	Enums.ItemType.APPLE:	 "Apple",
	Enums.ItemType.BREAD: 	 "Bread",
	Enums.ItemType.CABBAGE:  "Cabbage",
	Enums.ItemType.CARROT: 	 "Carrot",
	Enums.ItemType.DOUGH: 	 "Not implemented",
	Enums.ItemType.FLOUR: 	 "Not implemented",
	Enums.ItemType.EGG:		 "Egg",
	Enums.ItemType.ONION: 	 "Onion",
	Enums.ItemType.PUMPKIN:	 "Pumpkin",
	Enums.ItemType.PEPPER: 	 "Not implemented",
	Enums.ItemType.MILK: 	 "Not implemented",
	Enums.ItemType.TOMATO: 	 "Tomato",
	Enums.ItemType.WHEAT:	 "Wheat",
	Enums.ItemType.INVENTORY_UPGRADE: "Inventory Upgrade",
	Enums.ItemType.DOUBLE_FORAGE: "Double Forage",
	Enums. ItemType.INCREASED_DAMAGE: "Increased Damage"
}

var item_prices: Dictionary[Enums.ItemType, int] = {
	Enums.ItemType.APPLE: 1,
	Enums.ItemType.BREAD: 10,
	Enums.ItemType.CABBAGE: 3,
	Enums.ItemType.CARROT: 5,
	Enums.ItemType.DOUGH: 10,
	Enums.ItemType.FLOUR: 10,
	Enums.ItemType.EGG: 4,
	Enums.ItemType.ONION: 3,
	Enums.ItemType.PUMPKIN: 5,
	Enums.ItemType.PEPPER: 7,
	Enums.ItemType.MILK: 7,
	Enums.ItemType.TOMATO: 2,
	Enums.ItemType.WHEAT: 4,
	Enums.ItemType.INVENTORY_UPGRADE: 100,
	Enums.ItemType.DOUBLE_FORAGE: 200,
	Enums. ItemType.INCREASED_DAMAGE: 150
}
