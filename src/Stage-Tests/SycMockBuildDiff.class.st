Class {
	#name : #SycMockBuildDiff,
	#superclass : #Object,
	#instVars : [
		'oldVersionTextToDisplay',
		'textToDisplay'
	],
	#category : #'Stage-Tests-util'
}

{ #category : #'as yet unclassified' }
SycMockBuildDiff class >> oldVersionTextToDisplay: oldText textToDisplay: newText [
	^ self new
		oldVersionTextToDisplay: oldText;
		textToDisplay: newText;
		yourself
]

{ #category : #accessing }
SycMockBuildDiff >> oldVersionTextToDisplay [
	^ oldVersionTextToDisplay
]

{ #category : #accessing }
SycMockBuildDiff >> oldVersionTextToDisplay: anObject [
	oldVersionTextToDisplay := anObject
]

{ #category : #accessing }
SycMockBuildDiff >> textToDisplay [
	^ textToDisplay
]

{ #category : #accessing }
SycMockBuildDiff >> textToDisplay: anObject [
	textToDisplay := anObject
]
