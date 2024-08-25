# Project Title


Finance Tracker Smart Contract


## Description

The Solidity code defines a FinanceTracker smart contract for managing an individual's income, expenditures, and savings. The contract initializes savings to zero and designates the deployer as the owner. The owner can record income using the addIncome method, and expenses can be tracked using the addExpenditure function to ensure they don't exceed available savings. The current savings balance can be viewed through the viewSavings function. Error-handling mechanisms are incorporated to enforce rules and prevent unauthorized access. This smart contract encourages disciplined financial habits by maintaining strict checks on income and expenditure limits.

## Getting Started

### Installing
1.**Preparing REMIX**
- Visit [REMIX]
- Create a file name `Module1project.sol`.
- insert the code and save into `Module1project.sol`.

### Executing program

1.**Compile and deploy**
- Compile the code using the "Solidity Compiler" tab.
- Deploy the contract using the "Deploy & Run Transactions" tab.

### Contract Code
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FinanceTracker {
    address public owner;
    uint public totalIncome;
    uint public totalExpenditure;
    uint public currentSavings;
    uint public constant minIncomeRequired = 5000;
    uint public constant maxExpenditureLimit = 5000;
    uint public constant maxIncomeLimit = 10000;

    event IncomeReceived(address indexed sender, uint amount);
    event ExpenditureRecorded(address indexed sender, uint amount);
    event SavingsUpdated(uint newSavings);
    
    constructor() {
        owner = msg.sender;
        currentSavings = 0;
    }

    function addIncome(uint incomeAmount) public {
        require(msg.sender == owner, "Unauthorized access");
        require(incomeAmount > 0, "Income amount must be positive");

        if (totalIncome + incomeAmount > maxIncomeLimit) {
            revert("Income exceeds the non-taxable limit: Tax Applied");
        }

        totalIncome += incomeAmount;
        currentSavings += incomeAmount;

        emit IncomeReceived(msg.sender, incomeAmount);
        emit SavingsUpdated(currentSavings);

        assert(currentSavings >= totalIncome);
    }

    function addExpenditure(uint expenditureAmount) public {
        require(msg.sender == owner, "Unauthorized access");
        require(expenditureAmount > 0, "Expenditure amount must be positive");
        require(currentSavings >= expenditureAmount, "Insufficient savings for this expenditure");

        if (totalExpenditure + expenditureAmount > maxExpenditureLimit) {
            revert("Expenditure exceeds the allowable limit");
        }

        totalExpenditure += expenditureAmount;
        currentSavings -= expenditureAmount;

        emit ExpenditureRecorded(msg.sender, expenditureAmount);
        emit SavingsUpdated(currentSavings);

        assert(currentSavings >= 0);
    }

    function viewSavings() public view returns (uint) {
        return currentSavings;
    }

    function validateCondition() public view {
        if (msg.sender != owner) {
            revert("Unauthorized access: Only the owner can access this function");
        }

        if (totalIncome < minIncomeRequired) {
            revert("Insufficient income to cover expenditures");
        } else if (totalIncome >= minIncomeRequired && totalIncome <= maxIncomeLimit) {
            if (totalExpenditure <= maxExpenditureLimit) {
                revert("Operation allowed");
            } else if (totalExpenditure > maxExpenditureLimit) {
                revert("Operation not allowed");
            }
        } else if (totalIncome > maxIncomeLimit) {
            revert("Income exceeds the non-taxable limit");
        } else {
            revert("Unknown condition");
        }
    }
}

    
```

### Usage

### Events
These events will be emitted when income is received, expenditure is recorded,savings are updated.
```solidity
event incomeReceived(address indexed account, uint amount);
event ExpenditureAmount(address indexed account, uint amount);
event SavingUpdate(uint newSavings);
```

### receiveIncome
The receiveIncome function allows the contract owner to record income. It checks the caller's authorization, ensures the amount is positive and within the income limit, updates income and savings, emits events, and asserts the integrity of savings.
```solidity
function receiveIncome(uint amount) public {
    require(msg.sender == person, "Unauthorized ");
    require(amount > 0, "Sufficient Money");

    if (income + amount > incomeLimit) {
        revert("Income exceeds taxless limit: Tax Applied");
    }

    income = income + amount;
    savings = savings + amount;

    emit incomeReceived(msg.sender, amount);
    emit SavingUpdate(savings);

    assert(savings >= income);
}
```
### expenditureRecord
The expenditureRecord function allows the contract owner to record an expenditure. It checks the caller's authorization, ensures the amount is positive and within available savings, verifies the expenditure limit, updates expenditure and savings, emits events, and asserts the integrity of savings.
```solidity
function expenditureRecord(uint amount) public {
    require(msg.sender == person, "Unauthorized ");
    require(amount > 0, "expenditure must be positive");
    require(savings >= amount, "Insufficient savings for expenditure");

    if (expenditure + amount > expenditureLimit) {
        revert("Expenditure limits should < 5000");
    }

    expenditure = expenditure + amount;
    savings = savings - amount; 

    emit ExpenditureAmount(msg.sender, amount);
    emit SavingUpdate(savings);

    assert(savings >= 0);
}
```
### ConditionCheck
The ConditionCheck function verifies several conditions based on the contract's state. It ensures the caller is the contract owner and checks various scenarios for income and expenditure limits, reverting with appropriate messages for each case.
```solidity
function ConditionCheck() public view {
    if (msg.sender != person) {
        revert("Unauthorized access: owner has only access to this function");
    }
    if (income < Incomerequired) {
        revert("no sufficient income for expenditure");
    } else if (income >= Incomerequired && income <= incomeLimit) {
        if (expenditure <= expenditureLimit) {
            revert("Operation is allowed.");
        } else if (expenditure > expenditureLimit) {
            revert("operation not allowed");
        }
    } else if (income > incomeLimit) {
        revert("Income exceeds taxless limit.");
    } else {
        revert("unknown condition");
    }
}

```

## Help
For common issues or problems, ensure the following:

The correct compiler version is selected.
Ensure there are no missing semicolons or unexpected tokens.
Double-check that all Solidity syntax is correct.


## Authors
Rahul yadav


## License

This project is licensed under the MIT License 

