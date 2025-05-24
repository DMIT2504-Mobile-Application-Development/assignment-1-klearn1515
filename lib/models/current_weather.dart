class CurrentWeather{
  late String _city;
  late String _description;
  late double _currentTemp;
  late DateTime _currentTime;
  late DateTime _sunrise;
  late DateTime _sunset;

  String get city{
    return _city;
  }

  set city(String value){
    if(value.trim().isEmpty){
      throw Exception('City cannot be empty');
    }
    _city = value;
  }

  String get description{
    return _description;
  }

  set description(String value){
    if(value.trim().isEmpty){
      throw Exception('Description cannot be empty');
    }
    _description = value;
  }

  double get currentTemp{
    return _currentTemp;
  }

  set currentTemp (double value){
    if(value < -100 || value > 100){
      throw Exception('Temperature must be between -100 and 100');
    }
    _currentTemp = value;
  }

  DateTime get currentTime{
    return _currentTime;
  }

  set currentTime (DateTime value){
    if(value.isAfter(DateTime.now())){
      throw Exception('Current time cannot be in the future');
    }
    _currentTime = value;
  }

  DateTime get sunrise{
    return _sunrise;
  }

  set sunrise (DateTime value){
    if (value.day != currentTime.day || value.month != currentTime.month || value.year != currentTime.year){
      throw Exception('Sunrise must be on the same day as current time');
    }
    _sunrise = value;
  }

  DateTime get sunset{
    return _sunset;
  }

  set sunset (DateTime value){
    if (value.day != currentTime.day || value.month != currentTime.month || value.year != currentTime.year){
      throw Exception('Sunset must be on the same day as current time');
    }

    if(value.isBefore(_sunrise)){
      throw Exception('Sunset cannot be before sunrise');
    }
    _sunset = value;
  }

  CurrentWeather({required String city, required String description, required double currentTemp, required DateTime currentTime, required DateTime sunrise, required DateTime sunset}) {
    this.city = city;
    this.description = description;
    this.currentTemp = currentTemp;
    this.currentTime = currentTime;
    this.sunrise = sunrise;
    this.sunset = sunset;
  }

  factory CurrentWeather.fromOpenWeatherData (dynamic data){
    String city = data['name'];
    String description = data['weather'][0]['description'];
    double currentTemp = data['main']['temp'];
    DateTime currentTime = DateTime.fromMillisecondsSinceEpoch((data['dt'] * 1000).toInt());
    DateTime sunrise = DateTime.fromMillisecondsSinceEpoch((data['sys']['sunrise'] * 1000).toInt());
    DateTime sunset = DateTime.fromMillisecondsSinceEpoch((data['sys']['sunset'] * 1000).toInt());


    return CurrentWeather(city: city, description: description, currentTemp: currentTemp, currentTime: currentTime,sunrise: sunrise, sunset: sunset);
  }

  @override
  String toString(){
    return 'City: $city, Description: $description, Current Temperature: $currentTemp, Current Time: $currentTime, Sunrise: $sunrise, Sunset: $sunset';
  }
}