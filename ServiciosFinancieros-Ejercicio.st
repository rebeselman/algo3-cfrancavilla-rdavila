!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'cf 11/11/2022 15:03:26'!
test01AnEmptyPortfolioBalanceIsZero
	| portfolio |
	
	portfolio := Portfolio new.
	
	self assert: 0*peso equals: portfolio balance.
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'cf 11/11/2022 15:03:09'!
test02APortfolioBalanceIsTheSumOfAccountsBalances
	| portfolio accountOne accountTwo accountThree|
	
	accountOne := ReceptiveAccount new.
	accountTwo := ReceptiveAccount new.
	accountThree := ReceptiveAccount new.
	portfolio := Portfolio new.
	
	Deposit register: 100*peso on: accountOne.
	Deposit register: 200*peso on: accountTwo.
	Deposit register: 50*peso on: accountThree.
	
	self add: accountOne and: accountTwo and: accountThree toPortfolio: portfolio.
	
	self assert: 350*peso equals: portfolio balance.
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'cf 11/11/2022 15:03:44'!
test03APortfolioCanRegisterATransaction
	| portfolio accountOne accountTwo accountThree depositeAccountOne|
	
	accountOne := ReceptiveAccount new.
	accountTwo := ReceptiveAccount new.
	accountThree := ReceptiveAccount new.
	portfolio := Portfolio new.
	
	depositeAccountOne := Deposit register: 100*peso on: accountOne.
	
	self add: accountOne and: accountTwo and: accountThree toPortfolio: portfolio.
	
	self assert: (portfolio hasRegistered: depositeAccountOne).! !

!PortfolioTest methodsFor: 'tests' stamp: 'cf 11/11/2022 15:04:10'!
test04APortfolioCanReturnTransactionsOfAParticularAccount
	| portfolio accountOne accountTwo accountThree transactionsAccountOne |
	
	accountOne := ReceptiveAccount new.
	accountTwo := ReceptiveAccount new.
	accountThree := ReceptiveAccount new.
	transactionsAccountOne := OrderedCollection new.
	portfolio := Portfolio new.
	
	transactionsAccountOne add: (Deposit register: 100*peso on: accountOne).
	self add: accountOne and: accountTwo and: accountThree toPortfolio: portfolio.
	
	self assert: transactionsAccountOne = (portfolio transactionsOf: accountOne).
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'cf 11/11/2022 15:04:47'!
test05APortfolioWithAPortfolioCanReturnItsBalance
	| portfolioOne accountOne accountTwo portfolioTwo accountThree|
	
	accountOne := ReceptiveAccount new.
	accountTwo := ReceptiveAccount new.
	accountThree := ReceptiveAccount new.
	portfolioTwo := Portfolio new.
	portfolioOne := Portfolio new.
	
	Deposit register: 2*peso on: accountThree.
	Deposit register: 3*peso on: accountTwo.
	
	portfolioTwo add: accountThree.
	self add: accountOne and: accountTwo and: portfolioTwo toPortfolio: portfolioOne.
	
	self assert: 5*peso equals: portfolioOne balance. 
	
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'cf 11/11/2022 15:05:17'!
test06APortfolioWithAPortfolioCanRegisterATransactionOfAnAccount
	| portfolioOne accountOne accountTwo portfolioTwo accountThree depositAccountThree depositAccountTwo|
	
	accountOne := ReceptiveAccount new.
	accountTwo := ReceptiveAccount new.
	accountThree := ReceptiveAccount new.
	portfolioTwo := Portfolio new.
	portfolioOne := Portfolio new.
	
	depositAccountTwo := Deposit register: 2*peso on: accountThree.
	depositAccountThree := Deposit register: 3*peso on: accountTwo.
	
	portfolioTwo add: accountThree.
	self add: accountOne and: accountTwo and: portfolioTwo toPortfolio: portfolioOne .
	
	self assert: (portfolioOne hasRegistered: depositAccountThree).
	self assert: (portfolioOne hasRegistered: depositAccountTwo).
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'cf 11/11/2022 15:05:26'!
test07APortfolioCanNotHaveDuplicateAccounts
	|accountOne portfolio |
	
	accountOne := ReceptiveAccount new.
	portfolio := Portfolio new.
	
	portfolio add: accountOne.
	
	self blockToFail: [portfolio add: accountOne] assertError: [:anError |
			self assert: Portfolio portfolioDuplicateAccountsErrorDescription equals: anError messageText ] ! !

