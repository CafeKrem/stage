Class {
	#name : #CBAbstractCriticMenu,
	#superclass : #CBAbstractMenu,
	#category : #'Migrate-Tool-CriticBrowser-data-menu'
}

{ #category : #accessing }
CBAbstractCriticMenu class >> actionsGroup [
	^ self allSubclasses sorted: #itemPriority ascending
]

{ #category : #accessing }
CBAbstractCriticMenu class >> actionsMenu [
	^ self allSubclasses sorted: #groupPriority ascending
]

{ #category : #testing }
CBAbstractCriticMenu class >> isAbstract [
	^ self = CBAbstractCriticMenu 
]
