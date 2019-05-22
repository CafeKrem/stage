Class {
	#name : #SycMockRBRefactoring,
	#superclass : #Object,
	#instVars : [
		'class'
	],
	#category : #'Stage-Tests-util'
}

{ #category : #accessing }
SycMockRBRefactoring >> environment: anEnvironement [
	^ self
]

{ #category : #accessing }
SycMockRBRefactoring >> model [
	^ self
]

{ #category : #accessing }
SycMockRBRefactoring >> primitiveExecute [ 
	^self 
]

{ #category : #accessing }
SycMockRBRefactoring >> whatToDisplayIn: aBrowser [ 
	^ aBrowser scopeDropList selectedItem content
	
]
