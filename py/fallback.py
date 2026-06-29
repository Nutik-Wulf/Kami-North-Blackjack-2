# Program credit MiniChris

from collections import Counter
import json
import random

NUM_CHARS_IN_ESSENCE = 2

# list of valid essences
# ["fr", "wr", ...]
essences = []

# list of valid recipes 
# list of dictionaries representing the essences in recipe and resulting powerup
# {"essences": [...], "powerup": "..."}
recipes = []

def fallback(essences_in_craft: list):

    # number of essences in the attempted craft
    cost = len(essences_in_craft)

    found_recipe = False

    valid_powerups = []
    
    while cost > 2:
        if found_recipe:
            break
        
        for recipe in recipes:

            essences_counter = Counter(essences_in_craft)
            
            if len(recipe["essences"]) != cost:
                continue

            # subtract the essences in the recipe from the essences in the attempted craft
            essences_counter.subtract(Counter(recipe["essences"]))

            # if no essence count is negative, then the recipe can be made with the essences in the attempted craft
            # this is because if an essence count is negative, then the attempted craft does not have enough of that essence to make the recipe
            # this is accomplished by checking if the length of the list of negative counts is 0
            if len([c for c in essences_counter.values() if c < 0]) == 0:
                found_recipe = True
                valid_powerups.append(recipe["powerup"])

        # decrement cost to check for recipes with one less essence      
        cost -= 1

    if len(valid_powerups) == 0:
        print("garbage")

    else:
        for powerup in valid_powerups:
            print(f"valid powerup: {powerup}")

    if len(valid_powerups) > 1:
        print(f"random powerup: {random.choice(valid_powerups)}")        


def get_user_input():
    while True:
        user_input = input("Enter essences (e.g. frwrwr): ").lower()

        if len(user_input) % NUM_CHARS_IN_ESSENCE != 0:
            print(f"Essences must be {NUM_CHARS_IN_ESSENCE} characters long")
            continue

        # split user input into essences with each essence being NUM_CHARS_IN_ESSENCE characters long
        recipe_essences = [user_input[i:i+NUM_CHARS_IN_ESSENCE] for i in range(0, len(user_input), NUM_CHARS_IN_ESSENCE)]

        # validate each essence pair
        for essence in recipe_essences:
            if essence not in essences:
                print(f"{essence} is not a valid essence")
                break
        else:
            return recipe_essences

def get_user_input_old():

    # get user input for number of essences in the recipe
    while True:
        try:
            count = int(input("Number of essences: "))
        except ValueError:
            print("Invalid input. Please enter a number")
        else:
            if count < 3:
                print("Number of essences must be at least 3")
            else:
                break

    essence = ""
    recipe = []

    # get user input for each essence in the recipe
    for i in range(count):
        # validate user input
        while True:
            essence = input(f"Essence {i+1}: ").lower()
            if essence not in essences:
                print(f"{essence} is not a valid essence")
            else:
                break

        recipe.append(essence)

    return recipe


def main():
    with open ("recipes.json") as json_file:
        data = json.load(json_file)
        
        # load essences and recipes from json as global variables
        global essences
        essences = data["essences"]
        
        global recipes
        recipes = data["recipes"]

        #print(f"Valid essences: {essences}")

        #print (f"Recipes: {recipes}")
    
    while True:
        print("\nNew Craft Attempt")
        # get user input for the recipe
        recipe = get_user_input()

        # find valid powerups for the given recipe
        fallback(recipe)

if __name__ == '__main__':
    main()
