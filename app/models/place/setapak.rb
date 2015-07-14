class Place::Setapak
  def self.points
    [
      {lat: 3.230456218235476, lng: 101.72425679862499},
      {lat: 3.2301991353051225, lng: 101.72425679862499},
      {lat: 3.2240291254577995, lng: 101.7205660790205},
      {lat: 3.213959931819277, lng: 101.71211175620556},
      {lat: 3.206290138914202, lng: 101.69988088309765},
      {lat: 3.2045762108448037, lng: 101.69962339103222},
      {lat: 3.2032907629088485, lng: 101.69855050742626},
      {lat: 3.2001628328571825, lng: 101.6985934227705},
      {lat: 3.1981918035367864, lng: 101.7002671211958},
      {lat: 3.195449495571435, lng: 101.70056752860546},
      {lat: 3.1933927597882503, lng: 101.70086793601513},
      {lat: 3.190650439003444, lng: 101.70069627463818},
      {lat: 3.1888936359052225, lng: 101.7009537667036},
      {lat: 3.187651017267414, lng: 101.70301370322704},
      {lat: 3.186622642087269, lng: 101.70558862388134},
      {lat: 3.1862798501321774, lng: 101.71236924827099},
      {lat: 3.185080077390367, lng: 101.71644620597363},
      {lat: 3.1828519243039923, lng: 101.72215394675732},
      {lat: 3.183494661265859, lng: 101.72764711081982},
      {lat: 3.1852086245367204, lng: 101.73017911612988},
      {lat: 3.1864940951175, lng: 101.73279695212841},
      {lat: 3.1859370580629167, lng: 101.73541478812695},
      {lat: 3.1846515867865883, lng: 101.73876218497753},
      {lat: 3.1928357264713028, lng: 101.74022130668163},
      {lat: 3.1988345309054895, lng: 101.74704484641552},
      {lat: 3.2064186834036477, lng: 101.7416375130415},
      {lat: 3.2159309307458597, lng: 101.7377744615078},
      {lat: 3.2206441735965754, lng: 101.73305377364159},
      {lat: 3.224843226124238, lng: 101.72833308577538},
      {lat: 3.230327676778448, lng: 101.72575816512108},
      {lat: 3.2302848296224793, lng: 101.72421455383301}
    ]
  end

  def self.bounds
    geokit_points = points.collect {|coords| Geokit::LatLng.new(coords[:lat], coords[:lng])}
    Geokit::Polygon.new(geokit_points)
  end

  def self.contains?(address = "")
    search_results = Geocoder.search(address)

    if search_results.empty?
      return false
    end

    coordinates = search_results.first.coordinates
    bounds.contains? Geokit::LatLng.normalize coordinates
  end
end