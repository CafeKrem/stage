"
test
"
Class {
	#name : #CBSenderCriticMenu,
	#superclass : #CBGroupACriticMenu,
	#category : #'Migrate-Tool-CriticBrowser-data-menu'
}

{ #category : #accessing }
CBSenderCriticMenu class >> icon [ 
	^ nil
]

{ #category : #accessing }
CBSenderCriticMenu class >> itemPriority [ 
	^ 20
]

{ #category : #accessing }
CBSenderCriticMenu class >> runOn: aCriticBrowser [
	^ aCriticBrowser selectedCritic
		ifNotNil:
			[ :aCritic | ClyQueryBrowser browseSendersOf: aCritic sourceAnchor entity selector ]
]

{ #category : #accessing }
CBSenderCriticMenu class >> title [ 
	^ 'senders of...'
]
