Class {
	#name : #CBClassAddedAnnouncer,
	#superclass : #CBAbstractAnnouncer,
	#category : #'Migrate-Tool-CriticBrowser-data-announcer'
}

{ #category : #'announcement handling' }
CBClassAddedAnnouncer class >> classAdded: aClass [
	| rules |
	(criticBrowser environement definesClass: aClass)
		ifFalse: [ ^ self ].
	rules := self allRules.
	criticBrowser checker
		resetResult;
		checkClass: aClass.
	rules
		do: [ :rule | 
			(criticBrowser checker criticsOf: rule)
				do: [ :crit | criticBrowser cache addCritic: crit forRule: rule ].
			(criticBrowser checker falsePositiveOf: rule)
				do:
					[ :crit | criticBrowser cache addFalsePositive: crit forRule: rule ].
			(criticBrowser checker toDoOf: rule)
				do: [ :crit | criticBrowser cache addToDo: crit forRule: rule ] ].
	criticBrowser cache updateBrowser
]

{ #category : #'announcement handling' }
CBClassAddedAnnouncer class >> handleClassAdded: anAnnouncement [
	self classAdded: anAnnouncement classAdded
]

{ #category : #accessing }
CBClassAddedAnnouncer class >> runOn: aCriticBrowser [
	criticBrowser := aCriticBrowser.
	SystemAnnouncer uniqueInstance weak when: ClassAdded send: #handleClassAdded: to: self.
]
