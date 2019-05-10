Class {
	#name : #CBGroupMarkItemCriticMenu,
	#superclass : #CBAbstractCriticMenu,
	#category : #'Migrate-Tool-CriticBrowser-data-menu'
}

{ #category : #accessing }
CBGroupMarkItemCriticMenu class >> groupPriority [ 
	^ 20
]

{ #category : #accessing }
CBGroupMarkItemCriticMenu class >> icon [ 
	^ nil
]

{ #category : #testing }
CBGroupMarkItemCriticMenu class >> isAbstract [ 
	^ self = CBGroupMarkItemCriticMenu
]
