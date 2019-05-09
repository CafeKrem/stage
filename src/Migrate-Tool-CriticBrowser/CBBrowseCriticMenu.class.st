Class {
	#name : #CBBrowseCriticMenu,
	#superclass : #CBGroupACriticMenu,
	#category : #'Migrate-Tool-CriticBrowser-data'
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
	^ aCriticBrowser selectedRule
		ifNotNil: [ :aRule | aRule content browse ]
]

{ #category : #accessing }
CBBrowseCriticMenu class >> title [
	^ 'Browse rule'
]
