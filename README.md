RandomlyDecoratedItems
======================

<p>
RandomlyDecoratedItems is an iOS app demonstrating the creation and use of randomly generated loot using the decorator pattern.
</p>

<p align="center">
<img src="https://raw.githubusercontent.com/uimike/RandomlyDecoratedItems/master/readmeImages/screenshotBattleView.png" alt="rareItemDetailsView" width="213" height="320" class="alignnone"> <img src="https://raw.githubusercontent.com/uimike/RandomlyDecoratedItems/master/readmeImages/screenshotPlayerView.png" alt="rareItemDetailsView" width="213" height="320" class="alignnone"> <img src="https://raw.githubusercontent.com/uimike/RandomlyDecoratedItems/master/readmeImages/screenshotItemDetailsView.png" alt="rareItemDetailsView" width="213" height="320" class="alignnone">
</p>

App Structure
-------------

**MDBattleViewController** - Contained in the first tab and presents the battle UI to the player, allowing them to attack the enemy. This ViewController generates items when an enemy is defeated and presents an **MDVictoryViewController** for the player to pick the items up, which can push an **MDItemDetailsViewController** that displays more detailed information about the item.

**MDPlayerViewController** - Contained in the second tab and presents a UI for the player to equip items into various item slots. Pushes an **MDInventoryTableViewController** for the player to select an item, which pushes an **MDItemDetailsViewController** to display more detailed information about the item and allow the player to identify and equip it.

**MDGameEngine** - This is where the logic for attacking and being attacked occur. Methods in this class will call trigger events on the decorated weapons and armor, such as player:didHitEnemy:forDamage:messageLog:

**MDItemFactory** - Generates items at random, starting from the randomItem class. Gives a chance to wrap items in decorators, adding modifiers to the items.

**MDItem** - Base class for all items. Has subclasses **MDWeapon** and **MDarmor**. These subclasses are subclassed by specific items (like **MDSword** or **MDBoots**), and by weapon and armor decorators. See the next section for more details on the decorators.

**MDSharedPlayerData** - A singleton that contains the **MDPlayer** instance used throughout the app.

**MDPlayer** - Contains player info, like current health and equipped weapons and armor. Also handles logic for equipping and unequipping items and provides inventory access and information.

Use of the Decorator Pattern
----------------------------

This app's item model is designed with the decorator pattern. The pattern’s aim is to compose behavior and properties of objects at run-time, instead of hardcoding them at compile-time. This can be accomplished by wrapping an object in another object that shares the same superclass. The wrapper contains a reference to the object it’s wrapping, and simply sits in between method calls and getters to inject its own behavior.

Below is the class hierarchy for Weapons (Armor is set up in an identical fashion). Note that these aren't the exact class names in the project - I've stripped out the class prefixes for clarity here.

<p align="center">
<img src="https://raw.githubusercontent.com/uimike/RandomlyDecoratedItems/master/readmeImages/weaponHierarchy.png" alt="rareItemDetailsView" width="710" height="582" class="alignnone">
</p>

MDWeapon is a subclass of MDItem, and adds minDamage and maxDamage properties, among others. MDWeapon’s subclasses are mostly specific types of weapons (sword, dagger, hammer, etc.). The one exception is MDWeaponDecorator, a superclass of numerous weapon decorators.

There are two main aspects of WeaponDecorator that allow the decorator pattern to work:

<ul>
<li>MDWeaponDecorator has the same superclass as any other weapon instance. This allows a WeaponDecorator instance to be passed around in place of a Sword, Hammer, or any other Weapon instance. Any method that takes a parameter of type Weapon will now also take a WeaponDecorator. 
<li>Each MDWeaponDecorator has a reference to another Weapon instance. This reference is the Weapon object that the decorator is wrapping. This allows the decorator to pass any method or accessor calls to the wrapped Weapon instance, with the ability to add its own logic first.
</ul>

These aspects allow us to nest as many WeaponDecorators as we’d like. Each will pass any method calls to the object it wraps, and each has a chance to add its own logic. Let’s look at an example of an MDSword that’s been wrapped by two WeaponDecorators:

<p align="center">
<img src="https://raw.githubusercontent.com/uimike/RandomlyDecoratedItems/master/readmeImages/decoratorWrappedSword.png" alt="rareItemDetailsView" width="302" height="252" class="alignnone">
</p>

Below are the steps the app would take to create this weapon. You can find the corresponding code for item generation starting from the +randomItem method in MDItemFactory.m.
<ol><li>The ItemFactory class starts with a standard Weapon sublcass. It creates a Sword instance.<li>ItemFactory creates an instance of LifeLeechDecorator with a reference to the sword instance.<li>ItemFactory creates an instance of EnhancedDamageDecorator with a reference to the LifeLeechDecorator instance.<li>The EnhancedDamageDecorator instance is returned and treated as a standard Sword instance would be. The nested wrapping is concealed from the rest of the project.
</ol>

There are two types of “decorating” that occur when the items are used. 
<ul>
<li>Event-based, in which decorators run logic in response to events (player:willHitEnemy:messageLog:, player:didHitEnemy:forDamage:messageLog:, and player:didDefeatEnemy:messageLog:). There are similar events for armor, but from a damage-taking perspective (enemy:didHitPlayer:forDamage:messageLog:, enemy:didKillPlayer:messageLog:). See the attackEnemy:withPlayer:messageLog: method in MDGameEngine.m for examples of calling these events on weapons, and check out MDLifeLeechWeaponDecorator.m for an example of a decorator responding to an event.
<li>Modifying values by overriding getters. We see this with minDamage, maxDamage, critChance, and critPercentBonusDamage for MDWeaponDecorators, and in defense, percentDamageReflected, and percentDamageAbsorbed. Any time these are accessed, all weapon or armor decorators wrapping the item that override the getters can add their own values to the total returned. See MDCritChanceWeaponDecorator.m for an example of this.
</ul>

Composing Item Names
--------------------

<p align="center">
<img src="https://raw.githubusercontent.com/uimike/RandomlyDecoratedItems/master/readmeImages/screenshotMiracleClub.png" alt="rareItemDetailsView" width="213" height="320" class="alignnone"><img src="https://raw.githubusercontent.com/uimike/RandomlyDecoratedItems/master/readmeImages/screenshotItemDetailsView.png" alt="rareItemDetailsView" width="213" height="320" class="alignnone">
</p>

The app also uses the decorator pattern to build item names. MDItems have three separate strings that make up their name: a prefix (“Thorned”), a base name (“Sword”), and a prefix (“of Reaping”). Every decorator overrides the nameSuffix and namePrefix getters. In the suffix getter, they return a suffix if the prefix isn’t already being used in the item’s name. Otherwise, they pass the accessory call on to the wrapped instance. If the calls make it to the last wrapped item instance, no suffix is used and nil is returned. See any of weapon or armor decorator subclass for the overridden namePrefix and nameSuffix getters.
