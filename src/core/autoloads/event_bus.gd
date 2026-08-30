# event_bus.gd
extends Node

signal OnPlayerHit(health: int, max_health: int)
signal OnPlayerDead
signal OnPlayerMove
signal OnPlayerAttack1
signal OnPlayerAttack2
signal OnPlayerAttack3

signal OnGoblinAttack
signal OnGoblinWalk
signal OnGoblinDead

signal OnCoinUpdate(amount: int, coin_type: Enums.CoinType)
signal OnScammed(amount: int)
signal OnSlotUnlocked

signal OnItemRemoved(item_type: Enums.ItemType, amount: int)
signal OnItemCollected(item: Item, amount: int)
signal OnItemClose(item: Item)
signal OnItemFar

signal OnNPCInteracted(npc: NPC)
signal OnEndInteraction(npc: NPC)
signal OnNPCClose(npc: NPC)
signal OnNPCFar

signal UIError
signal OnEndGame
