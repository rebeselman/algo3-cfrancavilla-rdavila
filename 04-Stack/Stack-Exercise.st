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

!OOStackTest methodsFor: 'test' stamp: 'RD 10/14/2022 08:23:18'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
		
	self blockToFail: [stack pop ] assertError: [ :anError |
			self assert: OOStack stackEmptyErrorDescription equals: anError messageText ].! !

!OOStackTest methodsFor: 'test' stamp: 'RD 10/14/2022 08:24:56'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.	
	self blockToFail: [ stack pop ] assertError: [ :anError |
			self assert: OOStack stackEmptyErrorDescription equals: anError messageText ].! !

!OOStackTest methodsFor: 'test' stamp: 'RD 10/14/2022 08:25:38'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.

	self blockToFail: [ stack top ] assertError:  [ :anError |
			self assert: OOStack stackEmptyErrorDescription equals: anError messageText ].! !


!OOStackTest methodsFor: 'auxiliar' stamp: 'RD 10/14/2022 08:23:51'!
blockToFail: aBlockThatIsGonnaFail assertError: aBlockThatAssertsTheError
	self 
		should: aBlockThatIsGonnaFail 
		raise: Error
		withExceptionDo: aBlockThatAssertsTheError.! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'finder aCollectionOfNamesSimilarToGreta aCollectionOfTwoRandomNames'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'RD 10/13/2022 18:29:11'!
setUp
	finder := SentenceFinderByPrefix new.
	aCollectionOfNamesSimilarToGreta :=  {	'Gret'. 'GretaLinda'. 'Greta'. 'GretaThumberg'. 'GretaBella'.}.
	aCollectionOfTwoRandomNames := {'Mary'. 'Steven'.}! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'RD 10/13/2022 17:42:20'!
test01SearchingInAnStackShouldReturnAnCollectionWithACorrectSize
	| stack result| 
	
	stack := OOStack new.

	stack push: 'Gret'.
	stack push: 'GretaLinda'.
	
	result := finder find: 'Greta' in: stack.
	
	self deny: result isEmpty. 
	self assert: 1 equals: (result size). ! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'RD 10/13/2022 17:42:30'!
test02SearchingInAnEmptyStackShouldReturnAnEmptyCollection
	| stack result| 
	
	stack := OOStack new.
	
	result := finder find: 'Greta' in: stack.
	
	self assert: result isEmpty. ! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'RD 10/13/2022 18:30:51'!
test03SearchingAPrefixThatIsNotIntoTheStackShouldReturnAnEmptyCollection
	| stack result| 
	
	stack := OOStack new.
	
	
	self pushThisItems: aCollectionOfTwoRandomNames intoThisStack: stack.
	
	result := finder find: 'Greta' in: stack.
	
	self assert: result isEmpty. ! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'RD 10/13/2022 18:30:34'!
test04SearchingAPrefixDoesNotChangeTheOriginalStack
	| stack| 
	
	stack := OOStack new.
	
	
	self pushThisItems: aCollectionOfTwoRandomNames intoThisStack: stack.
	
	finder find: 'Greta' in: stack.
	
	self assert: 'Steven' = stack pop.
	self assert: 'Mary' = stack pop.
	self assert: stack isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'RD 10/13/2022 18:21:41'!
test05SearchingInAStackShouldReturnACollectionWithMultipleSentences
	| stack result| 
	stack := OOStack new.
	
	self pushThisItems: aCollectionOfNamesSimilarToGreta intoThisStack: stack.
	
	stack push: 'hola greta'.
	
	result := finder find: 'Greta' in: stack.
	
	self deny: result isEmpty. 
	self assert: 4 equals: (result size). ! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'RD 10/13/2022 18:24:33'!
test06SentenceFinderByPrefixIsCaseSensitive
	| stack result| 
	stack := OOStack new.

	self pushThisItems: aCollectionOfNamesSimilarToGreta intoThisStack: stack.
	
	stack push: 'gretaThumberg'.
	stack push: 'gretaLinda'.
	
	result := finder find: 'greta' in: stack.
	
	self deny: result isEmpty. 
	self assert: 2 equals: (result size). ! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'RD 10/13/2022 18:09:11'!
