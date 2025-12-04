import httpx
from fastapi import HTTPException, status
from typing import List
from app.core.config import settings

BASE_URL = 'https://api.spoonacular.com/recipes'

async def search_recipes_by_ingredients(ingredients: List[str]):
    url = f"{BASE_URL}/findByIngredients"
    params = {
        "apiKey": settings.SPOONACULAR_API_KEY,
        "ingredients": ",".join(ingredients),
        "number": 10,
        "ranking": 2,
        "ignorePantry": "true"
    }

    async with httpx.AsyncClient() as client:
        try:
            response = await client.get(url, params=params)
            if response.status_code != 200:
                raise HTTPException(
                    status_code=response.status_code,
                    detail=f"Spoonacular API Error: {response.text}"
                )
            return response.json()
        except httpx.RequestError as e:
            print(f"Spoonacular Request Error: {e}")
            raise HTTPException(
                status_code=status.HTTP_503_SERVICE_UNAVAILABLE,
                detail="Spoonacular API is unavailable"
            )
