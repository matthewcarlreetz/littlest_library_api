defmodule LittlestLibrary.Utils.Haversine do
  @to_radians :math.pi() / 180
  # km for the earth radius
  @radians 6372.8

  @spec distance({number, number}, {number, number}) :: any
  def distance({lat1, long1}, {lat2, long2}) do
    dlat = :math.sin((lat2 - lat1) * @to_radians / 2)
    dlong = :math.sin((long2 - long1) * @to_radians / 2)

    a =
      dlat * dlat + dlong * dlong * :math.cos(lat1 * @to_radians) * :math.cos(lat2 * @to_radians)

    @radians * 2 * :math.asin(:math.sqrt(a))
  end

  def within_distance(libraries, location, radius_in_km) do
    Enum.map(libraries, fn l ->
      Map.put(l, :distance, distance(location, {l.latitude, l.longitude}))
    end)
    |> Enum.filter(fn l ->
      l.distance < radius_in_km
    end)
    |> Enum.sort(&(&1.distance < &2.distance))
  end
end
