"
this class is an window for Method name edition 

TO DO:

HOW TO RUN 
	MethodNameEditor2 openOn: (Object >> #assert:).


Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	acceptButton:		<Object>
	argumentsList:		<Object>
	argumentsSelector:		<Object>
	cancelButton:		<Object>
	downButton:		<Object>
	previewFinalResult:		<Object>
	previewLabel:		<Object>
	selectorInput:		<Object>
	selectorLabel:		<Object>
	upButton:		<Object>


    Implementation Points
"
Class {
	#name : #MethodNameEditor2,
	#superclass : #ComposablePresenter,
	#instVars : [
		'selectorInput',
		'argumentsList',
		'previewResult',
		'upButton',
		'downButton',
		'acceptButton',
		'cancelButton',
		'compiledMethod'
	],
	#category : #Stage
}

{ #category : #specs }
MethodNameEditor2 class >> defaultSpec [
	^ SpecBoxLayout newVertical
		add:
			(SpecBoxLayout newHorizontal
				add: 'Selector' withConstraints: [ :aConstraints | aConstraints width: 100 ];
				add: #selectorInput withConstraints: [ :aConstraints | aConstraints width: 200 ];
				yourself);
		add:
			(SpecBoxLayout newHorizontal
				add: 'Arguments' withConstraints: [ :aConstraints | aConstraints width: 100 ];
				add: #argumentsList withConstraints: [ :aConstraints | aConstraints width: 200 ];
				add:
					(SpecBoxLayout newVertical
						add: #upButton withConstraints: [ :aConstraints | 
							aConstraints
								width: 30;
								expand: false;
								height: 30 ];
						add: #downButton withConstraints: [ :aConstraints | 
							aConstraints
								width: self buttonHeight;
								height: self buttonHeight ];
						yourself);
				yourself);
		add:
			(SpecBoxLayout newHorizontal
				add: 'Preview' withConstraints: [ :aConstraints | aConstraints width: 100 ];
				add: #previewResult withConstraints: [ :aConstraints | aConstraints width: 200  ];
				add:
					(SpecBoxLayout newHorizontal
						add: #acceptButton withConstraints: [ :aConstraints | 
							aConstraints
								width: self buttonHeight;
								height: self buttonHeight ];
						add: #cancelButton withConstraints: [ :aConstraints | 
							aConstraints
								width: self buttonHeight;
								height: self buttonHeight ];
						yourself);
				yourself);
		yourself
]

