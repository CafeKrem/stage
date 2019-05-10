Class {
	#name : #CBGroupACriticMenu,
	#superclass : #CBAbstractCriticMenu,
	#category : #'Migrate-Tool-CriticBrowser-data-menu'
}

{ #category : #accessing }
CBGroupACriticMenu class >> groupPriority [ 
	^ 1
]

{ #category : #testing }
CBGroupACriticMenu class >> isAbstract [ 
	^ self = CBGroupACriticMenu
]
