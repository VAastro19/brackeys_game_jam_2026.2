# event_bus.gd
extends Node

signal OnPlayerHit(health: int, max_health: int)
signal OnPlayerDead

signal OnCoinUpdate(amount: int, coin_type: Enums.CoinType)

signal OnItemRemoved(item_type: Enums.ItemType, amount: int)
signal OnItemCollected(item: Item, amount: int)
signal OnItemClose(item: Item)
signal OnItemFar

signal OnNPCInteracted(npc: NPC)
signal OnEndInteraction(npc: NPC)
signal OnNPCClose(npc: NPC)
signal OnNPCFar

signal UIError
