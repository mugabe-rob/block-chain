// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Hospital {
    address public owner;
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    struct Patient {
        uint patientId;
        string date;
        string tests;
        string results;
        string doctorName;
        string drugsReceived;
    }
    
    mapping(uint => Patient) private patients;
    
    event PatientRecorded(uint patientId, string date, string tests, string results, string doctorName, string drugsReceived);

    constructor() {
        owner = msg.sender;
    }

    function recordPatientData(
        uint _patientId,
        string memory _date,
        string memory _tests,
        string memory _results,
        string memory _doctorName,
        string memory _drugsReceived
    ) public onlyOwner {
        require(_patientId != 0, "Invalid patient ID");
        require(patients[_patientId].patientId == 0, "Patient ID already exists");

        patients[_patientId] = Patient(_patientId, _date, _tests, _results, _doctorName, _drugsReceived);
        emit PatientRecorded(_patientId, _date, _tests, _results, _doctorName, _drugsReceived);
    }
    
    function getPatientData(uint _patientId) public view returns (uint, string memory, string memory, string memory, string memory, string memory) {
        Patient memory patient = patients[_patientId];
        require(patient.patientId != 0, "Patient not found");
        return (patient.patientId, patient.date, patient.tests, patient.results, patient.doctorName, patient.drugsReceived);
    }
}
