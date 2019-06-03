Class {
	#name : #MockCriticBrowser,
	#superclass : #Object,
	#instVars : [
		'callFalsePositiveMethod',
		'callInformMethod'
	],
	#category : #'Migrate-Tool-CriticBrowser-Tests-Test-cache'
}

{ #category : #accessing }
MockCriticBrowser >> callFalsePositiveMethod [
	^ callFalsePositiveMethod
]

{ #category : #private }
MockCriticBrowser >> initialize [
	callFalsePositiveMethod := false.
]

{ #category : #private }
MockCriticBrowser >> markAsFalsePositiveForCurrentRule: anItem [ 
	callFalsePositiveMethod := true.
	
]

{ #category : #accessing }
MockCriticBrowser >> selectedCritic [
	^ self 
]
