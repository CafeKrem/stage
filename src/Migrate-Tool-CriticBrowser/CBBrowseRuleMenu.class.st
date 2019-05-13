"
ts
"
Class {
	#name : #CBBrowseRuleMenu,
	#superclass : #CBGroupARuleMenu,
	#category : #'Migrate-Tool-CriticBrowser-data-menu'
}

{ #category : #accessing }
CBBrowseRuleMenu class >> icon [ 
	^ nil
]

{ #category : #accessing }
CBBrowseRuleMenu class >> itemPriority [ 
	^ 1
]

{ #category : #accessing }
CBBrowseRuleMenu class >> runOn: aCriticBrowser [
	^ aCriticBrowser selectedRule ifNotNil: [ :aRule | aRule browse ]
]

{ #category : #accessing }
CBBrowseRuleMenu class >> title [
	^ 'Browse rule'
]
