Class {
	#name : #CBMarkAsTODOCriticMenu,
	#superclass : #CBGroupMarkItemCriticMenu,
	#category : #'Migrate-Tool-CriticBrowser-data-menu'
}

{ #category : #accessing }
CBMarkAsTODOCriticMenu class >> itemPriority [ 
	^ 1
]

{ #category : #accessing }
CBMarkAsTODOCriticMenu class >> runOn: aCriticBrowser [
	aCriticBrowser isSelectedCriticIsToDo
		ifTrue: [ aCriticBrowser
				removeToDo: aCriticBrowser selectedCritic
				forRule: aCriticBrowser selectedRule ]
		ifFalse: [ aCriticBrowser
				addToDo: aCriticBrowser selectedCritic
				forRule: aCriticBrowser selectedRule ].
	aCriticBrowser updateTree
]

{ #category : #accessing }
CBMarkAsTODOCriticMenu class >> title [ 
	^ 'Mark / unMark  as TODO'
]
