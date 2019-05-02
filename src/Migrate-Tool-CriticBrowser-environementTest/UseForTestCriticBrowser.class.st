Class {
	#name : #UseForTestCriticBrowser,
	#superclass : #Object,
	#instVars : [
		'B',
		'A'
	],
	#category : #'Migrate-Tool-CriticBrowser-environementTest'
}

{ #category : #accessing }
UseForTestCriticBrowser >> a [
	^ A
]

{ #category : #accessing }
UseForTestCriticBrowser >> a: anObject [
	A := anObject
]

{ #category : #accessing }
UseForTestCriticBrowser >> b [
	^ B
]

{ #category : #accessing }
UseForTestCriticBrowser >> b: anObject [
	B := anObject
]

{ #category : #'as yet unclassified' }
UseForTestCriticBrowser >> stringUseInsteadOfStream [
	^ 'abc' , 'def' , 'ghi'
]
