"
this class is an Abstract Class to defined button interact with Item in CriticsPresenter

	see documentation of my SuperClass 
	
i define :
	- actions : return a Collection of all my subclass sorted by priority
	
"
Class {
	#name : #CBAbstractCriticAction,
	#superclass : #CBAbstractButtonAction,
	#category : #'Migrate-Tool-CriticBrowser'
}

{ #category : #actions }
CBAbstractCriticAction class >> actions [
	^ self allSubclasses sorted: #priority ascending 
]

{ #category : #testing }
CBAbstractCriticAction class >> isAbstract [
	^ self = CBAbstractCriticAction
]

{ #category : #accessing }
CBAbstractCriticAction class >> priority [
	^ self subclassResponsibility
]

{ #category : #accessing }
CBAbstractCriticAction class >> runOn: aCriticBrowser [
	^ self subclassResponsibility
]

{ #category : #accessing }
CBAbstractCriticAction class >> title [
	^ self subclassResponsibility
]
