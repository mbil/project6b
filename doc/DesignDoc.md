Design Document
===========
# Huisgenoten

## Models:

### Calendar

Methods:

    *   getEvents
    *	addEvent
    *	deleteEvent
    *	adjustEvent
    *	setAlarm

### Shoppinglist

Methods:

    *	fetchNeededGroceries
    *	addNewProduct
    *   updateFinances

### Roommates

Methods:

    *	getFacebookFriendList
    *	getRoommates
    *	addRoommates
    *	deleteRoommates

### Alarms

Methods:

    *	addAlarm
    *	deleteAlarm
    * 	enableAlarm
    *	disableAlarm

### Alerts

Methods:

    *   fetchCurrentAlerts

### Finances

Methods:

    *	getRoommateStatus
    * 	buildBalance

## ViewControllers:

### HomeViewController

Methods:

    *   showShoppingList
    *   showAlarm
    *	showRoommates
    *	showFinances	
    *	updateLabels
    *   showInfo
    
### ShoppingListViewController

Methods

    * 	showGroceries
    *	tickProduct
    *	updateLabels
    *	returnToHome
    *	showInfo

### FinanceViewController

Methods

    *   showBalance
    *	updateLabels
    *	returnToHome
    *	showInfo
    
### AlarmViewController

Methods

    *   showAlarms
    *   updateLabels
    *	returnToHome
    *	showInfo
    
### CalendarViewController

Methods

    *   viewEvents
    *	returnToHome
    *	showInfo
    
### RoommateViewController

Methods:

    *   viewRoomMates
    *	returnToHome
    *	showInfo
	


## UI Sketches
### Huisgenoten
![GitHub Logo](https://github.com/mbil/project6b/blob/master/doc/UIsketch.png?raw=true)


![GitHub Logo](https://github.com/mbil/project6b/blob/master/doc/Diagram.png?raw=true)

## Style Guide:
- We maken gebruik van [Google Objective-C Style Guide][1]

[1]: http://google-styleguide.googlecode.com/svn/trunk/objcguide.xml
