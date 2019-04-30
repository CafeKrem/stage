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
	aCriticBrowser selectedItems
		ifNotNil: [ :items | 
			items
				do: [ :critic | "displayingProgress: [ :criti c |  ]" critic change execute ] ]
		ifNil: [ self inform: 'i don ' , $' , 't known how  ' ]
]

{ #category : #accessing }
CBTransformCriticAction class >> title [
	^ 'Transform'
]
