Class {
	#name : #CBImplementorCriticMenu,
	#superclass : #CBGroupACriticMenu,
	#category : #'Migrate-Tool-CriticBrowser-data-menu'
}

{ #category : #accessing }
CBImplementorCriticMenu class >> icon [
	^ nil
]

{ #category : #accessing }
CBImplementorCriticMenu class >> itemPriority [ 
	^ 10 
]

{ #category : #accessing }
CBImplementorCriticMenu class >> runOn: aCriticBrowser [
	^ aCriticBrowser selectedCritic
		ifNotNil:
			[ :aCritic | ClyQueryBrowser browseImplementorsOf: aCritic sourceAnchor entity name ]
]

{ #category : #accessing }
CBImplementorCriticMenu class >> title [ 
	^ 'implementors of...'
]
