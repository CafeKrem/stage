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
		ifNotNil: [ :aCritic | 
			(aCritic sourceAnchor entity respondsTo: #selector)
				ifFalse: [ ^ self inform: 'you can ask the implementors of this' ].
			ClyQueryBrowser
				browseImplementorsOf: aCritic sourceAnchor entity selector ]
]

{ #category : #accessing }
CBImplementorCriticMenu class >> title [ 
	^ 'implementors of...'
]
