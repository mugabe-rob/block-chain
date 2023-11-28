pragma solidity ^0.8.0;

contract Hospital {
    struct Patient {
        uint patientId;
        string date;
        string tests;
        string results;
        string doctorName;
        string drugsReceived;
    }
    
    mapping(uint => Patient) public patients;
    
    function recordPatientData(uint _patientId, string memory _date, string memory _tests, string memory _results, string memory _doctorName, string memory _drugsReceived) public {
        patients[_patientId] = Patient(_patientId,_date,  _tests, _results, _doctorName, _drugsReceived);
    }
    
    function getPatientData(uint _patientId) public view returns (uint, string memory, string memory, string memory, string memory, string memory) {
        Patient memory patient = patients[_patientId];
        return (patient.patientId, patient.date, patient.tests, patient.results, patient.doctorName, patient.drugsReceived);
    }
}
