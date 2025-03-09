import 'package:vania/vania.dart';
import 'package:backend_vania/app/models/index.dart';

class MalaysiaLocation extends Seeder {
  @override
  Future<void> run() async {
    List<Map<String, dynamic>> locations = [
      {
        "location_id": 1,
        "city": "Kuala Lumpur",
        "state": "Federal Territory",
        "latitude": 3.1478,
        "longitude": 101.6953
      },
      {
        "location_id": 2,
        "city": "George Town",
        "state": "Penang",
        "latitude": 5.4145,
        "longitude": 100.3292
      },
      {
        "location_id": 3,
        "city": "Ipoh",
        "state": "Perak",
        "latitude": 4.5975,
        "longitude": 101.0901
      },
      {
        "location_id": 4,
        "city": "Johor Bahru",
        "state": "Johor",
        "latitude": 1.4556,
        "longitude": 103.7578
      },
      {
        "location_id": 5,
        "city": "Kota Bharu",
        "state": "Kelantan",
        "latitude": 6.1333,
        "longitude": 102.2386
      },
      {
        "location_id": 6,
        "city": "Kota Kinabalu",
        "state": "Sabah",
        "latitude": 5.9804,
        "longitude": 116.0735
      },
      {
        "location_id": 7,
        "city": "Kuching",
        "state": "Sarawak",
        "latitude": 1.5535,
        "longitude": 110.3593
      },
      {
        "location_id": 8,
        "city": "Malacca City",
        "state": "Malacca",
        "latitude": 2.2064,
        "longitude": 102.2465
      },
      {
        "location_id": 9,
        "city": "Alor Setar",
        "state": "Kedah",
        "latitude": 6.121,
        "longitude": 100.3678
      },
      {
        "location_id": 10,
        "city": "Shah Alam",
        "state": "Selangor",
        "latitude": 3.0738,
        "longitude": 101.5183
      },
      {
        "location_id": 11,
        "city": "Petaling Jaya",
        "state": "Selangor",
        "latitude": 3.1073,
        "longitude": 101.6067
      },
      {
        "location_id": 12,
        "city": "Iskandar Puteri",
        "state": "Johor",
        "latitude": 1.4226,
        "longitude": 103.6482
      },
      {
        "location_id": 13,
        "city": "Seremban",
        "state": "Negeri Sembilan",
        "latitude": 2.7297,
        "longitude": 101.9381
      },
      {
        "location_id": 14,
        "city": "Miri",
        "state": "Sarawak",
        "latitude": 4.3995,
        "longitude": 113.9914
      },
      {
        "location_id": 15,
        "city": "Kuala Terengganu",
        "state": "Terengganu",
        "latitude": 5.3302,
        "longitude": 103.1408
      },
      {
        "location_id": 16,
        "city": "Sibu",
        "state": "Sarawak",
        "latitude": 2.2878,
        "longitude": 111.8308
      },
      {
        "location_id": 17,
        "city": "Sandakan",
        "state": "Sabah",
        "latitude": 5.84,
        "longitude": 118.1178
      },
      {
        "location_id": 18,
        "city": "Taiping",
        "state": "Perak",
        "latitude": 4.85,
        "longitude": 100.7333
      },
      {
        "location_id": 19,
        "city": "Sungai Petani",
        "state": "Kedah",
        "latitude": 5.6497,
        "longitude": 100.4793
      },
      {
        "location_id": 20,
        "city": "Kulim",
        "state": "Kedah",
        "latitude": 5.365,
        "longitude": 100.561
      },
      {
        "location_id": 21,
        "city": "Batu Pahat",
        "state": "Johor",
        "latitude": 1.8548,
        "longitude": 102.9325
      },
      {
        "location_id": 22,
        "city": "Bintulu",
        "state": "Sarawak",
        "latitude": 3.1667,
        "longitude": 113.035
      },
      {
        "location_id": 23,
        "city": "Lahad Datu",
        "state": "Sabah",
        "latitude": 5.0264,
        "longitude": 118.327
      },
      {
        "location_id": 24,
        "city": "Kangar",
        "state": "Perlis",
        "latitude": 6.433,
        "longitude": 100.2
      },
      {
        "location_id": 25,
        "city": "Temerloh",
        "state": "Pahang",
        "latitude": 3.45,
        "longitude": 102.4167
      },
      {
        "location_id": 26,
        "city": "Kuala Selangor",
        "state": "Selangor",
        "latitude": 3.35,
        "longitude": 101.25
      },
      {
        "location_id": 27,
        "city": "Putrajaya",
        "state": "Federal Territory",
        "latitude": 2.9264,
        "longitude": 101.6964
      },
      {
        "location_id": 28,
        "city": "Cyberjaya",
        "state": "Selangor",
        "latitude": 2.9225,
        "longitude": 101.65
      },
      {
        "location_id": 29,
        "city": "Raub",
        "state": "Pahang",
        "latitude": 3.789,
        "longitude": 101.8579
      },
      {
        "location_id": 30,
        "city": "Bentong",
        "state": "Pahang",
        "latitude": 3.5222,
        "longitude": 101.9104
      },
      {
        "location_id": 31,
        "city": "Jitra",
        "state": "Kedah",
        "latitude": 6.2667,
        "longitude": 100.4167
      },
      {
        "location_id": 32,
        "city": "Keningau",
        "state": "Sabah",
        "latitude": 5.3378,
        "longitude": 116.16
      },
      {
        "location_id": 33,
        "city": "Labuan",
        "state": "Federal Territory",
        "latitude": 5.2831,
        "longitude": 115.2308
      },
      {
        "location_id": 34,
        "city": "Limbang",
        "state": "Sarawak",
        "latitude": 4.75,
        "longitude": 115.0
      },
      {
        "location_id": 35,
        "city": "Sarikei",
        "state": "Sarawak",
        "latitude": 2.1167,
        "longitude": 111.5167
      },
      {
        "location_id": 36,
        "city": "Sri Aman",
        "state": "Sarawak",
        "latitude": 1.2376,
        "longitude": 111.464
      },
      {
        "location_id": 37,
        "city": "Beaufort",
        "state": "Sabah",
        "latitude": 5.3472,
        "longitude": 115.7453
      },
      {
        "location_id": 38,
        "city": "Sipitang",
        "state": "Sabah",
        "latitude": 5.0833,
        "longitude": 115.55
      },
      {
        "location_id": 39,
        "city": "Dungun",
        "state": "Terengganu",
        "latitude": 4.7561,
        "longitude": 103.421
      },
      {
        "location_id": 40,
        "city": "Kemaman",
        "state": "Terengganu",
        "latitude": 4.23,
        "longitude": 103.4479
      },
      {
        "location_id": 41,
        "city": "Besut",
        "state": "Terengganu",
        "latitude": 5.8333,
        "longitude": 102.5
      }
    ];
    // Start a batch operation
    final batch = LocationModel().query();

    // Add insert operations to the batch
    for (final location in locations) {
      await batch.insert(location);
    }
  }
}