!PortfolioTest methodsFor: 'tests' stamp: 'cf 11/11/2022 15:11:16'!
test08APortfolioCanNotAddAPortfolioWithAnAccountThatItIsAlreadyInIt
	|accountOne portfolioChild portfolioFather|
	
	accountOne := ReceptiveAccount new.
	portfolioChild := Portfolio new.
	portfolioFather := Portfolio new.
	
	self add: accountOne toPortfolio: portfolioChild and: accountOne toPortfolio: portfolioFather .
	
	self blockToFail: [portfolioFather add: portfolioChild ] assertError: [:anError |
			self assert: Portfolio portfolioDuplicateAccountsErrorDescription equals: anError messageText ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'cf 11/11/2022 15:05:53'!
test09APortfolioCanNotIncludeItself 
	|portfolio|
	
	portfolio := Portfolio new.
	
	self blockToFail: [portfolio add: portfolio] assertError:[:anError| self assert: Portfolio portfolioCanNotAddItselfErrorDescription equals: anError messageText ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'cf 11/11/2022 15:11:53'!
test10APortfolioCanNotAddAnAccountThatIsAlreadlyIncludedInOtherIncludedPortfolio
	|portfolioChild anAccount portfolioFather|
	
	anAccount := ReceptiveAccount new.
	portfolioChild := Portfolio new.
	portfolioFather := Portfolio new.
	
	self add:anAccount toPortfolio: portfolioChild and: portfolioChild toPortfolio: portfolioFather.
	
	self blockToFail: [portfolioFather add: anAccount] assertError:[:anError| self assert: Portfolio portfolioDuplicateAccountsErrorDescription equals: anError messageText ]
! !

!PortfolioTest methodsFor: 'tests' stamp: 'cf 11/11/2022 15:12:33'!
test11APortfolioCantAddAnAccountWhenItsFatherAlreadyHasThatAccountAdded
	|portfolioChild anAccount portfolioFather|
	
	anAccount := ReceptiveAccount new.
	portfolioChild := Portfolio new.
	portfolioFather := Portfolio new.

	self add: portfolioChild toPortfolio: portfolioFather and: anAccount toPortfolio: portfolioFather.
	
	self blockToFail: [portfolioChild add: anAccount] assertError:[:anError| self assert: Portfolio portfolioFatherHasAlreadyAccountErrorDescription equals: anError messageText ]! !


!PortfolioTest methodsFor: 'auxiliar' stamp: 'cf 11/11/2022 14:58:56'!
add: financialEntityOne and: financialEntityTwo and: financialEntityThree toPortfolio: aPortfolio
	aPortfolio add: financialEntityOne.
	aPortfolio add: financialEntityTwo.
	aPortfolio add: financialEntityThree.
	! !

!PortfolioTest methodsFor: 'auxiliar' stamp: 'cf 11/11/2022 15:10:26'!
add: financialEntityOne toPortfolio: portfolioOne and: financialEntityTwo toPortfolio: portfolioTwo
	portfolioOne add: financialEntityOne.
	portfolioTwo add: financialEntityTwo.
	! !

!PortfolioTest methodsFor: 'auxiliar' stamp: 'rd 11/10/2022 10:27:06'!
blockToFail: aBlockThatIsGonnaFail assertError: aBlockThatAssertsTheError
	self 
		should: aBlockThatIsGonnaFail 
		raise: Error
		withExceptionDo: aBlockThatAssertsTheError.! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests of first model' stamp: 'LL 7/1/2021 03:10:43'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests of first model' stamp: 'LL 7/1/2021 03:14:20'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests of first model' stamp: 'LL 7/1/2021 03:14:24'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests of first model' stamp: 'LL 7/1/2021 03:10:14'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests of first model' stamp: 'LL 7/1/2021 03:10:22'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests of first model' stamp: 'LL 7/1/2021 03:12:14'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests of first model' stamp: 'LL 7/1/2021 03:12:23'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).
! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferTest methodsFor: 'tests' stamp: 'rd 11/9/2022 17:43:44'!
test01TransferCanSayWhatIsItsValue
	| transfer receiverAccount senderAccount|
	
	receiverAccount  := ReceptiveAccount new.
	senderAccount  := ReceptiveAccount new.
	transfer := Transfer register: 100*peso to: receiverAccount from: senderAccount.
	self assert: 100*peso equals: transfer value.! !

!TransferTest methodsFor: 'tests' stamp: 'rd 11/9/2022 18:46:49'!
test02PartsOfATransactionCanRespondWithTheContrapart
	| transfer receiverAccount senderAccount depositForTransfer withdrawForTransfer |
	receiverAccount := ReceptiveAccount new. "pata de extracción"
	senderAccount := ReceptiveAccount new. "pata de depósito"
	transfer := Transfer register: 100*peso to: receiverAccount  from: senderAccount.
	
	depositForTransfer := (receiverAccount  depositForTransfer: transfer).
 	withdrawForTransfer := (senderAccount withdrawForTransfer: transfer).
	self assert: (senderAccount hasRegistered: withdrawForTransfer).
	self assert: (receiverAccount hasRegistered: depositForTransfer).
	! !

!TransferTest methodsFor: 'tests' stamp: 'rd 11/9/2022 18:53:59'!
test03TheBalancesAreOkey
	| transfer receiverAccount senderAccount|
	
	receiverAccount  := ReceptiveAccount new.
	senderAccount  := ReceptiveAccount new.
	transfer := Transfer register: 100*peso to: receiverAccount from: senderAccount.
	self assert: 100*peso equals: receiverAccount balance.
	self assert: -100*peso equals: senderAccount balance.! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'cf 11/4/2022 19:29:07'!
calculateBalance: aBalance
	^self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'private' stamp: 'cf 11/4/2022 19:32:24'!
calculateBalance: aBalance
	^aBalance + self value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'private' stamp: 'cf 11/4/2022 19:32:32'!
calculateBalance: aBalance
	^aBalance - self value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts financialEntities father'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'auxiliar' stamp: 'cf 11/11/2022 14:50:25'!
alreadyIncludesAnAccount: anAccount
	financialEntities do: [:anIncludedFinancialEntity | 
		(anIncludedFinancialEntity isKindOf: ReceptiveAccount) ifTrue: [ anAccount = anIncludedFinancialEntity ifTrue: [^true]].
		(anIncludedFinancialEntity isKindOf: Portfolio) ifTrue: [(anIncludedFinancialEntity alreadyIncludesAnAccount: anAccount) ifTrue: [^true]]].
	^false.! !

!Portfolio methodsFor: 'auxiliar' stamp: 'cf 11/11/2022 15:15:19'!
alreadyIncludesAnAccountInTree: anAccount

	father ~= nil ifTrue: [(father alreadyIncludesAnAccount: anAccount) ifFalse: [^father alreadyIncludesAnAccountInTree: anAccount] ifTrue: [^true]].
	^false.
	 ! !

!Portfolio methodsFor: 'auxiliar' stamp: 'cf 11/11/2022 14:50:43'!
alreadyIncludesAnAccountIncludedIn: aFinancialEntity
	financialEntities do: [:anIncludedFinancialEntity | 
		(anIncludedFinancialEntity isKindOf: ReceptiveAccount) ifTrue: [ (aFinancialEntity alreadyIncludesAnAccount: anIncludedFinancialEntity) ifTrue: [^true]].
		(anIncludedFinancialEntity isKindOf: Portfolio) ifTrue: [(self alreadyIncludesAnAccountIncludedIn: anIncludedFinancialEntity ) ifTrue: [^true]]].
	^false.! !

!Portfolio methodsFor: 'auxiliar' stamp: 'cf 11/11/2022 15:41:52'!
financialEntity: aFinancialEntity alreadyIncludesAnAccount: anAccount
	^(aFinancialEntity alreadyIncludesAnAccount: anAccount)! !


!Portfolio methodsFor: 'initialize' stamp: 'rd 11/10/2022 11:49:14'!
initialize
	super initialize.
	financialEntities := Set new.
	
	! !


!Portfolio methodsFor: 'accessing' stamp: 'rd 11/10/2022 11:52:09'!
balance
	| balance |
	balance := 0.
	financialEntities do: [:aFinancialEntity | balance := aFinancialEntity balance + balance].
	^balance.! !

!Portfolio methodsFor: 'accessing' stamp: 'rd 11/10/2022 11:52:40'!
hasRegistered: aTransaction
	financialEntities do: [:aFinancialEntity | (aFinancialEntity transactions includes: aTransaction) ifTrue: [^true]].
	^false.
	! !

!Portfolio methodsFor: 'accessing' stamp: 'rd 11/10/2022 11:53:47'!
transactions
	|transactions|
	transactions := OrderedCollection new.
	financialEntities do: [:anAccount|  transactions := transactions addAll: anAccount transactions].
	^transactions.! !

!Portfolio methodsFor: 'accessing' stamp: 'rd 11/10/2022 09:35:01'!
transactionsOf: aReceptiveAccount 
	^aReceptiveAccount transactions.! !


!Portfolio methodsFor: 'adding' stamp: 'cf 11/11/2022 15:16:42'!
add: aFinancialEntity
	
	self = aFinancialEntity ifTrue: [^self error: Portfolio portfolioCanNotAddItselfErrorDescription].
	(aFinancialEntity isKindOf: ReceptiveAccount) ifTrue: [(self alreadyIncludesAnAccountInTree: aFinancialEntity) ifTrue: [^self error: Portfolio portfolioFatherHasAlreadyAccountErrorDescription]].
	(aFinancialEntity isKindOf: ReceptiveAccount) ifTrue: [(self alreadyIncludesAnAccount: aFinancialEntity) ifTrue: [^self error: Portfolio portfolioDuplicateAccountsErrorDescription]].
	
	(aFinancialEntity isKindOf: Portfolio) ifTrue: [(self alreadyIncludesAnAccountIncludedIn: aFinancialEntity) ifTrue: [^self error: Portfolio portfolioDuplicateAccountsErrorDescription]].
	(aFinancialEntity isKindOf: Portfolio) ifTrue: [aFinancialEntity father: self].
	

	
	financialEntities add: aFinancialEntity.! !


!Portfolio methodsFor: 'as yet unclassified' stamp: 'rd 11/10/2022 11:13:38'!
financialEntities
	^accounts! !


!Portfolio methodsFor: 'private' stamp: 'rd 11/10/2022 18:16:59'!
father: aPortfolioFather
	father := aPortfolioFather.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error messages' stamp: 'rd 11/10/2022 12:17:32'!
portfolioCanNotAddItselfErrorDescription
	^'A portfolio can not add itself'! !

!Portfolio class methodsFor: 'error messages' stamp: 'rd 11/10/2022 10:51:40'!
portfolioDuplicateAccountsErrorDescription
	^'portfolio can not have two equal accounts'! !

!Portfolio class methodsFor: 'error messages' stamp: 'rd 11/10/2022 18:46:52'!
portfolioFatherHasAlreadyAccountErrorDescription
	^'A portafolio father already has that account included'! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'cf 11/4/2022 19:40:53'!
balance

	| aBalance |
	aBalance := 0.
	"transactions  do: [: aTransaction | 
			(aTransaction isKindOf: Deposit)
				ifTrue: [aBalance  := aBalance + aTransaction value].
			(aTransaction isKindOf: Withdraw)
				ifTrue: [aBalance := aBalance - aTransaction value.]
			]."
	transactions do: [: aTransaction | aBalance := aTransaction calculateBalance: aBalance].
	"cambiar nombre mensaje!!!!"
	^aBalance .! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'transfer' stamp: 'rd 11/9/2022 18:38:54'!
depositForTransfer: aTransfer 
	^aTransfer depositeTransaction.! !

!ReceptiveAccount methodsFor: 'transfer' stamp: 'rd 11/9/2022 18:37:27'!
withdrawForTransfer: aTransfer 
	^aTransfer withdrawTransaction.! !


!ReceptiveAccount methodsFor: 'auxiliar' stamp: 'cf 11/11/2022 15:29:28'!
add: aFinancialEntity

	(aFinancialEntity isKindOf: ReceptiveAccount) ifTrue: [(self alreadyIncludesAnAccountInTree: aFinancialEntity) ifTrue: [^self error: Portfolio portfolioFatherHasAlreadyAccountErrorDescription]].
	(aFinancialEntity isKindOf: ReceptiveAccount) ifTrue: [(self alreadyIncludesAnAccount: aFinancialEntity) ifTrue: [^self error: Portfolio portfolioDuplicateAccountsErrorDescription]].! !

!ReceptiveAccount methodsFor: 'auxiliar' stamp: 'cf 11/11/2022 15:41:22'!
financialEntity: aFinancialEntity alreadyIncludesAnAccount: anAccount
	^ anAccount = aFinancialEntity! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'valueOfTransfer depositeTransaction withdrawTransaction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transfer methodsFor: 'initialize' stamp: 'rd 11/10/2022 08:43:31'!
initialiazeRegister: anAmountOfMoney to: aReceiverAccount from: aSenderAccount
	valueOfTransfer := anAmountOfMoney.
	depositeTransaction := Deposit register: anAmountOfMoney on: aReceiverAccount.
	withdrawTransaction := 	Withdraw register: anAmountOfMoney on: aSenderAccount.
	! !


!Transfer methodsFor: 'parts of transaction' stamp: 'rd 11/9/2022 18:19:33'!
depositeTransaction
	^depositeTransaction
	! !

!Transfer methodsFor: 'parts of transaction' stamp: 'rd 11/9/2022 18:37:56'!
withdrawTransaction
	^withdrawTransaction.! !


!Transfer methodsFor: 'value' stamp: 'rd 11/9/2022 17:40:16'!
value
	^valueOfTransfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'rd 11/9/2022 18:43:51'!
register: anAmountOfMoney to: aReceiverAccount from: aSenderAccount
	| transaction |
	transaction := self new initialiazeRegister: anAmountOfMoney to: aReceiverAccount from: aSenderAccount.	
	^ transaction! !
