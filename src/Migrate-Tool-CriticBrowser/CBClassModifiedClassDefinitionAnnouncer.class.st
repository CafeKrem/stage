Class {
	#name : #CBClassModifiedClassDefinitionAnnouncer,
	#superclass : #CBAbstractAnnouncer,
	#category : #'Migrate-Tool-CriticBrowser-data-announcer'
}

{ #category : #accessing }
CBClassModifiedClassDefinitionAnnouncer >> runOn: aCriticBrowser [
	criticBrowser := aCriticBrowser.
	SystemAnnouncer uniqueInstance weak
		when: ClassModifiedClassDefinition 
		send: #handleClassModified:
		to: self
]