{ #category : #specs }
MethodNameEditor2 class >> openOn: aMethod [
	"
	argument:
		aMethod : it is the method that who want to rename
	return:
		return an instance of MethodNameEditor with selectorInput fill with the argument aString 
		and PreviewLabelFinal
		example:
			MethodNameEditor2 openOn: (Object >> #assert)
			
		"
	^ (self on: aMethod) openWithSpec
]

{ #category : #accessing }
MethodNameEditor2 >> acceptButton [
	^ acceptButton
]

{ #category : #action }
MethodNameEditor2 >> acceptButtonAction [
	self flag: #TODO
]

{ #category : #accessing }
MethodNameEditor2 >> argumentsList [
	^ argumentsList
]

{ #category : #action }
MethodNameEditor2 >> argumentsListAction [
	^ [ | argumentsListSize |
	argumentsListSize := argumentsList items size.
	(argumentsListSize = 1)
		ifTrue: [ upButton disable.
				downButton disable ];
		ifFalse: [ (argumentsList selectionMode selectedIndex = 1)
					ifTrue: [ upButton disable.
							downButton enable ];
					ifFalse: [ (argumentsList selectionMode selectedIndex = argumentsListSize)
								ifTrue: [ upButton enable.
										downButton disable ];
								ifFalse: [ upButton enable.
										downButton enable ] ] ] ]
]

{ #category : #accessing }
MethodNameEditor2 >> cancelButton [
	^ cancelButton
]

{ #category : #action }
MethodNameEditor2 >> cancelButtonAction [
	^ [ self application close  ]
]

{ #category : #accessing }
MethodNameEditor2 >> compiledMethod: aMethod [
	"
	this method is call by openOn  class side method.
	argument:
		* aMethod it's an CompiledMethod like (AClass>>#aMethod)
	return:
		an instance of MethodeNameEditor with widget 
		"
	compiledMethod := aMethod.
]

{ #category : #accessing }
MethodNameEditor2 >> downButton [
	^ downButton
]

{ #category : #action }
MethodNameEditor2 >> downButtonAction [
	^ [ | selectedIndex selectedElement elementBefore |
	selectedIndex := argumentsList selectionMode selectedIndex.
	selectedElement := argumentsList items at: selectedIndex.
	elementBefore := argumentsList items at: selectedIndex + 1.
	argumentsList items at: selectedIndex put: elementBefore.
	argumentsList items at: selectedIndex + 1 put: selectedElement.
	argumentsList selectionMode selectIndex: selectedIndex + 1.
	previewResult
		label:
			(self
				upDateSelector: self selectorInput text
				arguments: argumentsList items) ]
]

{ #category : #'spec-initializer' }
MethodNameEditor2 >> init [
	| argumentsCollection selectorCollection |
	self title: 'method name editor'.
	selectorCollection := compiledMethod selector.
	argumentsCollection := compiledMethod ast arguments
		sorted: #start ascending.
	selectorInput text: selectorCollection.
	argumentsList items: argumentsCollection.	"collect: [ :eachArgument | eachArgument name]"
	previewResult
		label:
			(self
				upDateSelector: selectorCollection
				arguments: argumentsCollection)
]

{ #category : #'spec-initializer' }
MethodNameEditor2 >> initializePresenter [
	"collect: [ :eachArgument | eachArgument name]"
	self init.
	selectorInput whenTextChangedDo: self selectorInputAction.
	argumentsList whenSelectionChangedDo: self argumentsListAction.
	upButton action: self upButtonAction.
	downButton action: self downButtonAction.
	acceptButton action: self acceptButtonAction.
	cancelButton action: self cancelButtonAction
]

{ #category : #'spec-initializer' }
MethodNameEditor2 >> initializeWidgets [
	selectorInput := (self instantiate: TextInputFieldPresenter)
		autoAccept: true;
		yourself.
	argumentsList := self newList
		items: OrderedCollection new;
		yourself.
	previewResult := self newLabel.
	acceptButton := self newButton
		label: 'OK';
		yourself.
	cancelButton := self newButton
		label: 'cancel';
		yourself.
	upButton := self newButton
		label: 'Up';
		disable;
		yourself.
	downButton := self newButton
		label: 'Dn';
		disable;
		yourself
]

{ #category : #accessing }
MethodNameEditor2 >> previewResult [
	^ previewResult
]

{ #category : #accessing }
MethodNameEditor2 >> selectorInput [
	^ selectorInput
]

{ #category : #action }
MethodNameEditor2 >> selectorInputAction [
	^ [ :text | 
	self previewResult
		label: (self upDateSelector: text arguments: self argumentsList items).
	(self previewResult = '(invalid)')
		ifTrue: [ acceptButton disable ];
		ifFalse: [ acceptButton enable ] ]
]

{ #category : #'accessing model' }
MethodNameEditor2 >> setModelBeforeInitialization: aCompiledMethod [
	self compiledMethod: aCompiledMethod
]

{ #category : #accessing }
MethodNameEditor2 >> upButton [
	^ upButton
]

{ #category : #action }
MethodNameEditor2 >> upButtonAction [
	^ [ | selectedIndex selectedElement elementBefore |
	selectedIndex := argumentsList selectionMode selectedIndex.
	selectedElement := argumentsList items at: selectedIndex.
	elementBefore := argumentsList items at: selectedIndex - 1.
	argumentsList items at: selectedIndex put: elementBefore.
	argumentsList items at: selectedIndex - 1 put: selectedElement.
	argumentsList selectionMode selectIndex: selectedIndex - 1.
	previewResult
		label:
			(self
				upDateSelector: self selectorInput text
				arguments: argumentsList items) ]
]

{ #category : #update }
MethodNameEditor2 >> upDateSelector: selectorCollection arguments: argumentsCollection [
	"this method is used to rebuild the preview when text in the selectorInput change and when the argumentsList change 
	example: 
		if we want to rename ARandomClass >> #open:with:
		upDateSelector: #open:with: arguments: #( #something #otherthing  ) 
			return: 'open: something with: otherthing'  
		upDateSelector: #open: arguments: #( #something #otherthing  ) 
			return: '(invalid)' 
		and the same thing with not acceptable method name "
	^ (RBMethodName
		selector: selectorCollection 
		arguments: (argumentsCollection  collect: #name)) methodName
]
