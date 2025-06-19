import functions_framework
import requests
import os
from datetime import datetime, timedelta
from flask import jsonify, request

# --- Configuration ---
WEATHERAPI_API_KEY = os.environ.get("WEATHERAPI_API_KEY")
WEATHERAPI_BASE_URL = "http://api.weatherapi.com/v1"

@functions_framework.http
def get_weather_webhook(request):
    if not WEATHERAPI_API_KEY:
        return jsonify({
            "fulfillment_response": {
                "messages": [{"text": {"text": ["Weather service not configured."]}}]
            }
        })

    request_json = request.get_json(silent=True)
    print("Received request:", request_json)

    parameters = request_json.get("sessionInfo", {}).get("parameters", {})
    city = parameters.get("geo-city")
    date_str = parameters.get("date")

    if not city:
        return jsonify({
            "fulfillment_response": {
                "messages": [{"text": {"text": ["Please provide a city."]}}]
            }
        })

    # Handle date
    requested_date = None
    if date_str:
        try:
            requested_date_obj = datetime.fromisoformat(date_str.replace('Z', '+00:00')).date()
            today = datetime.now().date()
            if today <= requested_date_obj <= today + timedelta(days=2):
                requested_date = requested_date_obj
            elif requested_date_obj > today + timedelta(days=2):
                return jsonify({
                    "fulfillment_response": {
                        "messages": [{
                            "text": {
                                "text": [f"I can only provide forecast up to 3 days. Try a closer date."]
                            }
                        }]
                    }
                })
            else:
                return jsonify({
                    "fulfillment_response": {
                        "messages": [{
                            "text": {
                                "text": ["I can't access past weather data currently."]
                            }
                        }]
                    }
                })
        except ValueError:
            pass

    # Fetch weather
    if requested_date and requested_date != datetime.now().date():
        weather_data = fetch_forecast_weather(city, requested_date)
        if weather_data:
            response_payload = format_forecast_response(weather_data)
        else:
            return jsonify({
                "fulfillment_response": {
                    "messages": [{"text": {"text": ["Couldn't fetch forecast."]}}]
                }
            })
    else:
        weather_data = fetch_current_weather(city)
        if weather_data:
            response_payload = format_current_response(weather_data)
        else:
            return jsonify({
                "fulfillment_response": {
                    "messages": [{"text": {"text": ["Couldn't fetch current weather."]}}]
                }
            })

    # Respond with proper Dialogflow CX format
    return jsonify({
        "fulfillment_response": {
            "messages": [
                {
                    "text": {
                        "text": [
                            f"Weather in {city} — Temp: {response_payload['temperature']}, "
                            f"Wind: {response_payload['wind']}, Rain: {response_payload['rain']}"
                        ]
                    }
                }
            ]
        },
        "session_info": {
            "parameters": {
                "temperature": response_payload["temperature"],
                "wind": response_payload["wind"],
                "rain": response_payload["rain"]
            }
        }
    })

def fetch_current_weather(city):
    params = {
        'key': WEATHERAPI_API_KEY,
        'q': city,
        'aqi': 'no'
    }
    try:
        res = requests.get(f"{WEATHERAPI_BASE_URL}/current.json", params=params)
        res.raise_for_status()
        return res.json()
    except Exception as e:
        print("Current weather error:", e)
        return None

def fetch_forecast_weather(city, date_obj):
    params = {
        'key': WEATHERAPI_API_KEY,
        'q': city,
        'dt': date_obj.strftime('%Y-%m-%d'),
        'aqi': 'no'
    }
    try:
        res = requests.get(f"{WEATHERAPI_BASE_URL}/forecast.json", params=params)
        res.raise_for_status()
        return res.json()
    except Exception as e:
        print("Forecast error:", e)
        return None

def format_current_response(data):
    current = data['current']
    temp = f"{current['temp_c']} C"
    wind = f"{current['wind_kph'] / 3.6:.1f} mps"
    rain = "Yes" if current.get('precip_mm', 0) > 0 else "No"
    return {"temperature": temp, "wind": wind, "rain": rain}

def format_forecast_response(data):
    day = data['forecast']['forecastday'][0]['day']
    temp = f"{day['avgtemp_c']} C"
    wind = f"{day['maxwind_kph'] / 3.6:.1f} mps"
    rain = "Yes" if day.get('totalprecip_mm', 0) > 0 else "No"
    return {"temperature": temp, "wind": wind, "rain": rain}
