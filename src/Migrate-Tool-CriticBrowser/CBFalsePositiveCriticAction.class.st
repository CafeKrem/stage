"
see superClass 's documentation
my action is :
	to tag the selected critic in the criticsPresenter 
"
Class {
	#name : #CBFalsePositiveCriticAction,
	#superclass : #CBAbstractCriticAction,
	#category : #'Migrate-Tool-CriticBrowser-util'
}

{ #category : #accessing }
CBFalsePositiveCriticAction class >> priority [
	^ 20
]

{ #category : #accessing }
CBFalsePositiveCriticAction class >> runOn: aCriticBrowser [
	aCriticBrowser selectedCritic
		ifNotNil: [ :item | 
			aCriticBrowser markAsFalsePositiveForCurrentRule: item ]
		ifNil: [ self inform: 'No critic selected' ]
]

{ #category : #accessing }
CBFalsePositiveCriticAction class >> title [
	^ 'Mark as wrong'
]
