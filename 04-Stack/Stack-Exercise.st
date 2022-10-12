!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 18:00:02'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:59:57'!
test02PushAddElementsToTheStack

	| stack |
	stack := OOStack new.
	
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:59:50'!
test03PopRemovesElementsFromTheStack

	| stack |
	stack := OOStack new.
	stack push: 'something'.
	
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:59:43'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: pushedObject equals: stack pop! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:56:59'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: secondPushedObject equals: stack pop.
	self assert: firstPushedObject equals: stack pop.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 18:00:26'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: pushedObject equals: stack top.
	! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:58:27'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: 1 equals: stack size.
	stack top.
	self assert: 1 equals: stack size.
	! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:58:44'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: OOStack stackEmptyErrorDescription equals: anError messageText ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:58:56'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: OOStack stackEmptyErrorDescription equals: anError messageText ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:59:07'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: OOStack stackEmptyErrorDescription equals: anError messageText ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'cc 10/11/2022 21:43:06'!
test01SearchingInAnStackShouldReturnAnCollectionWithACorrectSize
	| stack finder result| 
	
	stack := OOStack new.
	
	finder := SentenceFinderByPrefix new.
	stack push: 'Gret'.
	stack push: 'GretaLinda'.
	
	result := finder find: 'Greta' in: stack.
	
	self deny: result isEmpty. 
	self assert: 1 equals: (result size). ! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'cc 10/11/2022 21:31:39'!
test02SearchingInAnEmptyStackShouldReturnAnEmptyCollection
	| stack finder result| 
	
	stack := OOStack new.
	
	finder := SentenceFinderByPrefix new.
	
	result := finder find: 'Greta' in: stack.
	
	self assert: result isEmpty. ! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'stack elements firstItemIndex top size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'adding' stamp: 'RD 10/12/2022 18:22:58'!
push: anElement
	top := ElementNode withValue: anElement andPrecedingNodeIs: top.
	size := size + 1.
! !


!OOStack methodsFor: 'removing' stamp: 'RD 10/12/2022 18:23:15'!
pop
	| elementPopped |
	elementPopped := top value.
	top := top precedingNode.
	size := size -1.
	^elementPopped.
	
	
	
	! !


!OOStack methodsFor: 'private' stamp: 'RD 10/12/2022 18:22:30'!
initialize
	super initialize.
	top := TopNode new.
	size := 0.! !


!OOStack methodsFor: 'operating' stamp: 'RD 10/12/2022 18:14:46'!
isEmpty
	^size = 0.! !

!OOStack methodsFor: 'operating' stamp: 'RD 10/12/2022 18:14:37'!
size
	^size.! !

!OOStack methodsFor: 'operating' stamp: 'RD 10/12/2022 18:14:12'!
top
	^top value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #StackNode category: 'Stack-Exercise'!
Object subclass: #StackNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackNode methodsFor: 'operating' stamp: 'rd 10/12/2022 17:44:48'!
value
	self subclassResponsibility.! !


!classDefinition: #ElementNode category: 'Stack-Exercise'!
StackNode subclass: #ElementNode
	instanceVariableNames: 'value precedingNode'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!ElementNode methodsFor: 'operating' stamp: 'RD 10/12/2022 18:21:27'!
precedingNode
	^precedingNode.! !

!ElementNode methodsFor: 'operating' stamp: 'rd 10/12/2022 17:45:19'!
value
	^value.! !


!ElementNode methodsFor: 'inicialization' stamp: 'rd 10/12/2022 18:02:08'!
initializeWithValue: aNodeValue andPrecedingNodeIs: thePrecedingNode
	precedingNode := thePrecedingNode.
	value := aNodeValue.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElementNode class' category: 'Stack-Exercise'!
ElementNode class
	instanceVariableNames: ''!

!ElementNode class methodsFor: 'instance creation' stamp: 'rd 10/12/2022 17:59:22'!
withValue: anElement andPrecedingNodeIs: thePrecedingNode
	^self new initializeWithValue: anElement andPrecedingNodeIs: thePrecedingNode
! !


!classDefinition: #TopNode category: 'Stack-Exercise'!
StackNode subclass: #TopNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!TopNode methodsFor: 'operating' stamp: 'rd 10/12/2022 17:46:25'!
value
	^self error: OOStack stackEmptyErrorDescription
	! !
