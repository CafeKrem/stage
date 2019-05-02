"
i'm an Abstract class to define feature of a button:

abstract define:

	- actions : return a collection of all my subclass sorted by priority method
	- isAbstract : i'm use to say if the class is abstract 	

my subclass define:
	
	- priority : return an integer use for set the order of buttons 
	- runOn: aCriticBrowser it's the action of the button
	- title: the label of the button
"
Class {
	#name : #CBAbstractRuleAction,
	#superclass : #CBAbstractButtonAction,
	#category : #'Migrate-Tool-CriticBrowser'
}

{ #category : #actions }
CBAbstractRuleAction class >> actions [
	^ self allSubclasses sorted: #priority ascending 
]

{ #category : #testing }
CBAbstractRuleAction class >> isAbstract [
	^ self = CBAbstractRuleAction
]
