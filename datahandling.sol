// SPDX-License-Identifier: MIT
pragma solidity ^0.8;


contract MedicalRecords {
    struct BasicDetails {
        string name;
        uint256 age;
        string gender;
    }

    struct MedicalCase {
        string diagnosis;
        uint256 date;
    }

    mapping(address => BasicDetails) public basicDetailsMapping;
    mapping(address => MedicalCase[]) public medicalDataMapping;

    function addBasicDetails(string memory _name, uint256 _age, string memory _gender) public {
        BasicDetails storage basicDetails = basicDetailsMapping[msg.sender];
        basicDetails.name = _name;
        basicDetails.age = _age;
        basicDetails.gender = _gender;
    }

    function addMedicalCase(string memory _diagnosis, uint256 _date) public {
        MedicalCase[] storage medicalCases = medicalDataMapping[msg.sender];
        medicalCases.push(MedicalCase(_diagnosis, _date));
    }

    function getBasicDetails() public view returns (string memory, uint256, string memory) {
        BasicDetails memory basicDetails = basicDetailsMapping[msg.sender];
        return (basicDetails.name, basicDetails.age, basicDetails.gender);
    }

    function getMedicalCasesCount() public view returns (uint256) {
        return medicalDataMapping[msg.sender].length;
    }

    function getMedicalCase(uint256 index) public view returns (string memory, uint256) {
        require(index < medicalDataMapping[msg.sender].length, "Index out of bounds");
        MedicalCase memory medicalCase = medicalDataMapping[msg.sender][index];
        return (medicalCase.diagnosis, medicalCase.date);
    }
}
