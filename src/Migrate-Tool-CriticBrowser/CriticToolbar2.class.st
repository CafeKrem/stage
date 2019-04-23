"
I am the toolbar for a selected SmallLint Critic in the critic browser.
 
Instance Variable:  
	ruleHolder <NewValueHolder>
 	criticHolder <NewValueHolder>
 	browseModel <ButtonPresenter>
 	falsepositiveModel <ButtonPresenter>
 	transformModel <ButtonPresenter>

"
Class {
	#name : #CriticToolbar2,
	#superclass : #ComposablePresenter,
	#instVars : [
		'ruleHolder',
		'criticHolder',
		'browseModel',
		'falsepositiveModel',
		'transformModel'
	],
	#category : #'Migrate-Tool-CriticBrowser'
}

{ #category : #specs }
CriticToolbar2 class >> defaultSpec [
	<spec>
	"don't forget to add with by user "
	^ SpecBoxLayout newHorizontal 
		add: #browseModel  ;
		add: #transformModel ;
		add: #falsepositiveModel ;
		yourself
]

{ #category : #examples }
CriticToolbar2 class >> main [ 
<example>
	^self new openWithSpec.
]

{ #category : #private }
CriticToolbar2 >> browseCritic [

	criticHolder value ifNotNil: [ :elem | elem sourceAnchor entity browse ] 
]

{ #category : #accessing }
CriticToolbar2 >> browseModel [

	^ browseModel
]

{ #category : #api }
CriticToolbar2 >> critic: aCritic [

	criticHolder value: aCritic.
	transformModel enabled: (aCritic isNotNil and: [ aCritic providesChange ])
]

{ #category : #accessing }
CriticToolbar2 >> falsepositiveModel [

	^ falsepositiveModel
]

{ #category : #initialization }
CriticToolbar2 >> initialize [

	super initialize.
	criticHolder := nil asValueHolder.
	ruleHolder := nil asValueHolder.
	self registerForChanges
]

{ #category : #initialization }
CriticToolbar2 >> initializePresenter [
	browseModel action: [ self browseCritic ].
	transformModel action: [ self transformCritic ].
	"falsepositiveModel action: [ ] define in another class"
]

{ #category : #initialization }
CriticToolbar2 >> initializeWidgets [
	browseModel := self newButton.
	transformModel := self newButton.
	falsepositiveModel := self newButton.
	self setFocusOrder.	
	self setBrowseModel.
	self setTransformModel.
	self setFalsepositiveModel.
	
]

{ #category : #initialization }
CriticToolbar2 >> registerForChanges [

	criticHolder whenChangedDo: [ :contents |
		| boolean |
		boolean := contents notNil.
		browseModel state: (boolean and: [ browseModel enabled ]).
		transformModel state: (boolean and: [ transformModel enabled ]).
		falsepositiveModel state: (boolean and: [ falsepositiveModel enabled ]) 
		]

]

{ #category : #api }
CriticToolbar2 >> rule: aRule [
	
	ruleHolder value: aRule. 
	

]

{ #category : #initialization }
CriticToolbar2 >> setBrowseModel [
	
	browseModel
		state: false;
		label: 'Browse'
	

]

{ #category : #initialization }
CriticToolbar2 >> setFalsepositiveModel [
	
	falsepositiveModel
		state: false;
		label: 'Mark as wrong'
]

{ #category : #initialization }
CriticToolbar2 >> setFocusOrder [

	self focusOrder
		add: browseModel;
		add: transformModel;
		add: falsepositiveModel
		
]

{ #category : #initialization }
CriticToolbar2 >> setTransformModel [
	
	transformModel
		state: false;
		label: 'Transform'
]

{ #category : #private }
CriticToolbar2 >> transformCritic [
	 criticHolder value
		ifNotNil: [:critic | critic change execute ]
	

]

{ #category : #accessing }
CriticToolbar2 >> transformModel [

	^ transformModel
]

{ #category : #initialization }
CriticToolbar2 >> whenFalsePositiveClickedDo: aBlock [

	self falsepositiveModel whenActionPerformedDo: aBlock
]
