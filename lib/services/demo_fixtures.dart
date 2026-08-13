/// Invented data for App Store screenshots.
///
/// Store screenshots are published to the world, so they must never be a
/// photograph of a real account. The desktop app solves this by pointing every
/// capture run at a throwaway database seeded with the same invented shipments;
/// this is the mobile equivalent.
///
/// Before it existed, the capture proxied to the live review-code account and
/// photographed whatever happened to be there — including a genuine Royal Mail
/// label bought minutes earlier during release testing. It also meant the shot
/// list changed every time the account did: one run showed twelve consecutive
/// "Delivered" rows, which says nothing about what the app can do.
///
/// Two properties matter here, and neither is negotiable:
///
///  * **Nothing is real.** Names are obvious inventions, tracking numbers use
///    EasyPost's documented `EZ*` test prefixes, and no address is a real one.
///  * **The statuses span the range.** The Tracking list earns its place in a
///    listing by showing colour-coded states at a glance, so the fixtures cover
///    pre-transit through delivered, plus the unhappy paths — return to sender
///    and failure — that a shipper actually wants to know are handled.
library;

/// Fixed so a run is reproducible: a relative date would redraw every ETA each
/// day and make two captures impossible to compare.
const String _today = '2026-08-14';

const List<Map<String, dynamic>> demoTrackers = <Map<String, dynamic>>[
  {
    'id': 'trk_demo_01',
    'tracking_code': 'EZ1000000001',
    'carrier': 'USPS',
    'status': 'out_for_delivery',
    'est_delivery_date': _today,
    'tracking_details': <Map<String, dynamic>>[
      {
        'status': 'out_for_delivery',
        'message': 'Out for Delivery',
        'datetime': '2026-08-14T08:12:00Z',
        'tracking_location': {'city': 'Brooklyn', 'state': 'NY', 'country': 'US'},
      },
      {
        'status': 'in_transit',
        'message': 'Arrived at Post Office',
        'datetime': '2026-08-14T05:40:00Z',
        'tracking_location': {'city': 'Brooklyn', 'state': 'NY', 'country': 'US'},
      },
      {
        'status': 'in_transit',
        'message': 'Departed Sort Facility',
        'datetime': '2026-08-13T19:05:00Z',
        'tracking_location': {'city': 'Newark', 'state': 'NJ', 'country': 'US'},
      },
      {
        'status': 'pre_transit',
        'message': 'Shipping Label Created',
        'datetime': '2026-08-12T10:15:00Z',
        'tracking_location': {'city': 'Trenton', 'state': 'NJ', 'country': 'US'},
      },
    ],
  },
  {
    'id': 'trk_demo_02',
    'tracking_code': 'EZ2000000002',
    'carrier': 'RoyalMailV3',
    'status': 'in_transit',
    'est_delivery_date': '2026-08-15',
    'tracking_details': <Map<String, dynamic>>[
      {
        'status': 'in_transit',
        'message': 'Item Received at Mail Centre',
        'datetime': '2026-08-13T16:22:00Z',
        'tracking_location': {'city': 'Bristol', 'state': '', 'country': 'GB'},
      },
      {
        'status': 'pre_transit',
        'message': 'Shipping Label Created',
        'datetime': '2026-08-12T09:03:00Z',
        'tracking_location': {'city': 'London', 'state': '', 'country': 'GB'},
      },
    ],
  },
  {
    'id': 'trk_demo_03',
    'tracking_code': 'EZ3000000003',
    'carrier': 'FedEx',
    'status': 'delivered',
    'est_delivery_date': '2026-08-13',
    'tracking_details': <Map<String, dynamic>>[
      {
        'status': 'delivered',
        'message': 'Delivered',
        'datetime': '2026-08-13T14:48:00Z',
        'tracking_location': {'city': 'Manchester', 'state': '', 'country': 'GB'},
      },
    ],
  },
  {
    'id': 'trk_demo_04',
    'tracking_code': 'EZ4000000004',
    'carrier': 'DHLExpress',
    'status': 'pre_transit',
    'est_delivery_date': '2026-08-16',
    'tracking_details': <Map<String, dynamic>>[
      {
        'status': 'pre_transit',
        'message': 'Shipment Information Received',
        'datetime': '2026-08-13T11:30:00Z',
        'tracking_location': {'city': 'Leeds', 'state': '', 'country': 'GB'},
      },
    ],
  },
  {
    'id': 'trk_demo_05',
    'tracking_code': 'EZ5000000005',
    'carrier': 'Evri',
    'status': 'return_to_sender',
    'est_delivery_date': '2026-08-12',
    'tracking_details': <Map<String, dynamic>>[
      {
        'status': 'return_to_sender',
        'message': 'Returning to Sender',
        'datetime': '2026-08-12T17:14:00Z',
        'tracking_location': {'city': 'Glasgow', 'state': '', 'country': 'GB'},
      },
    ],
  },
  {
    'id': 'trk_demo_06',
    'tracking_code': 'EZ6000000006',
    'carrier': 'USPS',
    'status': 'failure',
    'est_delivery_date': '2026-08-12',
    'tracking_details': <Map<String, dynamic>>[
      {
        'status': 'failure',
        'message': 'Delivery Exception — Address Unknown',
        'datetime': '2026-08-12T13:02:00Z',
        'tracking_location': {'city': 'Austin', 'state': 'TX', 'country': 'US'},
      },
    ],
  },
];

