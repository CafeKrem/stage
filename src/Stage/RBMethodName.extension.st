Extension { #name : #RBMethodName }

{ #category : #'*Stage' }
RBMethodName >> methodName [
	"self isValid ifFalse: [ self error: 'Method name is invalid' ]."
	^ String streamContents: [ :s | self printOn: s ]
]
