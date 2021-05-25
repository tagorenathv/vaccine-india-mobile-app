class StateModel {
  static Map<String, String> statesMap = {
    "1": "Andaman and Nicobar Islands",
    "2": "Andhra Pradesh",
    "3": "Arunachal Pradesh",
    "4": "Assam",
    "5": "Bihar",
    "6": "Chandigarh",
    "7": "Chhattisgarh",
    "8": "Dadra and Nagar Haveli",
    "37": "Daman and Diu",
    "9": "Delhi",
    "10": "Goa",
    "11": "Gujarat",
    "12": "Haryana",
    "13": "Himachal Pradesh",
    "14": "Jammu and Kashmir",
    "15": "Jharkhand",
    "16": "Karnataka",
    "17": "Kerala",
    "18": "Ladakh",
    "19": "Lakshadweep",
    "20": "Madhya Pradesh",
    "21": "Maharashtra",
    "22": "Manipur",
    "23": "Meghalaya",
    "24": "Mizoram",
    "25": "Nagaland",
    "26": "Odisha",
    "27": "Puducherry",
    "28": "Punjab",
    "29": "Rajasthan",
    "30": "Sikkim",
    "31": "Tamil Nadu",
    "32": "Telangana",
    "33": "Tripura",
    "34": "Uttar Pradesh",
    "35": "Uttarakhand",
    "36": "West Bengal"
  };

  final String stateId;
  final String stateName;

  StateModel(this.stateId, this.stateName);

  bool isEqual(StateModel model) {
    return this.stateId == model.stateId;
  }

  bool filterByStateName(String filter) {
    return this.stateName.contains(filter.toUpperCase());
  }

  static List<StateModel> getStates() {
    List<StateModel> states = [];
    statesMap.forEach((stateId, stateName) {
      states.add(StateModel(stateId, stateName.toUpperCase()));
    });
    return states;
  }
}
