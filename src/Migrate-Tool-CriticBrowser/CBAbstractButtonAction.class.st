"
i'm an abstractClass
my subclass define :
	- actions : return a Collection of all my subclass sorted by priority
	- priority : return an integer use for set the order of buttons 
	- runOn: aCriticBrowser it's the action of the button
	- title: the label of the button
"
Class {
	#name : #CBAbstractButtonAction,
	#superclass : #Object,
	#category : #'Migrate-Tool-CriticBrowser-data'
}

{ #category : #actions }
CBAbstractButtonAction class >> actions [ 
	^ self subclassResponsibility 
]

{ #category : #accessing }
CBAbstractButtonAction class >> groupPriority [ 
	^ self subclassResponsibility 
]

{ #category : #testing }
CBAbstractButtonAction class >> isAbstract [ 
	^ self = CBAbstractButtonAction 
]

{ #category : #testing }
CBAbstractButtonAction class >> runOn: aCriticBrowser [
	^ self subclassResponsibility 
]

{ #category : #accessing }
CBAbstractButtonAction class >> title [ 
	^ self subclassResponsibility 
]
