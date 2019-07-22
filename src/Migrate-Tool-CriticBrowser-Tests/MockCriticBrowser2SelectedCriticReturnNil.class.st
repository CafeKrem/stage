Class {
	#name : #MockCriticBrowser2SelectedCriticReturnNil,
	#superclass : #Object,
	#instVars : [
		'callFalsePositiveMethod'
	],
	#category : #'Migrate-Tool-CriticBrowser-Tests-Test-cache'
}

{ #category : #accessing }
MockCriticBrowser2SelectedCriticReturnNil >> callFalsePositiveMethod [
	^ callFalsePositiveMethod
]

{ #category : #private }
MockCriticBrowser2SelectedCriticReturnNil >> initialize [
	callFalsePositiveMethod := false.
]

{ #category : #private }
MockCriticBrowser2SelectedCriticReturnNil >> markAsFalsePositiveForCurrentRule: anItem [ 
	callFalsePositiveMethod := true.
	
]

{ #category : #accessing }
MockCriticBrowser2SelectedCriticReturnNil >> selectedCritic [
	^ nil
]
