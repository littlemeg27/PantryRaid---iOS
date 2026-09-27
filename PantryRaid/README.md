# PantryRaid for iOS

Swift + SwiftUI app. Track fridge, freezer, pantry, and spices, find recipes from what’s on hand, and keep a shopping list that only stocks the kitchen after checkout.

## Run

1. Open `OnHand.xcodeproj` in Xcode 15 or newer.
2. Select an iOS 17+ simulator, or a device.
3. Set a Development Team under Signing & Capabilities if you run on a physical iPhone.
4. Run.

- Bundle ID: `com.onhand.app`
- Display name: PantryRaid

## What’s in the app

| Tab / screen | What it does |
| --- | --- |
| Kitchen | Counts by location, expiry warnings, shopping-list reminder |
| On hand | Full inventory, filter by location, add / adjust / remove |
| Recipes | Local on-hand matcher, optional live AI search |
| Shop | Grocery list → mark purchased → check out into fridge / freezer / pantry / spices |
| Add to kitchen | Name, quantity, unit, location, optional `YYYY-MM-DD` expiry |
| AI setup | API key, base URL, model |

First launch loads a seed kitchen so Recipes already has matches.

## Code map

```
OnHand/
  OnHandApp.swift
  ContentView.swift
  Models.swift
  SeedData.swift
  InventoryStore.swift
  RecipeMatcher.swift
  AiRecipeService.swift
  Expiry.swift
  Theme.swift
  KitchenView.swift
  InventoryView.swift
  RecipesView.swift
  RecipeDetailView.swift
  ShopView.swift
  AddItemView.swift
  SettingsView.swift
  Info.plist
  Assets.xcassets
```

Inventory, the shopping list, and AI settings persist in UserDefaults.

## AI

Leave the API key empty to stay on the built-in matcher.

Defaults if you turn AI on:

- Base URL: `https://api.x.ai/v1`
- Model: `grok-3`

Any OpenAI-compatible chat API works if you change the URL and model. Do not commit keys.

## Notes

This is starter code. There is no CloudKit sync, no notifications, and no finished App Store icon. The Xcode target is still named OnHand; the home-screen name is PantryRaid.
