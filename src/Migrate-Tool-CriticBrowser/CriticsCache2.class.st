Class {
	#name : #CriticsCache2,
	#superclass : #Object,
	#instVars : [
		'critics',
		'toDos',
		'falsePositives',
		'checker',
		'browser',
		'falsePositiveRules',
		'falsePositiveClasses',
		'packages',
		'change'
	],
	#category : #'Migrate-Tool-CriticBrowser'
}

{ #category : #private }
CriticsCache2 >> addAllCriticToFalsePositive: aCollectionOfCritic forRule: aRule on: aManifestBuilder [

	| ruleId versionId  criticss |
	criticss := aCollectionOfCritic 
						reject: [ :c | falsePositiveClasses includes: c criticTheNonMetaclassClass ].
	ruleId := aRule class uniqueIdentifierName.
	versionId := aRule class identifierMinorVersionNumber.
	(aManifestBuilder hasFalsePositiveOf: ruleId version: versionId) 
		ifFalse: [ aManifestBuilder installFalsePositiveOf: ruleId version: versionId ].		
	 aManifestBuilder addAllFalsePositive: criticss of: ruleId version: versionId

	
]

{ #category : #private }
CriticsCache2 >> addAllCriticToToDo: aCollectionOfCritic forRule: aRule on: aManifestBuilder [

	| ruleId versionId  |
	ruleId := aRule class uniqueIdentifierName.
	versionId := aRule class identifierMinorVersionNumber.
	(aManifestBuilder hasToDoOf: ruleId version: versionId) 
		ifFalse: [ aManifestBuilder installToDoOf: ruleId version: versionId ].		
	 aManifestBuilder addAllToDo: aCollectionOfCritic of: ruleId version: versionId

	
]

{ #category : #'add/remove' }
CriticsCache2 >> addCritic: aCritic forRule: aRule [

	(critics includesKey: aRule) 
		ifFalse: [ critics at:aRule put: IdentitySet new ].
	(critics at: aRule) add: aCritic. 
	self updateBrowser
]

{ #category : #'add/remove' }
CriticsCache2 >> addFalsePositive: aCritic forRule: aRule [
	(falsePositives includesKey: aRule) 
		ifFalse: [ falsePositives at: aRule put: IdentitySet new ].
	(falsePositives at: aRule) add: aCritic. 
	self updateBrowser 	
]

{ #category : #'add/remove' }
CriticsCache2 >> addFalsePositiveClass: aClass [ 
	 
	| fp |
	self flag: #testIt.
	"this method isn't test i only test method use"
	falsePositiveClasses add: aClass instanceSide. 
	critics keysAndValuesDo: [ :rule :criticss |
		fp := criticss select: [ :critic | aClass = critic criticTheNonMetaclassClass ].
		fp do: [ :each | self addFalsePositive: each forRule: rule] ].
	self updateBrowser	

]

{ #category : #'add/remove' }
CriticsCache2 >> addFalsePositiveRule: aRule forPackage: aPackage [
	| fp |
	(falsePositiveRules includesKey: aPackage)
		ifFalse: [ falsePositiveRules at: aPackage put: Set new ].
	(falsePositiveRules at: aPackage)
		add: aRule class uniqueIdentifierName.
	fp := (critics at: aRule ifAbsent: [ ^ self ])
		select:
			[ :aCritic | (self packageOf: aCritic) package name = aPackage packageName ].
	fp do: [ :aCritic | self addFalsePositive: aCritic forRule: aRule ]
]

{ #category : #'add/remove' }
CriticsCache2 >> addToDo: aCritic forRule: aRule [

	(toDos includesKey: aRule) 
		ifFalse: [ toDos at:aRule put: IdentitySet new ].
	(toDos at: aRule) add: aCritic. 
	self updateBrowser
]

{ #category : #accessing }
CriticsCache2 >> browser: aCodeCritiicBrowser [
	browser := aCodeCritiicBrowser 
]

{ #category : #private }
CriticsCache2 >> builderManifestClass [
	^ TheManifestBuilder
]

{ #category : #accessing }
CriticsCache2 >> cacheChange [
	^ change
]

{ #category : #private }
CriticsCache2 >> cacheChanged [ 
	change := true
]

{ #category : #private }
CriticsCache2 >> cacheNotChanged [ 
	change := false
]

{ #category : #'as yet unclassified' }
CriticsCache2 >> checker [
	^ checker
]

{ #category : #accessing }
CriticsCache2 >> checker: aSmallLintChercker [
	checker := aSmallLintChercker
]

{ #category : #accessing }
CriticsCache2 >> critics [
	^ critics
]

{ #category : #protocol }
CriticsCache2 >> criticsOf: aRule [

	aRule ifNil: [ ^ {} ].	
	^ aRule isComposite
		ifTrue: [ aRule rules flatCollect: [ :rule | self criticsOf: rule ]]
		ifFalse: [ critics at: aRule ifAbsent: [ {} ]]
]

{ #category : #protocol }
CriticsCache2 >> falsePositiveOf: aRule [
	
	aRule ifNil: [ ^ {}].
	^ aRule isComposite
		ifTrue: [ aRule rules flatCollect: [ :rule | self falsePositiveOf: rule ]]
		ifFalse: [ falsePositives at: aRule ifAbsent: [ {} ]]
	
	
]

{ #category : #accessing }
CriticsCache2 >> falsePositiveRules [
	^ falsePositiveRules
]

{ #category : #accessing }
CriticsCache2 >> falsePositives [
	^ falsePositives
]

{ #category : #initialization }
CriticsCache2 >> initCache [
	checker rule
		do: [ :rule | 
			falsePositives
				at: rule
				put: (IdentitySet newFrom: (checker falsePositiveOf: rule)).
			toDos at: rule put: (IdentitySet newFrom: (checker toDoOf: rule)).
			critics
				at: rule
				put: (IdentitySet newFrom: (checker criticsOf: rule)) ].
	packages
		do: [ :package | 
			falsePositiveRules
				at: package
				put: (checker rejectRulesOf: package) asSet.
			falsePositiveClasses
				addAll: (checker rejectClassesOf: package) asIdentitySet ]
]

{ #category : #initialization }
CriticsCache2 >> initialize [
	
	super initialize.
	falsePositives := Dictionary new.
	toDos := Dictionary new.	
	critics := Dictionary new.	
	falsePositiveRules := Dictionary new.
	falsePositiveClasses := IdentitySet new.
	change := false	

]

{ #category : #testing }
CriticsCache2 >> isFalsePositive: aCritic forRule: aRule [
	^ (self falsePositiveOf: aRule) includes: aCritic
]

{ #category : #testing }
CriticsCache2 >> isToDo: aCritic forRule: aRule [
	^ (self toDosOf: aRule) includes: aCritic
]

{ #category : #'add/remove' }
CriticsCache2 >> itemRemoved: anItem [
	"anItem : can be a method a class (where is the critics)"
	{ critics . toDos . falsePositives } do: [ :ruleDict |
		ruleDict valuesDo: [ :crits |
			crits removeAllSuchThat: [ :crit |
				crit sourceAnchor entity = anItem ]]]
	
]

{ #category : #private }
CriticsCache2 >> logFalsePositiveClassInManifest [
	| manifestBuilder |
	packages
		do: [ :package | 
			manifestBuilder := self builderManifestClass ofPackageNamed: package packageName.
			manifestBuilder rejectClasses \ falsePositiveClasses do: [ :cl | manifestBuilder removeRejectClass: cl ].
			falsePositiveClasses \ manifestBuilder rejectClasses do: [ :cl | manifestBuilder addRejectClass: cl ] ]
]

{ #category : #private }
CriticsCache2 >> logFalsePositiveInManifest [
	| removeFp addFp |
	falsePositives
		keysAndValuesDo: [ :rule :criticss | 
			removeFp := (checker falsePositiveOf: rule) \ criticss.
			addFp := criticss \ (checker falsePositiveOf: rule).
			(removeFp groupedBy: [ :each | self builderManifestClass of: each ])
				keysAndValuesDo: [ :manifestBuilder :value | self removeAllCriticToFalsePositive: value forRule: rule on: manifestBuilder ].
			(addFp groupedBy: [ :each | self builderManifestClass of: each ])
				keysAndValuesDo: [ :manifestBuilder :value | 
					(manifestBuilder rejectRules includes: rule class uniqueIdentifierName)
						ifFalse: [ self addAllCriticToFalsePositive: value forRule: rule on: manifestBuilder ] ] ]
]

{ #category : #private }
CriticsCache2 >> logFalsePositiveRulesInManifest [
	| manifestBuilder |
	falsePositiveRules
		keysAndValuesDo: [:package :rules | 
			manifestBuilder := self builderManifestClass ofPackageNamed: package packageName.
			manifestBuilder rejectRules \ rules do: [ :rule | manifestBuilder removeRejectRule: rule ].
			rules \ manifestBuilder rejectRules do: [ :rule | manifestBuilder addRejectRule: rule ]]
]

{ #category : #protocol }
CriticsCache2 >> logInManifest [

	self cacheChange 
		ifFalse: [^ self].
	self logFalsePositiveRulesInManifest.
	self logFalsePositiveClassInManifest.
	self logFalsePositiveInManifest.
	self logToDosInManifest.
	self cacheNotChanged. 		
	self initCache
	
]

{ #category : #private }
CriticsCache2 >> logToDosInManifest [
	| removeFp addFp |
	toDos
		keysAndValuesDo: [ :rule :criticss | 
			removeFp := (checker toDoOf: rule) \ criticss.
			addFp := criticss \ (checker toDoOf: rule).
			(removeFp groupedBy: [ :each | self builderManifestClass of: each ])
				keysAndValuesDo: [ :manifestBuilder :value | self removeAllCriticToToDo: value forRule: rule on: manifestBuilder ].
			(addFp groupedBy: [ :each | self builderManifestClass of: each ])
				keysAndValuesDo: [ :manifestBuilder :value | 
					(manifestBuilder rejectRules includes: rule class uniqueIdentifierName)
						ifFalse: [ self addAllCriticToToDo: value forRule: rule on: manifestBuilder ] ] ]
]

{ #category : #private }
CriticsCache2 >> packageOf: aCritc [
	^ aCritc sourceAnchor entity package
]

{ #category : #accessing }
CriticsCache2 >> packages: aPackageEnv [
	
	packages := aPackageEnv packages
]

{ #category : #private }
CriticsCache2 >> removeAllCriticToFalsePositive: aCollectionOfCritic forRule: aRule on: aManifestBuilder [

	| ruleId versionId |
	ruleId := aRule class uniqueIdentifierName.
	versionId := aRule class identifierMinorVersionNumber.
	(aManifestBuilder hasFalsePositiveOf: ruleId version: versionId) 
		ifTrue: [ aManifestBuilder removeAllFalsePositive: aCollectionOfCritic of: ruleId version: versionId ]	
	 

	
]

{ #category : #private }
CriticsCache2 >> removeAllCriticToToDo: aCollectionOfCritic forRule: aRule on: aManifestBuilder [

	| ruleId versionId |
	ruleId := aRule class uniqueIdentifierName.
	versionId := aRule class identifierMinorVersionNumber.
	(aManifestBuilder hasToDoOf: ruleId version: versionId) 
		ifTrue: [ aManifestBuilder removeAllToDo: aCollectionOfCritic of: ruleId version: versionId ]		
	

	
]

{ #category : #'add/remove' }
CriticsCache2 >> removeCritic: aCritic forRule: aRule [

	(critics includesKey: aRule) 
		ifFalse: [^ self].
	(critics at: aRule) remove: aCritic ifAbsent: [^ self].
	self updateBrowser
	
]

{ #category : #'add/remove' }
CriticsCache2 >> removeFalsePositive: aCritic forRule: aRule [
	(falsePositives includesKey: aRule) 
		ifFalse: [^ self ].
	[ (falsePositiveClasses includes: aCritic sourceAnchor entity criticTheNonMetaclassClass) 
			ifTrue: [^ self] ]
		on: MessageNotUnderstood 
		do: [ ^ self "#criticTheNonMetaclassClass makes no sense on a Package, ignore"].
	(falsePositives at: aRule) remove: aCritic ifAbsent: [^ self].
	self updateBrowser
]

{ #category : #'add/remove' }
CriticsCache2 >> removeFalsePositiveClass: aClass [
	
	| fp |
	falsePositiveClasses remove: aClass ifAbsent: [^ self]. 
	critics keysAndValuesDo: [ :rule :criticss |
		fp := criticss select: [ :critic | aClass = critic criticTheNonMetaclassClass].
		fp do: [ :each | self removeFalsePositive: each forRule: rule ]]
]

{ #category : #'add/remove' }
CriticsCache2 >> removeFalsePositiveRule: aRule forPackage: aPackage [
	| fp |
	(falsePositiveRules includesKey: aPackage)
		ifFalse: [ ^ self ].
	(falsePositiveRules at: aPackage)
		remove: aRule class uniqueIdentifierName
		ifAbsent: [ ^ self ].
	fp := (critics at: aRule ifAbsent: [ ^ self ])
		select: [ :c | 
			(self packageOf: c) package name = aPackage packageName
				and: [ (falsePositiveClasses
						includes: c sourceAnchor entity criticTheNonMetaclassClass) not ] ].
	fp do: [ :c | self removeFalsePositive: c forRule: aRule ].
	self updateBrowser
]

{ #category : #'add/remove' }
CriticsCache2 >> removeRule: aRule [

	{ critics . toDos . falsePositives } do: [ :ruleDict |
		ruleDict removeKey: aRule ]
]

{ #category : #'add/remove' }
CriticsCache2 >> removeToDo: aCritic forRule: aRule [
	(toDos includesKey: aRule)
		ifFalse: [ ^ self ].
	(toDos at: aRule) remove: aCritic ifAbsent: [ ^ self ].
	self updateBrowser
]

{ #category : #protocol }
CriticsCache2 >> replaceAll: oldMethod by: newMethod [

	critics valuesDo: [:each |  
		(each includes: oldMethod)
			ifTrue: [
				each remove: oldMethod.
				each add: newMethod ]].
		
	falsePositives valuesDo: [:each |  
		(each includes: oldMethod)
			ifTrue: [
				each remove: oldMethod.
				each add: newMethod ]].

	toDos valuesDo: [:each |  
		(each includes: oldMethod)
			ifTrue: [
				each remove: oldMethod.
				each add: newMethod ]]
	
]

{ #category : #accessing }
CriticsCache2 >> toDos [
	^ toDos
]

{ #category : #protocol }
CriticsCache2 >> toDosOf: aRule [

	aRule ifNil: [ ^{} ].
	^ aRule isComposite
		ifTrue: [ aRule rules flatCollect: [:rule | self toDosOf: rule ]]
		ifFalse: [toDos at: aRule ifAbsent: [ {} ]]
]

{ #category : #private }
CriticsCache2 >> updateBrowser [

	self cacheChanged.
	browser updateTree 
]
