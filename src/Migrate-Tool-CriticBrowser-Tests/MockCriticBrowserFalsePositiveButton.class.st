Class {
	#name : #MockCriticBrowserFalsePositiveButton,
	#superclass : #FusionSingleCodeCriticResultList2AndCriticBrowser2,
	#instVars : [
		'messageCall'
	],
	#category : #'Migrate-Tool-CriticBrowser-Tests-MockCriticBrowser'
}

{ #category : #initialize }
MockCriticBrowserFalsePositiveButton >> initialize [ 
	super initialize.
	messageCall := 0.
]

{ #category : #private }
MockCriticBrowserFalsePositiveButton >> markAsFalsePositiveForCurrentRule: anItem [
	messageCall := messageCall + 1
]

{ #category : #accessing }
MockCriticBrowserFalsePositiveButton >> messageCall [
	^ messageCall
]
