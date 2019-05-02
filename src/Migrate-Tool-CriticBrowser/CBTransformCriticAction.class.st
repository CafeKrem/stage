Class {
	#name : #CBTransformCriticAction,
	#superclass : #CBAbstractCriticAction,
	#category : #'Migrate-Tool-CriticBrowser'
}

{ #category : #accessing }
CBTransformCriticAction class >> priority [
	^ 10
]

{ #category : #accessing }
CBTransformCriticAction class >> runOn: aCriticBrowser [
	aCriticBrowser selectedCritic 
		ifNotNil: [ :itemCritic | itemCritic change execute ]
		ifNil: [ self inform: 'i don ' , $' , 't known how  ' ]
]

{ #category : #accessing }
CBTransformCriticAction class >> title [
	^ 'Transform'
]
