# rubocop:disable Metrics/ModuleLength
module Buildings
  UNIPOTSDAM_STYLING = {
    color: "#dea93e",
    className: "uni-potsdam-building building"
  }.freeze
  HPI_STYLING = {
    color: "#eb34de",
    className: "hpi-building building"
  }.freeze
  UNIPOTSDAM_POLYONGS = [
    [
      [52.3936124, 13.1279245],
      [52.3934552, 13.1278758],
      [52.3934148, 13.1278633],
      [52.3934366, 13.1276744],
      [52.3932962, 13.127681],
      [52.3933041, 13.1280838],
      [52.3933059, 13.1281777],
      [52.3932776, 13.128179],
      [52.3932542, 13.1281802],
      [52.3931426, 13.1281855],
      [52.3931386, 13.1279596],
      [52.3930474, 13.1279639],
      [52.3925593, 13.1279871],
      [52.392478, 13.1279909],
      [52.3924743, 13.1277937],
      [52.3924644, 13.1272688],
      [52.3924323, 13.1272589],
      [52.3924352, 13.1274656],
      [52.392277, 13.1274183],
      [52.3922879, 13.1279966],
      [52.3921278, 13.1280047],
      [52.3921315, 13.1282006],
      [52.3923921, 13.1281875],
      [52.3923988, 13.1285468],
      [52.3923999, 13.1286037],
      [52.3927902, 13.128584],
      [52.3927925, 13.1287062],
      [52.3928258, 13.1287045],
      [52.3931496, 13.1286882],
      [52.3931473, 13.1285653],
      [52.3931992, 13.1285624],
      [52.3933078, 13.1285562],
      [52.3934218, 13.1285497],
      [52.3934712, 13.1285469],
      [52.3934677, 13.1283568],
      [52.3934555, 13.1283574],
      [52.3934547, 13.1283153],
      [52.393561, 13.1283099],
      [52.3935737, 13.1281825],
      [52.3935922, 13.1279982],
      [52.3936039, 13.127998],
      [52.3936124, 13.1279245]
    ],
    [
      [52.394079, 13.1297517],
      [52.3941545, 13.1316002],
      [52.39406, 13.1316106],
      [52.3940682, 13.131813],
      [52.3939752, 13.1318233],
      [52.3939333, 13.1307988],
      [52.3939294, 13.1307036],
      [52.3938913, 13.1297723],
      [52.394079, 13.1297517]
    ]
  ].freeze
  HPI_POLYGONS = [
    [
      [52.39364, 13.1300582],
      [52.393654, 13.1303745],
      [52.3935641, 13.1303853],
      [52.3935143, 13.1303912],
      [52.393332, 13.130413],
      [52.3931996, 13.1304288],
      [52.3931856, 13.1301124],
      [52.3935107, 13.1300736],
      [52.3935512, 13.1300688],
      [52.3935896, 13.1300642],
      [52.39364, 13.1300582]
    ],
    [
      [52.394252, 13.1319832],
      [52.3942691, 13.1323834],
      [52.3941597, 13.1323959],
      [52.3941618, 13.1324464],
      [52.3941764, 13.1327861],
      [52.3940004, 13.1328063],
      [52.393984, 13.1324226],
      [52.3939684, 13.1320575],
      [52.3940821, 13.1320445],
      [52.3940804, 13.132003],
      [52.394252, 13.1319832]
    ],
    [
      [52.3934502, 13.1311611],
      [52.3934534, 13.1312424],
      [52.3934566, 13.1313254],
      [52.393461, 13.1314408],
      [52.3934964, 13.1314371],
      [52.3935027, 13.1316005],
      [52.3935031, 13.1316105],
      [52.3934685, 13.131614],
      [52.3934728, 13.131724],
      [52.3936223, 13.1317085],
      [52.3936377, 13.1321076],
      [52.3934892, 13.132123],
      [52.3934935, 13.132232],
      [52.3935329, 13.132228],
      [52.393539, 13.1323854],
      [52.3935396, 13.1324015],
      [52.3935008, 13.1324055],
      [52.3935051, 13.1325179],
      [52.3934869, 13.1325198],
      [52.3934708, 13.1325214],
      [52.3934724, 13.1325626],
      [52.3932991, 13.1325806],
      [52.3932822, 13.132145],
      [52.3934619, 13.1321263],
      [52.3934586, 13.132042],
      [52.3934574, 13.1320105],
      [52.3934094, 13.1320155],
      [52.3934024, 13.1318333],
      [52.3934443, 13.131829],
      [52.393443, 13.1317948],
      [52.3934404, 13.1317279],
      [52.3932673, 13.1317458],
      [52.3932456, 13.1311823],
      [52.3932775, 13.131179],
      [52.3933617, 13.1311703],
      [52.3934031, 13.131166],
      [52.3934502, 13.1311611]

    ],
    [
      [52.3923204, 13.1235078],
      [52.3923508, 13.1239105],
      [52.3922193, 13.1239371],
      [52.3921191, 13.1239574],
      [52.3919807, 13.1239854],
      [52.3919686, 13.123825],
      [52.3919496, 13.1235726],
      [52.3920381, 13.1235546],
      [52.3920584, 13.1238229],
      [52.3921071, 13.123813],
      [52.3921025, 13.1237523],
      [52.3921504, 13.1237426],
      [52.3922033, 13.1237319],
      [52.3922083, 13.1237971],
      [52.3922623, 13.1237862],
      [52.3922425, 13.1235236],
      [52.3923204, 13.1235078]
    ],
    [
      [52.3938, 13.1335236],
      [52.3939042, 13.1336337],
      [52.3939869, 13.1336976],
      [52.3940824, 13.1337067],
      [52.3941349, 13.1336533],
      [52.3941597, 13.1335289],
      [52.3941728, 13.1333662],
      [52.3941776, 13.1332311],
      [52.3941746, 13.1330726],
      [52.3941061, 13.1330741],
      [52.3940131, 13.1330814],
      [52.3940159, 13.1332776],
      [52.3940103, 13.1333298],
      [52.3939963, 13.1333622],
      [52.3939753, 13.1333843],
      [52.393958, 13.1333912],
      [52.3939363, 13.1333887],
      [52.3939166, 13.1333749],
      [52.3938646, 13.1333228],
      [52.3935358, 13.1328654],
      [52.3934658, 13.1328709],
      [52.3934663, 13.1328823],
      [52.3934544, 13.1328837],
      [52.3934435, 13.132885],
      [52.393443, 13.1328728],
      [52.3933565, 13.1328812],
      [52.3933567, 13.132896],
      [52.3938, 13.1335236]
    ],
    [
      [52.3918618, 13.1237636],
      [52.3918793, 13.1240368],
      [52.3918975, 13.1243203],
      [52.3917906, 13.1243387],
      [52.3917549, 13.123782],
      [52.3918618, 13.1237636]
    ],
    [
      [52.3948783, 13.1251391],
      [52.3947344, 13.1251472],
      [52.3947355, 13.1252033],
      [52.3946077, 13.1252105],
      [52.3946018, 13.1249272],
      [52.3945841, 13.1249282],
      [52.3945807, 13.1247619],
      [52.3945968, 13.124761],
      [52.3945909, 13.1244755],
      [52.3947187, 13.1244684],
      [52.3947199, 13.1245249],
      [52.3948646, 13.1245168],
      [52.3948672, 13.1246446],
      [52.3947229, 13.1246526],
      [52.3947249, 13.1247519],
      [52.3947268, 13.1247518],
      [52.394728, 13.1248111],
      [52.3947482, 13.12481],
      [52.3947488, 13.1248368],
      [52.3947493, 13.1248603],
      [52.3947293, 13.1248614],
      [52.3947306, 13.1249203],
      [52.3947288, 13.1249204],
      [52.3947309, 13.1250191],
      [52.3948757, 13.125011],
      [52.3948783, 13.1251391]
    ],
    [
      [52.3948757, 13.125011],
      [52.3948747, 13.124964],
      [52.39492, 13.1249615],
      [52.3950098, 13.1249565],
      [52.3950144, 13.1251775],
      [52.3948793, 13.1251851],
      [52.3948783, 13.1251391],
      [52.3948757, 13.125011]
    ],
    [
      [52.3948646, 13.1245168],
      [52.3948636, 13.1244691],
      [52.3949982, 13.1244616],
      [52.3950028, 13.1246834],
      [52.3949143, 13.1246883],
      [52.3948682, 13.1246909],
      [52.3948672, 13.1246446],
      [52.3948646, 13.1245168]
    ],
    [
      [52.3921191, 13.1239574],
      [52.3921212, 13.1239858],
      [52.3921265, 13.1240556],
      [52.3920423, 13.1240726],
      [52.3920612, 13.1243233],
      [52.392327, 13.1242694],
      [52.392308, 13.1240166],
      [52.3922266, 13.1240331],
      [52.3922193, 13.1239371],
      [52.3921191, 13.1239574]
    ],
    [
      [52.3925689, 13.1239734],
      [52.3924392, 13.1239986],
      [52.3924603, 13.1242902],
      [52.3924804, 13.1245679],
      [52.39261, 13.1245428],
      [52.3925689, 13.1239734]
    ],
    [
      [52.3847794, 13.1190556],
      [52.3847574, 13.1193409],
      [52.3841521, 13.119149],
      [52.3842127, 13.1188536],
      [52.3847794, 13.1190556]
    ],
    [
      [52.3921974, 13.1248406],
      [52.3924289, 13.1248221],
      [52.392443, 13.1252974],
      [52.3922115, 13.1253159],
      [52.3922096, 13.1252528],
      [52.3921988, 13.12489],
      [52.3921974, 13.1248406]
    ]
  ].freeze

  HPI_LETTERS = [
    {
      coordinate: [52.39364, 13.1300582],
      letter: 'K'
    },
    {
      coordinate: [52.394252, 13.1319832],
      letter: 'HS'
    },
    {
      coordinate: [52.3934502, 13.1311611],
      letter: 'A'
    },
    {
      coordinate: [52.3936223, 13.1317085],
      letter: 'B'
    },
    {
      coordinate: [52.3934892, 13.132123],
      letter: 'C'
    },
    {
      coordinate: [52.3923204, 13.1235078],
      letter: 'V'
    },
    {
      coordinate: [52.3941746, 13.1330726],
      letter: 'H'
    },
    {
      coordinate: [52.3918618, 13.1237636],
      letter: 'D'
    },
    {
      coordinate: [52.3948646, 13.1245168],
      letter: 'G'
    },
    {
      coordinate: [52.3922193, 13.1239371],
      letter: 'E'
    },
    {
      coordinate: [52.3925689, 13.1239734],
      letter: 'F'
    },
    {
      coordinate: [52.3847794, 13.1190556],
      letter: 'J'
    },
    {
      coordinate: [52.3924289, 13.1248221],
      letter: 'L'
    }

  ].freeze

  def self.transform_leaflet_letters(hpi_letters)
    hpi_letters.map do |hpi_letter|
      {
        latlng: hpi_letter[:coordinate],
        divIcon: {
          html: hpi_letter[:letter],
          className: "building-icon"
        }
      }
    end
  end

  def self.transform_leaflet_buildings(geometries, options)
    geometries.map do |polygon|
      {
        latlngs: polygon,
        options: options
      }
    end
  end
end
# rubocop:enable Metrics/ModuleLength
