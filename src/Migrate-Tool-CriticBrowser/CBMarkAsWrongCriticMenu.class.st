Class {
	#name : #CBMarkAsWrongCriticMenu,
	#superclass : #CBGroupMarkItemCriticMenu,
	#category : #'Migrate-Tool-CriticBrowser-data-menu'
}

{ #category : #accessing }
CBMarkAsWrongCriticMenu class >> itemPriority [ 
	^ 1
]

{ #category : #accessing }
CBMarkAsWrongCriticMenu class >> runOn: aCriticBrowser [
	^ aCriticBrowser isSelectedCriticIsToDo
		ifTrue: [ aCriticBrowser
				removeToDo: aCriticBrowser selectedCritic
				forRule: aCriticBrowser selectedRule ]
		ifFalse: [ aCriticBrowser
				addToDo: aCriticBrowser selectedCritic
				forRule: aCriticBrowser selectedRule ]
]

{ #category : #accessing }
CBMarkAsWrongCriticMenu class >> title [ 
	^ 'Mark / unMark  as TODO'
]
