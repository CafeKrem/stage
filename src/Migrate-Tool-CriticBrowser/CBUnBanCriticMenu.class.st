Class {
	#name : #CBUnBanCriticMenu,
	#superclass : #CBGroupBCriticMenu,
	#category : #'Migrate-Tool-CriticBrowser-data'
}

{ #category : #accessing }
CBUnBanCriticMenu class >> icon [ 
	^ nil
]

{ #category : #accessing }
CBUnBanCriticMenu class >> itemPriority [ 
	^ 10
]

{ #category : #accessing }
CBUnBanCriticMenu class >> runOn: aCriticBrowser [
	aCriticBrowser selectedRule
		ifNotNil: [ :rule | 
			rule leaves
				do: [ :r | 
					aCriticBrowser allPackages
						do:
							[ :package | aCriticBrowser removeFalsePositiveRule: r forPackage: package ] ] ]
]

{ #category : #accessing }
CBUnBanCriticMenu class >> title [ 
	^ 'Unban from selected packages'
]