test07PrefixCanNotBeAnEmptyString
	| stack| 
	
	stack := OOStack new.
	stack push: 'Greta'.
	stack push: 'GretaLinda'.

	self blockToFail: [finder find: '' in: stack] assertError: 
	[ :anError | self assert: SentenceFinderByPrefix sentenceFinderPrefixCantBeEmpty equals: anError messageText ].! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'RD 10/13/2022 18:09:24'!
test08PrefixCanNotHaveEmptySpaces
	| stack | 
	
	stack := OOStack new.
	stack push: 'Greta'.
	stack push: 'GretaLinda'.
	
	self blockToFail: [finder find: 'Grata jaja' in: stack] 
	assertError: [ :anError | self assert: SentenceFinderByPrefix sentenceFinderPrefixCantHaveEmptySpacesErrorDescription equals: anError messageText ].! !


!SentenceFinderByPrefixTest methodsFor: 'assertions' stamp: 'RD 10/13/2022 18:09:48'!
blockToFail: aBlockThatIsGonnaFail assertError: aBlockThatAssertsTheError
	self 
		should: aBlockThatIsGonnaFail 
		raise: Error
		withExceptionDo: aBlockThatAssertsTheError.! !


!SentenceFinderByPrefixTest methodsFor: 'private' stamp: 'RD 10/13/2022 18:22:51'!
pushThisItems: aCollection intoThisStack: aStack
	aCollection do: [:anElement| aStack push: anElement].! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'top size'
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

!SentenceFinderByPrefix methodsFor: 'operating' stamp: 'RD 10/13/2022 11:49:53'!
find: aString in: anOOStack 
	| auxiliarStack  poppedSentence listOfSentencesFoundedByPrefix |

	self checkPrefix: aString.
	listOfSentencesFoundedByPrefix := OrderedCollection new.
	auxiliarStack := OOStack new.
	
	self evaluateClosure: [ poppedSentence := anOOStack pop. 
		auxiliarStack push: poppedSentence. 
		(self isPrefix: aString within: poppedSentence) ifTrue: [listOfSentencesFoundedByPrefix add: poppedSentence]] whileStackIsNotEmpty: anOOStack.

	self evaluateClosure:  [anOOStack push: auxiliarStack pop] whileStackIsNotEmpty: auxiliarStack.
	^listOfSentencesFoundedByPrefix.
	
	! !


!SentenceFinderByPrefix methodsFor: 'private' stamp: 'RD 10/13/2022 11:36:39'!
aStringhasEmptySpaces: aString
	^self isPrefix: ' ' within: aString.



! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'RD 10/13/2022 11:49:21'!
checkPrefix: aString
	aString isEmpty ifTrue: [self error: self class sentenceFinderPrefixCantBeEmpty].
	(self aStringhasEmptySpaces: aString) ifTrue: [self error: self class sentenceFinderPrefixCantHaveEmptySpacesErrorDescription].! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'RD 10/13/2022 10:08:31'!
evaluateClosure: aClosureToEvaluate whileStackIsNotEmpty: anStack
	 [anStack isEmpty] whileFalse: aClosureToEvaluate.! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'RD 10/13/2022 11:41:56'!
isPrefix: aPrefix within: aSentence
	| indexOfPrefixInSentence |
	
	indexOfPrefixInSentence := aSentence findString: aPrefix startingAt: 1. 
	^indexOfPrefixInSentence ~= 0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'errorsMessages' stamp: 'RD 10/13/2022 11:30:10'!
sentenceFinderPrefixCantBeEmpty
	^'The prefix should not be empty'! !

!SentenceFinderByPrefix class methodsFor: 'errorsMessages' stamp: 'RD 10/13/2022 11:31:51'!
sentenceFinderPrefixCantHaveEmptySpacesErrorDescription
	^'The prefix cant have empty spaces'! !


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
