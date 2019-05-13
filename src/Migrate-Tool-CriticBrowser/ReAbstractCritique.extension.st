Extension { #name : #ReAbstractCritique }

{ #category : #'*Migrate-Tool-CriticBrowser' }
ReAbstractCritique >> actions [ 

	| actions |
	
	actions := OrderedCollection new: 3.

	actions add: (RePropertyAction new
			icon: (self iconNamed: #smallQuestionIcon);
			description: 'View rationale behind the rule';
			action: [ :crit |
				self popDescriptionUp.
				ReSystemAnnouncer uniqueInstance
					notifyCritique: self
					descriptionViewedFor: self sourceAnchor entity ];
			yourself).
	
	self providesChange ifTrue: [ 
		actions add: (RePropertyAction new
			icon: (self iconNamed: #repairIcon);
			description: 'Automatically resolve the issue';
			action: [ :crit |
				| changesBrowser |
				
				changesBrowser := (ChangesBrowser changes: { self change })
					extent: 500@400;
					setModal: SystemWindow topWindow;
					yourself.
					
				changesBrowser openDialogWithSpec
					okAction: [ changesBrowser accept ];
					centered ];
			yourself) ].
	
	actions add: (RePropertyAction new
			icon: (self iconNamed: #smallCancelIcon);
			description: 'Ban this rule';
			action: [ :crit | self guidedBan ];
			yourself).

	^ actions
]
