Class {
	#name : #CBReapplyCriticMenu,
	#superclass : #CBGroupACriticMenu,
	#category : #'Migrate-Tool-CriticBrowser-data'
}

{ #category : #accessing }
CBReapplyCriticMenu class >> icon [ 
	^ nil
]

{ #category : #accessing }
CBReapplyCriticMenu class >> itemPriority [ 
	^ 10 
]

{ #category : #accessing }
CBReapplyCriticMenu class >> runOn: aCriticBrowser [
	^ aCriticBrowser selectedRule
		ifNotNil: [ :aRule | 
			aRule content isComposite
				ifTrue:
					[ aRule content rules do: [ :each | aCriticBrowser reapplyRule: each ] ]
				ifFalse: [ aCriticBrowser reapplyRule: aRule content ] ]
]

{ #category : #accessing }
CBReapplyCriticMenu class >> title [ 
	^ 'Reapply this rule'
]
