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

{ #category : #update }
MockSycRefactoringPreview >> generateChanges [
	"do nothing"
	1 halt.
]

{ #category : #accessing }
MockSycRefactoringPreview >> selectedRefactorings [
	^ selectedRefactorings
]

{ #category : #update }
MockSycRefactoringPreview >> updateTablePresenter [
	| mockTreeTableItem2 mockTreeTableItem3 mockTreeTableItem1 |
	1 halt.
	mockTreeTableItem1 := MockTreeTableItem new.
	mockTreeTableItem2 := MockTreeTableItem new.
	mockTreeTableItem3 := MockTreeTableItem new.
	table
		items:
			{mockTreeTableItem1.
			mockTreeTableItem2.
			mockTreeTableItem3}
]
