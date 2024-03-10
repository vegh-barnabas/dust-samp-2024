Server:GetWeatherType(weatherid)
{
    switch (weatherid)
    {
        case 1, 3, 5, 10, 14, 18:
            return WEATHER_TYPE_SUNNY;
        case 0, 2, 6, 11, 13, 17:
            return WEATHER_TYPE_EXTRASUNNY;
        case 4, 7, 12, 15:
            return WEATHER_TYPE_CLOUDY;
        case 8, 16:
            return WEATHER_TYPE_RAINY;
        case 9: return WEATHER_TYPE_FOGGY;
        case 19: return WEATHER_TYPE_SANDSTORM;
    }

    // todo log error

    return WEATHER_TYPE_UNKNOWN;
}

Server:GetWeatherFromType(weatherid)
{
    switch (weatherid)
    {
        case WEATHER_TYPE_SUNNY:
        {
            new possibleWeathers[] = {1, 3, 5, 10, 14, 18};
            new rand = random(sizeof(possibleWeathers));

            return possibleWeathers[rand];
        }
        case WEATHER_TYPE_EXTRASUNNY:
        {
            new possibleWeathers[] = {0, 2, 6, 11, 13, 17};
            new rand = random(sizeof(possibleWeathers));

            return possibleWeathers[rand];
        }
        case WEATHER_TYPE_CLOUDY:
        {
            new possibleWeathers[] = {4, 7, 12, 15};
            new rand = random(sizeof(possibleWeathers));

            return possibleWeathers[rand];
        }
        case WEATHER_TYPE_RAINY:
        {
            new possibleWeathers[] = {8, 16};
            new rand = random(sizeof(possibleWeathers));

            return possibleWeathers[rand];
        }
        case WEATHER_TYPE_FOGGY: return 9;
        case WEATHER_TYPE_SANDSTORM: return 19;
    }

    // todo log error

    // weird doomsday weather
    return 42;
}

Server:GetRandomWeatherType()
{
    new currentWeather = GetWeather();
    new currentWeatherType = GetWeatherType(currentWeather);

    new randChangeWeather = random(100);

    // todo if day or if night
    // todo check this whole thing again
    // todo log weather change like: from - to - chance in percentage

    // todo depending on weather - sandstorm has really low chance to happen again, sunny has high, rain has very low, extrasunny has very high, cloudy has low, foggy has really low
    // 70% chance to no change in weather
    if (randChangeWeather >= 30) return currentWeatherType;

    if (currentWeatherType == WEATHER_TYPE_SUNNY)
    {
        new randNewWeather = random(100);

        // todo comment all of them
        // 50% to extra sunny, 25% to cloudy, 15% to rainy, 5% to foggy, 5% to sandstorm
        switch (randNewWeather)
        {
            case 0 .. 49:
                return WEATHER_TYPE_EXTRASUNNY;
            case 50 .. 74:
                return WEATHER_TYPE_CLOUDY;
            case 75 .. 89:
                return WEATHER_TYPE_RAINY;
            case 90 .. 94:
                return WEATHER_TYPE_FOGGY;
            case 95 .. 99:
                return WEATHER_TYPE_SANDSTORM;
        }
    }
    if (currentWeatherType == WEATHER_TYPE_EXTRASUNNY)
    {
        new randNewWeather = random(100);

        switch (randNewWeather)
        {
            case 0 .. 79:
                return WEATHER_TYPE_SUNNY;
            case 80 .. 99:
                return WEATHER_TYPE_SANDSTORM;
        }
    }
    if (currentWeatherType == WEATHER_TYPE_CLOUDY)
    {
        new randNewWeather = random(100);

        switch (randNewWeather)
        {
            case 0 .. 69:
                return WEATHER_TYPE_SUNNY;
            case 70 .. 89:
                return WEATHER_TYPE_RAINY;
            case 90 .. 99:
                return WEATHER_TYPE_FOGGY;
        }
    }
    if (currentWeatherType == WEATHER_TYPE_RAINY)
    {
        new randNewWeather = random(100);

        switch (randNewWeather)
        {
            case 0 .. 24:
                return WEATHER_TYPE_SUNNY;
            case 25 .. 39:
                return WEATHER_TYPE_EXTRASUNNY;
            case 40 .. 84:
                return WEATHER_TYPE_CLOUDY;
            case 85 .. 89:
                return WEATHER_TYPE_FOGGY;
            case 90 .. 99:
                return WEATHER_TYPE_SANDSTORM;
        }
    }
    if (currentWeatherType == WEATHER_TYPE_FOGGY)
    {
        new randNewWeather = random(100);

        switch (randNewWeather)
        {
            case 0 .. 39:
                return WEATHER_TYPE_SUNNY;
            case 40 .. 59:
                return WEATHER_TYPE_EXTRASUNNY;
            case 60 .. 89:
                return WEATHER_TYPE_CLOUDY;
            case 90 .. 99:
                return WEATHER_TYPE_RAINY;
        }
    }
    if (currentWeatherType == WEATHER_TYPE_SANDSTORM)
    {
        new randNewWeather = random(100);

        switch (randNewWeather)
        {
            case 0 .. 39:
                return WEATHER_TYPE_SUNNY;
            case 40 .. 69:
                return WEATHER_TYPE_EXTRASUNNY;
            case 70 .. 95:
                return WEATHER_TYPE_CLOUDY;
            case 96 .. 99:
                return WEATHER_TYPE_RAINY;
        }
    }

    // todo log error

    return WEATHER_TYPE_UNKNOWN;
}

CMD:weather(playerid, params[])
{
    new randomNextWeatherType = GetRandomWeatherType();
    if (randomNextWeatherType == WEATHER_TYPE_UNKNOWN) return SendClientMessage(playerid, -1, "error - unknown weather");

    new randomNextWeather = GetWeatherFromType(randomNextWeatherType);

    new string[128];
    format(string, sizeof(string), "%d", randomNextWeather);
    SendClientMessage(playerid, -1, string);

    return SetWeather(randomNextWeather);
}