import requests
import json

URL = "http://10.255.255.254:2999/liveclientdata/allgamedata"
headers = {"User-Agent": "Python-Requests/2.28.0"}

def format_get(data, key):
    tmp_data = data.get(key, {})
    pretty_json = json.dumps(tmp_data, indent=4)
    return pretty_json

def parse_champion_items(players):
    # Create a dictionary to store champion items
    champion_items = {}
    
    # Iterate through each player
    for player in players:
        champion_name = player.get("championName", "Unknown")
        champion_pos = player.get("position", "Unknown")
        champion_name = {champion_pos, champion_name}
        items = player.get("items", [])
        
        # Extract relevant item details (customize as needed)
        item_list = [
            {
                "displayName": item.get("displayName", "Unknown"),
                "itemID": item.get("itemID", 0),
                "slot": item.get("slot", -1),
                "count": item.get("count", 1),
                "price": item.get("price", 0)
            }
            for item in items
        ]
        
        # Store items under champion name
        champion_items[champion_name] = item_list
    
    # Sort champions alphabetically
    sorted_champions = dict(sorted(champion_items.items()))
    
    return sorted_champions

def print_champion_items(champion_items):
    # Print the sorted champion-items mapping
    for champion, items in champion_items.items():
        print(f"{champion}:")
        if items:
            totalprice = 0
            for item in items:
                price = item['price']
                totalprice += price
                print(f"  - {item['displayName']} (ID: {item['itemID']}, Slot: {item['slot']}, Count: {item['count']})")
            print(f"Total price: {totalprice}")
        else:
            print("  - No items")


def fetch_game_data():
    try:
        # Make GET request with SSL verification disabled
        response = requests.get(URL, headers=headers, timeout=5, verify=False)
        response.raise_for_status()  # Raise an error for bad status codes (e.g., 404, 500)
        
        # Parse JSON data
        data = response.json()
        print("Parsed JSON Data:", json.dumps(data, indent=4))
        return data
        #all_players = format_get(data, "allPlayers")
        all_players = data.get("allPlayers", {})

        #print(all_players)

        champ_items = parse_champion_items(all_players)

        print_champion_items(champ_items)

        # Example: Access specific fields (modify based on your needs)
        # if "activePlayer" in data:
        #     print("Active Player:", data["activePlayer"]["summonerName"])
        
        return data
    
    except requests.exceptions.HTTPError as http_err:
        print(f"HTTP error occurred: {http_err}")
    except requests.exceptions.ConnectionError:
        print("Failed to connect to the game client. Is the League client running?")
    except requests.exceptions.Timeout:
        print("Request timed out.")
    except requests.exceptions.RequestException as err:
        print(f"An error occurred: {err}")
    except ValueError as json_err:
        print(f"Failed to parse JSON: {json_err}")
    
    return None

def main():
    data = fetch_game_data()
    if data:
        # Add your data processing logic here
        pass

if __name__ == "__main__":
    main()