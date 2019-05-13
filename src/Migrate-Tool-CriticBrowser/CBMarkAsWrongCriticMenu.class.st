Class {
	#name : #CBMarkAsWrongCriticMenu,
	#superclass : #CBGroupMarkItemCriticMenu,
	#category : #'Migrate-Tool-CriticBrowser-data-menu'
}

{ #category : #accessing }
CBMarkAsWrongCriticMenu class >> itemPriority [ 
	^ 10
]

{ #category : #accessing }
CBMarkAsWrongCriticMenu class >> runOn: aCriticBrowser [
	aCriticBrowser isSelectedRuleIsFalsePositive
		ifTrue: [ aCriticBrowser
				removeFalsePositive: aCriticBrowser selectedCritic
				forRule: aCriticBrowser selectedRule ]
		ifFalse: [ aCriticBrowser
				addFalsePositive: aCriticBrowser selectedCritic
				forRule: aCriticBrowser selectedRule ].
	aCriticBrowser updateTree
]

{ #category : #accessing }
CBMarkAsWrongCriticMenu class >> title [ 
	^ 'Mark / UnMark as Wrong'
]
