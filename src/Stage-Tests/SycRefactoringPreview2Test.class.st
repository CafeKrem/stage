"
A SycRefactoringPreview2Test is a test class for testing the behavior of SycRefactoringPreview2
"
Class {
	#name : #SycRefactoringPreview2Test,
	#superclass : #TestCase,
	#instVars : [
		'sycRefactoringPreview'
	],
	#category : #'Stage-Tests-test'
}

{ #category : #setup }
SycRefactoringPreview2Test >> initializeForInitializeTest [
	| scopeClass scopePackage mockRBMethodRefactoringPreview |
	mockRBMethodRefactoringPreview := MockRBRenameMethodRefactoring new.
	scopePackage := ClyPackageScope
		of: 'Stage' asPackage
		in: ClyNavigationEnvironment currentImage.
	scopeClass := ClyClassScope
		of: 'SycRefactoringPreview'
		in: ClyNavigationEnvironment currentImage.
	sycRefactoringPreview := MockSycRefactoringPreview
		for: {MockRBRenameMethodRefactoring new}
		scopes:
			{scopePackage.
			scopeClass}
]

{ #category : #running }
SycRefactoringPreview2Test >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	super setUp.
	sycRefactoringPreview := MockSycRefactoringPreview new.
]

{ #category : #tests }
SycRefactoringPreview2Test >> testBuilDiffMethod [
	self assert: false.
]

{ #category : #tests }
SycRefactoringPreview2Test >> testDoubleClickAnTableItemShouldChangeTheValueAssociateToKey [
	| mockTreeTableItem1 mockTreeTableItem2 mockTreeTableItem3 |
	mockTreeTableItem1 := MockTreeTableItem new.
	mockTreeTableItem2 := MockTreeTableItem new.
	mockTreeTableItem3 := MockTreeTableItem new.
	sycRefactoringPreview table
		items:
			{mockTreeTableItem1.
			mockTreeTableItem2.
			mockTreeTableItem3}.
	sycRefactoringPreview selectedCheckBoxs
		at: mockTreeTableItem3
		put: true.
	sycRefactoringPreview table selectIndex: 3.
	sycRefactoringPreview table doActivateAtIndex: 3.
	self
		deny: (sycRefactoringPreview selectedCheckBoxs at: mockTreeTableItem3)
]

{ #category : #tests }
SycRefactoringPreview2Test >> testDropListChangeShouldChangeTableItems [
	| tableItemBeforeChangeDropList tableItemAfterChangeDropList className |
	self initializeForInitializeTest.
	tableItemBeforeChangeDropList := sycRefactoringPreview table items.
	sycRefactoringPreview scopeDropList selectIndex: 2.
	className := sycRefactoringPreview table items at: 1.
	self
		assert:
			(sycRefactoringPreview table items
				allSatisfy: [ :element | element class = className ])
]

{ #category : #'initialize-test' }
SycRefactoringPreview2Test >> testInitAllCheckBoxDictionarySetTrue [
	self initializeForInitializeTest.
	self
		assert:
			(sycRefactoringPreview selectedCheckBoxs
				allSatisfy: [ :key | sycRefactoringPreview selectedCheckBoxs at: key ])
]

{ #category : #'initialize-test' }
SycRefactoringPreview2Test >> testInitTextAreaShouldEmpty [
	self initializeForInitializeTest.
	self assert: sycRefactoringPreview textArea text equals: ''.
]

{ #category : #tests }
SycRefactoringPreview2Test >> testSelectAnElementTreeTablePresenterShouldSendBuilDiffForToTextArea [
	| mockTreeTableItem1 mockTreeTableItem2 mockTreeTableItem3 |
	mockTreeTableItem1 := MockTreeTableItem new.
	mockTreeTableItem2 := MockTreeTableItem new.
	mockTreeTableItem3 := MockTreeTableItem new.
	sycRefactoringPreview table
		items:
			{mockTreeTableItem1.
			mockTreeTableItem2.
			mockTreeTableItem3}.
	self assert: sycRefactoringPreview textArea text isEmpty.
	sycRefactoringPreview table selectIndex: 2.
	self assert: sycRefactoringPreview textArea text equals: 'useForTest'
]
