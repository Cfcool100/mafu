class Configs {
  static const ACCESSKEYID = "DO00FCQLXA6M7RL9U2DT";
  static const SECRETACCESSKEY = "bnBwbWr/cqiNAKMs9XMtOIj6Q4kSTuOpFaoAWfPvAQM";
  static const endpoint = 'ams3.digitaloceanspaces.com';
  static const region = 'ams3';
  static const BUCKET = "propay-storage";
}

Map<String, String>? currentUserHeader(String getToken) => {
      'Authorization': getToken,
    };

Map<String, String>? addPropertyHeader(String getToken) => {
      'Content-Type': 'application/json',
      'Authorization': getToken,
    };
