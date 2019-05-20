Class {
	#name : #MockSycRefactoringPreview,
	#superclass : #SycRefactoringPreview2,
	#category : #'Stage-Tests-util'
}

{ #category : #private }
MockSycRefactoringPreview >> buildDiffFor: aChange [
	"i override this method bacause i just want to test if the transmission use this method"
	^ 'useForTest'
]

{ #category : #accessing }
MockSycRefactoringPreview >> selectedCheckBoxs [
	^ selectedCheckBoxs
]
