Class {
	#name : #CBMarkAsTODOCriticMenu,
	#superclass : #CBGroupMarkItemCriticMenu,
	#category : #'Migrate-Tool-CriticBrowser-data-menu'
}

{ #category : #accessing }
CBMarkAsTODOCriticMenu class >> itemPriority [ 
	^ 10
]

{ #category : #accessing }
CBMarkAsTODOCriticMenu class >> runOn: aCriticBrowser [
	^ aCriticBrowser isSelectedRuleIsFalsePositive
		ifTrue: [ aCriticBrowser
				removeFalsePositive: aCriticBrowser selectedCritic
				forRule: aCriticBrowser selectedRule ]
		ifFalse: [ aCriticBrowser
				addFalsePositive: self selectedCritic
				forRule: aCriticBrowser selectedRule ]
]

{ #category : #accessing }
CBMarkAsTODOCriticMenu class >> title [ 
	^ 'Mark / UnMark as wrong'
]
