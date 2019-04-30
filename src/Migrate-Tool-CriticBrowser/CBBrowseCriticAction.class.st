Class {
	#name : #CBBrowseCriticAction,
	#superclass : #CBAbstractCriticAction,
	#category : #'Migrate-Tool-CriticBrowser'
}

{ #category : #accessing }
CBBrowseCriticAction class >> priority [
	^ 1
]

{ #category : #accessing }
CBBrowseCriticAction class >> runOn: aCriticBrowser [
	aCriticBrowser selectedCritic
		ifNotNil: [ :element | 
			| entity |
			entity := element sourceAnchor entity.
			entity isBehavior
				ifTrue: [ entity instanceSide browse ]
				ifFalse: [ entity browse ] ]
		ifNil: [ self inform: 'No critic selected' ]
]

{ #category : #accessing }
CBBrowseCriticAction class >> title [
	^ 'Browse'
]
