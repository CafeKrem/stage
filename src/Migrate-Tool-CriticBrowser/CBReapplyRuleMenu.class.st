Class {
	#name : #CBReapplyRuleMenu,
	#superclass : #CBGroupARuleMenu,
	#category : #'Migrate-Tool-CriticBrowser-data-menu'
}

{ #category : #accessing }
CBReapplyRuleMenu class >> icon [ 
	^ nil
]

{ #category : #accessing }
CBReapplyRuleMenu class >> itemPriority [ 
	^ 10 
]

{ #category : #accessing }
CBReapplyRuleMenu class >> runOn: aCriticBrowser [
	^ aCriticBrowser selectedRule
		ifNotNil: [ :aRule | 
			aRule isComposite
				ifTrue: [ aRule rules do: [ :each | aCriticBrowser reapplyRule: each ] ]
				ifFalse: [ aCriticBrowser reapplyRule: aRule ] ]
]

{ #category : #accessing }
CBReapplyRuleMenu class >> title [ 
	^ 'Reapply this rule'
]
