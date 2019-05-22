Class {
	#name : #SycRefactoringPreviewMockCommand,
	#superclass : #Object,
	#category : #'Stage-Tests-util'
}

{ #category : #converting }
SycRefactoringPreviewMockCommand >> asRefactorings [ 
	^ { SycMockRBRefactoring new  } 
]
