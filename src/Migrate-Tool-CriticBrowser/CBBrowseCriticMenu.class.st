Class {
	#name : #CBBrowseCriticMenu,
	#superclass : #CBGroupACriticMenu,
	#category : #'Migrate-Tool-CriticBrowser-data-menu'
}

{ #category : #accessing }
CBBrowseCriticMenu class >> icon [ 
	^ nil
]

{ #category : #accessing }
CBBrowseCriticMenu class >> itemPriority [ 
	^ 1
]

{ #category : #accessing }
CBBrowseCriticMenu class >> runOn: aCriticBrowser [
	^ CBBrowseCriticAction runOn: aCriticBrowser
]

{ #category : #accessing }
CBBrowseCriticMenu class >> title [ 
	^ 'browse'
]
