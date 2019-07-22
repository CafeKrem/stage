Class {
	#name : #CBBrowseCriticMenu,
	#superclass : #CmCommand,
	#category : #'Migrate-Tool-CriticBrowser-data-menu-critic'
}

{ #category : #hooks }
CBBrowseCriticMenu >> execute [
	"Execute the actions that should be done by the command.
	 This method expect that the context has been put in #context inst. var. if any context is relevant."

	CBBrowseCriticAction runOn: self context
]

{ #category : #initialization }
CBBrowseCriticMenu >> initialize [
	super initialize.
	self
		basicName: 'browse';
		basicDescription: 'open a browser on this rule'
]
