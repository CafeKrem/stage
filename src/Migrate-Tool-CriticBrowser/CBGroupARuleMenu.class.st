Class {
	#name : #CBGroupARuleMenu,
	#superclass : #CBAbstractRuleMenu,
	#category : #'Migrate-Tool-CriticBrowser-data-menu'
}

{ #category : #accessing }
CBGroupARuleMenu class >> groupPriority [
	^ 1
]

{ #category : #accessing }
CBGroupARuleMenu class >> isAbstract [
	^ self = CBGroupARuleMenu 
]