const List<Map<String, dynamic>> demoShipments = <Map<String, dynamic>>[
  {
    'id': 'shp_demo_01',
    'tracking_code': 'EZ1000000001',
    'status': 'delivered',
    'created_at': '2026-08-12T10:15:00Z',
    'selected_rate': {'carrier': 'USPS', 'service': 'Priority', 'rate': '8.40', 'currency': 'USD'},
    'to_address': {'name': 'Riverbend Studio', 'city': 'Brooklyn', 'state': 'NY', 'country': 'US'},
  },
  {
    'id': 'shp_demo_02',
    'tracking_code': 'EZ2000000002',
    'status': 'in_transit',
    'created_at': '2026-08-12T09:03:00Z',
    'selected_rate': {
      'carrier': 'RoyalMailV3',
      'service': 'RoyalMail1stClassSignedFor',
      'rate': '6.85',
      'currency': 'GBP',
    },
    'to_address': {'name': 'Halstead Books', 'city': 'Bristol', 'state': '', 'country': 'GB'},
  },
  {
    'id': 'shp_demo_03',
    'tracking_code': 'EZ3000000003',
    'status': 'delivered',
    'created_at': '2026-08-11T15:20:00Z',
    'selected_rate': {'carrier': 'FedEx', 'service': 'FEDEX_GROUND', 'rate': '11.20', 'currency': 'GBP'},
    'to_address': {'name': 'Peartree Ceramics', 'city': 'Manchester', 'state': '', 'country': 'GB'},
  },
];

const List<Map<String, dynamic>> demoInsurances = <Map<String, dynamic>>[
  {
    'id': 'ins_demo_01',
    'tracking_code': 'EZ2000000002',
    'amount': '120.00',
    'currency': 'USD',
    'status': 'purchased',
    'provider': 'InsureShield',
    'created_at': '2026-08-12T09:05:00Z',
  },
  {
    'id': 'ins_demo_02',
    'tracking_code': 'EZ1000000001',
    'amount': '75.00',
    'currency': 'USD',
    'status': 'pending',
    'provider': 'InsureShield',
    'created_at': '2026-08-12T10:18:00Z',
  },
];

const List<Map<String, dynamic>> demoClaims = <Map<String, dynamic>>[
  {
    'id': 'clm_demo_01',
    'tracking_code': 'EZ6000000006',
    'status': 'submitted',
    'type': 'damage',
    'amount': '64.00',
    'currency': 'USD',
    'description': 'Carton crushed in transit; contents broken.',
    'created_at': '2026-08-12T14:10:00Z',
  },
  {
    'id': 'clm_demo_02',
    'tracking_code': 'EZ5000000005',
    'status': 'approved',
    'type': 'loss',
    'amount': '42.50',
    'currency': 'USD',
    'description': 'Parcel not received; carrier confirmed loss.',
    'created_at': '2026-08-10T09:45:00Z',
  },
];

const List<Map<String, dynamic>> demoPickups = <Map<String, dynamic>>[
  {
    'id': 'pck_demo_01',
    'status': 'scheduled',
    'min_datetime': '2026-08-15T09:00:00Z',
    'max_datetime': '2026-08-15T17:00:00Z',
    'address': {'name': 'Riverbend Studio', 'city': 'London', 'country': 'GB'},
    'carrier': 'USPS',
    'service': 'NextDay',
  },
];
