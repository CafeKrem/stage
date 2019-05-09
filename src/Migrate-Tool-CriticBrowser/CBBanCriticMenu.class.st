Class {
	#name : #CBBanCriticMenu,
	#superclass : #CBGroupBCriticMenu,
	#category : #'Migrate-Tool-CriticBrowser-data'
}

{ #category : #accessing }
CBBanCriticMenu class >> icon [ 
	^ nil 
]

{ #category : #accessing }
CBBanCriticMenu class >> itemPriority [ 
	^ 10
]

{ #category : #accessing }
CBBanCriticMenu class >> runOn: aCriticBrowser [
	^ aCriticBrowser selectedCritic
		ifNotNil: [ :criticsCollection | 
			criticsCollection
				do: [ :critic | 
					aCriticBrowser
						addFalsePositiveRule: aCriticBrowser rule
						forPackage: critic mcWorkingCopy ] ]
]

{ #category : #accessing }
CBBanCriticMenu class >> title [ 
	^ 'Ban from selected packages'
]
