# Hospital Smart Contract

## Overview

This Solidity smart contract, named "Hospital," allows the recording and retrieval of patient data on the blockchain. Only the owner of the contract has the privilege to record patient data.

## Smart Contract Details

- **Contract Name:** Hospital
- **Compiler Version:** Solidity ^0.8.0

## Patient Status Enum

The contract introduces a `PatientStatus` enumeration, which includes the following states:
- Admitted
- Undergoing Tests
- Discharged

## Functions

1. **`recordPatientData`**
   - Allows the owner to record patient data, including patient ID, date, status, tests, results, doctor's name, and drugs received.
   - Parameters:
     - `patientId`: Unique identifier for the patient.
     - `date`: Date of the patient data record.
     - `status`: Current status of the patient (Admitted, Undergoing Tests, Discharged).
     - `tests`: Details of tests undergone by the patient.
     - `results`: Test results for the patient.
     - `doctorName`: Name of the treating doctor.
     - `drugsReceived`: Details of drugs received by the patient.
   - Emits the `PatientRecorded` event.

2. **`getPatientData`**
   - Allows anyone to retrieve patient data based on the patient ID.
   - Parameters:
     - `patientId`: Unique identifier for the patient.
   - Returns:
     - Tuple containing patient information (ID, date, status, tests, results, doctor's name, drugs received).
   - Throws an error if the patient is not found.

## Events

1. **`PatientRecorded`**
   - Event emitted when patient data is recorded.
   - Parameters:
     - `patientId`: Unique identifier for the patient.
     - `date`: Date of the patient data record.
     - `status`: Current status of the patient (Admitted, Undergoing Tests, Discharged).
     - `tests`: Details of tests undergone by the patient.
     - `results`: Test results for the patient.
     - `doctorName`: Name of the treating doctor.
     - `drugsReceived`: Details of drugs received by the patient.

## Usage

using [REMIX IDE](https://remix.ethereum.org), You can

1. Deploy the contract to a supported blockchain network.

2. Interact with the contract using a web3-enabled application or script, particularly the `recordPatientData` and `getPatientData` functions.

