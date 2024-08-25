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
            }                  else if (totalExpenditure > maxExpenditureLimit) {
                revert("Operation not allowed");
            }
        } else if (totalIncome > maxIncomeLimit) {
                                   revert("Income exceeds the non-taxable limit");
        } else {
            revert("Unknown condition");
        }
    }
}

