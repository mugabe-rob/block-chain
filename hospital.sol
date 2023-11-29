// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Hospital {

    /**
    * @dev The address of the owner of the Hospital contract.
    * This address has special privileges, such as the ability to record patient data.
    */
    address public owner;

    /**
    * @dev Enum representing the current status of a patient.
     * - `Admitted`: The patient is currently admitted to the hospital.
    * - `UndergoingTests`: The patient is undergoing various tests.
    * - `Discharged`: The patient has been discharged from the hospital.
    */
    enum PatientStatus { Admitted, UndergoingTests, Discharged }

    /**
     * @dev Modifier to restrict access to only the owner.
     */
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    /**
    * @dev Struct representing detailed information about a patient.
    * - `patientId`: Unique identifier for the patient.
    * - `date`: Date of the patient data record.
    * - `status`: Current status of the patient (Admitted, Undergoing Tests, Discharged).
    * - `tests`: Details of tests undergone by the patient.
    * - `results`: Test results for the patient.
    * - `doctorName`: Name of the treating doctor.
    * - `drugsReceived`: Details of drugs received by the patient.
     */
    struct Patient {
        uint patientId;
        string date;
        PatientStatus status;
        string tests;
        string results;
        string doctorName;
        string drugsReceived;
    }

    /**
    * @dev Mapping to store patient data records.
    * - Key: Unique identifier for each patient.
    * - Value: Patient struct containing detailed information about the patient.
    * private Access restricted to the contract for internal use.
    */
    mapping(uint => Patient) private patients;

    /**
    * @dev Emitted when patient data is recorded.
    * @param patientId Unique identifier for the patient.
    * @param date Date of the patient data record.
    * @param status Current status of the patient (Admitted, Undergoing Tests, Discharged).
    * @param tests Details of tests undergone by the patient.
    * @param results Test results for the patient.
    * @param doctorName Name of the treating doctor.
    * @param drugsReceived Details of drugs received by the patient.
    */
    event PatientRecorded(
        uint patientId, 
        string date, 
        PatientStatus status, 
        string tests, string results, 
        string doctorName, 
        string drugsReceived
    );

    /**
     * @dev Constructor that sets the owner to the deployer's address.
     */
    constructor() {
        owner = msg.sender;
    }

     /**
     * @dev Records patient data.
     * @param _patientId Unique identifier for the patient.
     * @param _date Date of the patient data record.
     * @param _status Current status of the patient (Admitted, Undergoing Tests, Discharged).
     * @param _tests Details of tests undergone by the patient.
     * @param _results Test results for the patient.
     * @param _doctorName Name of the treating doctor.
     * @param _drugsReceived Details of drugs received by the patient.
     */
    function recordPatientData(
        uint _patientId,
        string memory _date,
        PatientStatus _status,
        string memory _tests,
        string memory _results,
        string memory _doctorName,
        string memory _drugsReceived
    ) public onlyOwner {
        require(_patientId > 0, "Invalid patient ID");   
        require(patients[_patientId].patientId == 0, "Patient ID already exists");
        require(bytes(_date).length > 0, "Date cannot be empty");
        require(bytes(_tests).length > 0, "Tests details cannot be empty");
        require(bytes(_results).length > 0, "Results details cannot be empty");
        require(bytes(_doctorName).length > 0, "Doctor's name cannot be empty");
        require(bytes(_drugsReceived).length > 0, "Drugs received details cannot be empty");

        patients[_patientId] = Patient(_patientId, _date, _status, _tests, _results, _doctorName, _drugsReceived);
        emit PatientRecorded(_patientId, _date, _status, _tests, _results, _doctorName, _drugsReceived);
    }

    /**
    * @dev Retrieves patient data based on the patient ID.
    * @param _patientId Unique identifier for the patient.
    * @return 
    *   - Tuple containing patient information.
    *   - uint: Patient ID.
    *   - string: Date of the patient data record.
    *   - PatientStatus: Current status of the patient (Admitted, Undergoing Tests, Discharged).
    *   - string: Details of tests undergone by the patient.
    *   - string: Test results for the patient.
    *   - string: Name of the treating doctor.
    *   - string: Details of drugs received by the patient.
    * throws Patient not found if the patient ID is not valid.
    */
    function getPatientData(uint _patientId) public view returns (uint, string memory, PatientStatus, string memory, string memory, string memory, string memory) {
        Patient memory patient = patients[_patientId];
        require(patient.patientId != 0, "Patient not found");
        return (patient.patientId, patient.date, patient.status, patient.tests, patient.results, patient.doctorName, patient.drugsReceived);
    }
}
