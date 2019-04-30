Class {
	#name : #CBFalsePositiveCriticAction,
	#superclass : #CBAbstractCriticAction,
	#category : #'Migrate-Tool-CriticBrowser'
}

{ #category : #accessing }
CBFalsePositiveCriticAction class >> priority [
	^ 20
]

{ #category : #accessing }
CBFalsePositiveCriticAction class >> runOn: aCriticBrowser [
	aCriticBrowser selectedCritic
		ifNotNil: [ :items | 
			items
				do: [ :item | aCriticBrowser markAsFalsePositiveForCurrentRule: item ] ]
		ifNil: [ self inform: 'No critic selected' ]
]

{ #category : #accessing }
CBFalsePositiveCriticAction class >> title [
	^ 'Mark as wrong'
]
