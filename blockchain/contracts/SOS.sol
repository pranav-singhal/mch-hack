pragma solidity ^0.4.11;

contract SOS{
    // This is the Govt. who manages the hospitals
    address private creator;

    // address in the mappigs is of the hospital
    mapping(address => Hospital) hospitalDetail;

    //triggered when the availablility of hospitalchanges
    event incrementDone(address hospital,uint new_availability);

    // triggered when a patient clicks sos and he needs a bed
    event InformHospital(address hospital, string latitude, string longitude, string mobileNumber);
    event InformPatient(string postalAddress, string mobileNumber);

    // This Object stores the Information about the hospital
    struct Hospital{
        string postalAddress;
        string mobileNumber;
        uint hospitalCapacity;
        uint hospitalAvailability;
    }

    function SOS() public {
    creator = msg.sender;
  }
    function  addHospital(address _hospital, uint _capacity, uint _availability, string postalAddress, string mobileNumber) public{
        require(msg.sender == creator);
        require(hospitalDetail[_hospital].hospitalCapacity ==0);
        hospitalDetail[_hospital] = Hospital(postalAddress, mobileNumber, _capacity, _availability);

  }
    function increment() public{

      // does hospital exist in the map
      require(hospitalDetail[msg.sender].hospitalCapacity != 0);
      require(hospitalDetail[msg.sender].hospitalAvailability < hospitalDetail[msg.sender].hospitalCapacity);

      // to make sure that number of available beds does not exceed capacity
      hospitalDetail[msg.sender].hospitalAvailability +=1;
      incrementDone(msg.sender, hospitalDetail[msg.sender].hospitalAvailability);

  }
    function decrement(address _hospital, string latitude, string longitude, string mobileNumber) public returns (bool){
    // to check the decrement is done by the creator only
//      require(msg.sender == creator);

    // to check that the hospital is Authorised
      require(hospitalDetail[_hospital].hospitalCapacity != 0);

    //Wheather Hospital has available beds or not
      if(hospitalDetail[_hospital].hospitalAvailability > 0){
          // Decreaing the number of available beds
          hospitalDetail[_hospital].hospitalAvailability -= 1;

          // Tell the patient where he has been alloted a bed
          InformPatient(hospitalDetail[_hospital].postalAddress, hospitalDetail[_hospital].mobileNumber);

          // Tell the hospital that he needs to send Ambulance for a patient
          InformHospital(_hospital, latitude, longitude, mobileNumber);

          return true;
      }else{
          return false;
      }

  }


}
