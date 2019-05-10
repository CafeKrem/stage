Class {
	#name : #CBAbstractRuleMenu,
	#superclass : #CBAbstractMenu,
	#category : #'Migrate-Tool-CriticBrowser-data-menu'
}

{ #category : #accessing }
CBAbstractRuleMenu class >> actionsGroup [ 
	^ self allSubclasses sorted: #itemPriority ascending
]

{ #category : #accessing }
CBAbstractRuleMenu class >> actionsMenu [
	
	^ self allSubclasses sorted: #groupPriority ascending
]

{ #category : #accessing }
CBAbstractRuleMenu class >> isAbstract [
	^ self = CBAbstractRuleMenu
]
