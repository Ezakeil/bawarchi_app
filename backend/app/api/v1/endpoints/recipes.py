from fastapi import APIRouter, HTTPException, Body
from typing import List
from pydantic import BaseModel
from app.services.spoonacular_service import search_recipes_by_ingredients
from app.models.recipe import Recipe

router = APIRouter()

class RecipeRequest(BaseModel):
    pantry_ingredients: List[str]

@router.post("/generate", response_model=List[Recipe])
async def generate_recipes(request: RecipeRequest):
    """
    Generate recipes based on pantry ingredients using Spoonacular API.
    """
    ingredients = request.pantry_ingredients
    raw_recipes = await search_recipes_by_ingredients(ingredients)
    
    recipes = []
    for raw in raw_recipes:
        used_count = raw.get("usedIngredientCount", 0)
        missed_count = raw.get("missedIngredientCount", 0)
        total_count = used_count + missed_count
        
        # Calculate match percentage
        match_percentage = 0
        if total_count > 0:
            match_percentage = int((used_count / total_count) * 100)

        recipes.append(Recipe(
            id=raw["id"],
            title=raw["title"],
            image=raw["image"],
            match_percentage=match_percentage,
            used_ingredient_count=used_count,
            missed_ingredient_count=missed_count,
            likes=raw.get("likes", 0)
        ))
        
    return recipes
