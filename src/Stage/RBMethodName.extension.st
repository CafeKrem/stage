Extension { #name : #RBMethodName }

{ #category : #'*Stage' }
RBMethodName >> methodName [
	^ String streamContents: [ :s | self printOn: s ]
]
